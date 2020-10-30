cmake_minimum_required(VERSION 3.0)
project(libmnl C)

add_library(mnl
  ${CMAKE_CURRENT_LIST_DIR}/src/socket.c
  ${CMAKE_CURRENT_LIST_DIR}/src/nlmsg.c
  ${CMAKE_CURRENT_LIST_DIR}/src/callback.c
  ${CMAKE_CURRENT_LIST_DIR}/src/attr.c
)

target_include_directories(mnl PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/include
  ${CMAKE_CURRENT_LIST_DIR}/src
  )

INSTALL(TARGETS mnl
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)
