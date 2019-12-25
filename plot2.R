##PREPARING THE DATA

# set working directory
setwd("E:/DATA SCIENTIST TERBARU/COURSE 4/25 DECEMBER 2019/COURSE LAST EDA/exploratorydataanalysis")
if(!file.exists("./dataStore")){dir.create("./dataStore")}
# activity monitoring data
get.data.project <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(get.data.project,destfile="./dataStore/exdata-data-NEI_data.zip",method="auto")  

# make sure the site is live, if it is not live stop function terminate the program
check.url <- file(get.data.project,"r")
if (!isOpen(check.url)) {
  stop(paste("There's a problem with the data:",geterrmessage()))
}
# zipfile.data is the variable to keep the *.zip file
zipfile.data = "exdata-data-NEI_data.zip"

# make sure the data in the working directory if not download the zip file into the to zipfile.data and unzip the zipfile.data
if(!file.exists(zipfile.data)) {        
  # download.file(get.data.project,zipfile.data)
  unzip(zipfile="./dataStore/exdata-data-NEI_data.zip",exdir="./dataStore")
} 
path_rf <- file.path("./dataStore" , "exdata-data-NEI_data")
files<-list.files(path_rf, recursive=TRUE)
files


##SETTING THE LIBRARY THAT WE USED
library(dplyr)
library(ggplot2)


# Read data files
# read national emissions data
NEI <- readRDS("./dataStore/summarySCC_PM25.rds")
# str(NEI)
# dim(NEI)
# head(NEI)
#read source code classification data
SCC <- readRDS("./dataStore/Source_Classification_Code.rds")
# str(SCC)
# dim(SCC)
# head(SCC)
# visualization
number.add.width<-800                             # width length to make the changes faster
number.add.height<-800                             # height length to make the changes faster

# Plot 2
# open device
if(!file.exists('figures')) dir.create('figures')
png(filename = './figures/plot2.png', width =number.add.width, height =number.add.height, units='px')

baltcitymary.emissions<-summarise(group_by(filter(NEI, fips == "24510"), year), Emissions=sum(Emissions))
clrs <- c("red", "green", "blue", "yellow")
x2<-barplot(height=baltcitymary.emissions$Emissions/1000, names.arg=baltcitymary.emissions$year,
            xlab="years", ylab=expression('total PM'[2.5]*' emission in kilotons'),ylim=c(0,4),
            main=expression('Total PM'[2.5]*' emissions in Baltimore City-MD in kilotons'),col=clrs)

## Add text at top of bars
text(x = x2, y = round(baltcitymary.emissions$Emissions/1000,2), label = round(baltcitymary.emissions$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")
dev.off()
#close device
