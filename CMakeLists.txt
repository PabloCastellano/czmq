################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################

########################################################################
# Project setup
########################################################################
cmake_minimum_required(VERSION 2.8)
project(czmq)
enable_language(C)
enable_testing()

set(SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

########################################################################
# options
########################################################################
if (EXISTS "${SOURCE_DIR}/.git")
    OPTION (ENABLE_DRAFTS "Build and install draft classes and methods" ON)
else ()
    OPTION (ENABLE_DRAFTS "Build and install draft classes and methods" OFF)
endif ()

IF (ENABLE_DRAFTS)
    ADD_DEFINITIONS (-DCZMQ_BUILD_DRAFT_API)
ENDIF (ENABLE_DRAFTS)

########################################################################
# platform.h
########################################################################
include(CheckIncludeFile)
CHECK_INCLUDE_FILE("linux/wireless.h" HAVE_LINUX_WIRELESS_H)
CHECK_INCLUDE_FILE("net/if_media.h" HAVE_NET_IF_MEDIA_H)

include(CheckFunctionExists)
CHECK_FUNCTION_EXISTS("getifaddrs" HAVE_GETIFADDRS)
CHECK_FUNCTION_EXISTS("freeifaddrs" HAVE_FREEIFADDRS)

include(CheckIncludeFiles)
check_include_files("sys/socket.h;net/if.h" HAVE_NET_IF_H)
if (NOT HAVE_NET_IF_H)
    CHECK_INCLUDE_FILE("net/if.h" HAVE_NET_IF_H)
endif()

file(WRITE "${SOURCE_DIR}/src/platform.h.in" "
#cmakedefine HAVE_LINUX_WIRELESS_H
#cmakedefine HAVE_NET_IF_H
#cmakedefine HAVE_NET_IF_MEDIA_H
#cmakedefine HAVE_GETIFADDRS
#cmakedefine HAVE_FREEIFADDRS
")

configure_file("${SOURCE_DIR}/src/platform.h.in" "${SOURCE_DIR}/src/platform.h")

#The MSVC C compiler is too out of date,
#so the sources have to be compiled as c++
if (MSVC)
    enable_language(CXX)
    file(GLOB sources "${SOURCE_DIR}/src/*.c")
    set_source_files_properties(
        ${sources}
        PROPERTIES LANGUAGE CXX
    )
    set(MORE_LIBRARIES ws2_32 Rpcrt4 Iphlpapi)
endif()

# required libraries for mingw
if (MINGW)
    set(MORE_LIBRARIES -lws2_32 -lrpcrt4 -liphlpapi)
endif()

# required libraries for cygwin
if (CYGWIN)
    set(MORE_LIBRARIES -luuid)
endif()

list(APPEND CMAKE_MODULE_PATH "${SOURCE_DIR}")
set(OPTIONAL_LIBRARIES)

########################################################################
# LIBZMQ dependency
########################################################################
find_package(libzmq REQUIRED)
IF (LIBZMQ_FOUND)
    include_directories(${LIBZMQ_INCLUDE_DIRS})
    list(APPEND MORE_LIBRARIES ${LIBZMQ_LIBRARIES})
ELSE (LIBZMQ_FOUND)
    message( FATAL_ERROR "libzmq not found." )
ENDIF (LIBZMQ_FOUND)

########################################################################
# SYSTEMD dependency
########################################################################
find_package(systemd)
IF (SYSTEMD_FOUND)
    include_directories(${SYSTEMD_INCLUDE_DIRS})
    list(APPEND MORE_LIBRARIES ${SYSTEMD_LIBRARIES})
    add_definitions(-DHAVE_LIBSYSTEMD)
    list(APPEND OPTIONAL_LIBRARIES ${SYSTEMD_LIBRARIES})
ENDIF (SYSTEMD_FOUND)

########################################################################
# includes
########################################################################
set (czmq_headers
    include/czmq_library.h
    include/czmq_prelude.h
    include/czmq.h
    include/zactor.h
    include/zarmour.h
    include/zcert.h
    include/zcertstore.h
    include/zchunk.h
    include/zclock.h
    include/zconfig.h
    include/zdigest.h
    include/zdir.h
    include/zdir_patch.h
    include/zfile.h
    include/zframe.h
    include/zhash.h
    include/zhashx.h
    include/ziflist.h
    include/zlist.h
    include/zlistx.h
    include/zloop.h
    include/zmsg.h
    include/zpoller.h
    include/zsock.h
    include/zstr.h
    include/zuuid.h
    include/zauth.h
    include/zbeacon.h
    include/zgossip.h
    include/zmonitor.h
    include/zproxy.h
    include/zrex.h
    include/zsys.h
    include/zauth_v2.h
    include/zbeacon_v2.h
    include/zctx.h
    include/zmonitor_v2.h
    include/zmutex.h
    include/zproxy_v2.h
    include/zsocket.h
    include/zsockopt.h
    include/zthread.h
    src/zgossip_msg.h
    src/zsock_option.inc
    src/zgossip_engine.inc
    src/zhash_primes.inc
    src/foreign/sha1/sha1.inc_c
    src/foreign/sha1/sha1.h
    src/foreign/slre/slre.inc_c
    src/foreign/slre/slre.h
    src/foreign/slre/readme.txt
)

IF (ENABLE_DRAFTS)
    list(APPEND czmq_headers
        include/zproc.h
        include/ztrie.h
    )
ENDIF (ENABLE_DRAFTS)

source_group ("Header Files" FILES ${czmq_headers})
install(FILES ${czmq_headers} DESTINATION include)

########################################################################
# library
########################################################################
include_directories("${SOURCE_DIR}/src" "${SOURCE_DIR}/include")
set (czmq_sources
    src/zactor.c
    src/zarmour.c
    src/zcert.c
    src/zcertstore.c
    src/zchunk.c
    src/zclock.c
    src/zconfig.c
    src/zdigest.c
    src/zdir.c
    src/zdir_patch.c
    src/zfile.c
    src/zframe.c
    src/zhash.c
    src/zhashx.c
    src/ziflist.c
    src/zlist.c
    src/zlistx.c
    src/zloop.c
    src/zmsg.c
    src/zpoller.c
    src/zsock.c
    src/zstr.c
    src/zuuid.c
    src/zauth.c
    src/zbeacon.c
    src/zgossip.c
    src/zmonitor.c
    src/zproxy.c
    src/zrex.c
    src/zsys.c
    src/zgossip_msg.c
    src/zauth_v2.c
    src/zbeacon_v2.c
    src/zctx.c
    src/zmonitor_v2.c
    src/zmutex.c
    src/zproxy_v2.c
    src/zsocket.c
    src/zsockopt.c
    src/zthread.c
)

IF (ENABLE_DRAFTS)
    list (APPEND czmq_sources
        src/zproc.c
        src/ztrie.c
    )
ENDIF (ENABLE_DRAFTS)

source_group("Source Files" FILES ${czmq_sources})
if (NOT DEFINED BUILD_SHARED_LIBS)
    SET(BUILD_SHARED_LIBS ON)
endif()
add_library(czmq ${czmq_sources})
set_target_properties(czmq
    PROPERTIES DEFINE_SYMBOL "LIBCZMQ_EXPORTS"
)
set_target_properties(czmq
    PROPERTIES LIBRARY_OUTPUT_DIRECTORY "${SOURCE_DIR}/src"
)
target_link_libraries(czmq
    ${ZEROMQ_LIBRARIES} ${MORE_LIBRARIES}
)

install(TARGETS czmq
    LIBRARY DESTINATION "lib${LIB_SUFFIX}" # .so file
    ARCHIVE DESTINATION "lib${LIB_SUFFIX}" # .lib file
    RUNTIME DESTINATION bin              # .dll file
)

include(${CMAKE_CURRENT_SOURCE_DIR}/src/CMakeLists-local.txt) # Optional project-local hook

########################################################################
# pkgconfig
########################################################################
set (VERSION "3.0.3")
set (prefix "${CMAKE_INSTALL_PREFIX}")
set (exec_prefix "\${prefix}")
set (libdir "\${prefix}/lib${LIB_SUFFIX}")
set (includedir "\${prefix}/include")
IF (ENABLE_DRAFTS)
    set (pkg_config_defines "-DCZMQ_BUILD_DRAFT_API=1")
ELSE (ENABLE_DRAFTS)
    set (pkg_config_defines "")
ENDIF (ENABLE_DRAFTS)
configure_file(
    "${SOURCE_DIR}/src/libczmq.pc.in"
    "${SOURCE_DIR}/src/libczmq.pc"
@ONLY)

install(
    FILES "${SOURCE_DIR}/src/libczmq.pc"
    DESTINATION "lib${LIB_SUFFIX}/pkgconfig"
)

########################################################################
# executables
########################################################################
add_executable(
    zmakecert
    "${SOURCE_DIR}/src/zmakecert.c"
)
target_link_libraries(
    zmakecert
    czmq
    ${LIBZMQ_LIBRARIES}
    ${OPTIONAL_LIBRARIES}
)
set_target_properties(
    zmakecert
    PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${SOURCE_DIR}/src"
)
add_executable(
    czmq_selftest
    "${SOURCE_DIR}/src/czmq_selftest.c"
)
target_link_libraries(
    czmq_selftest
    czmq
    ${LIBZMQ_LIBRARIES}
    ${OPTIONAL_LIBRARIES}
)
set_target_properties(
    czmq_selftest
    PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${SOURCE_DIR}/src"
)

########################################################################
# tests
########################################################################
set(CLASSTEST_TIMEOUT 5 CACHE STRING "Timeout of the selftest of a class")
set(TOTAL_TIMEOUT 20 CACHE STRING "Timout of the total testsuite")

set(TEST_CLASSES
    zactor
    zarmour
    zcert
    zcertstore
    zchunk
    zclock
    zconfig
    zdigest
    zdir
    zdir_patch
    zfile
    zframe
    zhash
    zhashx
    ziflist
    zlist
    zlistx
    zloop
    zmsg
    zpoller
    zsock
    zstr
    zuuid
    zauth
    zbeacon
    zgossip
    zmonitor
    zproxy
    zrex
    zsys
    zgossip_msg
    zauth_v2
    zbeacon_v2
    zctx
    zmonitor_v2
    zmutex
    zproxy_v2
    zsocket
    zsockopt
    zthread
)

IF (ENABLE_DRAFTS)
    list (APPEND TEST_CLASSES
    zproc
    ztrie
    )
ENDIF (ENABLE_DRAFTS)

foreach(TEST_CLASS ${TEST_CLASSES})
    add_test(
        NAME ${TEST_CLASS}
        COMMAND czmq_selftest --continue --verbose --test ${TEST_CLASS}
    )
    set_tests_properties(
        ${TEST_CLASS}
        PROPERTIES TIMEOUT ${CLASSTEST_TIMEOUT}
    )
endforeach(TEST_CLASS)


########################################################################
# summary
########################################################################
message (STATUS "*** Version number: ${VERSION}")
message (STATUS "*** Install target: ${CMAKE_INSTALL_PREFIX}")

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################
