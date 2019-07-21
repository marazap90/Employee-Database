--===================================
-- #1 Create tables
--===================================

-- Employee table
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
  emp_no INT PRIMARY KEY NOT NULL,
  birth_date VARCHAR(255) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  gender VARCHAR(1) NOT NULL,
  hire_date VARCHAR(255) NOT NULL
);

-- Departments table
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  dept_no VARCHAR(255) PRIMARY KEY NOT NULL,
  dept_name VARCHAR(255) NOT NULL
);

-- Departments Employee table
DROP TABLE IF EXISTS dept_employee;
CREATE TABLE dept_employee (
  emp_no INT NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employee(emp_no),
  dept_no VARCHAR(255) NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  d_from_date VARCHAR(255) NOT NULL,
  d_to_date VARCHAR(255) NOT NULL
);

-- Departments Managers table
DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager (
  dept_no VARCHAR(255) NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  emp_no INT NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employee(emp_no),
  m_from_date VARCHAR(255) NOT NULL,
  m_to_date VARCHAR(255) NOT NULL
);

-- Salaries table
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employee(emp_no),
  salary FlOAT,
  s_from_date VARCHAR(255) NOT NULL,
  s_to_date VARCHAR(255) NOT NULL
);

-- Titles table
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
  emp_no INT NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employee(emp_no),
  title VARCHAR(255) NOT NULL,
  t_from_date VARCHAR(255) NOT NULL,
  t_to_date VARCHAR(255) NOT NULL
);

--===================================
-- #2 Import csv data into the tables
--===================================


--===================================
-- #3 Data analysis
--===================================

-- 1) List the following details of each employee: 
-- 	  employee number, last name, first name, gender, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM salaries as s
JOIN employee AS e ON
e.emp_no = s.emp_no;

-- 2) List employees who were hired in 1986.
SELECT * FROM employee
WHERE hire_date LIKE '1986%';

-- 3) List the manager of each department with the following information: 
--    department number, department name, the manager's employee number, last name, 
--    first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.m_from_date, m.m_to_date
FROM departments AS d
JOIN dept_manager AS m ON
m.dept_no = d.dept_no
JOIN employee AS e ON
e.emp_no = m.emp_no;

-- 4) List the department of each employee with the following information: 
--    employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employee AS e
JOIN dept_employee AS de ON
e.emp_no = de.emp_no
JOIN departments AS d ON
d.dept_no = de.dept_no;

-- 5) List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employee
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6) List all employees in the Sales department, including their employee number,
--    last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employee AS e
JOIN dept_employee AS d ON
e.emp_no = d.emp_no
JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales';

-- 7) List all employees in the Sales and Development departments, 
--    including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employee AS e
INNER JOIN dept_employee AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Development' OR dp.dept_name LIKE 'Sales';

-- 8) In descending order, list the frequency count of employee last names, i.e., 
--    how many employees share each last name.
SELECT last_name, COUNT(*) AS frequency
FROM employee
GROUP BY last_name
ORDER BY frequency DESC;
