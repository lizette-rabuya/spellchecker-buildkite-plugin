#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

#export DOCKER_STUB_DEBUG=/dev/tty

@test "Spelling check a single file with no misspelled words" {
  export BUILDKITE_PLUGIN_SPELLCHECKER_PATTERN="tests/testdata/TESTREADME.md"

  stub docker "run --rm -v $PWD:/mnt --workdir /mnt tmaier/markdown-spellcheck:latest --report tests/testdata/TESTREADME.md : echo 1 file is free from spelling errors"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "Running a spelling check report on files with pattern tests/testdata/TESTREADME.md"
  assert_output --partial "1 file is free from spelling errors" 

  unstub docker
}

@test "Spelling check a single file for misspelled words" {
  export BUILDKITE_PLUGIN_SPELLCHECKER_PATTERN="tests/testdata/MISSPELLEDREADME.md"

  stub docker "run --rm -v $PWD:/mnt --workdir /mnt tmaier/markdown-spellcheck:latest --report tests/testdata/MISSPELLEDREADME.md : echo 5 spelling errors found in 1 file"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "Running a spelling check report on files with pattern tests/testdata/MISSPELLEDREADME.md"
  assert_output --partial "5 spelling errors found in 1 file" 

  unstub docker
}

@test "Spelling check multiple files for misspelled words" {
  export BUILDKITE_PLUGIN_SPELLCHECKER_PATTERN="tests/testdata/*.md"

  stub docker "run --rm -v $PWD:/mnt --workdir /mnt tmaier/markdown-spellcheck:latest --report tests/testdata/*.md : echo 5 spelling errors found in 2 files"

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "Running a spelling check report on files with pattern tests/testdata/*.md"
  assert_output --partial "5 spelling errors found in 2 files" 

  unstub docker
}