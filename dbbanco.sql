-- P1
create database dbBANCO;
use dbBANCO;

-- Parte 2 as tabelas
create table tbbanco(
	Codigo int primary key,
    Nome varchar(50)
);

create table tbagencia(
	CodBanco int,
    NumeroAgencia int primary key,
    Endereco varchar(50)
);
alter table tbagencia add CONSTRAINT fk_tbbanco FOREIGN KEY (CodBanco) REFERENCES tbbanco(Codigo);

create table tbcliente(
	Cpf bigint primary key,
    Nome varchar(50),
    Sexo char(1),
    Endereco varchar(50)
);

create table tbconta(
	NumeroConta int primary key,
    Saldo decimal(7,2),
	TipoConta tinyint,
    NumeroAgencia int,
    CONSTRAINT fk_NumeroAgencia FOREIGN KEY (NumeroAgencia) REFERENCES tbagencia(NumeroAgencia)
);

create table tbtelefone_cliente(
	Cpf bigint,
    Telefone int primary key,
    CONSTRAINT fk_Cpf_ FOREIGN KEY (Cpf) REFERENCES tbcliente(Cpf)
);

create table tbhistorico(
	Cpf bigint,
    NumeroConta int,
    primary key (Cpf, NumeroConta),
    DataInicio date,
    CONSTRAINT fk_NumeroConta FOREIGN KEY (NumeroConta) REFERENCES tbconta(NumeroConta),
    CONSTRAINT fk_Cpf FOREIGN KEY (Cpf) REFERENCES tbcliente(Cpf)
);

-- Ex 3
insert into tbbanco (Codigo, Nome) values(1, 'Banco do Brasil');
insert into tbbanco (Codigo, Nome) values(104, 'Caixa Economica Federal');
insert into tbbanco (Codigo, Nome) values(801, 'Banco Escola');

insert into tbagencia (CodBanco, NumeroAgencia, Endereco) values(1, 123, 'Av Paulista, 78');
insert into tbagencia (CodBanco, NumeroAgencia, Endereco) values(104, 159, 'Rua Liberdade, 124');
insert into tbagencia (CodBanco, NumeroAgencia, Endereco) values(801, 401, 'Rua Vinte três, 23');
insert into tbagencia (CodBanco, NumeroAgencia, Endereco) values(801, 485, 'Av Marechal, 58');

insert into tbcliente (Cpf, Nome, Sexo, Endereco) values(12345678910, 'Enildo', 'M', 'Rua Grande, 75');
insert into tbcliente (Cpf, Nome, Sexo, Endereco) values(12345678911, 'Astrogildo', 'M', 'Rua Pequena, 789');
insert into tbcliente (Cpf, Nome, Sexo, Endereco) values(12345678912, 'Monica', 'F', 'Av Larga, 148');
insert into tbcliente (Cpf, Nome, Sexo, Endereco) values(12345678913, 'Cascão', 'M', 'Av Principal, 369');

insert into tbconta (NumeroConta, Saldo, TipoConta, NumeroAgencia) values(9876, 456.05, 1, 123);
insert into tbconta (NumeroConta, Saldo, TipoConta, NumeroAgencia) values(9877, 321.00, 1, 123);
insert into tbconta (NumeroConta, Saldo, TipoConta, NumeroAgencia) values(9878, 100.00, 2, 485);
insert into tbconta (NumeroConta, Saldo, TipoConta, NumeroAgencia) values(9879, 5589.48, 1, 401);

insert into tbhistorico (Cpf, NumeroConta, DataInicio) values(12345678910, 9876, '2001/04/15');
insert into tbhistorico (Cpf, NumeroConta, DataInicio) values(12345678911, 9877, '2011/03/10');
insert into tbhistorico (Cpf, NumeroConta, DataInicio) values(12345678912, 9878, '2021/03/11');
insert into tbhistorico (Cpf, NumeroConta, DataInicio) values(12345678913, 9879, '2000/07/05');

insert into tbtelefone_cliente (Cpf, Telefone) values(12345678910, 912345678);
insert into tbtelefone_cliente (Cpf, Telefone) values(12345678911, 912345679);
insert into tbtelefone_cliente (Cpf, Telefone) values(12345678912, 912345680);
insert into tbtelefone_cliente (Cpf, Telefone) values(12345678913, 912345681);

-- Ex 4
alter table tbcliente add email varchar(100);


-- Ex5
select Cpf, Endereco from tbcliente where Nome='Monica';
-- Ex 6
select NumeroAgencia, Endereco from tbagencia where CodBanco=801;
-- Ex 7
select * from tbcliente where Sexo='M';


-- Exercício IX
-- Ex 1
delete from tbtelefone_cliente where Cpf=12345678911;

-- Ex 2
update tbconta set TipoConta=2 where TipoConta=9879;

-- Ex 3
update tbcliente set email='Astro@Escola.com' where Nome='Monica';

-- Ex 4
update tbconta set Saldo=(Saldo * 10/100) + Saldo where NumeroConta=9876; -- (Ou múltiplica por Saldo * 1.1)

-- Ex 5
select Nome, email, Endereco from tbcliente where Nome="Monica";

-- Ex 6

/*update tbcliente set Nome="Enildo Candido" where Nome="Enildo";
update tbcliente set email='enildo@escola.com' where Nome="Enildo";*/ -- dois comandos para cada atributo
update tbcliente set Nome="Enildo Candido", email='enildo@escola.com' where Nome="Enildo"; -- fazendo múltiplos atributos com um único comando

-- Ex 7
update tbconta set Saldo=(Saldo-30);
set sql_safe_updates = 0;

-- Ex 8
delete from tbconta where NumeroConta=9878; /*Não é possível deletar uma chave estrangeira, pois essa se relaciona com outra tabela.
É como se, caso eu faça a exclusão desse campo, esse mesmo dado na tabela estrangeira não fará sentido
-Excluo um registro de conta ->
-No histórico dessa tabela, essa conta não terá nem um sentido pois é como se ela não existisse
*/
