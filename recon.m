cale='/Users/diana/Desktop/MASTER/EFAC/Proiect_APIB/';
nume_im='celule.jpg';
J=imread([cale nume_im]);
BW=imcomplement(im2bw(im2double(J),0.7));
se=strel('disk',9);%schimbarea dimensiunii
BWO=imopen(BW,se);
mask=uint8(BWO);
reconstruct=J;
for channel = 1:3
    reconstruct(:,:,channel) =  J(:,:,channel) .* mask;
end
imshow(reconstruct);