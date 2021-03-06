clear;
load Jaffe;
load Jaffe32_row;
global p1 knn
knn=1;
p1=2^-8;
X = Jaffe32_row;
Y=Y;
for loop=1:20
   index1=find(Y==1);
   index2=find(Y==2);
   index3=find(Y==3);
   index4=find(Y==4);
   index5=find(Y==5);
   index6=find(Y==6);
   index7=find(Y==7); 
     
   index1 = index1(randperm(length(index1)));
   index2 = index2(randperm(length(index2)));
   index3 = index3(randperm(length(index3)));
   index4 = index4(randperm(length(index4)));
   index5 = index5(randperm(length(index5)));
   index6 = index6(randperm(length(index6)));
   index7 = index7(randperm(length(index7)));
   
   sampN= 20;
   in1 = index1(1:sampN,1);
   in2 = index2(1:sampN,1);
   in3 = index3(1:sampN,1);
   in4 = index4(1:sampN,1);
   in5 = index5(1:sampN,1);
   in6 = index6(1:sampN,1);
   in7 = index7(1:sampN,1);
   
   trn = zeros(213,1);
   trn(in1(:,1)) = 1;
   trn(in2(:,1)) = 1;
   trn(in3(:,1)) = 1;
   trn(in4(:,1)) = 1;
   trn(in5(:,1)) = 1;
   trn(in6(:,1)) = 1;
   trn(in7(:,1)) = 1;
   
   ttrn = logical(trn);
   ttst = ~ttrn;
   x_trn=X(ttrn,:);
   y_trn=Y(ttrn);
   x_tst=X(ttst,:);
   y_tst=Y(ttst);
   
    [eigvectorPCA,eigvaluePCA] = PCA2(double(x_trn),1003);
    x_trn_PCA = double(x_trn)*eigvectorPCA;
    x_tst_PCA = double(x_tst)*eigvectorPCA; 

    %% sparse MFA with PCA
%     [V_SMFA_PCA,X_trn,X_tst]=sparse_MFA(x_trn_PCA,y_trn,x_tst_PCA,6); 
%     [out1]=cknear(knn,X_trn,y_trn,X_tst); 
%     Acc(loop,1)=mean(out1==y_tst);
    %% sparse MFA without PCA
    [V_SMFA,X_trn,X_tst]=sparse_MFA(x_trn,y_trn,x_tst,50); 
    [out2]=cknear(knn,X_trn,y_trn,X_tst); 
    Acc(loop,2)=mean(out2==y_tst);
    %% MFA with PCA
%     [V_MFA_PCA,X_trn,X_tst] = MFA(x_trn_PCA,y_trn,x_tst_PCA);
%     [out3]=cknear(knn,X_trn,y_trn,X_tst);
%     Acc(loop,3)=mean(out3==y_tst);
    %% MFA without PCA
%     [V_MFA,X_trn,X_tst] = MFA(x_trn,y_trn,x_tst);
%     [out4]=cknear(knn,X_trn,y_trn,X_tst);
%     Acc(loop,4)=mean(out4==y_tst);
   %% linear discriminant analysis
%     options = [];
%     options.Fisherface = 1;
%     x_trn = double(x_trn);
%     x_tst = double(x_tst);
%     [V_LDA, eigvalue] = LDA_z(y_trn, options, x_trn);
%     X_trn = x_trn*V_LDA;
%     X_tst = x_tst*V_LDA;
%     [out5]=cknear(knn,X_trn,y_trn,X_tst);
%     Acc(loop,5)=mean(out5==y_tst);   
     %% LPP with PCA
%     options = [];
%     options.Metric = 'Euclidean';
%     options.NeighborMode = 'Supervised';
%     options.gnd = y_trn;
%     options.bLDA = 1;
%     x_trn=double(x_trn);
%     x_tst=double(x_tst);
%     W = constructW(x_trn,options);      
%     options.PCARatio = 1;
%     [V_LPP, eigvalue] = LPP(W, options, x_trn);
%     X_trn = x_trn*V_LPP;
%     X_tst = x_tst*V_LPP;
%     [out6]=cknear(knn,X_trn,y_trn,X_tst);
%     Acc(loop,6)=mean(out6==y_tst);  
%% Linear discriminant analysis self
    [X_trn, V_LDA_self] = LDA(x_trn_PCA, y_trn,6);
    X_tst = x_tst_PCA*V_LDA_self.M;
    [out5]=cknear(knn,X_trn,y_trn,X_tst);
    Acc(loop,5)=mean(out5==y_tst); 
    %% lpp_self
    x_trn=double(x_trn);
    x_tst=double(x_tst);
    [X_trn, V_LPP_SELF] = lpp_self(x_trn_PCA, 50);
    X_tst = x_tst_PCA*V_LPP_SELF;
    [out6]=cknear(knn,X_trn,y_trn,X_tst);
    Acc(loop,6)=mean(out6==y_tst);  
    %% LFDA with PCA   last parameter was set to s-1(s=4,8,12,etc)
    x_trn_col = changeXRow2XCol(x_trn_PCA);
    x_tst_col = changeXRow2XCol(x_tst_PCA);
    [n,d] = size(x_trn_PCA);
    [V_LFDA,x_newtrn]=LFDA(x_trn_col,y_trn,6);%T: d x r transformation ; Z: r x n matrix of dimensionality reduced samples
    x_newtst=V_LFDA'*x_tst_col;
    X_trn = changeXCol2XRow(x_newtrn);
    X_tst = changeXCol2XRow(x_newtst);
    [out7]=cknear(knn,X_trn,y_trn,X_tst);
    Acc(loop,7)=mean(out7==y_tst);        
    %% SLFDA
    x_trn_col = changeXRow2XCol(x_trn);
    x_tst_col = changeXRow2XCol(x_tst);
    [V_SLFDA,X_trn,X_tst]=SparseLocal_FDA(x_trn_col,y_trn,x_tst_col,6);
    X_trn = changeXCol2XRow(X_trn);
    X_tst = changeXCol2XRow(X_tst);
    [out8]=cknear(knn,X_trn,y_trn,X_tst); 
    Acc(loop,8)=mean(out8==y_tst);
     %% NPE
%     options = [];
%     options.k = 5;
%     options.NeighborMode = 'Supervised';
%     options.gnd = y_trn;
%     x_trn=double(x_trn);
%     x_tst=double(x_tst);
%     [eigvector, eigvalue] = NPE(options, x_trn);
%     X_trn = x_trn*eigvector;
%     X_tst = x_tst*eigvector;
%     [out9]=cknear(knn,X_trn,y_trn,X_tst);
%     Acc(loop,9)=mean(out9==y_tst); 
    
end

mean(Acc)
std(Acc)