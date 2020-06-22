CREATE TABLE PATIENTS (
PID number not null primary key,
pFirst varchar(20) not null,
pLast varchar(20) not null,
pAddress varchar(30) not null,
pCity varchar(20) not null,
pState char(2) not null,
pZipcode char(5) not null,
pAge varchar(10) not null,
pGender char(1) not null,
pPhone char(10) not null,
pEmail varchar(30) not null
);

ALTER TABLE PATIENTS
ADD PDOB date not null;

ALTER TABLE PATIENTS
DROP COLUMN PDOB;

CREATE TABLE STAFF (
SID number not null primary key,
sFirst varchar(20) not null,
sLast varchar(20) not null,
sTitle varchar(20) not null,
sAddress varchar(30) not null,
sCity varchar(20) not null,
sState char(2) not null,
sZipcode char(5) not null,
sEmail varchar(30) not null
);

CREATE TABLE OFFICE(
OID number not null primary key,
oAddress varchar(30) not null,
oCity varchar(20) not null,
oState char(2) not null,
oZipcode char(5) not null,
PID number not null,
SID number not null,
foreign key(PID) references PATIENTS(PID),
foreign key(SID) references STAFF(SID)
);

CREATE TABLE STAFFASSIGNED(
SID number not null,
OID number not null,
FOREIGN KEY (SID) REFERENCES STAFF(SID),
FOREIGN KEY (OID) REFERENCES OFFICE(OID),
PRIMARY KEY(SID, OID)
);


CREATE TABLE DIAGNOSIS(
DID number not null primary key,
dName varchar(30) not null,
dDate date not null,
PID number not null,
SID number not null,
OID number not null,
foreign key(PID) references PATIENTS(PID),
foreign key(SID) references STAFF(SID),
foreign key(OID) references OFFICE(OID)
);

CREATE TABLE PROCEDURE(
PROC number not null primary key,
procName varchar(50) not null,
procDate date not null,
procCost decimal(4,2) not null,
PID number not null,
SID number not null,
DID number not null,
foreign key(PID) references PATIENTS(PID),
foreign key(SID) references STAFF(SID),
foreign key(DID) references DIAGNOSIS(DID)
);

-- ADD COLUMN IN EXISTING TABLE
ALTER TABLE PROCEDURE
ADD procResult char(1) not null;


-- Add new column to table in case you don't have
ALTER TABLE PROCEDURE
ADD VID number not null;

ALTER TABLE PROCEDURE
ADD OID number not null;


--Add Foreign Key Constraint on Existing Table
ALTER TABLE PROCEDURE 
ADD CONSTRAINT VID
FOREIGN KEY (VID) REFERENCES VISIT (VID);

ALTER TABLE PROCEDURE 
ADD CONSTRAINT OID
FOREIGN KEY (OID) REFERENCES OFFICE (OID);

-- DROP SPECIFIC COLUMN
ALTER TABLE PROCEDURE
DROP COLUMN VID;


CREATE TABLE PATIENTDIAGNOSIS(
PID number not null,
DID number not null,
PRIMARY KEY(PID, DID)
);

CREATE TABLE VISIT(
VID number not null primary key,
dOfVisit date not null,
PID number not null,
SID number not null,
OID number not null,
foreign key(PID) references PATIENTS(PID),
foreign key(SID) references STAFF(SID),
foreign key(OID) references OFFICE(OID)
);


CREATE TABLE ALLERGIES(
AID number not null primary key,
aName varchar(25) not null,
PID number not null,
foreign key(PID) references PATIENTS(PID)
);


CREATE TABLE PATIENTALLERGIES(
PID number not null,
AID number not null,
PRIMARY KEY(PID,AID)
);

CREATE TABLE MEDICATIONS(
MID number not null primary key,
mName varchar(50) not null,
mStartDate date not null,
mEndDate date not null,
mDosage varchar(15) not null,
PID number not null,
FOREIGN KEY (PID) REFERENCES PATIENTS(PID)
);

CREATE TABLE APPOINTMENTS (
APPID number not null primary key,
dateOfApp date not null,
patientReport varchar(100) not null,
PID number not null,
SID number not null,
OID number not null,
FOREIGN KEY(PID) REFERENCES PATIENTS(PID),
FOREIGN KEY(SID) REFERENCES STAFF(SID),
FOREIGN KEY(OID) REFERENCES OFFICE(OID)
);

