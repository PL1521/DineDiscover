CREATE TABLE reviews (
    /* BIGSERIAL gives a unique id */
    /* NOT NULL ensures there always is an entry */
    id BIGSERIAL NOT NULL PRIMARY KEY,
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(id),
    name VARCHAR(50) NOT NULL,
    review TEXT NOT NULL,
    rating INT NOT NULL check(
        rating >= 1
        and rating <= 5
    )
);

/* Inserts information into the table
INSERT INTO restaurants (name, location, price_range) values ('Wendys', 'Denver', 3);
*/

SELECT *
FROM restaurants
    left join(
        select restaurant_id,
            count(*),
            TRUNC(AVG(rating, 1)) as average_rating
        from reviews
        group by restaurant_id
    ) reviews on restaurants.id = reviews.restaurant_id;