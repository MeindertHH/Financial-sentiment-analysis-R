financialsentiment <- function(docs = exampledocs, dictneg, dictpos, stemming = FALSE, rmstopwords = FALSE, saveprocessed = FALSE) {
  
  # text preprocessing
  toSpace <- content_transformer(function(x, pattern) {return (gsub(pattern, " ", x))})
  docs <- tm_map(docs, toSpace, "\U003A") # :
  docs <- tm_map(docs, toSpace, "\U00BD") # ½
  docs <- tm_map(docs, toSpace, "\U002D") # -
  docs <- tm_map(docs, toSpace, "\U02BC") # ’
  docs <- tm_map(docs, toSpace, "\U201C") # “
  docs <- tm_map(docs, toSpace, "\U201D") # ”
  docs <- tm_map(docs, toSpace, "\U2013") # –
  docs <- tm_map(docs, toSpace, "\U2014") # —
  docs <- tm_map(docs, toSpace, "\U2018") # ‘
  docs <- tm_map(docs, toSpace, "\U2019") # ’
  docs <- tm_map(docs, toSpace, "\U0022") # "
  docs <- tm_map(docs, toSpace, "\U0027") # '
  docs <- tm_map(docs, toSpace, "\U2026") # …
  docs <- tm_map(docs, toSpace, "\U2212") # -
  docs <- tm_map(docs, removePunctuation)
  docs <- tm_map(docs, removeNumbers)
  docs <- tm_map(docs,content_transformer(tolower))
  
  if (rmstopwords == TRUE) {
    docs <- tm_map(docs, removeWords, stopwords("english"))
  }
  
  if (stemming == TRUE) {
    docs <- tm_map(docs,stemDocument)
    dictneg <- unique(stemDocument(dictneg))
    dictpos <- unique(stemDocument(dictpos))
  }
  
  docs <- tm_map(docs, stripWhitespace)
  
  if (saveprocessed == TRUE){
    dir.create("processed")
    writeCorpus(docs, path = "processed")
  }
  
  # financial sentiment
  dtm <- DocumentTermMatrix(docs, control = list(wordLengths = c(1, Inf)))
  counttotal <- rowSums(as.matrix(dtm))
  dtmneg <- as.matrix(DocumentTermMatrix(docs, list(dictionary = dictneg)))
  countneg <- rowSums(dtmneg)
  dtmpos <- as.matrix(DocumentTermMatrix(docs, list(dictionary = dictpos)))
  countpos <- rowSums(dtmpos)
  result <- cbind(counttotal, countpos, countneg)
  result <- transform(result, negativity = (countneg/counttotal))
  result <- transform(result, positivity = (countpos/counttotal))
  
  print(result)
}