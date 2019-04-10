#clearing the working space

rm(list=ls())

#Loading necessary libaries (if these packages are not installed, install them first)

library("tm")
library("SnowballC")
library("wordcloud")
library("wordcloud2")
library("RColorBrewer")
library("NLP")
library("tm")
library("ggplot2")


#Loading the Data

text <- readLines("YOUR_PATH\\q1_MALE.txt")


docs <- Corpus(VectorSource(text))


#### Transformation is performed using tm_map() function to replace, for example, special characters from the text. Replacing "/", "@" and "|" with space.

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, ",")
docs <- tm_map(docs, toSpace, "\\|")


#### code used to clean your text.


# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word. These are common phrases like greetings or exclamation
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("murakoze", "cyane", "numva", "uko","ariko", "iki","icyo","hari","kuri","ngo")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)



####Build a term-document matrix Document matrix is a table containing the frequency of the words. Column names are words and row names are documents. The function TermDocumentMatrix() from text mining package can be used as follow 

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
demoFreq<- data.frame(word = names(v),freq=v)
head(demoFreq, length(text))

####Generate the Word cloud The importance of words can be illustrated as a word cloud as follow

set.seed(1234)
#saving the image produced to a PNG
png("YOUR_PATH\\q1_MALE.png",res=100)
wordcloud(words = demoFreq$word, freq = demoFreq$freq,scale=c(2,1), min.freq = 2,
          max.words=150, random.order=FALSE, random.color=FALSE, rot.per=0.35, colors=brewer.pal(8, "Set2"))
dev.off()


#Spectral, Dark2 (7), paired (9,10), set2(8),set3 (12) (some of the cplors I like)


