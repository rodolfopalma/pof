module.exports = (grunt) ->
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-concurrent'
	grunt.loadNpmTasks 'grunt-nodemon'

	grunt.initConfig
		concurrent:
			dev: ['watch', 'nodemon:dev'],
			options: {
				logConcurrentOutput: true
			}

		watch:
			coffeePrivate:
				files: 'src/private/*.coffee'
				tasks: ['coffee:private']

		coffee:				
			private:
				expand: true
				flatten: true
				src: '<%= watch.coffeePrivate.files %>'
				dest: 'private'
				ext: '.js'

		nodemon:
			dev:
				script: 'private/main.js'

	grunt.registerTask('default', [
		'coffee:private',
		'concurrent:dev'])

	grunt.registerTask('build', ['coffee:private'])
