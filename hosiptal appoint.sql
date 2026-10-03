create database hospital_db;
use hospital_db;

create table departments(
 id int auto_increment primary key,
 name varchar(100) not null
 );
create table doctors(
  id int auto_increment primary key,
  name varchar(100) not null,
  specialization varchar(100),
  department_id int,
  foreign key (department_id) references departments(id)
);
create table patients(
  id int auto_increment primary key,
  name varchar(100) not null,
  dob date,
  gender enum('male', 'female', 'other')
);
create table appointments(
  id int auto_increment primary key,
  patient_id int,
  doctor_id int,
  date DATE,
  status enum ('scheduled','completed','cancelled') default 'scheduled',
  foreign key (patient_id) references patients(id),
  foreign key (doctor_id) references doctors(id)
);
  
  
  
-- ==========================================
-- 1. Insert data into departments
-- ==========================================
insert into departments(name) values
('cardiology'),
('neurology'),
('orthopedics'),
('pediatrics'),
('dermatology');
-- ==========================================
-- 2. Insert data into doctors
-- ==========================================
insert into doctors(name, specialization,department_id) values
('Dr. Nishi gupta', 'cardiologist',1),
('Dr. Palak agarwal','neurologist',2),
('Dr. priya gupta','orthopedic surgeon',3),
('Dr. yash dubey','pediatrician',4),
('Dr. karan kapoor','dermatologist',5);
-- ==========================================
-- 3. Insert data into patients
-- ==========================================
insert into patients (name, dob, gender) values
('Aarav Sharma', '1995-05-12', 'male'),
('Sneha Verma', '1990-08-22', 'female'),
('Rahul Singh', '1985-11-05', 'male'),
('Ananya Gupta', '2000-02-15', 'female'),
('Rohan Mehra', '1998-12-30', 'male');
-- ==========================================
-- 4. Insert data into appointments
-- ==========================================
insert into appointments (patient_id, doctor_id, date, status) values
(1, 1, '2026-10-05', 'scheduled'),
(2, 2, '2026-10-06', 'completed'),
(3, 3, '2026-10-07', 'scheduled'),
(4, 4, '2026-10-08', 'cancelled'),
(5, 5, '2026-10-09', 'scheduled');

-- 1.list all appointments with patient and doctor names
select a.id as appointment_id,
       p.name as patient_name,
       d.name as doctor_name,
       a.date,
       a.status
from appointments a
join patients p on a.patient_id=p.id
join doctors d on a.doctor_id=d.id
order by a.date;

-- 2. count appointments per departments
select dep.name as department,
       count(a.id) as total_appointments
from appointments a
join doctors d on a.doctor_id=d.id
join departments dep on d.department_id=dep.id
group by dep.name
order by total_appointments desc;
-- 3. upcoming appointments fpr agiven doctor
select a.id,p.name,a.date
from appointments a
join patients p on a.patient_id=p.id
where a.doctor_id= 3 and a.date >= current_date
order by a.date;

-- 4. no. of male vs female patients
select gender, count(*) as total_patients
from patients
group by gender;

-- 5. cancelled appointment count per month
select date_format(date, '%y-%m') as month,
       count(*) as cancelled_appointments
from appointments
where status = 'cancelled'
group by month
order by month;

