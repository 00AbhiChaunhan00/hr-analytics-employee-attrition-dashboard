CREATE TABLE employees (
    age INT,
    attrition VARCHAR(5),
    business_travel VARCHAR(50),
    daily_rate INT,
    department VARCHAR(50),
    distance_from_home INT,
    education INT,
    education_field VARCHAR(50),
    employee_count INT,
    employee_number INT PRIMARY KEY,
    environment_satisfaction INT,
    gender VARCHAR(10),
    hourly_rate INT,
    job_involvement INT,
    job_level INT,
    job_role VARCHAR(100),
    job_satisfaction INT,
    marital_status VARCHAR(20),
    monthly_income INT,
    monthly_rate INT,
    num_companies_worked INT,
    over18 CHAR(1),
    over_time VARCHAR(5),
    percent_salary_hike INT,
    performance_rating INT,
    relationship_satisfaction INT,
    standard_hours INT,
    stock_option_level INT,
    total_working_years INT,
    training_times_last_year INT,
    work_life_balance INT,
    years_at_company INT,
    years_in_current_role INT,
    years_since_last_promotion INT,
    years_with_curr_manager INT
);
Select * from employees;

-- Total employees
Select count(*) as total_employees from employees;

-- Total Attrition
Select Count(*) as total_attrition from employees
WHERE attrition='Yes';

-- Top 5 high salary employees
Select  monthly_income From employees
 order by  monthly_income desc limit 5

--Top 5 job roles by total salary payout?
Select job_role ,Sum(monthly_income) as total From employees
group by job_role order by total desc limit 5

-- Attrition Rate %
Select ROUND(SUM(CASE
	WHEN Attrition='Yes' THEN 1 
	ELSE 0 END) * 100.0/COUNT(*),2) as attrition_rate
from employees;

-- Department wise Employee,Attrition,Rate
Select Department,Count(*) AS total_emp,Sum( Case 
	WHEN attrition='Yes' THEN 1 
	ELSE 0 END) as attrition_count,
	ROUND(SUM(CASE
	WHEN Attrition='Yes' THEN 1 
	ELSE 0 END) * 100.0/COUNT(*),2) as attrition_rate
	from employees group by Department
	order by attrition_rate ;

--JobRole wise Attrition Rate
Select job_role,Count(*) AS total_emp,Sum( Case 
	WHEN attrition='Yes' THEN 1 
	ELSE 0 END) as attrition_count,
	ROUND(SUM(CASE
	WHEN Attrition='Yes' THEN 1 
	ELSE 0 END) * 100.0/COUNT(*),2) as attrition_rate
	from employees group by job_role
	order by attrition_rate ;

-- salary band
Select *,
	case WHEN  monthly_income<3000 THEN 'Low'
	WHEN monthly_income BETWEEN 3000 and 7000 THEN 'Medium'
	ELSE 'High'
	END as salary_band
	from employees;

-- Salary Band vs Attrition
Select 
	case WHEN  monthly_income<3000 THEN 'Low'
	WHEN monthly_income BETWEEN 3000 and 7000 THEN 'Medium'
	ELSE 'High'
	END as salary_band,
	Count(*) AS total_emp,Sum( Case 
	WHEN attrition='Yes' THEN 1 
	ELSE 0 END) as attrition_count,
	ROUND(SUM(CASE
	WHEN Attrition='Yes' THEN 1 
	ELSE 0 END) * 100.0/COUNT(*),2) as attrition_rate
	from employees group by salary_band
	order by attrition_rate ;
	
-- Attrition by YearsAtCompany
Select years_at_company, Count(*) as total_emp,
	Sum(CASE 
	WHEN attrition='Yes' THEN 1
	ELSE 0 END) as attriton_count
	from employees group by years_at_company 
	order by  years_at_company ;

-- Gender wise Attrition
Select Gender,COUNT(*) as total_emp,
	SUM(CASE WHEN Attrition='Yes' THEN 1 
	ELSE 0 END) as attrition_count,
	ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 
	ELSE 0 END)*100.0/COUNT(*),2) as attrition_rate
From employees
group by Gender;

-- which age group and job role has highest attrition?
Select CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    job_role,
    COUNT(*) AS attrition_count
FROM employees
WHERE attrition = 'Yes'
GROUP BY age_group, job_role
ORDER BY attrition_count DESC

-- Overtime Impact
SELECT 
OverTime,
COUNT(*) AS total_emp,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
ROUND(
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2
) AS attrition_rate
FROM employees
GROUP BY OverTime
