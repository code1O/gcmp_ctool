# &#128736; `GCMP_CTOOL`

`GCMP_CTOOL` is a proyect written for Linux system to compile C or Assembly files with gcc in a smarter way.

One prompt, one result, no worries.

# How to use `GCMP_CTOOL`

* ## Move the file from the dir were had've been download to the dir `/home/$USER/`

    <pre>
    user@root:~/Desktop/Download$ move gcmp.sh /home/$USER/cmp.sh
    user@root:~/Desktop/Download$
    </pre>

* ## Type the help prompt `gcmp -h`

    <pre>
    user@root:~$ gcmp -h
    
    NOTE: This will generate the same name for output if __flag_asm == 0
    Example with __flag_asm == 0: gcc file.c -o file
    Example with __flag_asm == 1; gcc -S file.c -o file_Asm

    ===============================================================================
                            GCC COMPILER FLAGS
    ===============================================================================
    Type -sNL  for compile C with gcc flag: &apos;-static -nostdlib&apos;
    Type -asNL for compile Assembly with gcc flag: &apos;-S -static -nostdlib&apos;
    Type -aS for compile Assembly with gcc flag: &apos;-S -static&apos;
    Type -a for compile Assembly with gcc flag: &apos;-S&apos;
    Type -b for default gcc compiling
    Type -s for compile C with gcc flag: &apos;-static&apos;
    ===============================================================================

    user@root:~$
    </pre>

* Compile your code
    <pre>
    user@root:~/Desktop/project$ gcmp -asNL nvidia_microchip_x8632.nasm
    user@root:~/Desktop/project$ gcmp -sNL cnasm_attble_driver.c
    user@root:~/Desktop/project$ gcmp -b physics_simulator.c
    </pre>

> [!NOTE]
> In case you compile the C code into assembly,
> you will get instantely a previous view of the generated assembly file.
>
> If you online compile the C code, you will get the output generated in the terminal


---

# &#x1F4BE; Download

<a href="https://github.com/code1O/gcmp_ctool/blob/main/cmp.sh" download>gcmp.sh</a>

