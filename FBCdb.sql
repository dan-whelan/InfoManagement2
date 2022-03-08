CREATE TABLE `ALTERED_WORLD_EVENT` (
    `AWE_ID` VARCHAR(10) NOT NULL UNIQUE,
    `AGENT` VARCHAR(20) NOT NULL,
    `LOCATION` VARCHAR(20) NOT NULL,
    `RESULTING_ITEM` VARCHAR(10) NOT NULL UNIQUE,
    `STATUS` VARCHAR(20) DEFAULT 'CLOSED',
    CONSTRAINT `AWE_STATUS` CHECK ((`STATUS`= 'Ongoing') OR (`STATUS` = 'Closed')),
    CONSTRAINT `AWE_PK` PRIMARY KEY (`AWE_ID`)
);

CREATE TABLE `ALTERED_ITEMS` (
    `AI_ID` VARCHAR(10) NOT NULL UNIQUE,
    `NAME` VARCHAR(20) NOT NULL,
    `AWE` VARCHAR(10) NOT NULL,
    `PROPERTIES` VARCHAR(255) NOT NULL,
    `MONITOR` VARCHAR(20) NOT NULL,
    CONSTRAINT `AI_PK` PRIMARY KEY (`AI_ID`)
);

CREATE TABLE `ROLE` (
    `TITLE` VARCHAR(20) NOT NULL UNIQUE ,
    `CLEARANCE` INT NOT NULL,
    `ANSWERS_TO` VARCHAR(20) NOT NULL UNIQUE,
    `#OF_HOLDERS` INT,
    CONSTRAINT `CLEARANCE_LEVEL` CHECK ((`CLEARANCE` >= 1) AND (`CLEARANCE` <= 5)),
    CONSTRAINT `ROLE_PK` PRIMARY KEY (`TITLE`)
);

CREATE TABLE `AGENT` (
    `NAME` VARCHAR(20) NOT NULL UNIQUE,
    `DATE_OF_BIRTH` DATE,
    `ROLE` VARCHAR(20) NOT NULL,
    `GENDER` VARCHAR(10) NOT NULL DEFAULT 'Non-Binary',
    `DEPARTMENT` VARCHAR(20) NOT NULL,
    CONSTRAINT `AGENT_GENDER` CHECK ((`GENDER` = 'Male') OR 
        (`GENDER` = 'Female') OR (`GENDER` = 'Non-Binary')),
    CONSTRAINT `AGENT_PK` PRIMARY KEY (`NAME`)
);

CREATE TABLE `DEPARTMENT`(
    `TITLE` VARCHAR(20) NOT NULL UNIQUE,
    `FLOOR` INT NOT NULL,
    `DEP_HEAD` VARCHAR(20) NOT NULL,
    `#AI_CONTAINED` INT,
    `PURPOSE` VARCHAR(255) NOT NULL,
    `STATUS` VARCHAR(20) DEFAULT 'Normal',
    CONSTRAINT `FLOOR_NUMBER` CHECK (FLOOR >= 0),
    CONSTRAINT `DEP_STATUS` CHECK ((`STATUS` = 'Normal') OR
        (`STATUS` = 'Danger') OR (`STATUS` = 'Compromised')),
    CONSTRAINT `DEP_PK` PRIMARY KEY (`TITLE`)
);

CREATE TABLE `AREAS_OF_INTEREST` (
    `NAME` VARCHAR(20) NOT NULL UNIQUE,
    `LOCATION` VARCHAR(20) DEFAULT 'UNKNOWN',
    `RESULT_OF` VARCHAR(10) NOT NULL,
    `AGENT` VARCHAR(20) NOT NULL,
    CONSTRAINT `AOI_PK` PRIMARY KEY (`NAME`)
);

CREATE TABLE `KNOWN_ENTITIES` (
    `NAME` VARCHAR(255) NOT NULL UNIQUE,
    `AWE` VARCHAR(10) NOT NULL,
    `LOCATION` VARCHAR(20) NOT NULL,
    `STATUS` VARCHAR(20) NOT NULL DEFAULT 'UNKNOWN',
    `DESCRIPTION` VARCHAR(255) DEFAULT 'Little Information',
    CONSTRAINT `ENTITY_STATUS` CHECK ((`STATUS` = 'Friendly') OR
    (`STATUS` = 'Dangerous') OR (`STATUS` = 'Unknown')),
    CONSTRAINT `ENTITY_PK` PRIMARY KEY (`NAME`)
);

