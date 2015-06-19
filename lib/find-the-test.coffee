FindTheTestView = require './find-the-test-view'
{CompositeDisposable} = require 'atom'

module.exports = FindTheTest =
  findTheTestView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @findTheTestView = new FindTheTestView(state.findTheTestViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @findTheTestView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'find-the-test:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @findTheTestView.destroy()

  serialize: ->
    findTheTestViewState: @findTheTestView.serialize()

  toggle: ->
    console.log 'FindTheTest was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
