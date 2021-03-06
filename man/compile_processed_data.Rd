% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compile_processed_data.R
\name{compile_processed_data}
\alias{compile_processed_data}
\title{Compile Input Layers}
\usage{
compile_processed_data(mainPath, country, mostRecent = TRUE)
}
\arguments{
\item{mainPath}{character; the parent directory of the country folder}

\item{country}{character; the country folder name}

\item{mostRecent}{logical; should the most recent 'processed' input be selected? If FALSE and if there are multiple
available 'processed' inputs, the user is interactively asked to select the 'processed' input based on file creation time.}
}
\description{
Compiles the available processed layers and copy them to a new folder called zToAccessMod to facilitate the further import into AccessMod
}
