function [o] = txtencr1()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
i=imread('greens.jpg');
imshow(i,[]);

%a(1:50,1)=textread('Test.txt','%s');

inc=1;%Represents the line number of txt file

[r c p]=size(i);
com1=i;

disp('This process may take a few mins...');
        while(inc<=1000)
            fid = fopen('Test.txt');
        for g=1:inc
            word=fgets(fid); %gets word at line number 'inc'
        end
        fclose(fid);
        w=uint8(word);
        w=de2bi(w,8,'left-msb');
        %ipk=0;
        
        for k=1:size(w,1) %loop runs till size of w since w contains binary of each letter of the word
        lb=randi(r); %CHAOTIC MAPPING
        rb=randi(c);
        pb=randi(p);
        %ARNOLD CAT MAP
        lb=mod((2*lb+rb),r)+1;
        rb=mod(lb+rb,c)+1;
        b=de2bi(i(lb,rb,pb),8,'left-msb');
        com12=de2bi(com1(lb,rb,pb),8,'left-msb');
        while(com12(1:8)~=b(1:8))
            pb=pb+1;
            if(pb==4)
                pb=1;
                rb=rb+1;
                if(rb>c)
                    rb=1;
                    lb=lb+1;
                    if(lb>r)
                        lb=1;
                        rb=1;
                        pb=1;
                    end
                end
            end
            b=de2bi(i(lb,rb,pb),8,'left-msb');
            com12=de2bi(com1(lb,rb,pb),8,'left-msb');
        end
        b(1:8)=w(k,1:8); %replace LSB of image pixel with bits of letter
        i(lb,rb,pb)=bi2de(b);
            
        end
                inc=inc+1;
        end
        


figure,imshow(i,[]);
%i(1,1,1:3)
%f(1,1,1:3)
o=i;

end

