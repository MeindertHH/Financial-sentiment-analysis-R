# Description
Perform a quick and simple financial sentiment analysis in R using the dictionary of Loughran & McDonald. It counts the number of financially positive and negative words in multiple texts at once.

# Basic Usage
## Install and load package 'tm'
```{r setup, include=FALSE}
> install.packages("tm")
> library(tm)
```

## Load a collection of documents

```{r setup, include=FALSE}
> docs <- Corpus(DirSource("foldername")) # replace foldername
```

## Load the dictionaries as a character vector

Dictionaries are provided by McDonald at http://www3.nd.edu/~mcdonald/Word_Lists.html. The positive and negative word lists should be a character vector in R. For example:

```{r setup, include=FALSE}
> dictneg <- readLines("negative.csv")
> dictpos <- readLines("positive.csv")
```

# License
See LICENSE.md for a full copy of the MIT-license.
