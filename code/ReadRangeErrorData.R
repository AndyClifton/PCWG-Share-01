ReadRangeErrorData <- function(wb,sheet,sv){
  # reads a PCWG Share 01 file and returns data about the error
  #
  # Args:
  # data.file: name of the data file to be read
  #
  # Returns:
  # data.frame containing data from the "Meta Data" tab
  
  require(XLConnect)
  setMissingValue(wb," ")
  # figure out the starting row
  if(compareVersion(VersionStr(sv),
                    "0.5.8") <= 0){sr = 23}
  if(compareVersion(VersionStr(sv),
                    "0.5.8") > 0){sr = 31}
  
  # get data...
  # By range
  bin = paste(as.character(readWorksheet(wb,
                                         sheet = sheet,
                                         region = paste0("D",sr,":E", sr),
                                         header = FALSE,
                                         autofitCol = FALSE,
                                         autofitRow= FALSE)),
              collapse=", ",
              sep=" ")
  data.count = paste(as.character(readWorksheet(wb,
                                                sheet = sheet,
                                                region = paste0("D",sr+1,":E", sr+1),
                                                header = FALSE,
                                                autofitCol = FALSE,
                                                autofitRow= FALSE)),
                     collapse=", ",
                     sep=" ")
  NME = paste(as.character(readWorksheet(wb,
                                         sheet = sheet,
                                         region = paste0("D",sr+2,":E", sr+2),
                                         header = FALSE,
                                         autofitCol = FALSE,
                                         autofitRow= FALSE)),
              collapse=", ",
              sep=" ")
  NMAE = paste(as.character(readWorksheet(wb,
                                          sheet = sheet,
                                          region = paste0("D",sr+3,":E", sr+3),
                                          header = FALSE,
                                          autofitCol = FALSE,
                                          autofitRow= FALSE)),
               collapse=", ",
               sep=" ")
  
  # return data
  data.error = data.frame(sheet.name = sheet,
                          bin = as.character(bin),
                          data.count = as.character(data.count),
                          NME = as.character(NME),
                          NMAE = as.character(NMAE),
                          stringsAsFactors=FALSE)
}

# note that there are some problems with XLConnect on a mac: see 
# https://github.com/s-u/rJava/issues/37 for details of how to fix them
# (download the Apple Java 1.6 release and install it)