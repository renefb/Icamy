-- NAC 2: SCRIPTS DML (MASSA DE DADOS PARA TESTE)
-- INTEGRANTES DO GRUPO:
-- 76007 - BIANCA CESAR TURCO
-- 77329 - LUCAS TAVARES DA ROCHA
-- 74426 - MAXWELL MARTINS LIMA
-- 76190 - RENÊ FERNANDES BARBOSA
-- 77150 - THIAGO TADEU BETTIOL FRATINI

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema icamydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `icamydb` ;

-- -----------------------------------------------------
-- Schema icamydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `icamydb` DEFAULT CHARACTER SET utf8 ;
USE `icamydb` ;

-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_PRESTADOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_PRESTADOR` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_PRESTADOR` (
  `cd_prestador` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nm_prestador` VARCHAR(255) NOT NULL,
  `ds_tipo_pessoa` CHAR(1) NOT NULL,
  `nr_documento` BIGINT(14) UNSIGNED NOT NULL,
  `nr_telefone` BIGINT(11) NOT NULL,
  `ds_email` VARCHAR(255) NOT NULL,
  `ds_senha` VARCHAR(255) NOT NULL,
  `tx_apresentacao` TEXT NOT NULL,
  `dt_nascimento` DATE NULL,
  PRIMARY KEY (`cd_prestador`),
  UNIQUE INDEX `cpf_prestador_UNIQUE` (`nr_documento` ASC),
  UNIQUE INDEX `ds_email_UNIQUE` (`ds_email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_CLIENTE` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_CLIENTE` (
  `cd_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nm_cliente` VARCHAR(255) NOT NULL,
  `nr_cpf` BIGINT(11) UNSIGNED NOT NULL,
  `nr_telefone` BIGINT(11) NOT NULL,
  `ds_email` VARCHAR(255) NOT NULL,
  `ds_senha` VARCHAR(255) NOT NULL,
  `dt_nascimento` DATE NULL,
  `ds_sexo` CHAR(1) NULL,
  PRIMARY KEY (`cd_cliente`),
  UNIQUE INDEX `nr_cpf_UNIQUE` (`nr_cpf` ASC),
  UNIQUE INDEX `ds_email_UNIQUE` (`ds_email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_PORTFOLIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_PORTFOLIO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_PORTFOLIO` (
  `cd_arquivo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_prestador` INT UNSIGNED NOT NULL,
  `ds_url` VARCHAR(255) NOT NULL,
  `nm_arquivo` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cd_arquivo`, `cd_prestador`),
  INDEX `fk_T_ICM_PORTFOLIO_T_ICM_PRESTADOR_idx` (`cd_prestador` ASC),
  CONSTRAINT `fk_T_ICM_PORTFOLIO_T_ICM_PRESTADOR`
    FOREIGN KEY (`cd_prestador`)
    REFERENCES `icamydb`.`T_ICM_PRESTADOR` (`cd_prestador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_ESTADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_ESTADO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_ESTADO` (
  `cd_estado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ds_nome` VARCHAR(255) NOT NULL,
  `ds_sigla` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cd_estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_CIDADE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_CIDADE` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_CIDADE` (
  `cd_cidade` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_estado` INT UNSIGNED NOT NULL,
  `nm_cidade` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cd_cidade`, `cd_estado`),
  INDEX `fk_T_ICM_CIDADE_T_ICM_ESTADO1_idx` (`cd_estado` ASC),
  CONSTRAINT `fk_T_ICM_CIDADE_T_ICM_ESTADO1`
    FOREIGN KEY (`cd_estado`)
    REFERENCES `icamydb`.`T_ICM_ESTADO` (`cd_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_BAIRRO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_BAIRRO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_BAIRRO` (
  `cd_bairro` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_cidade` INT UNSIGNED NOT NULL,
  `nm_bairro` VARCHAR(255) NOT NULL,
  `ds_regiao` VARCHAR(255) NULL,
  PRIMARY KEY (`cd_bairro`, `cd_cidade`),
  INDEX `fk_T_ICM_BAIRRO_T_ICM_CIDADE1_idx` (`cd_cidade` ASC),
  CONSTRAINT `fk_T_ICM_BAIRRO_T_ICM_CIDADE1`
    FOREIGN KEY (`cd_cidade`)
    REFERENCES `icamydb`.`T_ICM_CIDADE` (`cd_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_LOGRADOURO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_LOGRADOURO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_LOGRADOURO` (
  `cd_logradouro` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_bairro` INT UNSIGNED NOT NULL,
  `cd_cliente` INT UNSIGNED NOT NULL,
  `nr_cep` INT UNSIGNED ZEROFILL NOT NULL,
  `nm_logradouro` VARCHAR(255) NOT NULL,
  `nr_logradouro` INT NULL,
  `ds_complemento` VARCHAR(255) NULL,
  PRIMARY KEY (`cd_logradouro`, `cd_bairro`, `cd_cliente`),
  INDEX `fk_T_ICM_LOGRADOURO_T_ICM_BAIRRO1_idx` (`cd_bairro` ASC),
  INDEX `fk_T_ICM_LOGRADOURO_T_ICM_CLIENTE1_idx` (`cd_cliente` ASC),
  CONSTRAINT `fk_T_ICM_LOGRADOURO_T_ICM_BAIRRO1`
    FOREIGN KEY (`cd_bairro`)
    REFERENCES `icamydb`.`T_ICM_BAIRRO` (`cd_bairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_ICM_LOGRADOURO_T_ICM_CLIENTE1`
    FOREIGN KEY (`cd_cliente`)
    REFERENCES `icamydb`.`T_ICM_CLIENTE` (`cd_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_PRESTADOR_BAIRRO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_PRESTADOR_BAIRRO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_PRESTADOR_BAIRRO` (
  `cd_prestador` INT UNSIGNED NOT NULL,
  `cd_bairro` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`cd_prestador`, `cd_bairro`),
  INDEX `fk_T_ICM_PRESTADOR_BAIRRO_T_ICM_BAIRRO1_idx` (`cd_bairro` ASC),
  CONSTRAINT `fk_T_ICM_PRESTADOR_BAIRRO_T_ICM_PRESTADOR1`
    FOREIGN KEY (`cd_prestador`)
    REFERENCES `icamydb`.`T_ICM_PRESTADOR` (`cd_prestador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_ICM_PRESTADOR_BAIRRO_T_ICM_BAIRRO1`
    FOREIGN KEY (`cd_bairro`)
    REFERENCES `icamydb`.`T_ICM_BAIRRO` (`cd_bairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_CATEGORIA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_CATEGORIA` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_CATEGORIA` (
  `cd_categoria` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nm_categoria` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cd_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_SERVICO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_SERVICO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_SERVICO` (
  `cd_servico` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_categoria` INT UNSIGNED NOT NULL,
  `nm_servico` VARCHAR(255) NOT NULL,
  `st_servico` CHAR(1) NOT NULL,
  `ds_servico` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cd_servico`, `cd_categoria`),
  INDEX `fk_T_ICM_SERVICO_T_ICM_CATEGORIA1_idx` (`cd_categoria` ASC),
  CONSTRAINT `fk_T_ICM_SERVICO_T_ICM_CATEGORIA1`
    FOREIGN KEY (`cd_categoria`)
    REFERENCES `icamydb`.`T_ICM_CATEGORIA` (`cd_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_OFERTA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_OFERTA` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_OFERTA` (
  `cd_oferta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_servico` INT UNSIGNED NOT NULL,
  `cd_prestador` INT UNSIGNED NOT NULL,
  `ds_titulo` VARCHAR(255) NOT NULL,
  `vl_oferta` DECIMAL(10,2) UNSIGNED NOT NULL,
  `ds_prazo` VARCHAR(255) NOT NULL,
  `tx_oferta` TEXT NOT NULL,
  PRIMARY KEY (`cd_oferta`, `cd_servico`, `cd_prestador`),
  INDEX `fk_T_ICM_OFERTA_T_ICM_PRESTADOR1_idx` (`cd_prestador` ASC),
  INDEX `fk_T_ICM_OFERTA_T_ICM_SERVICO1_idx` (`cd_servico` ASC),
  CONSTRAINT `fk_T_ICM_OFERTA_T_ICM_PRESTADOR1`
    FOREIGN KEY (`cd_prestador`)
    REFERENCES `icamydb`.`T_ICM_PRESTADOR` (`cd_prestador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_ICM_OFERTA_T_ICM_SERVICO1`
    FOREIGN KEY (`cd_servico`)
    REFERENCES `icamydb`.`T_ICM_SERVICO` (`cd_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_MODALIDADE_PGTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_MODALIDADE_PGTO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_MODALIDADE_PGTO` (
  `cd_modalidade` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nm_modalidade` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cd_modalidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_CONTRATACAO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_CONTRATACAO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_CONTRATACAO` (
  `cd_contratacao` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_oferta` INT UNSIGNED NOT NULL,
  `cd_cliente` INT UNSIGNED NOT NULL,
  `dt_contratacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vl_contratacao` DECIMAL(10,2) UNSIGNED NOT NULL,
  `st_contratacao` CHAR(1) NOT NULL,
  `dt_execucao` DATE NULL,
  PRIMARY KEY (`cd_contratacao`, `cd_oferta`, `cd_cliente`),
  INDEX `fk_T_ICM_CONTRATACAO_T_ICM_OFERTA1_idx` (`cd_oferta` ASC),
  INDEX `fk_T_ICM_CONTRATACAO_T_ICM_CLIENTE1_idx` (`cd_cliente` ASC),
  CONSTRAINT `fk_T_ICM_CONTRATACAO_T_ICM_OFERTA1`
    FOREIGN KEY (`cd_oferta`)
    REFERENCES `icamydb`.`T_ICM_OFERTA` (`cd_oferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_ICM_CONTRATACAO_T_ICM_CLIENTE1`
    FOREIGN KEY (`cd_cliente`)
    REFERENCES `icamydb`.`T_ICM_CLIENTE` (`cd_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_AVALIACAO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_AVALIACAO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_AVALIACAO` (
  `cd_avaliacao` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_contratacao` INT UNSIGNED NOT NULL,
  `dt_avaliacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ds_parte_avaliada` CHAR(1) NOT NULL,
  `vl_nota` INT NOT NULL,
  `tx_comentario` TEXT NULL,
  PRIMARY KEY (`cd_avaliacao`, `cd_contratacao`),
  INDEX `fk_T_ICM_AVALIACAO_T_ICM_CONTRATACAO1_idx` (`cd_contratacao` ASC),
  CONSTRAINT `fk_T_ICM_AVALIACAO_T_ICM_CONTRATACAO1`
    FOREIGN KEY (`cd_contratacao`)
    REFERENCES `icamydb`.`T_ICM_CONTRATACAO` (`cd_contratacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_PROPOSTA_AGENDAMENTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_PROPOSTA_AGENDAMENTO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_PROPOSTA_AGENDAMENTO` (
  `cd_proposta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_contratacao` INT UNSIGNED NOT NULL,
  `ds_parte_proponente` CHAR(1) NOT NULL,
  `dt_postagem` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_sugerida` DATETIME NOT NULL,
  `tx_mensagem` TEXT NOT NULL,
  `st_proposta` CHAR(1) NOT NULL,
  PRIMARY KEY (`cd_proposta`, `cd_contratacao`),
  INDEX `fk_T_ICM_PROPOSTA_AGENDAMENTO_T_ICM_CONTRATACAO1_idx` (`cd_contratacao` ASC),
  CONSTRAINT `fk_T_ICM_PROPOSTA_AGENDAMENTO_T_ICM_CONTRATACAO1`
    FOREIGN KEY (`cd_contratacao`)
    REFERENCES `icamydb`.`T_ICM_CONTRATACAO` (`cd_contratacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_PAGAMENTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_PAGAMENTO` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_PAGAMENTO` (
  `cd_pagamento` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_contratacao` INT UNSIGNED NOT NULL,
  `cd_modalidade` INT UNSIGNED NOT NULL,
  `dt_operacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vl_operacao` DECIMAL(10,2) UNSIGNED NOT NULL,
  `st_pagamento` CHAR(1) NOT NULL,
  `cd_identificador` VARCHAR(255) NULL,
  PRIMARY KEY (`cd_pagamento`, `cd_contratacao`, `cd_modalidade`),
  INDEX `fk_T_ICM_PAGAMENTO_T_ICM_MODALIDADE_PGTO1_idx` (`cd_modalidade` ASC),
  INDEX `fk_T_ICM_PAGAMENTO_T_ICM_CONTRATACAO1_idx` (`cd_contratacao` ASC),
  CONSTRAINT `fk_T_ICM_PAGAMENTO_T_ICM_MODALIDADE_PGTO1`
    FOREIGN KEY (`cd_modalidade`)
    REFERENCES `icamydb`.`T_ICM_MODALIDADE_PGTO` (`cd_modalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_ICM_PAGAMENTO_T_ICM_CONTRATACAO1`
    FOREIGN KEY (`cd_contratacao`)
    REFERENCES `icamydb`.`T_ICM_CONTRATACAO` (`cd_contratacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `icamydb`.`T_ICM_REPASSE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `icamydb`.`T_ICM_REPASSE` ;

CREATE TABLE IF NOT EXISTS `icamydb`.`T_ICM_REPASSE` (
  `cd_repasse` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_pagamento` INT UNSIGNED NOT NULL,
  `dt_repasse` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vl_repasse` DECIMAL(10,2) UNSIGNED NOT NULL,
  `st_repasse` CHAR(1) NOT NULL,
  PRIMARY KEY (`cd_repasse`, `cd_pagamento`),
  INDEX `fk_T_ICM_REPASSE_T_ICM_PAGAMENTO1_idx` (`cd_pagamento` ASC),
  CONSTRAINT `fk_T_ICM_REPASSE_T_ICM_PAGAMENTO1`
    FOREIGN KEY (`cd_pagamento`)
    REFERENCES `icamydb`.`T_ICM_PAGAMENTO` (`cd_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
