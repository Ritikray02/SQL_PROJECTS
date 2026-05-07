/*I HAVE WORKED ON CTE, WINDOWS FUNCTION
SUCH AS RANK, DENSE_RANK,LEAD,LAG,ROW_NUMBER AND MUCH MORE THEN I WORKED WITH CO-RELATED QUERY,STORED PROCEDURE
VIEWS AND COALASCE AND MANY MUCH MORE TOPICS THAT INCLUDES FROM BASICS TO ADVANCED OF SQL */
-- ScienceQtech Employee Performance Mapping
/*
Problem scenario:

ScienceQtech is a startup that works in the Data Science field. ScienceQtech has worked on fraud detection, 
market basket, self-driving cars, supply chain, algorithmic early detection of lung cancer, customer sentiment, 
and the drug discovery field. With the annual appraisal cycle around the corner, the HR department has asked you 
(Junior Database Administrator) to generate reports on employee details, their performance, and on the project 
that the employees have undertaken, to analyze the employee database and extract specific data based on 
different requirements.

Objective: 
To facilitate a better understanding, managers have provided ratings for each employee which will help the HR department

 to finalize the employee performance mapping. As a DBA, you should find the maximum salary of the employees and ensure
 that all jobs are meeting the organization's profile standard. You also need to calculate bonuses to find extra cost 
 for expenses. This will raise the overall performance of the organization by ensuring that all required employees 
 receive training.*/
 -- The task to be performed: 

/* 1.Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv 
 into the employee database from the given resources.*/

CREATE DATABASE EMPLOYEE;
USE EMPLOYEE;
-- 2. Create an ER diagram for the given employee database.
-- DONE YOU CAN REFER TO SCREENSHOT.
-- 3. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee 
-- record table, and make a list of employees and details of their department.
SELECT EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT FROM emp_record_table;

 /*4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
 less than two
 between two and four
 greater than four */

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING FROM EMP_RECORD_TABLE WHERE EMP_RATING <2;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING FROM EMP_RECORD_TABLE WHERE EMP_RATING >4;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING FROM EMP_RECORD_TABLE WHERE EMP_RATING BETWEEN 2 AND 4;

/* 5. Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance 
department from the employee table and then give the resultant column alias as NAME.*/

SELECT FIRST_NAME,LAST_NAME, CONCAT(FIRST_NAME," ",LAST_NAME) AS NAME FROM EMP_RECORD_TABLE WHERE DEPT='FINANCE';

/* 6.Write a query to list only those employees who have someone reporting to them. Also, show the number of 
reporters (including the President).*/

SELECT MANAGER_ID,COUNT(*) FROM emp_record_table GROUP BY MANAGER_ID;

/* 7. Write a query to list down all the employees from the healthcare and finance departments using union. 
Take data from the employee record table.*/

SELECT * FROM emp_record_table WHERE DEPT='HEALTHCARE'
UNION
SELECT * FROM emp_record_table WHERE DEPT='FINANCE';

/* 8. Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, 
DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along 
with the max emp rating for the department.*/
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE,DEPT, EMP_RATING, MAX(EMP_RATING) 
OVER(PARTITION BY DEPT)AS MAX_RATING FROM emp_record_table ;

/* 9 Write a query to calculate the minimum and the maximum salary of the employees in each role. 
Take data from the employee record table.*/
SELECT ROLE, MIN(SALARY) AS MIN_SAL,MAX(SALARY) AS MAX_SAL FROM emp_record_table GROUP BY ROLE;

/* 10 Write a query to assign ranks to each employee based on their experience. 
Take data from the employee record table.*/
SELECT *, DENSE_RANK() OVER(ORDER BY EXP DESC) AS HIG_EXP FROM emp_record_table;

