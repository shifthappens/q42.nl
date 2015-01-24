mousePressed = false
lastX = undefined
lastY = undefined
ctx = undefined

Draw = (x, y, isDown) ->
  if isDown
    ctx.beginPath()
    ctx.strokeStyle = "black"
    ctx.lineWidth = 5
    ctx.lineJoin = "round"
    ctx.moveTo lastX, lastY
    ctx.lineTo x, y
    ctx.closePath()
    ctx.stroke()
  lastX = x
  lastY = y
  return

clearArea = ->
  
  # Use the identity matrix while clearing the canvas
  ctx.setTransform 1, 0, 0, 1, 0, 0
  ctx.clearRect 0, 0, ctx.canvas.width, ctx.canvas.height
  return

initSketch = ->
  $('#sketchpad').attr({ height: $('body').height(), width: $('body').width() })
  
  ctx = document.getElementById("sketchpad").getContext("2d")
  $("#sketchpad").mousedown (e) ->
    mousePressed = true
    Draw e.pageX - $(this).offset().left, e.pageY - $(this).offset().top, false
    return

  $("#sketchpad").mousemove (e) ->
    Draw e.pageX - $(this).offset().left, e.pageY - $(this).offset().top, true  if mousePressed
    return

  $("#sketchpad").mouseup (e) ->
    mousePressed = false
    return

  $("#sketchpad").mouseleave (e) ->
    mousePressed = false
    return

  return


Meteor.startup ->
  Session.setDefault("sketchLoaded", no)

Template.sketchCanvas.rendered = initSketch