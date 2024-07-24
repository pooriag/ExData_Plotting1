## importing libraries
library(sqldf)
library(lubridate)


if (!dir.exists("data")) dir.create("data")

## downloading dataset into data/epc
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data/epc.zip")

## unzipping esp
unzip("data/epc.zip", exdir = "data/")

## reading necessary rows into the epc(electrical power consumption) var
epc <- read.csv.sql("data/household_power_consumption.txt",
                    sql = "select * from file where Date == '1/2/2007' OR Date == '2/2/2007'", eol = '\n', sep = ";")

## creating the png device
png("plot2.png", width = 480, height = 480)

## combining epc time and date to a new var
epc$moment <- dmy_hms(paste0(epc$Date, '_', epc$Time))

## sorting based on moment
epc <- epc[order(epc$moment), ]

## creaiting plot 2
plot(epc$Global_active_power~epc$moment, type='l', lwd=1, xlab="", ylab = "Gloabal Active Power")

## closing png device
dev.off()