/* 11 Write a query to create a view that displays employees in various countries 
whose salary is more than six thousand. Take data from the employee record table.*/
CREATE VIEW HIGH_SAL AS(
SELECT * FROM emp_record_table WHERE SALARY >6000);
SELECT * FROM HIGH_SAL;
/* 12 Write a nested query to find employees with experience of more than ten years. 
Take data from the employee record table.*/
SELECT * FROM emp_record_table WHERE EMP_ID IN (SELECT EMP_ID FROM emp_record_table WHERE EXP > 10);
/* 13 Write a query to create a stored procedure to retrieve the details of the employees 
whose experience is more than three years. Take data from the employee record table.
*/
-- CREATE DEFINER=`root`@`localhost` PROCEDURE `HIGH_EXP`()
-- BEGIN
SELECT * FROM EMP_RECORD_TABLE WHERE EXP>10;
-- END

/* 14 Write a query using stored functions in the project table to check whether the 
job profile assigned to each employee in the data science team matches the organization’s set standard.

The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.
*/
/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `JOB_PROFILE_CHECK`()
BEGIN
SELECT *,CASE
WHEN EXP <=2 THEN 'JUNIOR DATA SCIENTIST'
WHEN EXP >2 AND EXP<=5 THEN 'ASSOCIATE DATA SCIENTIST'
WHEN EXP >5 AND EXP<=10 THEN 'SENIOR DATA SCIENTIST'
WHEN EXP>10 AND EXP<=12 THEN 'LEAD DATA SCIENTIST'
WHEN EXP>12 AND EXP<=16 THEN 'MANAGER'
END AS TITLE FROM DATA_SCIENCE_TEAM;
END */

/* 15 Create an index to improve the cost and performance of the query to find the 
employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.*/

ALTER TABLE emp_record_table MODIFY FIRST_NAME VARCHAR(20);
CREATE INDEX F ON emp_record_table(FIRST_NAME);
SELECT * FROM emp_record_table WHERE FIRST_NAME ='ERIC';

/*16 Write a query to calculate the bonus for all the employees, based on their ratings and salaries 
(Use the formula: 5% of salary * employee rating).*/
SELECT *, (0.5*SALARY*EMP_RATING) AS BONUS
FROM emp_record_table;
/* 17 Write a query to calculate the average salary distribution based on the continent and country. 
Take data from the employee record table.*/
SELECT CONTINENT,COUNTRY,AVG(SALARY) FROM emp_record_table GROUP BY COUNTRY,CONTINENT;

/* HERE'S MY PROJECT ENDED WITH EMP_RECORD TABLE BUT NOW I HAVE STARTED WORKING ON CTE, WINDOWS FUNCTION
SUCH AS RANK, DENSE_RANK,LEAD,LAG,ROW_NUMBER AND MUCH MORE THEN I WORKED WITH CO-RELATED QUERY,STORED PROCEDURE
VIEWS AND COALASCE AND MANY MUCH MORE TOPICS THAT INCLUDES FROM BASICS TO ADVANCED OF SQL */

-- I HAVE AN EMP_TABLE WHICH INCLUDES EMP_ID,FIRST_NAME,LAST_NAME,GENDER,ROLE,DEPT,EXP,COUNTRY
-- ,CONTINENT,SALARY,EMP_RATING,`MANAGER ID` THE TASKS I HAVE PERFORMED ;- USED DATABASE CLASSICMODELS
USE CLASSICMODELS;
-- VERY VERY IMPORTANT PRACTICE SESSION WORKING ON WINDOWS FUNCTIONS
/* Show me details of all employees getting maximum salary in their dept */
SELECT DEPT,MAX(SALARY) FROM EMP_TABLE GROUP BY DEPT;
SELECT FIRST_NAME,DEPT,MAX(SALARY) FROM EMP_TABLE GROUP BY FIRST_NAME,DEPT;
SELECT *,MAX(SALARY) OVER(PARTITION BY dept) FROM EMP_TABLE;
SELECT EMP_ID,FIRST_NAME,SALARY,DEPT,MAX(SALARY) OVER(PARTITION BY DEPT) FROM EMP_TABLE;
SELECT EMP_ID,FIRST_NAME,SALARY,DEPT,MAX(SALARY) OVER() FROM EMP_TABLE;
/*retrieve the emp details along with maximum emp rating,
'minimum emp rating, average rating */
SELECT EMP_ID,FIRST_NAME,EMP_RATING,MAX(EMP_RATING)OVER() AS MAX_RATING,
MIN(EMP_RATING)OVER() AS MIN_RATING,
AVG(EMP_RATING)OVER()AS AVG_RATING FROM EMP_TABLE;

