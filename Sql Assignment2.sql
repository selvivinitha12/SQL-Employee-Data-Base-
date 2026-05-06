DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;


CREATE TABLE Department_info (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender ENUM('M','F') NOT NULL,
    age INT CHECK (age >= 18),
    date_of_joining DATETIME DEFAULT CURRENT_TIMESTAMP,
    designation VARCHAR(100),
    department_id INT,
    location_id INT,
    salary DECIMAL(10,2),
    email VARCHAR(100) UNIQUE,

    FOREIGN KEY (department_id) 
        REFERENCES Department_info(department_id)
        ON UPDATE CASCADE ON DELETE SET NULL,

    FOREIGN KEY (location_id) 
        REFERENCES locations(location_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- 1. Employees with salary > 50000 and joined before 2016
SELECT DISTINCT salary
FROM employees
WHERE salary > 50000
AND date_of_joining < '2016-01-01';

-- 2. Update NULL designations
UPDATE employees
SET designation = 'Data Scientist'
WHERE designation IS NULL;

-- 3. Employees joined in 2018
SELECT *
FROM employees
WHERE YEAR(date_of_joining) = 2018
ORDER BY date_of_joining ASC
LIMIT 5;

-- 4. Total salary in Finance department
SELECT SUM(e.salary) AS total_salary
FROM employees e
JOIN Department_info d 
    ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

-- 5. Minimum age
SELECT MIN(age) AS minimum_age
FROM employees;

-- 6. Max salary by location
SELECT l.location, MAX(e.salary) AS max_salary
FROM employees e
JOIN locations l 
    ON e.location_id = l.location_id
GROUP BY l.location;

-- 7. Average salary for Analysts
SELECT designation, AVG(salary) AS avg_salary
FROM employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;

-- 8. Departments with less than 3 employees
SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM Department_info d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3;

-- 9. Average age of female employees by location < 30
SELECT l.location, AVG(e.age) AS avg_age
FROM employees e
JOIN locations l 
    ON e.location_id = l.location_id
WHERE e.gender = 'F'
GROUP BY l.location
HAVING AVG(e.age) < 30;

-- 10. Employee details with department
SELECT 
    e.employee_name,
    e.designation,
    d.department_name
FROM employees e
INNER JOIN Department_info d
    ON e.department_id = d.department_id;

-- 11. Employee count per department
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS total_employees
FROM Department_info d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- 12. All locations with employees (RIGHT JOIN)
SELECT 
    l.location,
    e.employee_name
FROM employees e
RIGHT JOIN locations l
    ON e.location_id = l.location_id;

