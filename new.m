close all
clear
%read the image
A=imread('C:\Users\abmasud\Google Drive (masud407@iut-dhaka.edu)\ME__ECE_5367\ME__ECE_5367\project1\Testimage2.tif');
X=edge(A,'canny',.5);%edge detection
figure
imshow(X)
%Hough Transformation
[H,T,R] = hough(X, 'RhoResolution', 2);
P = houghpeaks(H, 20);
figure,imshow(P);
%Find Houghlines
lines = houghlines(X, T, R, P);
figure
imshow(A)
hold on
for b = 1:length(lines)
  xy = [lines(b).point1; lines(b).point2];
  plot(xy(:,1), xy(:,2), 'LineWidth', .65, 'Color', 'green');
end
u = lines(3).point1 - lines(3).point2; 
v = [0 1]; 
%Find angle between the horizontal line and the hough line
theta = acos( u*v' / (norm(u) * norm(v)) );
% Rotate image by theta
B = imrotate(A, theta * 180 / pi);
figure
imshow(B);
C=B-130;
figure
imshow(C);
Y=edge(C,'canny',0.5);
figure,imshow(Y);
% Enlarge figure to full screen.
% Get all rows and columns where the image is nonzero
[M,N] = find(Y);
% Get the cropping parameters
topRow= min(M(:));
bottomRow = max(M(:));
leftColumn = min(N(:));
rightColumn = max(N(:));
% Extract a cropped image from the original.
croppedImage = B(topRow:bottomRow, leftColumn:rightColumn);
% Display the original gray scale image.
%subplot(2, 2, 2);
figure, imshow(croppedImage);


