ALTER TABLE `ALTERED_WORLD_EVENT` ADD FOREIGN KEY (`AGENT`) REFERENCES `AGENT`(`NAME`);
ALTER TABLE `ALTERED_WORLD_EVENT` ADD FOREIGN KEY (`LOCATION`) REFERENCES `AREAS_OF_INTEREST`(`NAME`);
ALTER TABLE `ALTERED_WORLD_EVENT` ADD FOREIGN KEY (`RESULTING_ITEM`) REFERENCES `ALTERED_ITEMS`(`AI_ID`);

ALTER TABLE `ALTERED_ITEMS` ADD FOREIGN KEY (`AWE`) REFERENCES `ALTERED_WORLD_EVENT`(`AWE_ID`);
ALTER TABLE `ALTERED_ITEMS` ADD FOREIGN KEY (`MONITOR`) REFERENCES `AGENT`(`NAME`);

ALTER TABLE `ROLE` ADD FOREIGN KEY (`ANSWERS_TO`) REFERENCES `ROLE`(`TITLE`);

ALTER TABLE `AGENT` ADD FOREIGN KEY (`ROLE`) REFERENCES `ROLE`(`TITLE`);
ALTER TABLE `AGENT` ADD FOREIGN KEY (`DEPARTMENT`) REFERENCES `DEPARTMENT`(`NAME`);

ALTER TABLE `DEPARTMENT` ADD FOREIGN KEY (`DEP_HEAD`) REFERENCES `AGENT`(`NAME`);

ALTER TABLE `AREAS_OF_INTEREST` ADD FOREIGN KEY (`RESULT_OF`) REFERENCES `ALTERED_WORLD_EVENT`(`AWE_ID`);
ALTER TABLE `AREAS_OF_INTEREST` ADD FOREIGN KEY (`AGENT`) REFERENCES `AGENT`(`NAME`);

ALTER TABLE `KNOWN_ENTITIES` ADD FOREIGN KEY (`AWE`) REFERENCES `ALTERED_WORLD_EVENT`(`AWE_ID`);
ALTER TABLE `KNOWN_ENTITIES` ADD FOREIGN KEY (`LOCATION`) REFERENCES `AREAS_OF_INTEREST`(`NAME`);

INSERT INTO `ALTERED_WORLD_EVENT` VALUES('AWE-1','Zachariah Trench','The Astral Plane','AI-0','Ongoing');
INSERT INTO `ALTERED_WORLD_EVENT` VALUES('AWE-7','Zachariah Trench','Fra Mauro','AI-1','Closed');
INSERT INTO `ALTERED_WORLD_EVENT` VALUES('AWE-17','Dr. Casper Darling','Oceanview Motel','AI-8','Ongoing');
INSERT INTO `ALTERED_WORLD_EVENT` VALUES('AWE-24','Frederick Langston','Ordinary','AI-15','Closed');
INSERT INTO `ALTERED_WORLD_EVENT` VALUES('AWE-35','Robert Nightingale','Bright Falls','AI-83','Ongoing');
INSERT INTO `ALTERED_WORLD_EVENT` VALUES('AWE-48','Lin Salvador','Havana','AI-85','Closed');

