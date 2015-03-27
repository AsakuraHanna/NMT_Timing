%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DOCUMENTATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Reads from a given file defined by 'filePath' and extracts channelMax
% rows from this file. Outputs the third column of this file as a
% separate vector given by 'counts'
%
% filePath: Filename preceded by full path to file
%
% ChannelMax:   Defines the first row to be deleted, this will be the number
%               of channels chosen deminished by one
%
% counts: Vector of numbers containing the counts for a particular file
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% END DOCUMENTATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [counts] = readDF(filePath,channelMax) 
    
    if ( isempty(strfind(filePath,'.csv')) == 0 && isempty(strfind(filePath,'sigma')) == 1 )
                % the above check is actually not needed since we already
                % filtered bad files in a previous for-loop
                
        %read files one by one
        fileID = fopen(filePath);
        data = textscan(fileID,'%s%s%s','Delimiter',';','HeaderLines',1,'EndOfLine','\n');
        fclose(fileID);
        
        %extract counts
        cnts = data{3};
        cnts(channelMax:end) = [];
        
        %transform counts from str to double and saves to vector
        counts = zeros(channelMax-1,1);
        for j=1:channelMax-1
            counts(j) = str2num(cnts{j});
        end        
    end
end