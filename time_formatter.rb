class TimeFormatter
  TIME_DIRECTIVES = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze
  
  def initialize(request)
    @path = request.path
    @format = request.params['format']
  end

  def processed_format
    format_string = @format.split(',').map do |directive|
      TIME_DIRECTIVES[directive]
    end
    
    Time.now.strftime(format_string.join('-'))
  end

  def unknown_formats
    @format.split(',') - TIME_DIRECTIVES.keys
  end

  def bad_path?
    @path != '/time'
  end

  def bad_params?
    unknown_formats.any?
  end
end
