-- Lesson 11: Create reusable views for common reports.

CREATE VIEW IF NOT EXISTS vip_attendees AS
SELECT a.attendee_id, a.first_name, a.last_name, a.email, t.ticket_type, t.price
FROM attendees a
JOIN tickets t ON a.attendee_id = t.attendee_id
WHERE t.ticket_type = 'VIP';

CREATE VIEW IF NOT EXISTS vw_vip_attendees AS
SELECT * FROM vip_attendees;

CREATE VIEW IF NOT EXISTS vwvip_attendees AS
SELECT * FROM vip_attendees;

CREATE VIEW IF NOT EXISTS artist_schedule AS
SELECT ar.artist_name, st.stage_name, p.performance_date, p.start_time, p.end_time
FROM performances p
JOIN artists ar ON p.artist_id = ar.artist_id
JOIN stages st ON p.stage_id = st.stage_id;

CREATE VIEW IF NOT EXISTS vw_artist_schedule AS
SELECT * FROM artist_schedule;

CREATE VIEW IF NOT EXISTS vendor_sales_summary AS
SELECT v.vendor_name,
       SUM(s.amount) AS total_sales,
       AVG(s.amount) AS average_sale_value,
       COUNT(s.sale_id) AS number_of_transactions
FROM vendors v
LEFT JOIN sales s ON v.vendor_id = s.vendor_id
GROUP BY v.vendor_id, v.vendor_name;

CREATE VIEW IF NOT EXISTS vw_vendor_sales_summary AS
SELECT * FROM vendor_sales_summary;

SELECT 'VIP attendees view' AS view_name;
SELECT * FROM vip_attendees LIMIT 5;

SELECT 'Artist schedule view' AS view_name;
SELECT * FROM artist_schedule ORDER BY performance_date, start_time LIMIT 10;

SELECT 'Vendor sales summary view' AS view_name;
SELECT * FROM vendor_sales_summary ORDER BY total_sales DESC;