INSERT INTO `ALTERED_ITEM` VALUES(
INSERT INTO `ALTERED_ITEM` VALUES('AI-1','[CLASSIFIED]','AWE-7','SEE ENTITY FRA','Zachariah Trench');
INSERT INTO `ALTERED_ITEM` VALUES('AI-8','The Lightswitch','AWE-17','Transports user to Oceanview Motel and ...','Dr. Casper Darling');
INSERT INTO `ALTERED_ITEM` VALUES('AI-15','Slide Projector','AWE_24','Allows user to travel to different places using...','Zachariah Trench');
INSERT INTO `ALTERED_ITEM` VALUES('AI-83','Typewritten Page','AWE-35','Author appears and begins to read...','Dr. Casper Darling');
INSERT INTO `ALTERED_ITEM` VALUES('AI-85','Cowboy Boot','AWE-48','Causes auditory damage and vertigo while...','Frederick Langston');

INSERT INTO `ROLE` VALUES('Director',5,'Director',1);
INSERT INTO `ROLE` VALUES('Department Head',4,'Director',6);
INSERT INTO `ROLE` VALUES('Supervisor',3,'Department Head',300);
INSERT INTO `ROLE` VALUES('Agent',2,'Supervisor',5000);
INSERT INTO `ROLE` VALUES('Janitor',5,'Director',1);

INSERT INTO `AGENT` VALUES('Zachariah Trench','1956-04-28','Director','Male','Executive');
INSERT INTO `AGENT` VALUES('Dr. Casper Darling','1972-02-08','Male','Department Head','Research');
INSERT INTO `AGENT` VALUES('Lin Salvador','1964-03-14','Male','Department Head','Maintenance');
INSERT INTO `AGENT` VALUES('Dr. Raya Underhill','1985-06-06','Female','Supervisor','Research');
INSERT INTO `AGENT` VALUES('Robert Nightingale','1981-07-18','Male','Agent','Operations');
INSERT INTO `AGENT` VALUES('Helen Marshall','1978-04-22','Female','Department Head','Operations');
INSERT INTO `AGENT` VALUES('Ahti','0000-01-01','Non-Binary','Janitor','Foundation');
INSERT INTO `AGENT` VALUES('Frederick Langston','1966-03-03','Male','Department Head','Panopticon');

INSERT INTO `DEPARTMENT` VALUES('Executive',5,'Zachariah Trench',3,'Central Control','Normal');
INSERT INTO `DEPARTMENT` VALUES('Research',3,'Dr. Casper Darling',40,'Research of Altered Items','Normal');
INSERT INTO `DEPARTMENT` VALUES('Operations',4,'Helen Marshall',10,'Control of AWE Operations','Normal');
INSERT INTO `DEPARTMENT` VALUES('Maintenance',1,'Lin Salvador',15,'Maintaining NSC Power Source','Danger');
INSERT INTO `DEPARTMENT` VALUES('Panopticon',2,'Frederick Langston',60,'Containment of Dangerous Altered Items','Danger');
INSERT INTO `DEPARTMENT` VALUES('Foundation',0,'Ahti',1,'[CLASSIFIED]','Compromised');

INSERT INTO `AREAS_OF_INTEREST` VALUES('Fra Mauro','Dark Side of the Moon','AWE-7','Zachariah Trench');
INSERT INTO `AREAS_OF_INTEREST` VALUES('Oceanview Motel','Unknown','AWE-17','Dr. Casper Darling');
INSERT INTO `AREAS_OF_INTEREST` VALUES('Ordinary','Maine, USA','AWE-24','Zachariah Trench');
INSERT INTO `AREAS_OF_INTEREST` VALUES('Bright Falls','Washington, USA','AWE-35','Robert Nightingale');
INSERT INTO `AREAS_OF_INTEREST` VALUES('Havana','Cuba','AWE-48','Lin Salvador');
INSERT INTO `AREAS_OF_INTEREST` VALUES('The Astral Plane','Unknown','AWE-1','Dr. Casper Darling');

INSERT INTO `KNOWN_ENTITIES` VALUES('Fra','AWE-7','Fra Mauro','Friendly','Found in Fra Mauro Canyon by Apollo 14...');
INSERT INTO `KNOWN_ENTITIES` VALUES('Polaris','AWE-24','Ordinary','Friendly','Found in Slide-36 of AI-15, nicknamed "The Hand"...');
INSERT INTO `KNOWN_ENTITIES` VALUES('The Hiss','AWE-24','Ordinary','Dangerous','Found with Polaris, The resonance of The Hiss...');
INSERT INTO `KNOWN_ENTITIES` VALUES('The Board','AWE-1','The Astral Plane','Unknown','Controlling the choosing of Director of the FBC, The Board...');
INSERT INTO `KNOWN_ENTITIES` VALUES('The Former','AWE-1','The Astral Plane','Unknown','Little Information, possibly former mamber of...');
INSERT INTO `KNOWN_ENTITIES` VALUES('The Dark Presence','AWE-35','Bright Falls','Dangerous','Having kidnapped author [REDACTED] this entity...');