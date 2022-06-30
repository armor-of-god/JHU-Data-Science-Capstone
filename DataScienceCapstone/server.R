suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))

# LOAD N-GRAM DATA SETS

quadgram <- readRDS("4gram.RData");
trigram <- readRDS("3gram.RData");
bigram <- readRDS("2gram.RData");
mesg <<- ""

# CLEAN USER INPUT DATA

Predict <- function(x) {
    clean <- removeNumbers(removePunctuation(tolower(x)))
    user_input <- strsplit(clean, " ")[[1]]

# PREDICT NEXT TERM - STARTING WITH 4-GRAM, THEN 3-GRAM IF UNSAT, THEN 2-GRAM IF UNSAT

    if (length(user_input)>= 3) {
        user_input <- tail(user_input,3)
        if (identical(character(0),head(quadgram[quadgram$unigram == user_input[1] & quadgram$bigram == user_input[2] & quadgram$trigram == user_input[3], 4],1))){
            Predict(paste(user_input[2],user_input[3],sep=" "))
        }
        else {mesg <<- "The next word is predicted using a 4-gram."; head(quadgram[quadgram$unigram == user_input[1] & quadgram$bigram == user_input[2] & quadgram$trigram == user_input[3], 4],1)}
    }
    else if (length(user_input) == 2){
        user_input <- tail(user_input,2)
        if (identical(character(0),head(trigram[trigram$unigram == user_input[1] & trigram$bigram == user_input[2], 3],1))) {
            Predict(user_input[2])
        }
        else {mesg<<- "The next word is predicted using a 3-gram."; head(trigram[trigram$unigram == user_input[1] & trigram$bigram == user_input[2], 3],1)}
    }
    else if (length(user_input) == 1){
        user_input <- tail(user_input,1)
        if (identical(character(0),head(bigram[bigram$unigram == user_input[1], 2],1))) {mesg<<-"No match found. Most common word 'the' is returned."; head("the",1)}
        else {mesg <<- "The next word is predicted using a 2-gram."; head(bigram[bigram$unigram == user_input[1],2],1)}
    }
}


shinyServer(function(input, output) {
    output$prediction <- renderPrint({
        result <- Predict(input$inputString)
        output$string2 <- renderText({mesg})
        result
    });
    
    output$string1 <- renderText({
        input$inputString});
}
)