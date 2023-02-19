--1
select job_id, 
    DECODE(job_id,  'IT_PROG', SALARY*1.1,
                    'ST-MAN', SALARY*1.2,
                    'AD_VP', SALARY*1.3,
                    'ST_CLERK', SALARY*1.4,
                    SALARY) "INCREASE SALARY"
from employees;

--2
select department_id, 
    CASE department_id  WHEN 50 THEN SALARY+1000
                        WHEN 80 THEN SALARY+500
                        WHEN 90 THEN SALARY+200
                        WHEN 100 THEN SALARY+100
                        ELSE SALARY 
    END "INCREASE SALARY"
from employees;

--3
select department_id, sum(salary), COUNT(*)
from employees
group by department_id;

--4
select department_id, job_id, sum(salary), count(*)
from employees
where department_id>40
group by department_id, job_id
having sum(salary)>10000
order by job_id desc;

--5
select department_id, department_name, location_id, State_province, country_ID
from departments 
NATURAL JOIN locations;
--order by 1 --auto order;

--6
select department_id, department_name, location_id, State_province, country_ID
from departments JOIN locations 
USING (location_id);

--7
select d.department_id, d.department_name, l.location_id, l.State_province, l.country_ID
from departments d JOIN locations l 
ON d.location_id = l.location_id;

--8
select d.department_id, d.department_name, l.location_id, l.State_province, l.country_ID
from departments d JOIN locations l 
ON d.location_id = l.location_id
WHERE d.department_id > 100;

--9
select m.last_name mgr, e.last_name emp
from employees m join employees e
on m.employee_id = e.manager_id;

--10
select m.last_name mgr, count(e.last_name) total_emp
from employees m join employees e
on m.employee_id = e.manager_id
group by m.last_name;

--11
select d.department_id, d.department_name, l.location_id, l.State_province, l.country_ID
from departments d left outer join locations l
on d.location_id = l.location_id;

--12
select d.department_id, d.department_name, l.location_id, l.State_province, l.country_ID
from departments d right outer join locations l
on d.location_id = l.location_id;

--13
select d.department_id, d.department_name, l.location_id, l.State_province, l.country_ID
from departments d full outer join locations l
on d.location_id = l.location_id;

--14
select d.department_id, d.department_name, l.location_id, l.State_province, l.country_ID
from departments d cross join locations l;

--15
select  last_name, city, department_name
from employees e cross join departments d cross join locations l;

--16
select  last_name, city, department_name
from employees e join departments d 
on e.department_id = d.department_id join locations l
on d.location_id = l.location_id
where city = 'Toronto';

--17
select  e.last_name, d.department_id, d.department_name
from employees e cross join departments d
where e.last_name like '%an%';

--18
select last_name, department_id, department_name
from employees natural join departments 
where department_id in (90,100,101);

--19
select d.department_name, count(e.last_name)
from departments d join employees e
on e.department_id = d.department_id
group by d.department_name;

--20
select last_name, job_ID, Salary, hire_date
from employees
where salary <= (select avg(salary)
                from employees);
                
--21
select last_name, job_ID, Salary, hire_date
from employees
where salary = (select min(salary)
                from employees);
                
--22
Select last_name, job_ID, Salary, hire_date 
from employees
where Job_ID =   (select Job_ID
                  from employees
                  where employee_id = 141)
    and salary = (select salary
                  from employees
                  where employee_id = 100);
                  
--23
Select last_name, job_ID, Salary, hire_date 
from employees
where hire_date=( select min(hire_date)
                  from employees);
                  
--24
select last_name, trunc(months_between(sysdate, hire_date) * 31 / 7,0) number_of_week
from employees;

--25
select sysdate, next_day(sysdate, 'Monday'), last_day(sysdate)
from dual;

--26
select department_id
from departments
minus
select department_id
from employees
where job_id = 'AD_VP';

--27
select employee_id, job_id
from employees
union all
select employee_id, job_id
from job_history;

--28
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

--29
select employee_id, job_id
from employees
minus
select employee_id, job_id
from job_history;

--30
select department_id, null location_id, hire_date
from employees
union
select department_id, location_id, null
from departments;

--31
select employee_id, department_id, job_id, salary, null location_id, hire_date
from employees
union
select  null, department_id, null, null, location_id, null
from departments;
