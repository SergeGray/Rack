class App
  HEADERS = { 'Content-Type' => 'text/plain' }.freeze

  def call(env)
    @request = Rack::Request.new(env)
    @formatter = TimeFormatter.new(@request)
    parse_request
  end

  private

  def parse_request
    if @formatter.bad_path?
      [404, HEADERS, ['Invalid URL']]
    elsif @formatter.bad_params?
      [
        400,
        HEADERS,
        ["Unknown time format #{@formatter.unknown_formats.inspect}"]
      ]
    else
      [200, HEADERS, [@formatter.processed_format]]
    end
  end
end
