program gymware;
uses crt;

type gimnasioRecord = record
	nombre, direccion: string[30];
	valorCuota: real;
	valorNutricionista: real;
	valorPersonalTrainer: real;
	end;

type actividadesRecord = record
	codigoActividad: integer;
	dscActividad: string[30];
	end;

type diasYhorariosRecord = record
	dia: integer;
	hora: string[5];
	codigoActividad: integer;
	end;

type ejerciciosXrutinasRecord = record
	codigoEjercicio: integer;
	dscRutina: string[30];
	end;

type clientesRecord = record
	dni: string[8];
	nYa: string[30];
	rutina: char;
	nutricionista: char;
	personalTrainer: char;
	pagoYpeso: array [1..2, 1..2] of real;
	end;

type rutinasXclientesRecord = record
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
	actividad: actividadesRecord;
	archivoActividades: file of actividadesRecord;



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
	var ba:char;
begin

	// Comprobacion si existe archivo
	assign(archivoGimnasio, './datos/archivoGimnasio.dat');
	{$I-}
	reset(archivoGimnasio);
	If ioresult = 2 then rewrite(archivoGimnasio);
	{$I+}

	if opMenu = '1' then begin
		// seek(archivoGimnasio, filesize(archivoGimnasio));
		writeln('Alta de gimnasio, sobreescribe el gimnasio actual');
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
		close(archivoGimnasio);
	end;

	if opMenu = '2' then begin
		if filesize(archivoGimnasio) = 0 then begin
			writeln('No hay ningun dato para modificar, presione enter para continuar');
			readln;
		end
		else
		begin
			writeln('Modificacion de gimnasio');
			write(archivoGimnasio, gimnasio);
			writeln('Ingrese nuevo valor cuota[',gimnasio.valorCuota,']: ');
			readln(gimnasio.valorCuota);
			writeln('Ingrese nuevo valor nutricionista[',gimnasio.valorNutricionista,']: ');
			readln(gimnasio.valorNutricionista);
			writeln('Ingrese nuevo valor personal trainer[',gimnasio.valorPersonalTrainer,']: ');
			readln(gimnasio.valorPersonalTrainer);
			reset(archivoGimnasio);
			write(archivoGimnasio, gimnasio);
		end;
	end;

	if opMenu = '3' then begin
		writeln('Desea borrar el gimnasio S/N?');
		repeat
			read (ba)
		until (ba = 'S') or (ba = 'N') or (ba = 's') or (ba = 'n');
		if (ba = 'S') or (ba = 's') then
			rewrite(archivoGimnasio);
	end;	

	if opMenu = '4' then begin
		writeln('Listado de gimnasio');
		while not EOF(archivoGimnasio) do
		begin
			read(archivoGimnasio, gimnasio);
			writeln(gimnasio.nombre);
			writeln(gimnasio.direccion);
			writeln(gimnasio.valorCuota);
			writeln(gimnasio.valorNutricionista);
			writeln(gimnasio.valorPersonalTrainer);
		end;
	readln;
	end;

end;


procedure abmActividades(opMenu:char);
var pos: integer;
	ba: char;
begin
		// Comprobacion si existe archivo
	assign(archivoActividades, './datos/archivoActividades.dat');
	{$I-}
	reset(archivoActividades);
	If ioresult = 2 then rewrite(archivoActividades);
	{$I+}

	if opMenu = '1' then begin
		seek(archivoActividades, filesize(archivoActividades));
		writeln('Alta de actividad');
		pos := filepos(archivoActividades);
		actividad.codigoActividad := pos + 1;
		write('Ingrese descripcion de actividad ',actividad.codigoActividad,' : ');
		readln(actividad.dscActividad);
		write(archivoActividades, actividad);
		close(archivoActividades);
	end;

	if opMenu = '4' then begin
		writeln('Listado de actividades');
		while not EOF(archivoActividades) do
		begin
			read(archivoActividades, actividad);
			writeln(actividad.codigoActividad);
			writeln(actividad.dscActividad);
		end;
	writeln('Presione cualquier tecla para continuar');
	readln;
	end;
end;

procedure abmDiasYhorarios(opMenu:char);
	begin
	readln;
	end;

procedure abmEjerciciosXrutinas(opMenu:char);
begin
	readln;
end;
// FIN ABMs
procedure opcionesABMmenu(nomArchivo:string);
var
	opMenu:char;
begin
	repeat
		writeln('INGRESE OPCION:');
		writeln('1) Alta');
		writeln('2) Modifacion');
		writeln('3) Baja');
		writeln('4) Listado');
		opMenu := readkey;
	until (opMenu >= '1') and (opMenu <= '4');
	case nomArchivo of
		'gym': abmGimnasio(opMenu);
		'act': abmActividades(opMenu);
		'dyg': abmDiasYhorarios(opMenu);
		'eje': abmEjerciciosXrutinas(opMenu);
	end;
end;

procedure menuABMs();
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
		'1': opcionesABMmenu('gym');
		'2': opcionesABMmenu('act');
		'3': opcionesABMmenu('dyh');
		'4': opcionesABMmenu('eje');
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
		'1': menuABMs();
		'2': seccionClientes();
		'3': seccionRutinasPorClientes();
		'7': salir:=true;
	end;
until salir = true;
end.

