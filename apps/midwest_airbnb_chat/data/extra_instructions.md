# Extra Instructions

Rules the LLM follows when it writes SQL for `listings`.

- `price` is the nightly price in U.S. dollars. When the user asks what something costs, use `price` and round money to whole dollars in the answer.
- `accommodates` is the maximum number of people the listing can host. Use `accommodates` if asked a question about a certain number of guests or visitors.
- When asking about host names, make sure to group `host_name` with `host_id` as multiple different hosts can have the same name but not the same id. 
<!-- Add more rules below (Assignment 05 asks for at least three). Good candidates:
     `host_is_superhost` and `instant_bookable` are the text values 't' and 'f',
     not booleans; how to match a city name the user types; how to search `name`
     case-insensitively; and whether to ignore rows whose `review_scores_rating`
     is NULL when averaging ratings. -->