/*retrieve the emp details along with maximum emp rating,
'minimum emp rating, average rating FOR EACH ROLE*/
SELECT EMP_ID,FIRST_NAME,DEPT,EMP_RATING,MAX(EMP_RATING)OVER(PARTITION BY DEPT) AS MAX_RATING,
MIN(EMP_RATING)OVER(PARTITION BY DEPT) AS MIN_RATING,
AVG(EMP_RATING)OVER(PARTITION BY DEPT)AS AVG_RATING FROM EMP_TABLE;

select emp_id, first_name, dept, salary,
sum(salary) over(partition by dept order by dept desc) as Total_
from emp_table;
-- WORKING WIT RANK FUNCTION 1.RANK.2.DENS RANK 3. ROW NUMBER
-- Rank the employees according the experience
SELECT EMP_ID,FIRST_NAME,EXP,
RANK() OVER(ORDER BY EXP DESC) AS RNK FROM EMP_TABLE;
--
SELECT EMP_ID,FIRST_NAME,EXP,
DENSE_RANK() OVER(ORDER BY EXP DESC) AS DNS_RNK,
RANK () OVER(ORDER BY EXP DESC) AS RNK,
ROW_NUMBER() OVER(ORDER BY EXP DESC) AS SNO
FROM EMP_TABLE;

select emp_id, first_name, salary, dept,
rank() over(partition by dept order by salary desc) as Rnk, 
dense_rank() over (partition by dept order by salary desc) as Dn from emp_table;

