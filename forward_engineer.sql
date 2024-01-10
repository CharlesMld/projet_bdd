-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema 2024_INFO2_PENAVAIRE_MILLIAUD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 2024_INFO2_PENAVAIRE_MILLIAUD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `2024_INFO2_PENAVAIRE_MILLIAUD` ;
USE `2024_INFO2_PENAVAIRE_MILLIAUD` ;

-- -----------------------------------------------------
-- Table `2024_INFO2_PENAVAIRE_MILLIAUD`.`Abonné`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2024_INFO2_PENAVAIRE_MILLIAUD`.`Abonné` (
  `idAbonné` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prénom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `date_adhésion` DATE NOT NULL,
  `pénalité` INT NOT NULL,
  `id_contenu_emprunté` INT NULL,
  PRIMARY KEY (`idAbonné`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `2024_INFO2_PENAVAIRE_MILLIAUD`.`Contenu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2024_INFO2_PENAVAIRE_MILLIAUD`.`Contenu` (
  `idContenu` INT NOT NULL,
  `type_contenu` VARCHAR(45) NOT NULL,
  `code_cata` INT NOT NULL,
  `titre` VARCHAR(45) NOT NULL,
  `genre` VARCHAR(45) NOT NULL,
  `p/n` VARCHAR(45) NOT NULL,
  `localisation` VARCHAR(45) NULL,
  `statut` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idContenu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `2024_INFO2_PENAVAIRE_MILLIAUD`.`Livre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2024_INFO2_PENAVAIRE_MILLIAUD`.`Livre` (
  `idLivre` INT NOT NULL,
  `auteur` VARCHAR(45) NOT NULL,
  `éditeur` VARCHAR(45) NOT NULL,
  `Contenu_idContenu` INT NOT NULL,
  PRIMARY KEY (`idLivre`, `Contenu_idContenu`),
  INDEX `fk_Livre_Contenu1_idx` (`Contenu_idContenu` ASC) VISIBLE,
  CONSTRAINT `fk_Livre_Contenu1`
    FOREIGN KEY (`Contenu_idContenu`)
    REFERENCES `2024_INFO2_PENAVAIRE_MILLIAUD`.`Contenu` (`idContenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `2024_INFO2_PENAVAIRE_MILLIAUD`.`CD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2024_INFO2_PENAVAIRE_MILLIAUD`.`CD` (
  `idCD` INT NOT NULL,
  `chanteur` VARCHAR(45) NOT NULL,
  `producteur` VARCHAR(45) NOT NULL,
  `Contenu_idContenu` INT NOT NULL,
  PRIMARY KEY (`idCD`, `Contenu_idContenu`),
  INDEX `fk_CD_Contenu1_idx` (`Contenu_idContenu` ASC) VISIBLE,
  CONSTRAINT `fk_CD_Contenu1`
    FOREIGN KEY (`Contenu_idContenu`)
    REFERENCES `2024_INFO2_PENAVAIRE_MILLIAUD`.`Contenu` (`idContenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `2024_INFO2_PENAVAIRE_MILLIAUD`.`Film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2024_INFO2_PENAVAIRE_MILLIAUD`.`Film` (
  `idDVD/Blu-Ray` INT NOT NULL,
  `typeFilm` VARCHAR(45) NOT NULL,
  `acteur` VARCHAR(45) NOT NULL,
  `réalisateur` VARCHAR(45) NOT NULL,
  `Contenu_idContenu` INT NOT NULL,
  PRIMARY KEY (`idDVD/Blu-Ray`, `Contenu_idContenu`),
  INDEX `fk_Film_Contenu1_idx` (`Contenu_idContenu` ASC) VISIBLE,
  CONSTRAINT `fk_Film_Contenu1`
    FOREIGN KEY (`Contenu_idContenu`)
    REFERENCES `2024_INFO2_PENAVAIRE_MILLIAUD`.`Contenu` (`idContenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `2024_INFO2_PENAVAIRE_MILLIAUD`.`Emprunts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2024_INFO2_PENAVAIRE_MILLIAUD`.`Emprunts` (
  `Abonné_idAbonné` INT NOT NULL,
  `Contenu_idContenu` INT NOT NULL,
  `date_emprunt` DATE NOT NULL,
  `date_retour_reelle` DATE NULL,
  `date_retour_theo` DATE NOT NULL,
  PRIMARY KEY (`Abonné_idAbonné`, `Contenu_idContenu`),
  INDEX `fk_Abonné_has_Contenu_Contenu1_idx` (`Contenu_idContenu` ASC) VISIBLE,
  INDEX `fk_Abonné_has_Contenu_Abonné1_idx` (`Abonné_idAbonné` ASC) VISIBLE,
  CONSTRAINT `fk_Abonné_has_Contenu_Abonné1`
    FOREIGN KEY (`Abonné_idAbonné`)
    REFERENCES `2024_INFO2_PENAVAIRE_MILLIAUD`.`Abonné` (`idAbonné`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Abonné_has_Contenu_Contenu1`
    FOREIGN KEY (`Contenu_idContenu`)
    REFERENCES `2024_INFO2_PENAVAIRE_MILLIAUD`.`Contenu` (`idContenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `2024_INFO2_PENAVAIRE_MILLIAUD`.`Demandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2024_INFO2_PENAVAIRE_MILLIAUD`.`Demandes` (
  `Abonné_idAbonné` INT NOT NULL,
  `Contenu_idContenu` INT NOT NULL,
  `date_demande` DATE NOT NULL,
  PRIMARY KEY (`Abonné_idAbonné`, `Contenu_idContenu`),
  INDEX `fk_Abonné_has_Contenu_Contenu2_idx` (`Contenu_idContenu` ASC) VISIBLE,
  INDEX `fk_Abonné_has_Contenu_Abonné2_idx` (`Abonné_idAbonné` ASC) VISIBLE,
  CONSTRAINT `fk_Abonné_has_Contenu_Abonné2`
    FOREIGN KEY (`Abonné_idAbonné`)
    REFERENCES `2024_INFO2_PENAVAIRE_MILLIAUD`.`Abonné` (`idAbonné`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Abonné_has_Contenu_Contenu2`
    FOREIGN KEY (`Contenu_idContenu`)
    REFERENCES `2024_INFO2_PENAVAIRE_MILLIAUD`.`Contenu` (`idContenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
