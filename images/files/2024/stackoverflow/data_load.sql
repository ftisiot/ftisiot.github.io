-- Loading Users
\copy data_load from program 'tr -d "\t" < Users.xml | sed -e ''s/\\/\\\\/g''' HEADER


-- Loading posts
truncate data_load;

\copy data_load from program 'tr -d "\t" < Posts.xml | sed -e ''s/\\/\\\\/g''' HEADER

INSERT INTO POSTS (
    Id, PostTypeId, CreationDate, score, viewcount, 
    body, OwnerUserId, LastActivityDate, Title, Tags, AnswerCount,
    CommentCount, ContentLicense)
SELECT
     (xpath('//@Id', x))[1]::text::int
    ,(xpath('//@PostTypeId', x))[1]::text::int
    ,(xpath('//@CreationDate', x))[1]::text::timestamp
    ,(xpath('//@Score', x))[1]::text::int
    ,(xpath('//@ViewCount', x))[1]::text::int
    ,(xpath('//@Body', x))[1]::text 
    ,(xpath('//@OwnerUserId', x))[1]::text::int 
    ,(xpath('//@LastActivityDate', x))[1]::text::timestamp 
    ,(xpath('//@Title', x))[1]::text 
    ,(xpath('//@Tags', x))[1]::text 
    ,(xpath('//@AnswerCount', x))[1]::text::int 
    ,(xpath('//@CommentCount', x))[1]::text::int 
    ,(xpath('//@ContentLicense', x))[1]::text 
FROM data_load, unnest(xpath('//row', data::xml)) x
WHERE regexp_like(data,'[ ]+\<row');

-- Loading badges

truncate data_load;

\copy data_load from program 'tr -d "\t" < Badges.xml | sed -e ''s/\\/\\\\/g''' HEADER

INSERT INTO BADGES (
    Id, userId, Name, dt, class, 
    tagbased)
SELECT
     (xpath('//@Id', x))[1]::text::int
    ,(xpath('//@UserId', x))[1]::text::int
    ,(xpath('//@Name', x))[1]::text
    ,(xpath('//@Date', x))[1]::text::timestamp
    ,(xpath('//@Class', x))[1]::text::int
    ,(xpath('//@TagBased', x))[1]::text::boolean
FROM data_load, unnest(xpath('//row', data::xml)) x
WHERE regexp_like(data,'[ ]+\<row');

-- Loading comments

truncate data_load;

\copy data_load from program 'tr -d "\t" < Comments.xml | sed -e ''s/\\/\\\\/g''' HEADER

INSERT INTO COMMENTS (
    Id, postId, score, text, creationdate, 
    userid, contentlicense)
SELECT
     (xpath('//@Id', x))[1]::text::int
    ,(xpath('//@PostId', x))[1]::text::int
    ,(xpath('//@Score', x))[1]::text::int
    ,(xpath('//@Text', x))[1]::text
    ,(xpath('//@CreationDate', x))[1]::text::timestamp
    ,(xpath('//@UserId', x))[1]::text::int
    ,(xpath('//@ContentLicense', x))[1]::text
FROM data_load, unnest(xpath('//row', data::xml)) x
WHERE regexp_like(data,'[ ]+\<row');

-- Loading posthistory

truncate data_load;

\copy data_load from program 'tr -d "\t" < PostHistory.xml | sed -e ''s/\\/\\\\/g''' HEADER

INSERT INTO posthistory (
    Id, PostHistoryTypeId, postId, RevisionGUID, CreationDate, 
    userID, text, ContentLicense)
SELECT
     (xpath('//@Id', x))[1]::text::int
    ,(xpath('//@PostHistoryTypeId', x))[1]::text::int
    ,(xpath('//@PostId', x))[1]::text::int
    ,(xpath('//@RevisionGUID', x))[1]::text
    ,(xpath('//@CreationDate', x))[1]::text::timestamp
    ,(xpath('//@UserId', x))[1]::text::int
    ,(xpath('//@Text', x))[1]::text
    ,(xpath('//@ContentLicense', x))[1]::text
FROM data_load, unnest(xpath('//row', data::xml)) x
WHERE regexp_like(data,'[ ]+\<row');

-- Loading postlinks

truncate data_load;

\copy data_load from program 'tr -d "\t" < PostLinks.xml | sed -e ''s/\\/\\\\/g''' HEADER

INSERT INTO postlinks (
    Id, creationdate, postId, relatedPostId, LinkTypeId)
SELECT
     (xpath('//@Id', x))[1]::text::int
    ,(xpath('//@CreationDate', x))[1]::text::timestamp
    ,(xpath('//@PostId', x))[1]::text::int
    ,(xpath('//@RelatedPostId', x))[1]::text::int
    ,(xpath('//@LinkTypeId', x))[1]::text::int
FROM data_load, unnest(xpath('//row', data::xml)) x
WHERE regexp_like(data,'[ ]+\<row');


-- Loading tags

truncate data_load;

\copy data_load from program 'tr -d "\t" < Tags.xml | sed -e ''s/\\/\\\\/g''' HEADER

INSERT INTO tags (
    Id, tagname, count, ExcerptPostId, WikiPostId, IsModeratorOnly, IsRequired)
SELECT
     (xpath('//@Id', x))[1]::text::int
    ,(xpath('//@TagName', x))[1]::text
    ,(xpath('//@Count', x))[1]::text::int
    ,(xpath('//@ExcerptPostId', x))[1]::text::int
    ,(xpath('//@WikiPostId', x))[1]::text::int
    ,(xpath('//@IsModeratorOnly', x))[1]::text::boolean
    ,(xpath('//@IsRequired', x))[1]::text::boolean
FROM data_load, unnest(xpath('//row', data::xml)) x
WHERE regexp_like(data,'[ ]+\<row');

-- Loading votes

truncate data_load;

\copy data_load from program 'tr -d "\t" < Votes.xml | sed -e ''s/\\/\\\\/g''' HEADER

INSERT INTO votes (
    Id, postid, votetypeid, creationdate)
SELECT
     (xpath('//@Id', x))[1]::text::int
    ,(xpath('//@PostId', x))[1]::text::int
    ,(xpath('//@VoteTypeId', x))[1]::text::int
    ,(xpath('//@CreationDate', x))[1]::text::timestamp
FROM data_load, unnest(xpath('//row', data::xml)) x
WHERE regexp_like(data,'[ ]+\<row');