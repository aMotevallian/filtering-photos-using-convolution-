function output = conv2D(img_path , stride , is_same , filter)
    image = imread(img_path);
    w=size(image , 1);
    h=size(image , 2);
    f=length(filter);
    if is_same
        p = floor((f-1)/2); %zero padding
        width = ((w + 2 * p -f )+1);
        height = ((h + 2 * p - f) +1);
        image = padarray(image , [p , p] , 0 , 'both');
    else
        width = w-f+1;
        height=h-f+1;
    end
    output = uint8(zeros(ceil(width/stride) , ceil(height/stride)));

    for i = 1 : size(filter , 3)
        for row = 1 : stride : height - f + 1
            for col = 1 : stride : width -f + 1
                local = image(col:col+f-1 , row:row+f-1);
                out = uint8(sum(double(local) .* double(filter(:,:,i)) , 'all'));
                output(ceil(col/stride) , ceil(row/stride) , i) = out;
            end
        end
    end
end