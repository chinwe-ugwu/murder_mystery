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
 
  SELECT * 
 FROM interview
 WHERE person_id = 16371;
 
 /*After obtaining their interviews, we need to get more insights from the "Get Fit Now" gym*/
 SELECT *
 FROM get_fit_now_check_in;
 /*We need to find all the members who came to the gym on January 9th"*/crime_scene_report
 SELECT *
 FROM get_fit_now_check_in
 WHERE check_in_date = '20180109';
 
 /*We narrow the suspects down to gold members with membership id starting with 48Z*/
 SELECT *
 FROM get_fit_now_check_in
 WHERE membership_id LIKE '48Z%' AND check_in_date = '20180109';
 
 /*We join the check in table and members table to get the names and person_id's of our suspects*/
 SELECT
 	mem.name,
    mem.person_id,
    mem.id,
    mem.membership_status,
    che.check_in_date,
    che.check_in_time,
 	che.check_out_time
  FROM get_fit_now_member mem
  JOIN get_fit_now_check_in che
  ON mem.id = che.membership_id
  WHERE che.check_in_date = '20180109' AND mem.id LIKE '48Z%';

/*We can use the insight from the gym to obtain license information on our suspects*/
/*Let us check out the license table*/
SELECT *
FROM drivers_license;
/*The license id is different from the person_id so we need to use their person id's 
to obtain their license id*/

SELECT 
	pers.name,
    mem.person_id,
    pers.license_id,
    mem.id,
    che.check_in_date
from person pers 
JOIN get_fit_now_member mem
ON pers.id = mem.person_id
JOIN get_fit_now_check_in che
ON mem.id = che.membership_id
WHERE che.check_in_date = '20180109' AND mem.id LIKE '48Z%';

/*We have their license ID's and can now get their license information*/
SELECT * 
FROM drivers_license
WHERE license_id = 173289;

SELECT * 
FROM drivers_license
WHERE id = 423327;

/*Only one of our suspects checks out with the info we have at this stagecrime_scene_report*/

/*We should retrieve their interview*/
SELECT *
FROM interview
where person_id = 67318;

/*Suspect's confession leads us to seek insights from the facebook events check in*/
SELECT *
FROM facebook_event_checkin
WHERE event_name LIKE '%SQL Symphony%';

/*We can join the facebook events table with the person table, license table, and income table to use details of the 
suspect's interview to find the mastermind*/

SELECT
	pers.name,
    pers.id,
    pers.license_id,
    pers.ssn,
    lic.car_model,
    lic.car_make,
    lic.gender,
    lic.hair_color,
    lic.height,
    fac.person_id,
    inc.annual_income
FROM drivers_license lic
join person pers
ON lic.id = pers.license_id
JOIN facebook_event_checkin fac
ON pers.id = fac.person_id
JOIN income inc
ON pers.ssn = inc.ssn
WHERE (lic.car_model = "Model S" And lic.car_make = "Tesla") and lic.hair_color = "red";

/* We should see our culprit's interview */
SELECT
	pers.name,
    pers.id,
    int.transcript
FROM person pers
JOIN interview int
ON pers.id = int.person_id
WHERE pers.id = 99716;
/* There are no results for her interview*/
    
SELECT * 
FROM solution;

VIEW TRIGGER;



