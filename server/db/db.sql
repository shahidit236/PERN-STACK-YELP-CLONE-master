CREATE TABLE reviews (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(id),
    name VARCHAR(50) NOT NULL,
    review TEXT NOT NULL,
    rating INT NOT NULL check(
        rating >= 1
        and rating <= 5
    )
);
-- select *
-- from restaurants
--     left join(
--         select restaurant_id,
--             count(*),
--             TRUNC(AVG(rating, 1)) as average_rating
--         from reviews
--         group by restaurant_id
--     ) reviews on restaurants.id = reviews.restaurant_id;


-- chatgpt code
SELECT restaurants.*,
       COALESCE(reviews.review_count, 0) AS review_count,
       ROUND(COALESCE(reviews.average_rating, 0), 1) AS average_rating
FROM restaurants
LEFT JOIN (
    SELECT restaurant_id,
           COUNT(*) AS review_count,
           AVG(rating) AS average_rating
    FROM reviews
    GROUP BY restaurant_id
) reviews ON restaurants.id = reviews.restaurant_id;
