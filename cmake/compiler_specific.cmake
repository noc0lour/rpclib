# Compiler-specific options

cmake_policy(SET CMP0054 OLD) # silence quoted variables warning

if (${CMAKE_CXX_COMPILER_ID} MATCHES "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Wno-unused-local-typedef -std=c++14")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Wno-unused-local-typedef -std=c++14")
    if(coverage)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g --coverage -O0")
    endif()
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "Intel")
  # using Intel C++
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
    add_definitions(-DWIN32_LEAN_AND_MEAN -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_GNU_SOURCE)

    add_definitions(
        -DASIO_HAS_STD_ADDRESSOF
        -DASIO_HAS_STD_ARRAY    
        -DASIO_HAS_CSTDINT
        -DASIO_HAS_STD_SHARED_PTR
        -DASIO_HAS_STD_TYPE_TRAITS
    )

	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Zi")
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} /DEBUG")
	STRING(REPLACE "/O2" "/Od" CMAKE_CXX_FLAGS_DEBUG ${CMAKE_CXX_FLAGS_DEBUG})
endif()

if (WIN32)
    add_definitions(-DCALLME_WIN32)
elseif (LINUX)
    add_definitions(-DCALLME_LINUX)
elseif (APPLE)
    add_definitions(-DCALLME_MAC)
endif()
