
## This script assumes you have the following zip file saved to your
## current working directory.
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## We will only read the first 70,000 rows to save memory.

fullData <- read.table("household_power_consumption.txt", header=TRUE,
                       sep=';', na.strings = "?", nrows=70000,
                       colClasses=c('character', 'character', 'numeric', 'numeric',
                                    'numeric', 'numeric', 'numeric', 'numeric'))
fullData$Date <- as.Date(fullData$Date, format="%d/%m/%Y")

## We will select only the data from 2/1/2007 and 2/2/2007.
data <- subset(fullData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
data$DateTime = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

## Create plot3
with(data, {
    plot(DateTime, Sub_metering_1, type='l', col='black',
         ylab='Energy sub metering', xlab='', ylim=c(0,38))
    lines(DateTime, Sub_metering_2, type='l', col='red')
    lines(DateTime, Sub_metering_3, type='l', col='blue')
    legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
           lty=1, col=c('black', 'red', 'blue'))
    }
)

## Saving plot3 to png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

