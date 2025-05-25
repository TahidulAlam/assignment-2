CREATE DATABASE conservation_db

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
)

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
)

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT NOT NULL,
    species_id INT NOT NULL,
    location VARCHAR(255) NOT NULL,
    sighting_time DATE NOT NULL,
    notes TEXT
)

-- CREATE TABLE sightings_new (
--     sighting_id SERIAL PRIMARY KEY,
--     species_id INT NOT NULL,
--     ranger_id INT NOT NULL,
--     location VARCHAR(255) NOT NULL,
--     sighting_time TIMESTAMP NOT NULL,
--     notes TEXT
-- )

-- INSERT INTO sightings_new (sighting_id, species_id, ranger_id,location,sighting_time, notes)
-- SELECT sighting_id, species_id, ranger_id,location,sighting_time, notes FROM sightings;

-- DROP TABLE sightings;

-- ALTER TABLE sightings_new RENAME TO sightings;

INSERT into
    rangers (name, region)
values (
        'Alice Green',
        ' Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

SELECT * FROM rangers;

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Endangered'
    );

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Asiatic Elephant',
        ' Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

SELECT * FROM species;

INSERT INTO
    sightings (
        ranger_id,
        species_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        4,
        4,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        (NULL)
    );
-- problem - 1
INSERT into
    rangers (name, region)
values ('Derek Fox', 'Coastal Plains');

-- problem - 2

Select count(*) AS unique_species_count
FROM (
        SELECT DISTINCT
            species_id
        FROM sightings
    ) AS unique_species;

-- UPDATE sightings
-- SET ranger_id = 2
-- WHERE sighting_id = 4;

-- problem - 3

SELECT * FROM sightings WHERE LOCATION ILIKE '%Pass%';

SELECT * FROM sightings;

SELECT * FROM species;

SELECT * FROM rangers;

-- problem - 4

SELECT
    r.name AS ranger_name,
    COUNT(s.sighting_id) AS total_sightings
FROM rangers r
    LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY
    r.name
HAVING
    COUNT(s.sighting_id) = 0
ORDER BY ranger_name;

-- problem - 5

SELECT sp.common_name AS common_name, s.sighting_time, r.name AS name
FROM
    sightings s
    JOIN rangers r ON s.ranger_id = r.ranger_id
    JOIN species sp ON s.species_id = sp.species_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- problem - 6

SELECT * FROM sightings ORDER BY sighting_time DESC LIMIT 2;

-- problem - 7

UPDATE sightings
SET
    notes = 'Historic'
WHERE
    sighting_time < '1800-01-01';

-- problem - 8

SELECT
    sighting_id,
    ranger_id,
    species_id,
    location,
    sighting_time,
    notes,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) >= 12
        AND EXTRACT(
            HOUR
            FROM sighting_time
        ) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- UPDATE sightings
-- SET
--     sighting_time = '2024-05-19 16:30:00'
-- WHERE
--     sighting_id = 1;

-- problem - 9

SELECT *
FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT DISTINCT
            ranger_id
        FROM sightings
    );

-- problem - 10

DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT DISTINCT
            ranger_id
        FROM sightings
    );