#!/usr/bin/env bash
set -euo pipefail

# Smart compile with gcc

echo "NOTE: This will generate the same name for output if __flag_asm == 0"
echo "Example with __flag_asm == 0: gcc file.c -o file"
echo "Example with __flag_asm == 1; gcc -S file.c -o file_Asm"

__flag_stdlib=-1;    __flag_static=0;    __flag_asm=0

if [ "$#" -ne "3" ]; then
    __source=""
else
    __source="$2"
fi

__output="${__source%.*}";
__output_asm="${__source%.*}_Asm.s"

# -sNL (gcc -static -nostdlib)
# -asNL (gcc -S -static -nostdlib)
# -aS (gcc -S -static)
# -a (gcc -S)
# -a (gcc)

__help_compilerFlags="
===============================================================================
                        GCC COMPILER FLAGS
===============================================================================
Type "-sNL"  for compile C with gcc flag: '-static -nostdlib'
Type "-asNL" for compile Assembly with gcc flag: '-S -static -nostdlib'
Type "-aS" for compile Assembly with gcc flag: '-S -static'
Type "-a" for compile Assembly with gcc flag: '-S'
Type "-b" for default gcc compiling
Type "-s" for compile C with gcc flag: '-static'
==============================================================================="

__compiler_flags=("-sNL" "-s" "-asNL" "-aS" "-a" "-h" "-b")
__read_input_flag="$1"

case "$__read_input_flag" in
    "${__compiler_flags[0]}")
    __flag_static=1
    __flag_stdlib=0
    ;;
    "${__compiler_flags[1]}")
    __flag_static=1
    ;;
    "${__compiler_flags[2]}")
    __flag_asm=1
    __flag_static=1
    __flag_stdlib=0
    ;;
    "${__compiler_flags[3]}")
    __flag_asm=1
    __flag_static=1
    ;;
    "${__compiler_flags[4]}")
    __flag_asm=1
    ;;
    "${__compiler_flags[5]}")
    echo "$__help_compilerFlags"
    exit 0 # In case that given char **argv[2] and not char **argv[3]
    ;;
    "${__compiler_flags[6]}")
    __flag_stdlib=1
    ;;
    *)
    exit 0
    ;;
esac


if [ "$__flag_stdlib" -eq 1 ] && [ "$__flag_static" -eq 0 ]; then
    __contradict_flags=1

else
    __contradict_flags=0

fi

if [ "$__flag_stdlib" -eq 0 ] && [ "$__flag_static" -eq 1 ]; then
    __no_contradict_flags=1

else
    __no_contradict_flags=0

fi


__mode="bin"
__executable="./$__output"
__asm_converted="./$__output_asm"

if  [ "$__contradict_flags" -eq 1 ] && [ "$__flag_asm" -eq 0 ]; then
    __gcc_cmd_params="$__source -o $__output"

elif [ "$__contradict_flags" -eq 1 ] && [ "$__flag_asm" -eq 1 ]; then
    __gcc_cmd_params="-S $__source -o $__output_asm"
    __mode="asm"

elif [ "$__no_contradict_flags" -eq 1 ] && [ "$__flag_asm" -eq 1 ]; then
    __gcc_cmd_params="-S -static -nostdlib $__source -o $__output_asm"
    __mode="asm"

else
    __gcc_cmd_params="-static -nostdlib $__source -o $__output"

fi

echo "gcc $__gcc_cmd_params"
gcc $__gcc_cmd_params

if [ "$__mode" = "asm" ]; then
    echo "FILE: $__asm_converted"
    echo "==============================================="
    cat "$__asm_converted"
    echo "==============================================="

elif [ -f "$__executable" ] && [ -x "$__executable" ]; then

    echo "Executing $__output"
    "$__executable"

else
    echo "There's no binary for $__output"

fi