/*
- lead - it will show the next value in the column
- lag - it will show the previous value in the column
- first_value - it will display */
select emp_id, first_name, salary,
lead (salary)over () as Next_value from emp_table;
-- LAG WORKING
select emp_id, first_name, salary,
LAG (salary)over () as Next_value from emp_table;
-- WORKING WILL ALL LEAD,ALG,FIRST VALUE
select emp_id, first_name, salary, lead (salary)over() as Next_value, lag(salary)over() as Previous_value,
first_value(salary) over() as First_data from emp_table;
-- Retrieve the details of employees who is getting the maximum salary
SELECT * FROM EMP_TABLE WHERE SALARY =(SELECT MAX(SALARY) FROM EMP_TABLE);
SELECT * FROM EMP_TABLE WHERE SALARY >(SELECT AVG(SALARY) AS AVG_SAL FROM EMP_TABLE);
-- Show the detail of emp who are getting 2nd highest salary
SELECT MAX(SALARY) FROM EMP_TABLE WHERE SALARY <(SELECT MAX(SALARY) FROM EMP_TABLE);
SELECT SALARY FROM EMP_TABLE ORDER BY SALARY DESC LIMIT 1,1;
SELECT * FROM EMP_TABLE WHERE SALARY <(SELECT MAX(SALARY) FROM EMP_TABLE)ORDER BY SALARY DESC LIMIT 1,1;
select * from emp_table
where salary<(select max(salary) from emp_table)
order by salary desc
limit 1,1;
select * from emp_table
where salary=(select distinct(salary) from emp_table
order by salary desc limit 3,1);
-- VERY VERY IMPORTANT RETREVING DATA OF NTH HIGEST SALARY USING WWINDOWS FUNCTION
SELECT * FROM 
(SELECT*,DENSE_RANK() OVER(ORDER BY SALARY DESC)AS RNK FROM EMP_TABLE)AS A 
WHERE RNK=4 ;
SELECT * ,DENSE_RANK() OVER(ORDER BY SALARY DESC)AS RNK FROM EMP_TABLE;
-- Retrieve the details of employees working in USA without using joins GREAT JOB DONE DO CAREFULLY LOOK ON IT 
SELECT * FROM EMPLOYEES WHERE OFFICECODE IN(SELECT OFFICECODE FROM OFFICES WHERE COUNTRY ='USA'); 
SELECT COUNTRY,COUNT(*) as TOTAL_EMP FROM EMP_TABLE WHERE COUNTRY ='USA' GROUP BY COUNTRY;
SELECT * FROM EMPLOYEES AS E
JOIN OFFICES AS O
ON 
E.OFFICECODE = O.OFFICECODE WHERE COUNTRY ='USA';
-- Retrieve the details of employees working in USA, France, China without using Joins
SELECT * FROM EMPLOYEES AS E
JOIN OFFICES AS O
ON
E.OFFICECODE=O.OFFICECODE WHERE COUNTRY IN ('USA','CHINA','FRANCE');
SELECT * FROM EMPLOYEES WHERE OFFICECODE IN(SELECT OFFICECODE FROM OFFICES WHERE COUNTRY IN ('USA','CHINA','FRANCE'));
-- IRetrieve customers who have placed an order without using joins
SELECT * FROM CUSTOMERS AS C
INNER JOIN ORDERS AS O
ON
C.CUSTOMERNUMBER=O.CUSTOMERNUMBER;
SELECT * FROM CUSTOMERS WHERE CUSTOMERNUMBER IN(SELECT CUSTOMERNUMBER FROM ORDERS);
-- -- Retrieve the employee details who is getting the 3rd highest salary
 SELECT * FROM
 (
SELECT *, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RNK FROM EMP_TABLE) AS E
WHERE RNK =3;
/* Common Table Expression (CTE)
- type of subquery which improves the readability of the query
- breaks down the complex code into simple query
- named subquery which temporarily stores the query in a variable
*/
WITH EMP_DETAILS AS (
SELECT *,DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RNK FROM EMP_TABLE)
SELECT * FROM EMP_DETAILS WHERE RNK =3;
-- Create a CTE for employees earning greater than 6000
WITH EMP_DETAILS AS (
SELECT * FROM EMP_TABLE WHERE SALARY >10000)
SELECT *FROM EMP_DETAILS;
SELECT * FROM EMPLOYEES;
SELECT E1.EMPLOYEENUMBER,E1.FIRSTNAME,E1.LASTNAME,E1.SALARY,E1.REPORTSTO FROM EMPLOYEES AS E1
INNER JOIN EMPLOYEES AS E2
ON
E1.EMPLOYEENUMBER=E2.EMPLOYEENUMBER;
with highsalary as ( select * from emp_table
where salary>6000)
select dept, count(emp_id) from highsalary
group by dept;
WITH HIGHSALARY AS(
SELECT * FROM EMP_TABLE WHERE SALARY > 6000)
SELECT DEPT,MAX(SALARY) AS MAXSALARY FROM HIGHSALARY GROUP BY DEPT;
SELECT FIRSTNAME AS MANAGER,COUNT(FIRSTNAME) FROM EMPLOYEES GROUP BY REPORTSTO;
-- Create a CTE for employees working in India
WITH INDIAN AS (
SELECT * FROM EMP_TABLE WHERE COUNTRY IN ('USA','INDIA'))
SELECT * FROM INDIAN;

WITH COUNTRY AS (
SELECT COUNTRY,COUNT(*) FROM EMP_TABLE GROUP BY COUNTRY)
SELECT * FROM COUNTRY;

 -- Retrieve the employees who are earning more than the average salary in the entire organization */
 SELECT * FROM EMP_TABLE WHERE SALARY >(SELECT AVG(SALARY) FROM EMP_TABLE);
WITH HIGHEARNERS AS (
SELECT * FROM EMP_TABLE WHERE SALARY >(SELECT AVG(SALARY) FROM EMP_TABLE))
SELECT * FROM HIGHEARNERS;
/* Retrieve the details of employees who are earning more than the average salary of their department */
/* Correlated Queries
- These are also sub-queries where the inner and outer query are related to each other*/
SELECT DEPT,AVG(SALARY) FROM EMP_TABLE GROUP BY DEPT;
SELECT * FROM EMP_TABLE AS E WHERE SALARY >
(SELECT AVG(SALARY) FROM EMP_TABLE WHERE DEPT=E.DEPT);
-- Retrieve the employees whose salary is above country average salary.             CORELATED QUERY
SELECT  * FROM EMP_TABLE AS A WHERE SALARY >(
SELECT AVG(SALARY) FROM EMP_TABLE WHERE COUNTRY=A.COUNTRY);
SELECT COUNTRY, AVG(SALARY) FROM EMP_TABLE GROUP BY COUNTRY;
SELECT * FROM (
SELECT *, AVG(SALARY) OVER(PARTITION BY COUNTRY) AS CTR FROM EMP_TABLE) AS E
WHERE SALARY >CTR;
WITH CTRENR AS (
SELECT *, AVG(SALARY) OVER(PARTITION BY COUNTRY) AS CTR FROM EMP_TABLE)
SELECT * FROM CTRENR WHERE SALARY >CTR;

