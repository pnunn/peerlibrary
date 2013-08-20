Meteor.Router.add
  '/': ->
    Session.set 'indexActive', true
    'index'

  '/login':
    'login'

  '/logout': ->
    Meteor.logout()
    # TODO: Redirect back to the page where it came from (or support logout without having to go to /logout)
    Meteor.Router.to '/'

  '/register':
    'register'

  '/p/:publicationId/:publicationSlug?':
    as: 'publication'
    to: (publicationId, publicationSlug) ->
      Session.set 'currentPublicationId', publicationId
      Session.set 'currentPublicationSlug', publicationSlug
      'publication'

  '/u/:username': (username) ->
    Session.set 'currentProfileUsername', username
    'profile'

  '/admin': ->
    Session.set 'adminActive', true
    'admin'

  '*':
    'notfound'

Meteor.Router.beforeRouting = ->
  Session.set 'indexActive', false
  Session.set 'indexHeader', $(window).scrollTop() < $(window).height()
  Session.set 'currentSearchQuery', null
  Session.set 'currentSearchLimit', 5
  Session.set 'searchActive', false
  Session.set 'searchFocused', false
  Session.set 'adminActive', false
  Session.set 'currentPublicationId', null
  Session.set 'currentProfileUsername', null

# TODO: Use real parser (arguments can be listed multiple times, arguments can be delimited by ";")
parseQuery = (qs) ->
  query = {}
  for pair in qs.replace('?', '').split '&'
    [k, v] = pair.split('=')
    query[k] = v
  query