-- PATINET CAN RECEIVE MANY APPOINTMENTS SO MULTIVALUE

CREATE TABLE PATIENTSAPPOINMENTS(
APPID number not null,
PID number not null,
primary key(APPID, PID)
);

CREATE TABLE PHARMACY (
PHARID number not null primary key,
pName varchar(20) not null
);

CREATE TABLE PRESCRIPTIONS (
PRESID number not null primary key,
presDate date not null,
PID number not null,
SID number not null,
MID number not null,
PHARID number not null,
FOREIGN KEY(PID) REFERENCES PATIENTS(PID),
FOREIGN KEY(SID) REFERENCES STAFF(SID),
FOREIGN KEY(MID) REFERENCES MEDICATIONS(MID),
FOREIGN KEY(PHARID) REFERENCES PHARMACY(PHARID)
);

-- PATIENTS CAN RECEIVE MANY PRESCRIPTIONS SO MULTIVALUE

CREATE TABLE PATIENTPRESCRIPTION(
PID NUMBER NOT NULL,
PRESID NUMBER NOT NULL,
PRIMARY KEY(PID, PRESID)
);

CREATE TABLE STAFFNOTES (
SNID number not null primary key,
staffNote varchar(300) not null,
snDates date not null,
PID number not null,
SID number not null,
FOREIGN KEY(PID) REFERENCES PATIENTS(PID),
FOREIGN KEY(SID) REFERENCES STAFF(SID)
);

drop table STAFFNOTES;


set autocommit off;