WITH AVGEARNER AS (
SELECT * FROM EMP_TABLE WHERE SALARY >(SELECT AVG(SALARY) FROM EMP_TABLE))
SELECT * FROM AVGEARNER;
/* Retrieve the details of employees who are earning more than the average salary of their department */
SELECT *,AVG(SALARY) OVER(PARTITION BY DEPT) FROM EMP_TABLE ;
SELECT * FROM (
SELECT *,AVG(SALARY) OVER(PARTITION BY DEPT) AS AVERAGE FROM EMP_TABLE) AS E
WHERE SALARY > AVERAGE;
-- VERY IMPORTANT QUESTION RETREIVING DATA OF EMPLOYEES FROM EACH DEPARTMENT AS THEY ARE EARNING MAX OF SALARY FROM THEIR
-- DEPT USING WINDOWS FUNCTION
SELECT * FROM (
SELECT *,MAX(SALARY) OVER(PARTITION BY DEPT) AS MAX_E FROM EMP_TABLE) AS E
WHERE SALARY = MAX_E;
SELECT * FROM EMP_TABLE WHERE SALARY =(SELECT MAX(SALARY) FROM EMP_TABLE);
SELECT *,MAX(SALARY) OVER(PARTITION BY DEPT) FROM EMP_TABLE;
-- CTE 
WITH AVGSAL AS (
SELECT *,AVG(SALARY) OVER(PARTITION BY DEPT) AS AVERAGE FROM EMP_TABLE)
SELECT * FROM AVGSAL WHERE SALARY > AVERAGE;
-- Retrieve the employees whose salary is above country average salary
SELECT  * FROM EMP_TABLE AS A WHERE SALARY >(
SELECT AVG(SALARY) FROM EMP_TABLE WHERE COUNTRY=A.COUNTRY);
SELECT COUNTRY, AVG(SALARY) FROM EMP_TABLE GROUP BY COUNTRY;
SELECT * FROM (
SELECT *, AVG(SALARY) OVER(PARTITION BY COUNTRY) AS CTR FROM EMP_TABLE) AS E
WHERE SALARY >CTR;
-- Retrieve the employee details with highest rating in their department
SELECT DEPT,MAX(EMP_RATING) FROM EMP_TABLE GROUP BY DEPT;
-- SUB QUERY BY USING CORELATED QUEERY
SELECT * FROM EMP_TABLE AS E
WHERE EMP_RATING =
(SELECT MAX(EMP_RATING) FROM EMP_TABLE WHERE DEPT =E.DEPT);
-- USING CTES
WITH EMPRATING AS  (
SELECT *,MAX(EMP_RATING) OVER(PARTITION BY DEPT) AS RNK FROM EMP_TABLE)
SELECT * FROM EMPRATING WHERE EMP_RATING=RNK;
-- USING WINDOWS FUNCTION
SELECT * FROM (
SELECT *,RANK() OVER(PARTITION BY DEPT ORDER BY EMP_RATING DESC) AS RNK FROM EMP_TABLE) AS E
WHERE RNK=1;
-- USING CTE AND WINDOW FUNCTION
WITH HIGH_EMP_RATING AS (
SELECT *,RANK() OVER(PARTITION BY DEPT ORDER BY EMP_RATING DESC) AS RNK FROM EMP_TABLE)
SELECT * FROM HIGH_EMP_RATING WHERE RNK = 1;
SELECT * FROM EMP_TABLE WHERE EMP_RATING =(SELECT MAX(EMP_RATING) FROM EMP_TABLE) ;
/* NOW WORKING WITH VIEWS IT IS NOTHING ONLY
VIRTUAL TABLE
-- TEMPORARY TABLE
IT DOES NOT HAAVE ANY DATA PHYSICALLY STORED IT IS BASICALLY SUBSET OF DATA
*/
CREATE VIEW EMP_DETAILS AS (
SELECT EMP_ID,FIRST_NAME,ROLE,DEPT,SALARY FROM EMP_TABLE
WHERE CONTINENT = 'ASIA');
SELECT * FROM EMP_DETAILS;
/*
index - it is used to speed up the process of reading the data when to create a index
- when the dataset is too big
- if reading the data takes too longer syntax
create index indexname on table(colname);
*/
ALTER TABLE EMP_TABLE MODIFY FIRST_NAME VARCHAR(20);
CREATE INDEX I1 ON EMP_TABLE(FIRST_NAME);
SHOW INDEX FROM EMP_TABLE;
/*
Stored Procedure set -saved set of instructions
-- STEP BY STEP
DIFFERENT TYPE OF STORED PROCEDURE
- simple stored procedure
- stored procedure with in parameter - in means input
- stored procedure with out parameter - out means output

*/
SELECT * FROM (
SELECT *,DENSE_RANK()OVER(ORDER BY SALARY DESC)AS RNK FROM EMP_TABLE)AS E
WHERE RNK=2;
SELECT* FROM EMP_TABLE WHERE SALARY <(SELECT MAX(SALARY) FROM EMP_TABLE);
-- WORKING WITH STORED PROCEDURE
select *, if(emp_rating=5, 'Excellent', if (emp_rating=4, 'Good',
 if(emp_rating=3, 'Average',
if (emp_rating=2, 'Below Average', 'Worst' )))) 
as remarks from emp_table;
SELECT * FROM EMP_TABLE WHERE SALARY >@A;

