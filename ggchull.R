####function to take x and y vectors and
#### grouping factor and return object with 
####convex hulls that can be added to ggplot object

require(plyr)
require(ggplot2)

ggchull <- function (x,y,grouping) {
  
    
  theDataFrame <- data.frame(x=x,y=y,grouping=grouping)
  theDataFrame <- data.frame(theDataFrame[complete.cases(theDataFrame),])
  theDataFrame$grouping <- as.factor(theDataFrame$grouping)
  
  compute_hull <- function(df) { 
    ##helper function to compute convex hull
    df[chull(df$x, df$y),]
  }
  
    
    hulls <- ddply(theDataFrame, "grouping", compute_hull)
  
  return( 
        geom_polygon(data=hulls,aes(group=grouping,fill=grouping),alpha=I(.3))
        )
  
}

