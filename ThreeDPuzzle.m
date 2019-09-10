function ThreeDPuzzle
models = ["models/cat.stl", "models/diamond.stl", "models/fox.stl", "models/heart.stl", "models/moon.stl", "models/star.stl", "models/unicorn.stl"];


f = figure;
ax = axes(f);
ax.Units = 'pixels';
ax.Position = [75 75 325 280];
c = uicontrol;
c.String = 'New Game';
c.Callback = @plotButtonPushed;
c.Position = [200, 30, 75, 40];
I = imread('boat.png');
% J = imresize(I,5);
imshow(I,'InitialMagnification',300)
t = text(150,10,'PolySphere 3D Game');
t.FontSize = 14;
axis off;

    function plotButtonPushed(src,event)
        clf('reset')
        
        c = uicontrol;
        c.String = 'New Game';
        c.Callback = @plotButtonPushed;
        c.Position = [200, 30, 75, 40];
        
        index = randi([1,8],1);
        
        if( index<8 )
            
            fv = stlread(models(index));
            fv.vertices(:,3) = 0;
            vertices=fv.vertices;
            fv.vertices(:,2) = vertices(:,3);
            fv.vertices(:,3) = vertices(:,2);

            fvmodified = fv;

            indOffset = rand(size(fv.vertices,1),1);
            indOffset = (indOffset - 0.5) * 2;
            fvmodified.vertices(:,2)=fvmodified.vertices(:,2) + indOffset;

            faceOffset = (rand(size(fvmodified.faces,1),1) - 0.5) * 10;
            for idx = 1:size(fvmodified.faces,1)
                idxList = fvmodified.faces(idx,:);
                fvmodified.vertices(idxList,2) = fvmodified.vertices(idxList,2) + faceOffset(idx);
            end

            patch(fvmodified,'FaceColor',       [rand, rand, rand], ...
                     'EdgeColor',       'none',        ...
                     'FaceLighting',    'gouraud',     ...
                     'AmbientStrength', 0.15);

            % Add a cameindOffset light, and tone down the specular highlighting
            camlight('headlight');
            material('dull');

            % xlim([-1 1])
            % ylim([-1 1])
            % zlim([min(fvmodified.vertices(:,3)) max(fvmodified.vertices(:,3))]);
            axis off;

            view(randi([-180,180]),randi([-180,180]));
            rotate3d on
        else
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
            
        end

               
    end

end