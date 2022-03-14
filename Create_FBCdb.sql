DROP DATABASE IF EXISTS FBC;
CREATE DATABASE FBC;
USE FBC;

CREATE TABLE IF NOT EXISTS altered_world_event(
    awe_id VARCHAR(10) NOT NULL UNIQUE,
    agent VARCHAR(20) NOT NULL,
    location VARCHAR(20) NOT NULL,
    resulting_item VARCHAR(10) NOT NULL UNIQUE,
    status VARCHAR(20) DEFAULT 'CLOSED',
    CONSTRAINT awe_status CHECK ((status= 'Ongoing') OR (status = 'Closed')),
    CONSTRAINT awe_pk PRIMARY KEY (awe_id)
);
INSERT INTO altered_world_event VALUES('AWE-1','Zachariah Trench','The Astral Plane','AI-0','Ongoing');
INSERT INTO altered_world_event VALUES('AWE-7','Zachariah Trench','Fra Mauro','AI-1','Closed');
INSERT INTO altered_world_event VALUES('AWE-17','Dr. Casper Darling','Oceanview Motel','AI-8','Ongoing');
INSERT INTO altered_world_event VALUES('AWE-24','Frederick Langston','Ordinary','AI-15','Closed');
INSERT INTO altered_world_event VALUES('AWE-35','Robert Nightingale','Bright Falls','AI-83','Ongoing');
INSERT INTO altered_world_event VALUES('AWE-48','Lin Salvador','Havana','AI-85','Closed');

CREATE TABLE IF NOT EXISTS altered_item (
    ai_id VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(20) NOT NULL,
    awe VARCHAR(10) NOT NULL,
    properties VARCHAR(255) NOT NULL,
    monitor VARCHAR(20) NOT NULL,
    CONSTRAINT ai_pk PRIMARY KEY (ai_id)
);
INSERT INTO altered_item VALUES('AI-0','Service Pistol;','AWE-1','Weapon used by Director chosen by The Board,...','Zachariah Trench');
INSERT INTO altered_item VALUES('AI-1','[REDACTED]','AWE-7','SEE ENTITY FRA','Zachariah Trench');
INSERT INTO altered_item VALUES('AI-8','The Lightswitch','AWE-17','Transports user to Oceanview Motel and ...','Dr. Casper Darling');
INSERT INTO altered_item VALUES('AI-15','Slide Projector','AWE-24','Allows user to travel to different places using...','Zachariah Trench');
INSERT INTO altered_item VALUES('AI-83','Typewritten Page','AWE-35','Author appears and begins to read...','Dr. Casper Darling');
INSERT INTO altered_item VALUES('AI-85','Cowboy Boot','AWE-48','Causes auditory damage and vertigo while...','Frederick Langston');

CREATE TABLE IF NOT EXISTS role (
    title VARCHAR(20) NOT NULL UNIQUE,
    clearance INT NOT NULL,
    answers_to VARCHAR(20),
    no_of_holders INT,
    CONSTRAINT clearance_level CHECK ((clearance >= 1) AND (clearance <= 5)),
    CONSTRAINT role_pk PRIMARY KEY (title)
);
INSERT INTO role VALUES('Director',5,NULL,1);
INSERT INTO role VALUES('Department Head',4,'Director',6);
INSERT INTO role VALUES('Supervisor',3,'Department Head',300);
INSERT INTO role VALUES('Agent',2,'Supervisor',5000);
INSERT INTO role VALUES('Janitor',5,'Director',1);

