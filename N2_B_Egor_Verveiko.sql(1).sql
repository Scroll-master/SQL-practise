№1
Create table SeatСost
(
    room_class decimal(6,0) NOT NULL,
    seatcost_price decimal(6,0)  NOT NULL,
    PRIMARY KEY (room_class)
);


Create table GUESTS
(
   passport_id CHAR(10) NOT NULL,
    occup_num decimal(6,0) NOT NULL,
    FIO CHAR(50)  NOT NULL,
    gender CHAR(1) DEFAULT 'M',
    org_guests CHAR(60) NULL,
    movein_date date NOT NULL,
    checkout_date date NULL,
    PRIMARY KEY (passport_id)
);

Create table ROOMS
(
    num_id decimal(6,0) NOT NULL,
     room_class decimal(6,0) NOT NULL,
     room_num decimal(6,0) NOT NULL,
     num_of_res_room decimal(6,0) NOT NULL,
    PRIMARY KEY (num_id)
);

ALTER TABLE GUESTS add constraint
FK_PK_GUESTS_ROOMS FOREIGN KEY (occup_num) REFERENCES ROOMS (num_id)

ALTER TABLE ROOMS add constraint
FK_PK_ROOMS_SeatСost FOREIGN KEY (room_class) REFERENCES SeatСost (room_class)


begin
INSERT INTO SeatСost (room_class, seatcost_price)
VALUES('3', '540');

INSERT INTO SeatСost (room_class, seatcost_price)
VALUES('5', '980');

INSERT INTO SeatСost (room_class, seatcost_price)
VALUES('1', '270');

INSERT INTO SeatСost (room_class, seatcost_price)
VALUES('2', '340');

end;

begin
INSERT INTO ROOMS (num_id, room_class, room_num, num_of_res_room)
VALUES( '100090', '3','12','7');

INSERT INTO ROOMS (num_id, room_class, room_num, num_of_res_room)
VALUES('100091','5', '6','6');

INSERT INTO ROOMS (num_id, room_class, room_num, num_of_res_room)
VALUES('100089','1', '20','4');

INSERT INTO ROOMS (num_id, room_class, room_num, num_of_res_room)
VALUES('100096','2', '15','6');

end;




begin
INSERT INTO GUESTS (passport_id, occup_num, FIO, gender, org_guests, movein_date, checkout_date)
VALUES('5643889261', '100090', 'Tovarish Stalin', 'M', 'Savok', TO_DATE('2016-07-11', 'yyyy-mm-dd'), NULL);

INSERT INTO GUESTS (passport_id, occup_num, FIO, gender, org_guests, movein_date, checkout_date)
VALUES('5643889077', '100091', 'Tovarish Lenin', 'M', 'Savok', TO_DATE('2017-11-05', 'yyyy-mm-dd'), NULL);

INSERT INTO GUESTS (passport_id, occup_num, FIO, gender, org_guests, movein_date, checkout_date)
VALUES('5643887001', '100089', 'Tovarish Carl Marks', 'M', 'Savok', TO_DATE('2018-08-14', 'yyyy-mm-dd'), NULL);

INSERT INTO GUESTS (passport_id, occup_num, FIO, gender, org_guests, movein_date, checkout_date)
VALUES('4367089170', '100096', 'Tovarish Mao', 'M', 'Savok', TO_DATE('2018-08-14', 'yyyy-mm-dd'), NULL);
end;




№2

1.-

2.
SELECT  num_id,room_class, room_num, room_num - num_of_res_room as count_free FROM ROOMS , GUESTS
WHERE ROOMS.num_id = GUESTS.occup_num
AND  room_num > num_of_res_room;

3.
SELECT num_id ,room_class, room_num , num_of_res_room FROM ROOMS
where  room_num = num_of_res_room;

№3

1.
CREATE VIEW GuestsRightNow AS
SELECT * FROM GUESTS

SELECT * FROM GuestsRightNow;

2.
CREATE VIEW FullRooms AS
SELECT num_id , room_num FROM ROOMS
where  room_num = num_of_res_room;

SELECT * FROM FullRooms;

3.
CREATE VIEW FreeRooms AS
SELECT gender,  num_id, room_num, room_num - num_of_res_room as count_free FROM ROOMS , GUESTS
WHERE ROOMS.num_id = GUESTS.occup_num
AND  room_num > num_of_res_room;

SELECT * FROM FreeRooms;