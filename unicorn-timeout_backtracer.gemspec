# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unicorn/timeout_backtracer/version'

Gem::Specification.new do |spec|
  spec.name          = "unicorn-timeout_backtracer"
  spec.version       = Unicorn::TimeoutBacktracer::VERSION
  spec.authors       = ["haruyama-makoto"]
  spec.email         = ["makoto.haruyama@dena.com"]

  spec.required_rubygems_version = ">= 2.0"

  spec.summary       = %q{Save log when Unicorn timeout}
  spec.description   = %q{Save log when Unicorn timeout}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency 'gdbruby'
  spec.add_dependency 'unicorn'
end
