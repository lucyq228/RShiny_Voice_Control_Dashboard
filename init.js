var initVoice = function() {
if (annyang) {
  var bigger = 1;
  Shiny.onInputChange('title', 'change title');
  Shiny.onInputChange('color', 'black');
  Shiny.onInputChange('information', 0);
  Shiny.onInputChange('yes', 'no');
  Shiny.onInputChange('category', 'everything');
  var commands = {
    'title *title': function(title) {
      Shiny.onInputChange('title', title);
    },
	 'horizontal *horizontal': function(horizontal) {
      Shiny.onInputChange('horizontal', horizontal);
    },
	'vertical *vertical': function(vertical) {
      Shiny.onInputChange('vertical', vertical);
    },
	'category *category': function(category) {
      Shiny.onInputChange('category', category);
    },
    'color :color': function(color) {
      Shiny.onInputChange('color', color);
    },

    'regression': function() {
      Shiny.onInputChange('yes', Math.random());
    }
  };
  annyang.addCommands(commands);
  annyang.start();
  }
};

$(function() {
  setTimeout(initVoice, 10);
});