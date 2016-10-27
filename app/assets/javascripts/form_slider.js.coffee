$.fn.applyGradient = (position) -> 
  position = parseInt(position) - 1
  gradientStyle = ""
  browserVariations = ["-moz-linear-gradient", "linear-gradient", "-o-linear-gradient", "-webkit-linear-gradient", "-ms-linear-gradient"]
  for browser in browserVariations 
    gradientStyle += 'background-image: '+browser+'(left, '+@.data('color')+' '+position+'px, white 0%);'
  @.attr('style', gradientStyle)

window.sliderInput =
  load: -> 
    self = @
    sliders = $('.form-slider')
    console.log("load")
    sliders.each ->
      currentSlider = $(@)
      currentSliderContainer = currentSlider.parents('.slider-container')
      inputField = currentSliderContainer.find('input')
      sliderValue = self.findDisplayValue(currentSlider, currentSliderContainer)
      currentSlider.slider
        min: currentSlider.data('min'),
        max: currentSlider.data('max'),
        step: currentSlider.data('step'),
        disabled: currentSlider.data('disabled'),
        labels: currentSlider.data('option_labels'),
        colorGradient: currentSlider.data('color_gradient')
        value: inputField.attr('value'),
        create: ->
          console.log("create")
          console.log(currentSlider)
          currentSliderContainer.find('label').append(currentSlider.data('append'))
          sliderValue.text(inputField.attr('value'))
          currentSlider.applyGradient(currentSlider.find('.ui-slider-handle').css('left'))

          labels_count = currentSlider.data('max') - currentSlider.data('min')
          labels = currentSlider.data('option_labels')
          console.log(labels)

          if labels
            i = 0

            while i <= labels_count
              label_val = labels[i]
              el = $('<label>' + label_val + '</label>').css('left', i / labels_count * 100 + '%')
              console.log(el)
              currentSlider.append el
              i++
          inputField.hide()
        change: ( event, ui ) ->
          inputField.val(ui.value).parents('.slider-container')
          sliderValue.text(ui.value)
          currentSlider.applyGradient(currentSlider.find('.ui-slider-handle').css('left'))
        slide: ( event, ui ) ->
          inputField.val(ui.value).parents('.slider-container')
          sliderValue.text(ui.value)


  findDisplayValue: (currentSlider, currentSliderContainer)->
    if currentSlider.data('value-display')
      $( currentSlider.data('value-display') )
    else
      currentSliderContainer.find('.val')


$(document).ready ->
  $(document).on "page:load", ->
    sliderInput.load()
  $(document).on "page:festch", ->
    sliderInput.load()
  sliderInput.load()
