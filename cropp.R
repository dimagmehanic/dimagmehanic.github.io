library(magick)

files <- list.files(file.path("assets", "img"), full.names = TRUE)
files <- files[!grepl("background|profile|cropped_", files)]

crop_center <- function(img, w, h) {

  img <- image_scale(img, paste0(w, "x", h, "^"))

  info <- image_info(img)

  x_off <- as.integer((info$width - w) / 2)
  y_off <- as.integer((info$height - h) / 2)

  image_crop(img, geometry_area(w, h, x_off, y_off))
}

for (f in files) {
  img <- image_read(f)

  img2 <- crop_center(img, 600, 400)

  image_write(img2, file.path("assets", "img", paste0("cropped_", basename(f))))
}
