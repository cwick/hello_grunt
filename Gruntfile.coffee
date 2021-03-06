module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    coffeelint:
      lint: ["src/**/*.coffee"]
      options:
        max_line_length:
          value: 110

    requirejs:
      optimize:
        options:
          baseUrl: "src"
          name: "../lib/almond"
          include: ["cs!impl/FizzBuzz"]
          exclude: ["coffee-script", "cs"]
          out: "build/FizzBuzz.js"
          wrap:
            startFile: "src/intro.js"
            endFile: "src/outro.js"

          paths:
            cs: "../lib/cs"
            "coffee-script": "../lib/coffee-script"
          # Uncomment to debug compiled file
          # optimize: "none"

          # Strip "cs!" from module names
          onBuildWrite: (moduleName, path, contents) ->
            contents.replace(/define\('cs!/g, "define('")
                    .replace(/'cs!/g, "'")
                    .replace(/require\("cs!/g, "require(\"")

    yuidoc:
      compile:
        name: "<%= pkg.name %>"
        description: "<%= pkg.description %>"
        version: "<%= pkg.version %>"
        url: "<%= pkg.homepage %>"
        options:
          paths: "src"
          outdir: "doc"
          syntaxtype: "coffee"
          extension: ".coffee"

    connect:
      server:
        options: {}

  grunt.loadNpmTasks "grunt-contrib-yuidoc"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-requirejs"
  grunt.loadNpmTasks "grunt-contrib-connect"

  grunt.registerTask "default", ["coffeelint", "requirejs", "yuidoc"]
  grunt.registerTask "server", ["connect:server:keepalive"]

