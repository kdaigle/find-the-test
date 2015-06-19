FindTheTestView = require './find-the-test-view'
{CompositeDisposable} = require 'atom'

module.exports = FindTheTest =
  findTheTestView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @findTheTestView = new FindTheTestView(state.findTheTestViewState)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'find-the-test:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()
    @findTheTestView.destroy()

  serialize: ->
    findTheTestViewState: @findTheTestView.serialize()

  toggle: ->
    console.log 'FindTheTest was toggled!'

    # Get the path of the current file
    pane = atom.workspace.getActivePane()
    console.log pane.activeItem.buffer.file.path

    # Get the paths for the current directory
    console.log atom.project.getPaths()
