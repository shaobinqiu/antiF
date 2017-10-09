clear 
NSW=200;
ENCUT=540;
ISMEAR=-5;
EDIFFG=-0.02;
EDIFF=1E-6;
NPAR=2;
ISIF=3;
IBRION=2;
ISPIN=2;%Parameters of INCAR
fileFolder=fullfile('./Ratio1_1POSCAR_V2_V10');
dirOutput=dir(fullfile(fileFolder,'*'));%get the filename in direction
 for ii=3:size(dirOutput,1)
message=import_poscar(['./Ratio1_1POSCAR_V2_V10/',dirOutput(ii).name]);

fid=fopen(['./INCAR&POSCAR/POSCAR_','S',int2str(message.atomcount(1)),'Mn',int2str(message.atomcount(2)+message.atomcount(3)),'_',int2str(ii-2)],'w+');
fprintf(fid,['S',int2str(message.atomcount(1)),'Mn',int2str(message.atomcount(2)+message.atomcount(3)),'\n']);
fprintf(fid,'%g\n',1);
fprintf(fid,'%g     %g     %g\n',message.lattice');
m=char(message.symbols);%cell to char
fprintf(fid,'%s\n',[m(1,:),[m(2,:),' '] ,m(2 ,:)]');
fprintf(fid,'%g     %g     %g\n',message.atomcount);
fprintf(fid,'%s\n','direct');
fprintf(fid,'%g     %g     %g\n',message.coords');
fclose(fid);%POSCAR

fid=fopen(['./INCAR&POSCAR/INCAR_','S',int2str(message.atomcount(1)),'Mn',int2str(message.atomcount(2)+message.atomcount(3)),'_',int2str(ii-2)],'w+');
fprintf(fid,['SYSTEM=MnS','\n']);
fprintf(fid,['NSW=',int2str(NSW),'\n']);
fprintf(fid,['ENCUT=',int2str(ENCUT),'\n']);
fprintf(fid,['ISMEAR=',int2str(ISMEAR),'\n']);
fprintf(fid,['EDIFFG=',num2str(EDIFFG),'\n']);
fprintf(fid,['EDIFF=',num2str(EDIFF),'\n']);
fprintf(fid,['NPAR=',int2str(NPAR),'\n']);
fprintf(fid,['ISIF=',int2str(ISIF),'\n']);
fprintf(fid,['IBRION=',int2str(IBRION),'\n']);
fprintf(fid,['ISPIN=',int2str(ISPIN),'\n']);
fprintf(fid,['MAGMOM=',int2str(message.atomcount(1,1)),'*0 ',int2str(message.atomcount(2,1)),'*1 ',int2str(message.atomcount(3,1)),'*-1 ',]);
fclose(fid);%INCAR
 end