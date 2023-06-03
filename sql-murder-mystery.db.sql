/*First, we use the info we can remember to get the description of the crime*/
SELECT * 
FROM crime_scene_report
where type = 'murder' AND date = '20180115';

/*The crime scene description point us to 2 witnesses, 
we try to find info on them from the stated approximate addresses*/

/*For witness 1 who lives at the last house on "NorthWesr drive"*/
SELECT *
FROM person;

SELECT * 
FROM person
WHERE address_street_name = "Northwestern Dr";

SELECT *, MAX(address_number) 
FROM person
WHERE address_street_name = "Northwestern Dr";

/*For witness two who is named Annabel and lives on "Franklin Ave"*/
SELECT *
FROM person
WHERE address_street_name = "Franklin Ave" AND name LIKE 'Annabel%';

/*Next up is to retrieve their interview transcript using suitable id's*/
SELECT * 
FROM interview;

/*We can use person id's in this table to join the person table and begin to build a profile*/
SELECT 
	pers.name,
    int.transcript,
    int.person_id,
    pers.ssn,
    pers.license_id
 FROM person pers
 JOIN interview int
 ON pers.id = int.person_id
 
 SELECT * 
 FROM interview
 WHERE person_id = 14887;
 
    






