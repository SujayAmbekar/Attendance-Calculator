function varargout = M2(varargin)
% M2 MATLAB code for M2.fig
%      M2, by itself, creates a new M2 or raises the existing
%      singleton*.
%
%      H = M2 returns the handle to a new M2 or the handle to
%      the existing singleton*.
%
%      M2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in M2.M with the given input arguments.
%
%      M2('Property','Value',...) creates a new M2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before M2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to M2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help M2

% Last Modified by GUIDE v2.5 18-Apr-2021 18:27:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @M2_OpeningFcn, ...
                   'gui_OutputFcn',  @M2_OutputFcn, ...
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


% --- Executes just before M2 is made visible.
function M2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to M2 (see VARARGIN)

% Choose default command line output for M2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1);
imshow('blank.jpg');
set(handles.text4,'string','Percentage : 0 %');
set(handles.text6,'string','No of Students : 0');
% UIWAIT makes M2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = M2_OutputFcn(hObject, eventdata, handles) 
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
facedetector = vision.CascadeObjectDetector;
global f;%file name(file path)
global g;%total class strength

image = imread(f);                                                       %store that frame in 'image'
bbox = step(facedetector, image);%position of face in the image                                         % position of face in 'bbox' (x, y, width and height)
insert_object = insertObjectAnnotation(image,'Rectangle',bbox,'Student');      % Draw the bounding box around the detected face.
imshow(insert_object);
no_rows = size(bbox,1);%no of students
global int prct;
prct=int8((no_rows/str2double(g))*100);
% get the number of rows (which will be equal to number of people)
fprintf('No. of students: %d\n', no_rows);
set(handles.text4,'string',strcat('Percentage : ',string(prct),' %'));                                              %display the value of X in GUI
set(handles.text6,'string',strcat('No of Students : ',string(no_rows)));                                              %display the value of X in GUI
axes(handles.axes1)
if(prct>40)
    set(handles.text5,'string','Covid Alert!!');
else
    set(handles.text5,'string','Stay Safe!!');
    set(handles.text5,'ForegroundColor','blue');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global f;
f=get(hObject,'String');



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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
global g;
g=get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
