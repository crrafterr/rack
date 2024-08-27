class FormatTime
  VALID_FORMAT = { 'year' => '%Y', 'month' => '%m',
                   'day' => '%d', 'hour' => '%H',
                   'minute' => '%m', 'second' => '%S' }.freeze

  def initialize(params)
    @params = params
  end

  def time
    return [invalid_params] unless params_valid?

    ["#{time_format} \n"]
  end

  def params_valid?
    return false unless (format_params - VALID_FORMAT.keys).empty?

    true
  end

  private

  def invalid_params
    invalid_params = format_params - VALID_FORMAT.keys

    "Unknown time format #{invalid_params} \n"
  end

  def time_format
    time_format = []
    format_params.each { |p| time_format << VALID_FORMAT[p] }

    Time.now.strftime(time_format.join('-'))
  end

  def format_params
    @params['format'].split(',')
  end
end
