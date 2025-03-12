function varargout = Proiect17(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Proiect17_OpeningFcn, ...
                   'gui_OutputFcn',  @Proiect17_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Proiect17 is made visible.
function Proiect17_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Proiect17 (see VARARGIN)

% Choose default command line output for Proiect17
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Proiect17 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Proiect17_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    [filename, pathname] = uigetfile({'*.jpg';'*.*'},'Selectați un fișier');
    full_path = fullfile(pathname, filename);
    J = imread(full_path);
                 axes(handles.axes1);
           imshow(J)
        save([tempdir 'J'],'J');


        
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load([tempdir 'J']);
continut=cellstr(get(hObject,'String'));
b=continut{get(hObject,'Value')};
if (strcmp(b,'Histograma')) %Egalizarea Histogramei
   
    H=histeq(J,256);
axes(handles.axes1);
imshow(H); axis off
   save([tempdir 'H'],'H')
elseif (strcmp(b,'Reconstructia'))%reconstructia

BW=imcomplement(im2bw(im2double(J),0.7));
a=str2num(get(handles.edit1, 'string'));
se=strel('disk',a);
BWO=imopen(BW,se);
mask=uint8(BWO);
reconstruct=J;
for channel = 1:3
    reconstruct(:,:,channel) =  J(:,:,channel) .* mask;
end
imshow(reconstruct);
 save([tempdir 'reconstruct'],'reconstruct')

end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{sget(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
a=get(hObject,'Value');
load ([tempdir 'J'])
if (a==1)

h= imhist(J);
h1=h(1:10:256);
horiz=1:10:256;
% figure
axes(handles.axes1);
bar(horiz, h1)
axis([0 255 0 15000]);
set(gca, 'xtick', 0:50:255);
set(gca, 'ytick', 0:2000:15000);
xlabel('intensitate');
ylabel('nr de pixeli');
else
axes(handles.axes1);
imshow(J)
end


% --- Executes on button press in original.
function original_Callback(hObject, eventdata, handles)


load([tempdir 'J']);
imshow(J)
% hObject    handle to original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of original


% --- Executes on button press in modificat.
function modificat_Callback(hObject, eventdata, handles)
   
a=get(handles.popupmenu1,'Value');
val=get(handles.popupmenu1, 'String');

switch val{a}
    case 'Histograma'
        load([tempdir 'H'])
        imshow(H)
    case 'Reconstructia'
        load([tempdir 'reconstruct'])
        imshow(reconstruct)
end


% hObject    handle to modificat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of modificat



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in salvare.
function salvare_Callback(hObject, eventdata, handles)
 
axesHandle=handles.axes1;
imageHandle=findobj(axesHandle,'Type','image');
imageData=get(imageHandle,'CData');
[filename,pathname]=uiputfile('*.jpg','Salveaza ca');
if isequal(filename,0)||isequal(pathname,0)
    return;
else
    full_path=fullfile(pathname,filename);
    imwrite(imageData,full_path,'jpg');
end

                 


% hObject    handle to salvare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
