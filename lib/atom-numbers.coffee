AtomNumbersView = require './atom-numbers-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomNumbers =
  atomNumbersView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomNumbersView = new AtomNumbersView(state.atomNumbersViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomNumbersView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-numbers:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomNumbersView.destroy()

  serialize: ->
    atomNumbersViewState: @atomNumbersView.serialize()

  toggle: ->
    console.log 'AtomNumbers was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
