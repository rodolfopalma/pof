# Modules and configuration. Boring stuff.
request = require('request').defaults {jar: true}
cheerio = require 'cheerio'

config 	= require '../config' 

request 'http://sigeb.cbs.cl/default.aspx', (error, res, body) ->
	# Cheering up the HTML
	$ = cheerio.load body

	# Getting the annoying ASPX variables
	viewState = $('#__VIEWSTATE').val()
	eventValidation = $('#__EVENTVALIDATION').val()
	txtRut = config.sigeb.user
	txtContrasena = config.sigeb.password

	# Posting it up, babe
	request.post {
		'url': 'http://sigeb.cbs.cl/default.aspx?ReturnUrl=%2f', 
		'form': {
			'__VIEWSTATE': viewState,
			'__EVENTVALIDATION': eventValidation,
			'txtRut': txtRut,
			'txtContrasena': txtContrasena,
			'numeroPerfil': 0,
			'btnIngresar': 'Ingresar'
		}
	}, (error, res, body) ->
		request 'http://sigeb.cbs.cl/sistema/pof/listado.aspx', (error, res, body) ->
			# Cheering up the reports
			$ = cheerio.load body

			$('.tablaListado tr').each (index, el) ->
				console.log $(this).find('.iz').text()

				#TO DO: KEEP GOING!!