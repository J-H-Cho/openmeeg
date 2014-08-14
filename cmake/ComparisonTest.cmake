include(UnitTest)

macro(SET_FILE_PROPERTIES PROPERTY)
    foreach(arg ${ARGN})
        string(REGEX REPLACE "^([^ ]+) .+$" "\\1" VAR_NAME ${arg})
        string(REGEX REPLACE "^[^ ]+ +(.+)$" "\\1" VALUE ${arg})
        string(REGEX REPLACE ":" ";" VALUE ${VALUE})
        set(${PROPERTY}_${VAR_NAME} "${VALUE}")
    endforeach()
endmacro()

function(OPENMEEG_COMPARISON_TEST TEST_NAME FILENAME REFERENCE_FILENAME)
    set(COMPARISON_COMMAND compare_matrix)
    if (NOT IS_ABSOLUTE ${FILENAME})
        set(FILENAME ${OpenMEEG_BINARY_DIR}/tests/${FILENAME})
    endif()
    if (NOT IS_ABSOLUTE ${REFERENCE_FILENAME})
        set(REFERENCE_FILENAME ${OpenMEEG_SOURCE_DIR}/tests/${REFERENCE_FILENAME})
    endif()

    OPENMEEG_TEST("cmp-${TEST_NAME}" 
             ${COMPARISON_COMMAND} ${FILENAME} ${REFERENCE_FILENAME} ${ARGN} DEPENDS ${TEST_NAME})
endfunction()
