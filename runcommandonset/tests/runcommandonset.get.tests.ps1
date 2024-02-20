# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

Describe 'tests for runcommandonset get' {
    BeforeAll {
        $oldPath = $env:DSC_RESOURCE_PATH
        $env:DSC_RESOURCE_PATH = Join-Path $PSScriptRoot ".."
    }

    AfterAll {
        $env:DSC_RESOURCE_PATH = $oldPath
    }

    It 'Input can be sent to the resource via stdin json' {
        $json = @"
        {
            "executable": "foo",
            "arguments": ["bar", "baz"],
            "exit_code": 5,
        }
"@

        $result = $json | dsc resource get -r Microsoft/RunCommandOnSet | ConvertFrom-Json
        $result.actualState.arguments | Should -BeExactly @('bar', 'baz')
        $result.actualState.executable | Should -BeExactly 'foo'
        $result.actualState.exit_code | Should -BeExactly 5
    }

    It 'Input can be sent to the resource via stdin yaml' {
        $yaml = @"
executable: foo
arguments:
- bar
- baz
exit_code: 5
"@

        $result = $yaml | dsc resource get -r Microsoft/RunCommandOnSet | ConvertFrom-Json
        $result.actualState.arguments | Should -BeExactly @('bar', 'baz')
        $result.actualState.executable | Should -BeExactly 'foo'
        $result.actualState.exit_code | Should -BeExactly 5
    }
}
