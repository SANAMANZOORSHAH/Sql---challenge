Data Engineering
ALTER DATABASE module_challenge  SET datestyle TO "ISO,MDY";
CREATE TABLE titles (    
    title_id VARCHAR   NOT NULL,    
    title VARCHAR   NOT NULL,
    PRIMARY KEY (title_id)
);
SELECT * from titles
CREATE TABLE departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    PRIMARY KEY (dept_no)
);
SELECT * from departments
CREATE TABLE employees (
	
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date DATE  NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE  NOT NULL,
    FOREIGN KEY  (emp_title_id) REFERENCES titles (title_id),
    PRIMARY KEY (emp_no)
);
SELECT * from employees
CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary INT  NOT NULL,
 FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
 PRIMARY KEY (emp_no)
);
SELECT * from salaries
CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no)REFERENCES departments(dept_no),
    PRIMARY KEY (emp_no,dept_no)

);
SELECT * from dept_emp
DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
 FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no)REFERENCES departments(dept_no)

);
SELECT * from dept_manager
Data Analysis
1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

2.List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date between '1986-01-01' and '1986-12-31'
ORDER BY hire_date;

3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name Like 'B%'

6.List each employee in the Sales department, including their employee number, last name, and first name.
SELECT departments.dept_name, employees.last_name, employees.first_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';
8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;
