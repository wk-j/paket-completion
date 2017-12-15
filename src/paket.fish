function __fish_paket_needs_command
    set cmd (commandline -opc)

    if [ (count $cmd) -eq 1 ]
        return 0
    end

    return 1
end

function __fish_paket_using_command
    set cmd (commandline -opc)

    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end

    return 1
end

function __projs
    find . -name '*.fsproj'  | grep "proj" | sed 's/\.\///g'
    find . -name '*.csproj'  | grep "proj" | sed 's/\.\///g'
end

function __packages 
    grep nuget paket.dependencies | grep "^nuget" | sed  "s/nuget //g"
end

complete -fc paket -n '__fish_paket_needs_command' -a add   -d 'Add new dependency'
complete -fc paket -n '__fish_paket_needs_command' -a install   -d 'Compute dependencies graph, odwnload dependencies and update projects'
complete -fc paket -n '__fish_paket_needs_command' -a remove   -d 'Remove a dependency'
complete -fc paket -n '__fish_paket_needs_command' -a init   -d 'Create an empty paket.dependencies file in the current working directory'
complete -fc paket -n '__fish_paket_needs_command' -a clear-cache   -d 'Clear the NuGet and git cache directories'

complete -fc paket -n '__fish_paket_using_command add' -xa '(__packages)'
complete -fc paket -n '__fish_paket_using_command add' -l project -xa '(__projs)'

complete -fc paket -n '__fish_paket_using_command remove' -xa '(__packages)'
complete -fc paket -n '__fish_paket_using_command remove' -l project -xa '(__projs)'