CREATE TABLE IF NOT EXISTS agent (
    name VARCHAR(20) NOT NULL UNIQUE,
    date_of_birth DATE,
    role VARCHAR(20) NOT NULL,
    gender VARCHAR(20) NOT NULL DEFAULT 'Non-Binary',
    department VARCHAR(20) NOT NULL,
    CONSTRAINT agent_gender CHECK ((gender = 'Male') OR 
        (gender = 'Female') OR (gender = 'Non-Binary')),
    CONSTRAINT agent_pk PRIMARY KEY (name)
);
INSERT INTO agent VALUES('Zachariah Trench','1956-04-28','Director','Male','Executive');
INSERT INTO agent VALUES('Dr. Casper Darling','1972-02-08','Department Head','Male','Research');
INSERT INTO agent VALUES('Lin Salvador','1964-03-14','Department Head','Male','Maintenance');
INSERT INTO agent VALUES('Dr. Raya Underhill','1985-06-06','Supervisor','Female','Research');
INSERT INTO agent VALUES('Robert Nightingale','1981-07-18','Agent','Male','Operations');
INSERT INTO agent VALUES('Helen Marshall','1978-04-22','Department Head','Female','Operations');
INSERT INTO agent VALUES('Ahti','0000-01-01','Janitor','Non-Binary','Foundation');
INSERT INTO agent VALUES('Frederick Langston','1966-03-03','Department Head','Male','Panopticon');

CREATE TABLE IF NOT EXISTS department(
    title VARCHAR(20) NOT NULL UNIQUE,
    floor_number INT NOT NULL,
    dep_head VARCHAR(20) NOT NULL,
    no_ai_contained INT,
    purpose VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'Normal',
    CONSTRAINT floor_number_check CHECK (floor_number >= 0),
    CONSTRAINT dep_status CHECK ((status = 'Normal') OR
        (status = 'Danger') OR (status = 'Compromised')),
    CONSTRAINT dep_pk PRIMARY KEY (title)
);
INSERT INTO department VALUES('Executive',5,'Zachariah Trench',3,'Central Control','Normal');
INSERT INTO department VALUES('Research',3,'Dr. Casper Darling',40,'Research of Altered Items','Normal');
INSERT INTO department VALUES('Operations',4,'Helen Marshall',10,'Control of AWE Operations','Normal');
INSERT INTO department VALUES('Maintenance',1,'Lin Salvador',15,'Maintaining NSC Power Source','Danger');
INSERT INTO department VALUES('Panopticon',2,'Frederick Langston',60,'Containment of Dangerous Altered Items','Danger');
INSERT INTO department VALUES('Foundation',0,'Ahti',1,'[CLASSIFIED]','Compromised');

CREATE TABLE IF NOT EXISTS areas_of_interest (
    name VARCHAR(20) NOT NULL UNIQUE,
    location VARCHAR(255) DEFAULT 'UNKNOWN',
    result_of VARCHAR(10) NOT NULL,
    agent VARCHAR(20) NOT NULL,
    CONSTRAINT aoi_pk PRIMARY KEY (name)
);
INSERT INTO areas_of_interest VALUES('Fra Mauro','Dark Side of the Moon','AWE-7','Zachariah Trench');
INSERT INTO areas_of_interest VALUES('Oceanview Motel','Unknown','AWE-17','Dr. Casper Darling');
INSERT INTO areas_of_interest VALUES('Ordinary','Maine, USA','AWE-24','Zachariah Trench');
INSERT INTO areas_of_interest VALUES('Bright Falls','Washington, USA','AWE-35','Robert Nightingale');
INSERT INTO areas_of_interest VALUES('Havana','Cuba','AWE-48','Lin Salvador');
INSERT INTO areas_of_interest VALUES('The Astral Plane','Unknown','AWE-1','Dr. Casper Darling');

CREATE TABLE IF NOT EXISTS known_entities (
    name VARCHAR(255) NOT NULL UNIQUE,
    awe VARCHAR(10) NOT NULL,
    location VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'UNKNOWN',
    description VARCHAR(255) DEFAULT 'Little Information',
    CONSTRAINT entity_status CHECK ((status = 'Friendly') OR
    (status = 'Dangerous') OR (status = 'Unknown')),
    CONSTRAINT entity_pk PRIMARY KEY (name)
);
INSERT INTO known_entities VALUES('Fra','AWE-7','Fra Mauro','Friendly','Found in Fra Mauro Canyon by Apollo 14...');
INSERT INTO known_entities VALUES('Polaris','AWE-24','Ordinary','Friendly','Found in Slide-36 of AI-15, nicknamed "The Hand"...');
INSERT INTO known_entities VALUES('The Hiss','AWE-24','Ordinary','Dangerous','Found with Polaris, The resonance of The Hiss...');
INSERT INTO known_entities VALUES('The Board','AWE-1','The Astral Plane','Unknown','Controlling the choosing of Director of the FBC, The Board...');
INSERT INTO known_entities VALUES('The Former','AWE-1','The Astral Plane','Unknown','Little Information, possibly former mamber of...');
INSERT INTO known_entities VALUES('The Dark Presence','AWE-35','Bright Falls','Dangerous','Having kidnapped author [REDACTED] this entity...');

