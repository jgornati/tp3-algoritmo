program gymware;
uses crt;

type gimnasioRecord = record
	nombre, direccion: string[30];
	valorCuota: real;
	valorNutricionista: real;
	valorPersonalTrainer: real;
	end;

type actividades = record
	codigoActividad: integer;
	dscActividad: string[30];
	end;

type diasYhorarios = record
	dia: integer;
	hora: string[5];
	codigoActividad: integer;
	end;

type ejerciciosXrutinas = record
	codigoEjercicio: integer;
	dscRutina: string[30];
	end;

type clientes = record
	dni: string[8];
	nYa: string[30];
	rutina: char;
	nutricionista: char;
	personalTrainer: char;
	pagoYpeso: array [1..2, 1..2] of real;
	end;

type rutinasXclientes = record
	dni: string[8];
	mes: integer;
	anio: integer;
	cantRepet: array[1..4, 1..50] of integer;
	estado: boolean;
	end;
//**************	
//VARIABLES
//**************
var
	menuSel: char;
	salir: boolean;
	gimnasio: gimnasioRecord;
	archivoGimnasio: file of gimnasioRecord;




procedure bienvenido();
begin
	writeln('   ____ ___.__. _______  _  _______ _______   ____  ');
	writeln('  / ___<   |  |/     \ \/ \/ /\__  \\_  __ \_/ __ \ ');
	writeln(' / /_/  >___  |  Y Y  \     /  / __ \|  | \/\  ___/ ');
	writeln(' \___  // ____|__|_|  /\/\_/  (____  /__|    \___  >');
	writeln('/_____/ \/          \/             \/            \/ ');
end;


// INICIO ABMs
procedure abmGimnasio(opMenu:char);
var 
	ba: char;
begin

	// Comprobacion si existe archivo
	assign(archivoGimnasio, './datos/archivoGimnasio.dat');
	{$I-}
	reset(archivoGimnasio);
	If ioresult = 2 then rewrite(archivoGimnasio);
	{$I+}

	if opMenu = '1' then begin
		// seek(archivoGimnasio, filesize(archivoGimnasio));
		repeat
			write('Ingrese nombre del gimnasio: ');
			readln(gimnasio.nombre);
			write('Ingrese direccion del gimnasio: ');
			readln(gimnasio.direccion);
			write('Ingrese valor de cuota: ');
			readln(gimnasio.valorCuota);
			write('Ingrese valor de nutricionista: ');
			readln(gimnasio.valorNutricionista);
			write('Ingrese valor de personal trainer: ');
			readln(gimnasio.valorPersonalTrainer);
			write(archivoGimnasio, gimnasio);
			Write('Ingresa datos de otro gimnasio? ( s=SI n=NO)');
			repeat
				readln(ba)
			until (ba = 's') or (ba = 'n');
		until (ba='n') ;
		close(archivoGimnasio);
	end;

	if opMenu = '2' then begin
		Writeln('listado de gimnasios');
		while not EOF(archivoGimnasio) do
		begin
			Read(archivoGimnasio, gimnasio);
			writeln(gimnasio.nombre);
		end;
	readln;
	end;
end;


procedure abmActividades();
begin
	readln;
end;

procedure abmDiasYhorarios();
	begin
	readln;
	end;

procedure abmEjerciciosXrutinas();
begin
	readln;
end;
// FIN ABMs
procedure abmGimnasioMenu();
var
	opMenu:char;
begin
	repeat
		writeln('INGRESE OPCION:');
		writeln('1) Alta');
		writeln('2) Modifacion');
		writeln('3) Baja');
		opMenu := readkey;
	until (opMenu >= '1') and (opMenu <= '3');
	abmGimnasio(opMenu);
end;

procedure menuABM();
var opMenu: char;
begin
	repeat
		writeln('ABM DE ARCHIVOS');writeln('');
		writeln('1) GIMNASIO');
		writeln('2) ACTIVIDADES');
		writeln('3) DIAS Y HORARIOS');
		writeln('4) EJERCICIOS POR RUTINAS');
		writeln('5) VOLVER');
		write('Ingrese opcion');
		opMenu := readkey;
	until (opMenu >= '1') and (opMenu <= '5');
	clrscr;
	// SECCIONES
	case opMenu of
		'1': abmGimnasioMenu();
		'2': abmActividades();
		'3': abmDiasYhorarios();
		'4': abmEjerciciosXrutinas();
		'5': clrscr;
	end;
end;

procedure seccionClientes();
begin
	writeln('seccionClientes');
end;

procedure seccionRutinasPorClientes();
begin
	writeln('seccionRutinasPorClientes');
end;

function menu():char;
var opMenu: char;
begin
	repeat
		writeln('');writeln('');
		writeln('1) AMB');
		writeln('2) CLIENTES');
		writeln('3) RUTINAS POR CLIENTES');
		writeln('4) LISTADO DE DIAS Y HORARIOS');
		writeln('5) RECAUDACION');
		writeln('6) REINICIAR(BLANQUEO)');
		writeln('7) SALIR');
		write('Ingrese opcion');
		opMenu := readkey;
	until (opMenu >= '1') and (opMenu <= '7');
	clrscr;
	menu := opMenu;
end;

begin
repeat
	clrscr;
	bienvenido();
    menuSel := menu();
	case menuSel of
		'1': menuABM();
		'2': seccionClientes();
		'3': seccionRutinasPorClientes();
		'7': salir:=true;
	end;
until salir = true;
end.

