getGeoCode <- function(gcStr, key)  {
  library("RJSONIO") #Load Library
  gcStr <- gsub(' ','%20',gcStr) #Encode URL Parameters
  #Open Connection
  connectStr <- paste0('https://maps.googleapis.com/maps/api/geocode/json?address=',gcStr, "&key=",key) 
  con <- url(connectStr)
  data.json <- fromJSON(paste(readLines(con), collapse=""))
  close(con)
  #Flatten the received JSON
  data.json <- unlist(data.json)
  if(data.json["status"]=="OK")   {
    lat <- data.json["results.geometry.location.lat"]
    lng <- data.json["results.geometry.location.lng"]
    gcodes <- c(lat, lng)
    names(gcodes) <- c("Lat", "Lng")
    return (gcodes)
  }
}


geoCodes <- getGeoCode(gcStr="11 via del piano, empoli", key)
