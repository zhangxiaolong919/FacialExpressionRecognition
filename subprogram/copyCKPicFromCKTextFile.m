% mydir = 'C:\Users\Administrator\Desktop\ExpressionRecognition\CK���ݼ���¼\1\';
% % picDir = '';
% DIRS = dir([mydir,'*.txt']); % DIRS(i).name�������ļ��� S010_004_00000019.txt
% % ȡ����׺��
% for i = 1 : 44
% %     str = [mydir,DIRS(i).name];
% %     img = imread(str);               
%     DIRS(i).name = DIRS(i).name(1:end-4);
%     DIRS(i).name = [DIRS(i).name,'.png'];
% end

%����ͼƬ�ļ��У�����ͼƬ
imgDataPath = 'E:\����ʶ���о�\����ʶ��\����������\Cohn�CKanade facial expression database\CK+\cohn-kanade-images\';
imgDataDir  = dir(imgDataPath);             % ���������ļ�
% 
% for k=1:44
    for i = 1:length(imgDataDir)
        if(isequal(imgDataDir(i).name,'.')||... % ȥ��ϵͳ�Դ����������ļ���
           isequal(imgDataDir(i).name,'..')||...
           ~imgDataDir(i).isdir)                % ȥ�������в����ļ��е�
               continue;
        end
        tempDir1 = dir([imgDataPath,imgDataDir(i).name]);
        
        for j=1:length(tempDir1)
%             imgDir = dir([imgDataPath,imgDataDir(j).name]);
            if(isequal(tempDir1(j).name,'.')||... % ȥ��ϵͳ�Դ����������ļ���
                    isequal(tempDir1(j).name,'..')||...
                    ~tempDir1(j).isdir)                % ȥ�������в����ļ��е�
                    continue;
                end
            imgDir = dir([imgDataPath,imgDataDir(i).name,tempDir1(j).name]);
            for k=1:length(imgDir)
                if(isequal(imgDir(k).name,'.')||... % ȥ��ϵͳ�Դ����������ļ���
                    isequal(imgDir(k).name,'..')||...
                    ~imgDir(k).isdir)                % ȥ�������в����ļ��е�
                    continue;
                end
                img = dir([imgDataPath,imgDataDir(i).name,tempDir1(j).name,imgDir(k)]);
                
            end
%             for k=1:length(imgDir)
%                 
%             end
%             iDir = dir([imgDataPath,imgDataDir(j).name],imgDir);
%             for j =1:length(imgDir)                 % ��������ͼƬ
%                 img = imread([imgDataPath imgDataDir(i).name '/' imgDir(j).name]);
%                 imshow(img);
%             end
        end       
%         imgDir = dir([tempDir,'*.png']); 
       
    end

% 
% end