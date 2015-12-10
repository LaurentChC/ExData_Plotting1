## EDA, CourseProject1, plot 3

## Preliminaries: In order to get the axis ticks in English, one needs to set the 
## appropriate locale
Sys.setlocale("LC_TIME", "en_US.UTF-8")

## First step: loading the data and preparing the relevant dataframe (transforming 
## mssing data characterized by a "?" into "NA", filtering on the relevant dates, 
## adding a combined data/time column in POSIX format)

## The following step is to speed up data loading by specifying the column classes
## on a small subset
rawdata10 <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?", nrows=10)
classes <- sapply(rawdata10, class)

## Importing the data : attention to the missing values that need to be identified
## as such during the loading process with the option na.strings
rawdata <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?", 
                    colClasses = classes)
filtdata <- subset(rawdata, Date == "1/2/2007" | Date == "2/2/2007")

## Creating a column that combines the date and time data into a single field that 
## has the POSIX format. The column will be added to the dataframe on the left side
## and one obtains the new dataframe extdata ('ext' stands for 'extended')
Datetime <- strptime(paste(filtdata$Date,filtdata$Time), format = "%d/%m/%Y %H:%M:%S")
workdata <- cbind(Datetime,filtdata)

## Code for plotting Plot3
png(file="plot3.png", width = 480, height = 480, units = "px")

with(workdata, plot(x=Datetime,y=Sub_metering_1, ylim=range(0,38), type="l", 
                    col = "black", ylab="Energy sub metering", xlab=""))
par(new=TRUE)
with(workdata, plot(x=Datetime,y=Sub_metering_2, ylim=range(0,38), type="l", 
                    col = "red", axes = FALSE, xlab="", ylab=""))
par(new=TRUE)
with(workdata, plot(x=Datetime,y=Sub_metering_3, ylim=range(0,38), type="l", 
                    col = "blue", axes = FALSE, xlab="", ylab=""))
legend("topright",lty="solid", col=c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),text.font = 1, cex=0.64)

dev.off()


