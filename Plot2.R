#Reading data from file

powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

#Quitting scientific notation

powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#POSIXct date filtered and graphed by time of day

powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Filtering Dates from 2007-02-01 to 2007-02-02

powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

#Plot 2

plot(x = powerDT[, dateTime]
     , y = powerDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

