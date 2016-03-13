
## Before running this script, ensure the source file household_power_concumption.txt is in your working directory

# read first fe rows of data file and identify column classes
household_data <- read.table(file="./household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", nrows=100)
classes <- sapply(household_data, class)

# read entire data file and change date to date format
household_data <- read.table(file="./household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", colClasses = classes)
household_data$Date <- as.Date(household_data$Date, "%d/%m/%Y")

# subset data for required dates
Subset_data <- subset(household_data, Date == "2007-02-01" | Date == "2007-02-02") 

# create new column with timestamp TS
Subset_data$TS <- as.POSIXct(paste(Subset_data$Date, Subset_data$Time), format="%Y-%m-%d %H:%M:%S")

png(file = "./plot3.png")
with(Subset_data, plot(Sub_metering_1~TS, xlab= "", ylab = "Energy sub metering", type="l"))
with(Subset_data, points(Sub_metering_2~TS, col="red", type="l"))
with(Subset_data, points(Sub_metering_3~TS, col="blue", type="l"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()


