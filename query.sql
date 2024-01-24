-- TASK 1

SELECT
    cities.id AS city_id,
    cities.name AS city_name,
    COALESCE(from_city_count, 0) AS from_city_count,
    COALESCE(to_city_count, 0) AS to_city_count
FROM cities
LEFT JOIN (
    SELECT
        from_city_id,
        COUNT(*) AS from_city_count
    FROM drivers
    WHERE from_city_id IS NOT NULL
    GROUP BY from_city_id
) AS from_counts ON cities.id = from_counts.from_city_id
LEFT JOIN (
    SELECT
        to_city_id,
        COUNT(*) AS to_city_count
    FROM drivers
    WHERE to_city_id IS NOT NULL
    GROUP BY to_city_id
) AS to_counts ON cities.id = to_counts.to_city_id;

-- TASK 2

SELECT
    trips.id AS trip_id,
    trips.trip_number_id,
    trips.from_city_id AS from_city,
    from_city.name AS from_city_name,
    trips.to_city_id AS to_city,
    to_city.name AS to_city_name,
    trips.driver_id AS driver,
    drivers.full_name AS driver_name,
    trips.price,
    trip_customers.id AS trip_customer_id,
    customers.id AS customer_id,
    customers.full_name AS customer_name,
    customers.phone AS customer_phone,
    customers.email AS customer_email
FROM
    trips
JOIN
    cities AS from_city ON trips.from_city_id = from_city.id
JOIN
    cities AS to_city ON trips.to_city_id = to_city.id
JOIN
    drivers ON trips.driver_id = drivers.id
JOIN
    trip_customers ON trips.id = trip_customers.trip_id
JOIN
    customers ON trip_customers.customer_id = customers.id;

