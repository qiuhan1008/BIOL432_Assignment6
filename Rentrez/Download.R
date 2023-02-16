

install.packages("rentrez")
#load NCBI IDs
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")
#load library
library(rentrez)
#Downlooad data from NCBI. The name of the database is nuccore with an 
#unique ID, and the data type is fasta. 
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

#take a look at the Bburg object
head(Bburg)
#create sequence
Sequences <- strsplit(Bburg, split = "\n\n", fixed = T)
print(Sequences)

#convert list to dataframe
Sequences<-unlist(Sequences)

#use regular expressions to separate the sequences from the headers
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

#remove the newline characters by using regular expressions
Sequences$Sequence <- gsub("\n", "", Sequences$Sequence)

#Output this data frame to a file called Sequences.csv.
write.csv(Sequences, "Sequences.csv")














