#' Get Boundary Shapefile
#'
#' Internal function that is used to get the boundary shapefile required in other functions
#' @param mainPath character; the parent directory of the country folder
#' @param country character; the country folder name
#' @param type character; 'raw' or 'processed' depending on whether the required input is
#' the raw input or the already processed one (i.e. projected shapefile).
#' @param mostRecent logical; should the most recent input be selected? If FALSE and if there are multiple
#' available inputs, the user is interactively asked to select the input based on file creation time.
#' @return object of class \code{sf} when a layer was successfully read
#' @export
get_boundaries <- function (mainPath, country, type, mostRecent) {
  if (!is.character(mainPath)) {
    stop("mainPath must be 'character'")
  }
  if (!is.character(country)) {
    stop("country must be 'character'")
  }
  if (!type %in% c("raw", "processed")) {
    stop("type must be 'raw' or 'processed")
  }
  # Check directory
  pathBorder <- paste0(mainPath, "/", country, "/data/vBorders")
  if (!dir.exists(pathBorder)) {
    stop(paste(pathBorder,"does not exist. Run the initiate_project function first or check the input parameters."))
  }
  folders <- check_exists(pathBorder, type, layer = TRUE)
  if (is.null(folders)) {
    stop(paste(stringr::str_to_title(type), "boundary shapefile is missing."))
  } else {
    if (type == "raw") {
      timeFolder <- select_input(folders, "Shapefile downloaded at", mostRecent)
      if (is.null(timeFolder)) {
        stop_quietly("You exit the function.")
      } else {
        boundFolder <- paste0(pathBorder, "/", timeFolder, "/raw/")
        multipleFilesMsg <- "Select the boundary shapefile that you would like to use."
        message(paste("Loading", type, "boundaries..."))
        border <- load_layer(boundFolder, multipleFilesMsg)[[2]]
        return(border)
      }
    } else {
      timeFolder <- select_input(folders, "Shapefile processed at", mostRecent)
      if (is.null(timeFolder)) {
        stop_quietly("You exit the function.")
      } else {
        folderLst <- list.dirs(pathBorder)
        boundFolder <-   folderLst[grepl(paste0("processed/", timeFolder), folderLst)]
        multipleFilesMsg <- "Select the boundary shapefile that you would like to use."
        message(paste("\nLoading", type, "boundaries..."))
        border <- load_layer(boundFolder, multipleFilesMsg)[[2]]
        return(border)
      }
    }
  } 
}
