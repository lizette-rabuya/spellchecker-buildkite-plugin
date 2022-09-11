# Spellchecker Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) that runs a spelling check on specific files using the [tmaier/markdown-spellcheck](https://hub.docker.com/r/tmaier/markdown-spellcheck/) docker image.

## Example

This plugin runs a spelling check within a build.

```yml
steps:
  - plugins:
      - spellchecker#v1.2.3:
        pattern: value
```

## Configuration

### Required

### `pattern` (string)

The file or file pattern to run spelling check on.

### `version` (string)

Version of docker image to use.

Default: `latest`

## License

MIT (see [LICENSE](LICENSE))
