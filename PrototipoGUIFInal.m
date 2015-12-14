function GUI_Fourier
% Este programa es una interfaz de usuario acoplada al programa que calcula
% los coeficientes de fourier

%  Se crea la ventana de interfaz de usuario
g = figure('Visible','off','Position',[360,500,800,650]);

% Se crean y dan las especificaciones de los coponentes

Grabar = uicontrol('Style','pushbutton',...
             'String','Grabar','Position',[1000,500,70,25],...
             'Callback',@Grabar_Callback);
text1  = uicontrol('Style','text','String','Elige el tipo de entrada',...
           'Position',[325,400,200,15]);
autor1  = uicontrol('Style','text','String','Diego Uribe Muñiz',...
           'Position',[600,200,200,15]);
autor2  = uicontrol('Style','text','String','Andres Garcia Rubio',...
           'Position',[600,180,200,15]);
hpopup = uicontrol('Style','popupmenu',...
           'String',{'Generador de Tonos', 'Monosilabos'},...
           'Position',[300,350,200,25],...
           'Callback',@popup_menu_Callback);
txtbox = uicontrol(g,'Style','edit',...
                'String','Grabadora Apagada',...
                'Position',[600 550 200 20]);
txtbox.BackgroundColor = 'green';

%Se dan los parametros del grafico y se alinean los botones

align([Grabar,text1,hpopup,autor1,autor2, txtbox],'Center','None');


% Se normalizan los datos de los componentes para que cambien de tamaño
% automaticamente
g.Units = 'normalized';
Grabar.Units = 'normalized';
text1.Units = 'normalized';
hpopup.Units = 'normalized';

% Se pone el nombre dle programa en la ventana principal
g.Name = 'Proyecto Final';

% Se mueve la ventana al centro
movegui(g,'center')

% Se hace visible la ventana
g.Visible = 'on';

%  Pop-up menu callback.Esta funcion corre cada vez que se cambia de
%  funcion en el menu
   function popup_menu_Callback(source,eventdata) 
   
%Se crea un vector t para definir numéricamente el dominio, se crea un
%vector vacío para guardar los datos dela suma y se le piden los
%parámetros a la interfaz   
  
%El siguiente FOR crea un vector diferente para cada valor k, y los agrega
%a la suma 
     
    %usando los coeficientes de la serie de fouirier, se evalúan los
    %diferentes elementos de la seri, el valor k = 1 de la funcion 5 es un
    %caso especial (division entre 0) asi que es calculado por separado
    
    
   end


  %Se grafica al momento que el usuario oprime el boton Grabar
  

  function Grabar_Callback(source,eventdata) 
        
   f = get(hpopup,'Value'); 
   
   if (f == 1)
   
       recObj = audiorecorder;
       txtbox.BackgroundColor = 'red';
       txtbox.String = 'Grabando';
       recordblocking(recObj, 3);
       txtbox.BackgroundColor = 'white';
       txtbox.String = 'Grabadora Apagada';
       signal = transpose(getaudiodata(recObj));
       subplot(4,2,1)
       plot(signal)
       title('Audio Original')
       Y = fft(signal,40000);
       subplot(4,2,3)
       plot(Y)
       title('Transformada Audio Original')
       %subplot(4,2,5)
       %plot(real(Y))
       %title('Amplitud')
       %subplot(4,2,7)
       %plot(imag(Y))
       %title('Fase')

       r=3000;

       rectangle = zeros(size(Y));
       rectangle(1:r+1) = 1;  
       rectangle(end-r+1:end) = 1; 

       filtrada = ifft(Y.* rectangle, 40000);

        subplot(4,2,5)
        plot(filtrada)
        title('Señal Filtrada Pasabandas')

        L = 40000;
        Fs = 80000;

        P2 = abs(Y/L);
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);

        f = Fs*(0:(L/2))/L;

        subplot(4,2,7)
        plot(f,P1)
        title('Frecuencia')

        [M,I] = max(P1);

        
        fsonido = I(1)*2;


        if ((fsonido < 21800) && (fsonido > 18000))
  
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'1');
            pause(3);
            fprintf(s,'LF');
            fclose(s);

         elseif(fsonido < 22500)
    
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'2');
            pause(3);
            fprintf(s,'LF');
            fclose(s);
    
        elseif(fsonido < 26000)
     
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'3');
            pause(3);
            fprintf(s,'LF');
            fclose(s);
   
        elseif(fsonido < 30000)
    
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'4');
            pause(3);
            fprintf(s,'LF');
            fclose(s);
       
        elseif(fsonido < 32000)
     
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'5');
            pause(3);
            fprintf(s,'LF'); 
            fclose(s);
       
        elseif(fsonido < 32600)
     
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'6');
            pause(3);
            fprintf(s,'LF');
            fclose(s);
            
        elseif(fsonido < 35000)
     
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'7');
            pause(3);
            fprintf(s,'LF');
            fclose(s);   
            
        elseif(fsonido < 37000)
            
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'8');
            pause(3);
            fprintf(s,'LF');
            fclose(s);
        else
    
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'9');
            pause(3);
            fprintf(s,'LF');  
            fclose(s);   
        end
    
   else if (f == 2)
         recObj = audiorecorder;
       txtbox.BackgroundColor = 'red';
       txtbox.String = 'Grabando';
       recordblocking(recObj, 3);
       txtbox.BackgroundColor = 'white';
       txtbox.String = 'Grabadora Apagada';
       signal = transpose(getaudiodata(recObj));
       subplot(4,2,1)
       plot(signal)
       title('Audio Original')
       Y = fft(signal,40000);
       subplot(4,2,3)
       plot(Y)
       title('Transformada Audio Original')
       %subplot(4,2,5)
       %plot(real(Y))
       %title('Amplitud')
       %subplot(4,2,7)
       %plot(imag(Y))
       %title('Fase')

       r=3000;

       rectangle = zeros(size(Y));
       rectangle(1:r+1) = 1;  
       rectangle(end-r+1:end) = 1; 

       filtrada = ifft(Y.* rectangle, 40000);

        subplot(4,2,5)
        plot(filtrada)
        title('Señal Filtrada Pasabandas')

        L = 40000;
        Fs = 80000;

        P2 = abs(Y/L);
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);

        f = Fs*(0:(L/2))/L;

        subplot(4,2,7)
        plot(f,P1)
        title('Frecuencia')

        [M,I] = max(P1);

        
        fsonido = I(1)*2;     
        
        if (fsonido < 5000)
  
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'1');
            pause(3);
            fprintf(s,'LF');
            fclose(s);

        else
    
            s = serial('COM13','BaudRate',9600);
            fopen(s);
            fscanf(s);
            fprintf(s,'2');
            pause(3);
            fprintf(s,'LF');
            fclose(s);
        end
       end

   end
       
  end


end