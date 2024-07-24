## importing libraries
library(sqldf)


if (!dir.exists("data")) dir.create("data")

## downloading dataset into data/epc
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data/epc.zip")

## unzipping esp
unzip("data/epc.zip", exdir = "data/")

## reading necessary rows into the epc(electrical power consumption) var
epc <- read.csv.sql("data/household_power_consumption.txt",
                    sql = "select * from file where Date == '1/2/2007' OR Date == '2/2/2007'", eol = '\n', sep = ";")

## creating the png device
png("plot1.png", width = 480, height = 480)

## creating plot 1
hist(epc$Global_active_power, xlab = "Gloabal Active Power (kilowatts)", main = "Gloabal Active Power", col="red")

## closing png device
dev.off()
