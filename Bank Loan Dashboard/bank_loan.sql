create database [Bank Loan  DB]

select * from bank_loan_data

--Total Loan Applications
select count(id) as [total loan applications] from bank_loan_data

--Month To Date Loan Applications
select count(id) as [MTD total loan applications] from bank_loan_data
where Month(issue_date) =  12 and year(issue_date) = 2021

--Previous Month To Date Loan Applications
select count(id) as [PMTD total loan applications] from bank_loan_data
where Month(issue_date) =  11 and year(issue_date) = 2021

--Total Loan amount
select sum(loan_amount) as [total loan amount] from bank_loan_data

--Month To Date Loan Applications
select sum(loan_amount) as [MTD total loan amount] from bank_loan_data
where Month(issue_date) =  12 and year(issue_date) = 2021

--Previous Month To Date Loan Applications
select sum(loan_amount) as [PMTD total loan amount] from bank_loan_data
where Month(issue_date) =  11 and year(issue_date) = 2021

--avg interest rate
select avg(int_rate) *100 as [average Interest rate] from bank_loan_data

--avg DTI
select ROUND(avg(dti), 4) *100 as [average DTI] from bank_loan_data

--good loan percentage
select 
(count( case when loan_status = 'Fully Paid' OR loan_status = 'Current' then id end) * 100)
/
count(id) from bank_loan_data
----good loan percentage
select (count(id) * 100) / (select count(id)  from bank_loan_data) from bank_loan_data where loan_status = 'Current' or loan_status = 'Fully Paid'

--good loan application
select count(id) from bank_loan_data where loan_status = 'Current' or loan_status = 'Fully Paid'

--good loan funded amount
select sum(loan_amount) from bank_loan_data where loan_status = 'Current' or loan_status = 'Fully Paid'

--good loan recieved amount
select sum(total_payment) from bank_loan_data where loan_status = 'Current' or loan_status = 'Fully Paid'


--bad loan percentage
select (count(id) * 100) / (select count(id)  from bank_loan_data) from bank_loan_data where loan_status = 'Charged Off'
--all for good loan

--Loan status
select loan_status,
count(id) as loancount,
sum(total_payment) as [total received amount],
sum(loan_amount) as [total amount],
avg(int_rate * 100) as [average init rate],
avg(dti *100) as [average dti]
from bank_loan_data
group by loan_status

--bank loan report
select 
Month(issue_date) as  month_number,
DateNAme(Month, issue_date) as month_Name,
COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
from bank_loan_data
group by Month(issue_date), DateNAme(Month, issue_date)
order by Month(issue_date)

--bank loan report by state
select 
address_state,
COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
from bank_loan_data
group by address_state
order by sum(loan_amount)

--bank loan report by term
select 
term,
COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
from bank_loan_data
group by term
order by term

select DB_NAME()
select @@SERVERNAME