-- WORKING WITH TEXT FFUNCTIONS
-- Text functions - upper, lower, concat, substring, left, right, trim
SELECT FIRST_NAME,UPPER(FIRST_NAME),LOWER(FIRST_NAME) FROM EMP_TABLE;
SELECT FIRST_NAME,LAST_NAME, CONCAT(FIRST_NAME,' ',LAST_NAME) AS NAME FROM EMP_TABLE;
select country, left(country, 2), right(country, 3) from emp_table; 
select country, substring(country, 2,3) from emp_table;
-- Numerical functions
select 4567.678, truncate(4567.678,2), round (4567.678, 2);
select 44.56, ceil (44.56),floor(44.56);
SELECT * FROM EMP_TABLE ORDER BY SALARY DESC LIMIT 1,1;
SELECT *,DENSE_RANK() OVER( ORDER BY SALARY DESC) AS HIG_SAL FROM EMP_TABLE;
SELECT * FROM (
SELECT *,DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RNK FROM EMP_TABLE) A
WHERE RNK=8;
-- Retrieve the employee details with highest rating in their department
WITH EMPRATING AS (
SELECT *, MAX(EMP_RATING) OVER(PARTITION BY DEPT ) AS RNK FROM EMP_TABLE)
SELECT * FROM EMPRATING WHERE EMP_RATING = RNK;

WITH EMPRATING AS  (
SELECT *,MAX(EMP_RATING) OVER(PARTITION BY DEPT) AS RNK FROM EMP_TABLE)
SELECT * FROM EMPRATING WHERE EMP_RATING=RNK;

SELECT * FROM EMP_TABLE AS E
WHERE EMP_RATING=(SELECT MAX(EMP_RATING) FROM EMP_TABLE WHERE DEPT=E.DEPT);
SELECT * FROM (
SELECT *, DENSE_RANK() OVER(PARTITION BY DEPT ORDER BY EMP_RATING DESC) AS RATING FROM EMP_TABLE) AS A
WHERE RATING = 1;
SELECT * FROM(
SELECT *,MAX(SALARY) OVER(PARTITION BY DEPT) AS HIGPAY FROM EMP_TABLE) AS E
WHERE SALARY = HIGPAY;


SELECT * FROM EMP_TABLE;
SELECT * FROM emp_record_table;

 
 