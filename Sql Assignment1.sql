CREATE DATABASE IF NOT EXISTS employee;
DROP DATABASE IF EXISTS employee;
USE employee;
CREATE TABLE Department_info(
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

FOREIGN KEY (department_id) REFERENCES Department_info(department_id)
ON UPDATE CASCADE ON DELETE SET NULL,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
ON UPDATE CASCADE ON DELETE SET NULL
);