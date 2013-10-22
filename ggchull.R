####function to take a dataframe, x and y variables and
####optional grouping variable and returns object with 
####convex hulls that can be added to ggplot
require(plyr)
require(ggplot2)

ggchull <- function (df,x,y,grouping=NULL) {
  
  compute_hull <- function(df) { 
    ##helper function to compute convex hull
    df[chull(df$x, df$y),]
  }
  
  if(is.null(grouping)) {df$grouping <- rep(1,nrow(df))} #create grouping if it doesn't exist
  
  if (!(sum(c("x","y","grouping") %in% names(df))==3)) {
        stop("x , y,and grouping variable must exist as columns in dataframe")
        }
  
  df <- data.frame(df[complete.cases(df),])
  hulls <- ddply(df, grouping, compute_hull)
  return( 
        geom_polygon(data=hulls,aes(group=grouping,fill=grouping),alpha=I(.3))
        )
  
}