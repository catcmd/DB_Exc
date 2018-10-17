create table Studenten
(
	name varchar(30),
	matrikel DECIMAL(4,0) primary key,
);

/************************************************************************/
/* Create Tables							*/
/************************************************************************/
create table Dozenten
(
	name varchar(30) primary key,
	buero varchar(30) NOT NULL,
	tel varchar(30),
);


create table Veranstaltungen
(
	name varchar(30),
	semester char(4),
	raum varchar(8),
	dozent varchar(30),
	foreign key (dozent) REFERENCES Dozenten(name),
	primary key(name, semester),

);

create table student_in_veranstaltung
(
	student DECIMAL(4,0),
	foreign key (student) REFERENCES Studenten(matrikel),
	
	veranstaltung varchar(30),
	semester char(4),
	foreign key (veranstaltung, semester) REFERENCES Veranstaltungen(name, semester),
	
	note decimal(2,1),
	constraint note_rules check(note >=1 and note <=5 ),

	primary key(student, semester, veranstaltung), 
);


/************************************************************************/
/* Alter and add new column/spalte								*/
/************************************************************************/

alter table Studenten add geburtsdatum date;

alter table Studenten alter column geburtsdatum date NOT NULL;


/************************************************************************/
/* Insert Data								*/
/************************************************************************/
insert into Studenten(name, matrikel, geburtsdatum) values
	('Klaus',		'1234', '2018.03.13'),
	('Hans',		'3456', '1999.03.03'),
	('Herberdt',	'3461', '1999.07.10'),
	('Meemet',		'7328', '1970.05.15');

insert into Dozenten(name, buero, tel) values
	('Schmidt', 	'A3.05', '08031787878'),
	('Höfig',		'A2.04', '08031454545'),
	('Ferret',		'A4.05', '08031242424');

insert into Veranstaltungen(name, semester, raum, dozent) values
	('Prog1',			'ws17', 'R0.29', 'Höfig'),
	('Prog2',			'ws17', 'B0.04', 'Schmidt'),
	('Hochschulsport',	'ws17', 'A0.15', 'Ferret'),
	('DB',				'ws17', 'E0.08', 'Höfig');
	

insert into student_in_veranstaltung(student, veranstaltung, semester, note) values
	('1234', 'Prog1',		'ws17', '2.0'),
	('3456', 'Prog2',		'ws17', '4.0'),
	('3461', 'DB',			'ws17', '3.2'),
	('7328', 'Hochschulsport', 	'ws17', '5.0');

/************************************************************************/
/* 2.4. Insert Data						*/
/************************************************************************/
insert into Studenten(name, matrikel, geburtsdatum) values
	('Eva', '3333', '01-03-1970'),
	('Luise', '3334','01-04-1990'),
	('Daniel', '3335', '01-05-1990'),
	('Dominik','3336','01-06-2018');

insert into Dozenten(name, buero, tel) values
	('Klaus',		'C2.01', '123'),
	('Maria',		'D1.20', null);

insert into Veranstaltungen(name, semester, raum, dozent) values
	('Tanzgymnastik',	'ws17',	'D1.11' , 'Klaus'),
	('Tanzgymnastik',	'ss18',	'D1.11' , 'Klaus'),
	('Sackhüpfen',		'ws18', null,	'Klaus'),
	('Drachenfliegen',	'ss17',	'beach', 'Maria'),
	('Drachenfliegen',	'ss18',	'beach', 'Maria'),
	('Beachvolleyball',	'ss17',	'beach', 'Maria'),
	('Beachvolleyball',	'ss18',	'beach', 'Maria');



insert into student_in_veranstaltung(student, veranstaltung, semester, note) values
	('3333', 'Beachvolleyball', 'ss18', null),
	('3334', 'Beachvolleyball', 'ss18', null),
	('3335', 'Beachvolleyball','ss18', null),
	
	('3336', 'Drachenfliegen', 'ss17', null),
	('3333', 'Drachenfliegen', 'ss17', null),
	
	('3334', 'Tanzgymnastik', 'ws17', null),
	('3335', 'Tanzgymnastik', 'ws17', null);
	
update student_in_veranstaltung set note = '4.0' where veranstaltung = 'Beachvolleyball';
update Dozenten set buero = 'D0.22' where name = 'Maria';




/************************************************************************/
/* Select from Tables							*/
/************************************************************************/
select * from Studenten;
select * from Dozenten;
select * from Veranstaltungen;
select * from student_in_veranstaltung;

/************************************************************************/
/* Select from Tables 3.1					*/
/************************************************************************/
SELECT Dozenten.name, Dozenten.buero
from Dozenten 
where buero like 'D%';

Select student_in_veranstaltung.student
from student_in_veranstaltung
 where semester like 'ss18' and note is null;

 /*Declare @Alter TABLE
 (
 Alter int*/
 
-- insert datediff(year, Studenten.geburtsdatum, gedate())
--select @Alter+"----->"

select Studenten.name, datediff(year, Studenten.geburtsdatum, getdate())
 from Studenten 
 
 where datediff(year, Studenten.geburtsdatum, getdate()) > 20  
 and datediff(year, Studenten.geburtsdatum, getdate()) < 40;
 --where "Alter" > 20 and "Alter" < 40;

/************************************************************************/
/* Select from Tables 3.2					*/
/************************************************************************/
--3.2.1
select student_in_veranstaltung.student, Veranstaltungen.name, Veranstaltungen.raum, student_in_veranstaltung.semester 
from Veranstaltungen join student_in_veranstaltung 
on Veranstaltungen.semester = student_in_veranstaltung.semester 
and Veranstaltungen.name = student_in_veranstaltung.veranstaltung
where student_in_veranstaltung.semester like 'ss18';

--3.2.2
select s1.name, s2.name as 'Ist älter als: '
from Studenten as s1, Studenten as s2
	where s1.geburtsdatum < any -- vergleicht alle geburtsdaten von s3
	(
		Select s2.geburtsdatum
		from Studenten
	)
order by s1.geburtsdatum -- ordnet nach geburtsdatum bzw coloumn

--SELECT CONCAT('SQL ', 'Tutorial', 's', 'fun!') AS ConcatenatedString; --The CONCAT() function adds two or more expressions together.
--3.2.3

--3.3.1
select Veranstaltungen.dozent, Veranstaltungen.name, student_in_veranstaltung.note 
from Veranstaltungen join student_in_veranstaltung 
on Veranstaltungen.name = student_in_veranstaltung.veranstaltung
and Veranstaltungen.semester = student_in_veranstaltung.semester
where student_in_veranstaltung.note <= all 
(
select student_in_veranstaltung.note
)
order by student_in_veranstaltung.note 



/************************************************************************/
/* Delet								*/
/************************************************************************/
drop table student_in_veranstaltung;
drop table Veranstaltungen;
drop table Studenten;
drop table Dozenten;


--alter table Studenten drop column geburtsdatum;

