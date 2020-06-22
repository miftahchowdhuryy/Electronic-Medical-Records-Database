# Electronic-Medical-Records-Database
Create a database to manage patient medical records. Create searches and output using SQL.

Database design include the following requirements. 

1. Patients have medical conditions that requires medical staff to diagnosis and perform treatments. Identify the patient name, address, age, gender, phone and email.

2. Staff perform the diagnosis and procedures during a patient visit. Identify the staff name and title.

3. The medical office is where patients visit staff to receive procedures and a diagnosis. Staff can be assigned to many offices. Identify office location.

4. Diagnosis is the identification of the patinet's disease, disorder or medical condition. The diagnosis is performed by staff. A patient can have many diagnoses identified during a visit. Identify the diagnosis name, diagnosis date, office of diagnosis and who performed the diagnosis.

5. Procedures performed by staff assist in the diagnosis or is necessary for the treatment. Patients can have many procedures during a visit. Identify the procedure name, procedure date, office of the procedures and who performed the procedures and procedure cost.

6. A visit is a meeting between the staff and patient to determine a diagnosis or perform a procedure. Identify the patient, date of visit, office of the visit and staff.

7. Allergies are tracked to insure it doesn't interfere with treatment and assist with a diagnosis. Allergies are diagnosed by staff. A patient can have many allergies.

8. Track all patient medications. Identify the medication name, start date, end date and dosage. 

Additional Design Requirements

1. Create database using Oracle version 18c.
2. Normalize your database to third normal form.
3. All multi-value columns must be saved to their own table.
4. Create foregn keys to enforce referential integrity. For instance, you must have foreign keys with references to at least the following:
    a. Staff and offices
    
    b. Patient and diagnoses
    
    c. Patient and Procedures
    
    d. Patient and alleriges
    
    e. Patient and medications
    
5. Create descriptive column labels for all output. For instance, don't display a column label named count (*)

Security:
    a. Staff are restricted from accessing patient date of birth and age.
    b. Patients can view but not change medical records.
