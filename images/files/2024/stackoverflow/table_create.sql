--Creating Tables
CREATE TABLE data_load (
    data text
);

CREATE TABLE users(
    id int PRIMARY KEY,
    reputation int,
    CreationDate text,
    DisplayName text,
    LastAccessDate timestamp,
    Location text,
    AboutMe text,
    views int,
    UpVotes int,
    DownVotes int,
    AccountId int
);

CREATE TABLE posts (
    id int PRIMARY KEY,
    PostTypeId int,
    CreationDate timestamp,
    score int,
    viewcount int,
    body text,
    OwnerUserId int,
    LastActivityDate text,
    Title text,
    Tags text,
    AnswerCount int,
    CommentCount int,
    ContentLicense text
);

CREATE TABLE badges (
    id int PRIMARY KEY,
    userId int,
    Name text,
    dt timestamp,
    class int,
    tagbased boolean
);

CREATE TABLE comments (
    id int,
    postId int,
    score int,
    text text,
    creationdate timestamp,
    userid int,
    contentlicense text
);

CREATE TABLE posthistory (
    id int,
    PostHistoryTypeId int,
    postId int,
    RevisionGUID text,
    CreationDate timestamp,
    userID int,
    text text,
    ContentLicense text
);

CREATE TABLE postlinks (
    id int,
    creationdate timestamp,
    postId int,
    relatedPostId int,
    LinkTypeId int
);

CREATE TABLE tags (
    id int,
    tagname text,
    count int,
    ExcerptPostId int,
    WikiPostId int,
    IsRequired boolean,
    IsModeratorOnly boolean
);

CREATE TABLE votes(
    id int,
    postid int,
    votetypeid int,
    creationdate timestamp
);