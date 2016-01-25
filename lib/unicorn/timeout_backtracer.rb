require "unicorn/timeout_backtracer/version"

require 'open3'
require 'rubygems/installer'
require 'unicorn'

class Unicorn::HttpServer
  alias_method :unlogged_kill_worker, :kill_worker
  def kill_worker(signal, wpid)
    bin_dir = Gem::Installer.new('gdbruby').bin_dir
    gdbruby_bin = "#{bin_dir}/gdbruby.rb"
    path = ENV['UNICORN_TIMEOUT_LOG_PATH'] || "/tmp/unicorn-timeout-backtrace-#{Process.pid}.log"
    if ENV['ENABLE_UNICORN_TIMEOUT_LOG'].to_i.nonzero? && FileTest.executable?(gdbruby_bin)
      if signal == :KILL
        begin
          pid = fork do
            log_file = File.open(path, "a")
            IO.popen("#{gdbruby_bin} #{wpid}", "r+") do |io|
              while line = io.gets
                log_file.puts line
              end
            end
          end
          Process.waitpid(pid)
        rescue => e
          p e
        end
      end
    end
    unlogged_kill_worker(signal, wpid)
  end
end
