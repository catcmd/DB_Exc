create table Studenten
(
	name varchar(30),
	matrikel DECIMAL(4,0) primary key,
);

/************************************************************************/
/* Create Tables														*/
/************************************************************************/
create table Dozenten
(
	name varchar(30) primary key,
	buero varchar(30) NOT NULL,
	tel varchar(30),
);

----------------------------------------------
create table Veranstaltungen
(
	name varchar(30),
	semester char(4),
	raum varchar(8),
	dozent varchar(30),
	foreign key (dozent) REFERENCES Dozenten(name),
	primary key(name, semester),

);

----------------------------------------------
create table student_in_veranstaltung
(
	student DECIMAL(4,0),
	foreign key (student) REFERENCES Studenten(matrikel),
	
	veranstaltung varchar(30),
	semester char(4),
	foreign key (veranstaltung, semester) REFERENCES Veranstaltungen(name, semester),
	
	note decimal(2,1),
	constraint note_rules check(note <=1 and note >=5 ),

	primary key(student, semester, veranstaltung), 
);


/************************************************************************/
/* Insert Data															*/
/************************************************************************/
insert into Studenten(name, matrikel) values
	('Klaus', '1234'),
	('Hans', '3456'),
	('Herberdt', '3461'),
	('Meemet', '7328');

----------------------------------------------
insert into Dozenten(name, buero, tel) values
	('Schmidt', 'A3.05', '08031787878'),
	('Höfig', 'A2.04', '08031454545'),
	('Ferret', 'A4.05', '08031242424');

----------------------------------------------
insert into Veranstaltungen(name, semester, raum, dozent) values
	('1234', 'DB', 'R0.29', 'Höfig'),

/************************************************************************/
/* Select from Tables													*/
/************************************************************************/
select * from student_in_veranstaltung;


/************************************************************************/
/* Delet																*/
/************************************************************************/
drop table student_in_veranstaltung;
drop table Studenten;
drop table Dozenten;
drop table Veranstaltungen;