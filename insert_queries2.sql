-- Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co


insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co'

);

SELECT * FROM BOOKS;

-- Update an Existing Member's Address

SELECT * FROM members;

update members
set member_address='125 MAIN ST'
where member_id='C101';

--Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE  FROM isssue
where issued_id = 'IS107';

--Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM isssue
where issued_emp_id= 'E101';

-- List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

select issued_emp_id
	issued_emp_id,
	count(issued_id) as total_books_issued
from isssue
	group by issued_emp_id


--Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt*c


--CREATE TABLE book_issued_cnt AS
--SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count
--FROM issued_status as ist
--JOIN books as b
--ON ist.issued_book_isbn = b.isbn
--GROUP BY b.isbn, b.book_title;


-- Retrieve All Books in a Specific Category:

select * from books
where category='Classic'

--Find Total Rental Income by Category:
--join will be used

SELECT 
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM 
isssue as ist
JOIN
books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY 1

--List Members Who Registered in the Last 180 Days:

select * from members
where reg_date=> current_Date-INTERVAL'180 days';

--List Employees with Their Branch Manager's Name and their branch details:

select
	e.emp_id,
	e.emp_name,
	e.position,
	e.salary,
   b.*,
   m.emp_name as manager
    from employees e
join branch b
on e.branch_id=b.branch_id
 join employees m
on m.emp_id =b.manager_id;


--Create a Table of Books with Rental Price Above a Certain Threshold:

CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;

--Retrieve the List of Books Not Yet Returned
SELECT * FROM isssue as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;