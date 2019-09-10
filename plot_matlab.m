%% 3D Model Demo
% This is short demo that loads and renders a 3D model of a human femur. It
% showcases some of MATLAB's advanced graphics features, including lighting and
% specular reflectance.

% Copyright 2011 The MathWorks, Inc.


%% Load STL mesh
% Stereolithography (STL) files are a common format for storing mesh data. STL
% meshes are simply a collection of triangular faces. This type of model is very
% suitable for use with MATLAB's PATCH graphics object.

% Import an STL mesh, returning a PATCH-compatible face-vertex structure
fv1 = stlread('models/matlab_1.stl');

fv2 = stlread('models/matlab_2.stl');


fv1.vertices(:,3) = 0;
vertices=fv1.vertices;
fv1.vertices(:,2) = vertices(:,3);
fv1.vertices(:,3)=vertices(:,2);

fv2.vertices(:,3) = 0;
vertices=fv2.vertices;
fv2.vertices(:,2) = vertices(:,3);
fv2.vertices(:,3)=vertices(:,2);


fvmodified1 = fv1;

indOffset = rand(size(fv1.vertices,1),1);
indOffset = (indOffset - 0.5) * 2;
fvmodified1.vertices(:,2)=fvmodified1.vertices(:,2) + indOffset;

faceOffset = (rand(size(fvmodified1.faces,1),1) - 0.5) * 10;
for idx = 1:size(fvmodified1.faces,1)
    idxList = fvmodified1.faces(idx,:);
    fvmodified1.vertices(idxList,2) = fvmodified1.vertices(idxList,2) + faceOffset(idx);
end



fvmodified2 = fv2;

indOffset = rand(size(fv2.vertices,1),1);
indOffset = (indOffset - 0.5) * 2;
fvmodified2.vertices(:,2)=fvmodified2.vertices(:,2) + indOffset;

faceOffset = (rand(size(fvmodified2.faces,1),1) - 0.5) * 10;
for idx = 1:size(fvmodified2.faces,1)
    idxList = fvmodified2.faces(idx,:);
    fvmodified2.vertices(idxList,2) = fvmodified2.vertices(idxList,2) + faceOffset(idx);
end

figure;
patch(fvmodified1,'FaceColor',       'r', ...
         'EdgeColor',       'none',        ...
         'FaceLighting',    'gouraud',     ...
         'AmbientStrength', 0.15);
     
     
 hold on
 
 patch(fvmodified2,'FaceColor',       'b', ...
         'EdgeColor',       'none',        ...
         'FaceLighting',    'gouraud',     ...
         'AmbientStrength', 0.15);



% Add a camera light, and tone down the specular highlighting
camlight('headlight');
material('dull');

% Fix the axes scaling, and set a nice view angle
axis('image');
view([-135 35]);
axis off
rotate3d on