-- 15 PATIENTS

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(1, 'Marsha', 'Sims', '13858 Rt 31 W', 'Albion', 'NY', '13021', '20', 'F', '3472233247', 'msims@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(2, 'Freddy', 'Lighty', '250 Rt 59', 'Airmont', 'NY', '10901', '24', 'M', '3472233298', 'flighty@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(3, 'Sierra', 'Lapeyrouse', '13890 Rt 32 W', 'Albion', 'NY', '13021', '34', 'F', '3472233260', 'sierra@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(4, 'Keven', 'Souder', '141 Washington Ave', 'Extension', 'NY', '12205', '21', 'M', '3472233777', 'keven@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(5, 'BONNY', 'KOLSTAD', '2055 Niagara Falls Blvd', 'Amherst', 'NY', '14228', '37', 'F', '3472233230', 'bonny@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(6, 'Earlene', 'Blomberg', '20 Sanford Farm Shpg', 'Amsterdam', 'NY', '12010', '19', 'F', '9172233247', 'earlene@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(7, 'Casandra', 'Hefner', '297 Grand Ave', 'Auburn', 'NY', '13021', '48', 'F', '9172233260', 'Casandra@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(8, 'Vida', 'Verrier', '4133 Veteran Memorial Drive', 'Batavia', 'NY', '14020', '68', 'F', '9172233291', 'vida@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(9, 'Tanisha', 'Northrup', '6264 Brockport Spenceport Rd', 'Brockport', 'NY', '13031', '37', 'F', '9172233217', 'tanisha@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(10, 'Arnulfo', 'Jameson', '5499 W Genesse St', 'Camillus', 'NY', '14424', '30', 'M', '6262233247', 'jameson@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(11, 'Angelina', 'Jolie', '3191 County RD', 'Amsterdam', 'NY', '12010', '30', 'F', '9172233244', 'angelina@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(12, 'Selena', 'Gomez', '3018 East Ave', 'Central Square', 'NY', '14225', '25', 'F', '9172233240', 'selena@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(13, 'Billie', 'Ilish', '3020 East Ave', 'Central Square', 'NY', '14225', '18', 'F', '9172233241', 'billie@gmail.com'); 

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(14, 'John', 'Legend', '3021 West Ave', 'NY', 'NY', '10021', '40', 'M', '9172233240', 'John@gmail.com');

INSERT INTO PATIENTS (PID, pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge, pGender, pPhone, pEmail)
VALUES(15, 'Zayn', 'Malik', '2020 East Ave', 'NY', 'NY', '10010', '25', 'M', '3472233241', 'zayn@gmail.com');

-- 10 STAFF

INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (1, 'Holly', 'Shockley', 'Doctor', 'Holly@gmail.com');

INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (2, 'Travis', 'Stromain', 'Physican Assistant', 'Travis@gmail.com');

INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (3, 'Justin', 'Bieber', 'Nurse', 'justin@gmail.com');


INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (4, 'Alden', 'Wieland', 'Dietitians', 'alden@gmail.com');

INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (5, 'Santiago', 'Watters', 'Occupation Therapist', 'Santiago@gmail.com');

INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (6, 'Steve', 'Yan', 'Pharmacist', 'steve@gmail.com');


INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (7, 'Daniela', 'Raiford', 'Physiotherapists', 'daniele@gmail.com');

INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (8, 'Kary', 'Lacourse', 'Podiatrists', 'kary@gmail.com');

INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (9, 'Tom', 'Cruz', 'Speech Pathologist', 'tom@gmail.com');

INSERT INTO STAFF (SID, sFirst, sLast, sTitle, sEmail)
VALUES (10, 'Kristal', 'Popham', 'Clinical Assistant', 'kristal@gmail.com');


-- 5 OFFICES

INSERT INTO OFFICE (OID, oAddress, oCity, oState, oZipcode)
VALUES (10, '250 Rt 59', 'Airmont', 'NY', '12205');

INSERT INTO OFFICE (OID, oAddress, oCity, oState, oZipcode)
VALUES (11, '100 Rt 60', 'Airmont', 'NY', '12205');

INSERT INTO OFFICE (OID, oAddress, oCity, oState, oZipcode)
VALUES (12, '2055 Niagara Falls Blvd', 'Amherst', 'NY', '14228');

INSERT INTO OFFICE (OID, oAddress, oCity, oState, oZipcode)
VALUES (13, '1055 Niagara Falls Blvd', 'Amherst', 'NY', '14228');

INSERT INTO OFFICE (OID, oAddress, oCity, oState, oZipcode)
VALUES (14, '8470 169 Street', 'Queens', 'NY', '11432');

-- 5 STAFFASSGINED

INSERT INTO STAFFASSIGNED (SID, OID)
VALUES (1, 10);

INSERT INTO STAFFASSIGNED (SID, OID)
VALUES (1, 11);

INSERT INTO STAFFASSIGNED (SID, OID)
VALUES (2, 11);

INSERT INTO STAFFASSIGNED (SID, OID)
VALUES (3, 12);

INSERT INTO STAFFASSIGNED (SID, OID)
VALUES (4, 14);


-- 20 DIAGNOSIS

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(20, 'Hypertension',sysdate-23, 1, 1, 10); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(21, 'Hyperlipidimia',sysdate-5, 2, 2, 11); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(22, 'Diabetes',sysdate, 3, 3, 12); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(23, 'Back Pain',sysdate-(5*365), 3, 3, 13); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(24, 'Anxiety',sysdate - (3*365), 4, 4, 13);

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(25, 'Obesity',sysdate - (2*365) -3, 3, 3, 12); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(26, 'Allergic Rhinitis',sysdate - (1*365) -40, 3, 3, 12); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(27, 'Reflux Esophagitis',sysdate - 40, 5, 5, 13);

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(28, 'Respiratory Problem',sysdate - (2*365) -40, 6, 6, 14); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(29, 'Hypothyroidism',sysdate - (3*365) -60, 7, 7, 12); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(30, 'Osteoarthritis',sysdate - (5*365) -90, 8, 8, 11); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(31, 'Ashma',sysdate - (5*365) -60, 9, 9, 13);

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(32, 'Nail Fungus',sysdate - 40, 10, 10, 13);

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(33, 'Cancer',sysdate - (1*365) -50, 11, 1, 12); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(34, 'STD',sysdate - 20, 2, 2, 13);

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(35, 'HIV',sysdate - (2*365) -40, 12, 1, 12); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(36, 'Depressive Disorder',sysdate - (3*365) -10, 13, 2, 13);

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(37, 'Heart Disease',sysdate - 90, 14, 4, 11);

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(38, 'Urinary Infection',sysdate - (1*365) -70, 15, 5, 13); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(39, 'Major Depressive Order',sysdate - (1*365) -10, 15, 3, 10); 

INSERT INTO DIAGNOSIS (DID, dName, dDate, PID, SID, OID)
VALUES(40, 'Headache',sysdate - (4*365) -40, 2, 2, 10); 

DESC PROCEDURE

-- 20 PROCEDURES

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (40, 'Antinuclear Antibody Test', sysdate-20, 10, 1, 1, 20, 10, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (41, 'CA 125', sysdate-30, 20, 2, 2, 21, 10, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (42, 'CAT Scan', sysdate-10, 30, 3, 3, 22, 11, 'N');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (43, 'Chemotherapy', sysdate, 40, 4, 4, 23, 11, 'N');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (44, 'Colonoscopy', sysdate-(3*365)-20, 30, 5, 5, 24, 12, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (45, 'Complete Blood Count', sysdate-(2*365)-10, 10, 6, 6, 25, 12, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (46, 'Noronary Artery Bypass Graft', sysdate-(3*365)-10, 11, 7, 7, 26, 13, 'N');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (47, 'Cortisone Injection', sysdate-(4*365)-11, 14, 8, 8, 27, 14, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (48, 'Electrolyte', sysdate-(5*365)-40, 14, 9, 9, 28, 14, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (49, 'Hemoglobin', sysdate-(5*365)-21, 40, 10, 10, 29, 10, 'N');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (50, 'Ultrasound', sysdate-(2*365)-22, 11, 11, 1, 30, 10, 'N');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (51, 'Tuberculosis', sysdate-(3*365)-50, 12, 12, 2, 31, 11, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (52, 'Knee Replacement', sysdate-(5*365)-20, 15, 13, 2, 32, 11, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (53, 'Pap Smear', sysdate-(3*365)-30, 16, 14, 3, 33, 12, 'N');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (54, 'MRI Scan', sysdate-(2*365)-60, 17, 15, 4, 34, 12, 'N');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (55, 'Hip Replacement', sysdate-31, 17, 1, 5, 35, 13, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (56, 'Liver Blood Test', sysdate-(3*365)-20, 17, 12, 2, 36, 13, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (57, 'Lab Band Surgery', sysdate-120, 30, 3, 3, 37, 14, 'N');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (58, 'Hemoglobin', sysdate-320, 20, 13, 4, 38, 14, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (59, 'Hysterectomy', sysdate-350, 21, 14, 5, 39, 14, 'P');

INSERT INTO PROCEDURE (PROC, procName, procDate, procCost, PID, SID, DID, OID, procResult)
VALUES (60, 'Heart Replacement', sysdate-360, 22, 11, 6, 40, 10, 'N');


-- 1O VISITS

DESC VISIT

INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (1, sysdate-20, 1, 1, 10);

INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (2, sysdate, 2, 2, 11);

INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (3, sysdate-2*365, 3, 3, 12);

INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (4, sysdate-70, 4, 4, 13);

INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (5, sysdate-120, 5, 5, 14);

INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (6, sysdate-2, 6, 6, 10);

INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (7, sysdate, 7, 7, 11);


INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (8, sysdate, 8, 8, 12);

INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (9, sysdate-55, 9, 9, 13);

INSERT INTO VISIT (VID, dOfVisit, PID, SID, OID)
VALUES (10, sysdate-30, 10, 10, 14);

-- 1 ALLERGIES FOR EACH PATIENT

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (1, 'Asplenia', 1);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (2, 'Asplenic', 2);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (3, 'Astelin', 3);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (4, 'Atarax', 4);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (5, 'Autism', 5);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (6, 'Autoantibody', 6);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (7, 'Autoimmune', 7);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (8, 'Aerobid', 8);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (9, 'Alavert', 9);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (10, 'Allegra', 10);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (11, 'Adenovirus', 11);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (12, 'Latex', 12);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (13, 'Allergy Insect', 13);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (14, 'Allergy Immunotherapy', 14);

INSERT INTO ALLERGIES (AID, aName, PID)
VALUES (15, 'Allergy Home Remedy', 15);

-- 2 MEDICATIONS FOR EACH PATIENT

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (1, 'Acetaminophen', sysdate-2, sysdate+20, 1, 1);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (2, 'Adderall', sysdate-2, sysdate+20, 1, 1);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (3, 'Alprazolam', sysdate-3, sysdate+2, 1, 2);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (4, 'Amitriptyline', sysdate-4, sysdate+3, 1, 2);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (5, 'Zoloft', sysdate-3, sysdate+2, 1, 3);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (6, 'Wellbutrin', sysdate-5, sysdate+10, 1, 3);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (7, 'Viagra', sysdate-3, sysdate+3, 1, 4);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (8, 'Tradozone', sysdate-3, sysdate+2, 1, 4);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (9, 'Prednisone', sysdate-4, sysdate+10, 1, 5);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (10, 'Prednisone', sysdate-3, sysdate+4, 1, 5);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (11, 'Pantoprazole', sysdate-3, sysdate+2, 1, 6);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (12, 'Oxycodone', sysdate-3, sysdate+7, 2, 6);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (13, 'Naproxen', sysdate-3, sysdate+29, 1, 7);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (14, 'Metformin', sysdate-3, sysdate+2, 1, 7);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (15, 'Advil', sysdate-3, sysdate+3, 1, 8);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (16, 'Tylenol', sysdate-3, sysdate+3, 1, 8);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (17, 'Metoprolol', sysdate-3, sysdate+20, 1, 9);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (19, 'Advil', sysdate-3, sysdate+20, 1, 9);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (18, 'Meloxicam', sysdate-3, sysdate+21, 1, 10);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (20, 'Advil', sysdate-3, sysdate+21, 1, 10);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (21, 'Lorazepam', sysdate-1, sysdate+22, 1, 11);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (22, 'Gabapentin', sysdate-1, sysdate+22, 1, 11);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (23, 'Advil', sysdate-1, sysdate+22, 1, 12);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (24, 'Clonazepam', sysdate-1, sysdate+22, 1, 12);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (25, 'Lorazepam', sysdate-1, sysdate+22, 1, 13);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (26, 'Tylenol', sysdate-1, sysdate+40, 1, 13);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (27, 'Ibuprofen', sysdate-1, sysdate+22, 1, 14);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (28, 'Advil', sysdate-1, sysdate+22, 1, 14);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (29, 'Lorazepam', sysdate-1, sysdate+22, 1, 15);

INSERT INTO MEDICATIONS (MID, mName, mStartDate, mEndDate, mDosage, PID)
VALUES (30, 'Ibuprofen', sysdate-1, sysdate+22, 1, 15);

-- AT LEAST 5 STAFF NOTES
    INSERT INTO STAFFNOTES (SNID, staffNote, snDates, PID, SID)
    VALUES (1, 'Complaining about daily migrane headache', sysdate, 1, 1);
    
    INSERT INTO STAFFNOTES (SNID, staffNote, snDates, PID, SID)
    VALUES (2, 'Complaining about daily headache', sysdate - 30, 2, 2);
    
    INSERT INTO STAFFNOTES (SNID, staffNote, snDates, PID, SID)
    VALUES (3, 'Complaining about teethpain', sysdate - 60, 1, 3);
    
    INSERT INTO STAFFNOTES (SNID, staffNote, snDates, PID, SID)
    VALUES (4, 'Complaining about upset stomach', sysdate - 90, 2, 4);
    
    INSERT INTO STAFFNOTES (SNID, staffNote, snDates, PID,  SID)
    VALUES (5, 'Complaining about daily headache', sysdate - 120, 1, 5);

-- Pharmacy 
    INSERT INTO PHARMACY (PHARID, pName)
    VALUES (1, 'CVS');
    
    INSERT INTO PHARMACY (PHARID, pName)
    VALUES (2, 'Walgreens');
    
    INSERT INTO PHARMACY (PHARID, pName)
    VALUES (3, 'Rite Aid');
    
-- AT LEAST 5 PRESCRIPTIONS
    INSERT INTO PRESCRIPTIONS (PRESID, presDate, PID, SID, MID, PHARID)
    VALUES (10, sysdate, 1, 1, 7, 2); 
    
    INSERT INTO PRESCRIPTIONS (PRESID, presDate, PID, SID, MID, PHARID)
    VALUES (11, sysdate + 22, 2, 3, 15, 2);
    
    INSERT INTO PRESCRIPTIONS (PRESID, presDate, PID, SID, MID, PHARID)
    VALUES (12, sysdate - 30 , 3, 1, 7, 1); 
    
    INSERT INTO PRESCRIPTIONS (PRESID, presDate, PID, SID, MID, PHARID)
    VALUES (13, sysdate - 60, 4, 2, 15, 3); 
    
    INSERT INTO PRESCRIPTIONS (PRESID, presDate, PID, SID, MID, PHARID)
    VALUES (14, sysdate - 90, 5, 1, 27, 3);
    
    INSERT INTO PRESCRIPTIONS (PRESID, presDate, PID, SID, MID, PHARID)
    VALUES (15, sysdate - 120, 6, 1, 7, 1);    
    
-- AT LEAST 5 APPOINMENTS
    INSERT INTO APPOINTMENTS(APPID, dateOfAPP, patientReport, PID, SID, OID)
    VALUES (1, sysdate, 'Headache', 1, 1, 10);
    
    INSERT INTO APPOINTMENTS(APPID, dateOfAPP, patientReport, PID, SID, OID)
    VALUES (2, sysdate - 30, 'Headache', 2, 1, 11);
    
    INSERT INTO APPOINTMENTS(APPID, dateOfAPP, patientReport, PID, SID, OID)
    VALUES (3, sysdate - 60, 'Sore Throat', 3, 3, 12);
    
    INSERT INTO APPOINTMENTS(APPID, dateOfAPP, patientReport, PID, SID, OID)
    VALUES (4, sysdate - 90, 'Upset Stomach', 4, 1, 13);
    
    INSERT INTO APPOINTMENTS(APPID, dateOfAPP, patientReport, PID, SID, OID)
    VALUES (5, sysdate - 120, 'Migrain Pain', 5, 3, 14);


-- #1
-- Identify procedures performed for patient Marsha Sims's visit last 3 months. Display the patient name, procedure name, 
-- date of procedure and procedure cost.

    SELECT pFirst, pLast, procName, procDate, concat('$' ,procCost)
    FROM PATIENTS p, PROCEDURE pr
    WHERE p.PID = pr.PID and 
    pFirst = 'Freddy' and pLast = 'Lighty'
    and pr.procDate < sysdate and pr.procDate > sysdate-90;

-- #2
-- Identify patients that have never received the 'Ultrasound'. Display teh patient name, age, and address.
-- Order the output alphabetically by patient name.


    SELECT pFirst, pLast, pAddress, pCity, pState, pZipcode, pAge
    FROM PATIENTS
    WHERE PID NOT IN (
                      SELECT DISTINCT(PID)
                      FROM PROCEDURE
                      WHERE procName = 'Ultrasound'
                     )
    ORDER BY pFirst, pLast;
      

-- #3
-- Identify the procedures performed by a 'Doctor' last year. Display the procedure name, 
-- procedure date, and patient name.

    SELECT procName, procDate, pFirst, pLast
    FROM PROCEDURE pR, STAFF s, PATIENTS p
    WHERE pr.SID = s.SID
    and pr.PID = p.PID
    and sTitle = 'Doctor'
    and procDate < sysdate and procdate > sysdate - (365);

-- #4
-- Identify patients with an 'Diabetes' last month. Display the
-- patient name, procedure name, and procedure result.

    SELECT pFirst, pLast, procName AS "Procedure Name", procResult AS "Procedure Result"
    FROM PATIENTS p, PROCEDURE pr, DIAGNOSIS d
    WHERE p.PID = pr.PID
    AND pr.PID = d.PID
    AND dName = 'Diabetes'
    AND dDate < sysdate AND dDate > sysdate - 30;

-- #5
-- Identify patients who were diagnosed with 'Osteoarthritis' in the last two years 
-- and are being treated with 'Ultrasound'. Display the patient name and 
-- procedure. Display the output alphabetically by patient name.

SELECT pFirst, pLast, procName
FROM PATIENTS p, PROCEDURE pr, DIAGNOSIS d
WHERE p.PID = pr.PID
AND pr.DID = d.DID
AND dName = 'Osteoarthritis'
AND procName = 'Ultrasound'
AND procDate < sysdate AND procdate > sysdate - (5*365)
ORDER BY pFirst, pLast;

-- #6
-- Identify staff who have not performed any procedures in the last two months.
-- Display the staff name. Display the output alphabetically by staff name.

    SELECT sFirst, sLast
    FROM STAFF s, PROCEDURE pr
    WHERE s.SID = pr.SID
    AND procDate < sysdate AND procDate > sysdate - 60
    ORDER BY sFirst, sLast;

-- #7
-- Identify patients who have not visited with medical staff in the last 2 years.
-- Display the output alphabetically by patient name.

    SELECT pFirst, pLast, pEmail
    FROM PATIENTS p, VISIT v
    WHERE p.PID = v.PID
    AND dOfVisit < sysdate AND dOfVisit > sysdate - (2*365)
    ORDER BY pFirst, pLast;


-- #8
-- Identify the number of proceudures performed in the last 5 years.
-- Display at least three columns: Office Location, procedure name, and number of procedures.
-- Display one row for each distinct office and procedure name.
-- Display the output alphabetically by office location and procedure.

    SELECT oAddress, oCity, oState, oZipcode, procName, COUNT(PROC) AS "Number of Procedure"
    FROM OFFICE o, PROCEDURE pr
    WHERE o.OID = pr.OID
    AND procDate < sysdate AND procDate > sysdate - (5*365)
    GROUP BY oAddress, oCity, oState, oZipcode, procName
    ORDER BY oAddress, oCity, oState, oZipcode, procName;

-- #9
-- Identify the number of patients who had procedures in the last 3 years.
-- Display four columns. patient first and last name, number of procedures and total cost.
-- Display one row for each distinct patient name. 
-- Display the output alphabetically by patient name.

    SELECT pFirst AS "First Name", pLast AS "Last Name", COUNT(PROC) AS "Number of Procedures" , concat('$', SUM(procCost)) AS "Total Cost"
    FROM PATIENTS p, PROCEDURE pr
    WHERE p.PID = pr.PID 
    AND procDate < sysdate AND procDate > sysdate - (3*365)
    GROUP BY pFirst, pLast
    ORDER BY pFirst, pLast;

-- #10
-- Identify the number of procedures performed at each office in the last 2 years. Display at least two columns: 
-- office location and number of procedures. Display the output alphabetically by office location.

    SELECT oAddress, oCity, oState, oZipcode, COUNT(PROC) AS "Number of Procedure"
    FROM OFFICE o, PROCEDURE pr
    WHERE o.OID = pr.OID
    AND procDate < sysdate AND procDate > sysdate - (5*365)
    GROUP BY oAddress, oCity, oState, oZipcode
    ORDER BY oAddress, oCity, oState, oZipcode;

-- #11 
-- Identify the revenue generated by each procedure in the last 5 years.
-- Display three columns: procedure name, number of procedures and total revenue/ cost.
-- Display one row for each distinct procedure name.
-- Display the output alphabetically by procedure name.

    SELECT procName AS "Procedure Name", COUNT(PROC) AS "Number of Procedures", concat('$', SUM(procCost)) AS "Total Revenue"
    FROM PROCEDURE
    WHERE procDate < sysdate and procDate > sysdate - (5*365)
    GROUP BY procName
    ORDER BY procName;

-- #12 
-- Display the structure of ALL tables using SQL Describe
    DESC PATIENTS;
    DESC STAFF;
    DESC OFFICE;
    DESC STAFFASSIGNED;
    DESC DIAGNOSIS;
    DESC PATIENTDIAGNOSIS;
    DESC PROCEDURE;
    DESC VISIT;
    DESC ALLERGIES;
    DESC PATIENTALLERGIES;
    DESC MEDICATIONS;
        

-- #13 
-- Display the version of Oracle. Enter:
-- SELECT *
-- FROM v$version;

    SELECT *
    FROM v$version;



-- #14 
-- Identify patients who have not scheduled an appoinment in last year. Display the patient name.
-- Use a nested select to answer this question.

    SELECT pFirst as " First Name", pLast as "Last Name"
    FROM PATIENTS
    WHERE PID NOT IN  (
                      SELECT PID
                      FROM APPOINTMENTS
                      WHERE dateOfApp < sysdate AND dateOfApp > sysdate - 365
                      )
                      
    ORDER BY pFirst, pLast;
            
-- #15 
-- Identify the most common medication prescribed in the last year. Display three columns: 
-- Medication, prescribing staff and number or prescriptions.
-- Display one distinct row for each medication and prescribing staff.
-- Display the medication with the most prescriptions first. 
    
    SELECT mName AS "Medication Name", sFirst AS "First Name", sLast AS "Last Name", count(PRESID) AS "Number Of Prescriptions"
    FROM MEDICATIONS m, PATIENTS p, PRESCRIPTIONS pr, Staff s
    WHERE m.MID = pr.MID
    AND p.PID = pr.PID
    AND s.SID = pr.SID
    AND  presDate < sysdate AND presDate > sysdate - 365
    GROUP BY mName, sFirst, sLast
    ORDER BY COUNT(PRESID) 
    DESC;

-- #16
-- Identify patients with the most appoinments in the last two years by age and gender.
-- Limit the age range to
-- a) young patients less than 19 years old;
-- b) middle age patients between 19 and 64 years old;
-- c) senior patients older than 64 years old.
-- Display three columns: patient age, gender and number of patients.
-- The highest number of patients is displayed first. 
-- You may need multiple SQL to answer this question.

-- a) young patients less than 19 years old
    SELECT pFirst,pLast, pAge, pGender, count (app.PID) AS "Number of Patients"
    FROM PATIENTS p, APPOINTMENTS app
    WHERE p.PID = app.PID
    AND dateOfApp < sysdate AND dateOfApp > sysdate - (3*365)
    AND pAge < 19
    GROUP BY pFirst, pLast, pAge, pGender
    ORDER BY pFirst, pLast
    DESC;
    
-- b) middle age patients between 19 and 64 years old
    SELECT pFirst,pLast, pAge, pGender, count (app.PID) AS "Number of Patients"
    FROM PATIENTS p, APPOINTMENTS app
    WHERE p.PID = app.PID
    AND dateOfApp < sysdate AND dateOfApp > sysdate - (3*365)
    AND pAge > 19 AND pAge < 64
    GROUP BY pFirst, pLast, pAge, pGender
    ORDER BY pFirst, pLast
    DESC;
    
-- c) senior patients older than 64 years old
    SELECT pFirst,pLast, pAge, pGender, count (app.PID) AS "Number of Patients"
    FROM PATIENTS p, APPOINTMENTS app
    WHERE p.PID = app.PID
    AND dateOfApp < sysdate AND dateOfApp > sysdate - (3*365)
    AND pAge > 64
    GROUP BY pFirst, pLast, pAge, pGender
    ORDER BY pFirst, pLast
    DESC;

-- #17
-- Identify patients with no open-ended narrative text/comments.
-- Display the patient name.

    SELECT pFirst, pLast
    FROM PATIENTS
    WHERE PID NOT IN 
                (SELECT PID
                 FROM STAFFNOTES
                )
    ORDER BY pFirst, pLast;
                

-- #18
-- Search the open-ended narative text/comments in the  medical records and 
-- identify Personally Identifiable Information (PII). This includes any data
-- that could potentially by used to identify a person. 
-- For instance, examples of PII includes email address, date of birth,
-- Social Security Number, bank account number, home address, and full name.
-- Display the staff who created the comment, date of comment and the comment.
-- Order the output by staff name.

-- Using Cartesian Product
    SELECT sFirst, sLast, snDates, staffNote
    FROM STAFF s, STAFFNOTES st
    WHERE s.SID = st.SID
    ORDER BY sFirst, sLast;

-- Using Inner Join
    SELECT sFirst, sLast, snDates, staffNote
    FROM STAFF s
    INNER JOIN STAFFNOTES st ON
    s.SID = st.SID
    ORDER BY sFirst, sLast;


-- #19
-- Patients can view, but not edit all medical records.
-- Create SQL to implement. 
-- Demonstrate your implementation will not edit
-- medical records by attempting to change data.




alter session set container = xepdb1;

create user sally identified by Oracle18;
grant connect to sally;
grant connect, resource to sally;
grant create session to sally;
grant unlimited tablespace to sally;

create user vader identified by Oracle18;
grant connect to vader;
grant connect, resource to vader;
grant create session to vader;
grant unlimited tablespace to vader;

SELECT table_name
FROM user_table;

SELECT *
FROM PATIENTS;