ALTER TABLE altered_world_event ADD FOREIGN KEY (agent) REFERENCES agent(name);
ALTER TABLE altered_world_event ADD FOREIGN KEY (location) REFERENCES areas_of_interest(name);
ALTER TABLE altered_world_event ADD FOREIGN KEY (resulting_item) REFERENCES altered_item(ai_id);

ALTER TABLE altered_item ADD FOREIGN KEY (awe) REFERENCES altered_world_event(awe_id);
ALTER TABLE altered_item ADD FOREIGN KEY (monitor) REFERENCES agent(name);

ALTER TABLE agent ADD FOREIGN KEY (role) REFERENCES role(title);
ALTER TABLE agent ADD FOREIGN KEY (department) REFERENCES department(title);

ALTER TABLE department ADD FOREIGN KEY (dep_head) REFERENCES agent(name);

ALTER TABLE areas_of_interest ADD FOREIGN KEY (result_of) REFERENCES altered_world_event(awe_id);
ALTER TABLE areas_of_interest ADD FOREIGN KEY (agent) REFERENCES agent(name);

ALTER TABLE known_entities ADD FOREIGN KEY (awe) REFERENCES altered_world_event(awe_id);
ALTER TABLE known_entities ADD FOREIGN KEY (location) REFERENCES areas_of_interest(name);

DELIMITER //
CREATE TRIGGER new_awe AFTER INSERT ON altered_world_event
FOR EACH ROW
BEGIN
	INSERT INTO altered_item SET ai_id = new.resulting_item;
    IF NOT EXISTS(SELECT * FROM areas_of_interest WHERE(areas_of_interest.name = NEW.location))
		THEN INSERT INTO areas_of_interest SET name = new.location;
    ELSE 
		UPDATE areas_of_interest SET result_of = new.awe_id;
	END IF;
END; //
DELIMITER ;

CREATE OR REPLACE VIEW agent_clearance AS 
	SELECT agent.name, role.clearance 
	FROM agent, role 
	WHERE agent.role = role.title;

CREATE OR REPLACE VIEW entities_item AS
	SELECT known_entities.name, known_entities.status, 
			altered_item.ai_id, altered_item.name AS item_name
    FROM known_entities, altered_item
    WHERE known_entities.awe = altered_item.awe;
    
DELIMITER $$
CREATE FUNCTION Calculate_Age(dob DATE)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE TodayDate DATE;
    SELECT CURRENT_DATE() INTO TodayDate;
    RETURN YEAR(TodayDate) - YEAR(dob);
END$$
DELIMITER ;

CREATE ROLE 'director','department_head','supervisor','agent';
GRANT ALL ON FBC.* TO 'director';
GRANT INSERT,UPDATE,SELECT ON FBC.* TO 'department_head','supervisor';
GRANT SELECT ON FBC.* TO 'agent';

CREATE USER 'z_trench'@'localhost' IDENTIFIED BY 'DIRECTOR03';
CREATE USER 'c_darling'@'localhost' IDENTIFIED BY 'DHEAD13';
CREATE USER 'r_underhill'@'localhost' IDENTIFIED BY 'SUP35';
CREATE USER 'r_nighingale'@'localhost' IDENTIFIED BY 'AG1010';

GRANT 'director' TO 'z_trench'@'localhost';
GRANT 'department_head' TO 'c_darling'@'localhost';
GRANT 'supervisor' TO 'r_underhill'@'localhost';
GRANT 'agent' TO 'r_nighingale'@'localhost';