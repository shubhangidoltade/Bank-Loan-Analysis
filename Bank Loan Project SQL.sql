create database bank_loan_da;
use bank_loan_da;
select * from bank_loan;

UPDATE bank_loan
SET issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y'),
    last_credit_pull_date = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y'),
    last_payment_date = STR_TO_DATE(last_payment_date, '%d-%m-%Y'),
    next_payment_date = STR_TO_DATE(next_payment_date, '%d-%m-%Y'); 
    
    /*Update the Date Values to Correct Format
    and change their datatype from text to date*/

ALTER TABLE bank_loan
MODIFY COLUMN issue_date DATE,
MODIFY COLUMN last_credit_pull_date DATE,
MODIFY COLUMN last_payment_date DATE,
MODIFY COLUMN next_payment_date DATE;

DESCRIBE bank_loan;

/* KPI 1
Total Loan Applications */
SELECT COUNT(id) AS Total_Applications FROM bank_loan;

/* KPI 2
 MTD Loan Applications */
SELECT COUNT(id) AS Total_Applications FROM bank_loan
WHERE MONTH(issue_date) = 12;

/* KPI 3 
PMTD Loan Applications */
SELECT COUNT(id) AS Total_Applications FROM bank_loan
WHERE MONTH(issue_date) = 11;

/*KPI 4
Total Funded Amount */
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan;

/* KPI 5
MTD Total Funded Amount */
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan
WHERE MONTH(issue_date) = 12;

/* KPI 6
PMTD Total Funded Amount */
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan
WHERE MONTH(issue_date) = 11;

/* KPI 7
Total Amount Received */
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan;

/* KPI 8
MTD Total Amount Received */
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan
WHERE MONTH(issue_date) = 12;

/* KPI 9
PMTD Total Amount Received */
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan
WHERE MONTH(issue_date) = 11;

/* KPI 10
Average Interest Rate */
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan;

/* KPI 11
MTD Average Interest */
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM bank_loan
WHERE MONTH(issue_date) = 12;

/* KPI 12
PMTD Average Interest */
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM bank_loan
WHERE MONTH(issue_date) = 11;

 /* KPI 13
Avg DTI */
SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan;

/* KPI 14
MTD Avg DTI */
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bank_loan
WHERE MONTH(issue_date) = 12;

/* KPI 15
PMTD Avg DTI */
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM bank_loan
WHERE MONTH(issue_date) = 11;

/* KPI 16
GOOD LOAN ISSUED 
Good Loan Percentage */
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan;

/*Good Loan Applications*/
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

/*Good Loan Funded Amount*/
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

/*Good Loan Amount Received*/
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

/* KPI 17 
BAD LOAN ISSUED
Bad Loan Percentage */
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan;

/*Bad Loan Applications*/
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan
WHERE loan_status = 'Charged Off';

/*Bad Loan Funded Amount*/
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan
WHERE loan_status = 'Charged Off';

/*Bad Loan Amount Received*/
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan
WHERE loan_status = 'Charged Off';

/* KPI 18
LOAN STATUS */
	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan
    GROUP BY
        loan_status;

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

/*KPI 19
B.	BANK LOAN REPORT | OVERVIEW 
MONTH */
SELECT 
    MONTH(issue_date) AS Month_Number,
    MONTHNAME(issue_date) AS Month_name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);


/*KPI 20 
STATE */ 

SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY address_state
ORDER BY address_state;

/* KPI 21
TERM */

SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY term
ORDER BY term;

/* KPI 22 
EMPLOYEE LENGTH */

SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY emp_length
ORDER BY emp_length;

/* KPI 23 
PURPOSE */ 

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY purpose
ORDER BY purpose;

/*KPI 24
HOME OWNERSHIP */

SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY home_ownership
ORDER BY home_ownership;


SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;






