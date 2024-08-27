require_relative 'format_time'

class App
  def call(env)
    @request = Rack::Request.new(env)
    @format_time = FormatTime.new(@request.params)

    [status, headers, body]
  end

  private

  def status
    return 404 unless path_valid?

    return 404 unless format_exist?

    return 400 unless @format_time.params_valid?

    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    return ["404\n"] unless path_valid?

    return ["404\n"] unless format_exist?

    @format_time.time
  end

  def path_valid?
    return true if @request.path == '/time'

    false
  end

  def format_exist?
    return true if @request.params.include?('format')

    false
  end
end
