/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 1 of the case study, which means that there'll be more guidance for you about how to 
setup your local SQLite connection in PART 2 of the case study. 


PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */

SELECT * 
FROM `Facilities` 
WHERE membercost > 0

/* Q2: How many facilities do not charge a fee to members? */

there are 4 facilities that don't charge memeber costs

SELECT * 
FROM `Facilities` 
WHERE membercost = 0


/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */


SELECT facid, name, membercost, monthlymaintenance 
FROM `Facilities` 
WHERE membercost > 0 AND membercost < (monthlymaintenance *.20)


/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */

SELECT *
FROM `Facilities` 
WHERE facid IN (1,5);



/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */

SELECT *
FROM `Facilities` 
WHERE monthlymaintenance > 100;


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */

SELECT firstname, surname
FROM `Members`
Where joindate = (SELECT MAX(joindate) FROM Members);

/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */


SELECT DISTINCT CONCAT(firstname, ' ', surname) AS full_name
FROM Members
JOIN Facilities
WHERE name LIKE '%Tennis Court%'
ORDER BY full_name;



/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */



SELECT DISTINCT 
	CONCAT(m.firstname, ' ', m.surname) AS full_name, f.name, 
CASE WHEN 
	firstname ='GUEST' THEN f.guestcost * b.slots ELSE 
    f.membercost * b.slots END AS COST
FROM 
	Members m
JOIN 
	Bookings b on m.memid = b.memid
JOIN 
	Facilities f on b.facid = f.facid
WHERE
    DATE(b.starttime) = '2012-09-14' AND 
CASE WHEN 
	m.firstname ='GUEST' THEN f.guestcost * b.slots ELSE 
    f.membercost * b.slots END > 30
ORDER BY 
	b.memid DESC;



/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT DISTINCT 
    full_name, 
    name, 
    cost
FROM (
    SELECT 
        CONCAT(m.firstname, ' ', m.surname) AS full_name, 
        f.name, 
        CASE 
            WHEN m.firstname = 'GUEST' THEN f.guestcost * b.slots 
            ELSE f.membercost * b.slots 
        END AS cost,
        b.memid
    FROM 
        Members m
    JOIN 
        Bookings b ON m.memid = b.memid
    JOIN 
        Facilities f ON b.facid = f.facid
    WHERE 
        DATE(b.starttime) = '2012-09-14'
) AS subquery
WHERE 
    cost > 30
ORDER BY 
    memid DESC;

/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  


QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

Please see CaseStudy - country club

    Total Revenue (Initialoutlay) < 1000 = Facilities(name)

    What is the output? 
    Facilities Name (name)
    Total Revenue (Initialoutlay)

    organized by revenue (ORDER BY DSC)

    I'm unsure how cost of guests and members would affect the cost of facilities. 
    Is the total cost the initial cost or the yearly cost? 

Facilities with total revenue less than 1000:
Facility: Table Tennis, Total Revenue: 180
Facility: Snooker Table, Total Revenue: 240
Facility: Pool Table, Total Revenue: 270




/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */
List is long and I have it in the python coding.

Please see CaseStudy - country club

/* Q12: Find the facilities with their usage by member, but not guests */

Facilities usage by members (excluding guests):

Facility: Badminton Court, Total Usage by Members: 1086
Facility: Tennis Court 1, Total Usage by Members: 957
Facility: Massage Room 1, Total Usage by Members: 884
Facility: Tennis Court 2, Total Usage by Members: 882
Facility: Snooker Table, Total Usage by Members: 860
Facility: Pool Table, Total Usage by Members: 856
Facility: Table Tennis, Total Usage by Members: 794
Facility: Squash Court, Total Usage by Members: 418
Facility: Massage Room 2, Total Usage by Members: 54

/* Q13: Find the facilities usage by month, but not guests */
Please see CaseStudy - country club

