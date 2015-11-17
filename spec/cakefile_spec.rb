require 'spec_helper'

module Xcake
  describe Cakefile do

    it "should have a default project name" do
      cakefile = Cakefile.new

      expect(cakefile.project_name).to eq("Project")
    end

    it "should set project name" do
      cakefile = Cakefile.new("Test")

      expect(cakefile.project_name).to eq("Test")
    end

    it "should initialize targets" do
      cakefile = Cakefile.new

      expect(cakefile.targets).not_to be(nil)
    end

    it "should store targets when created" do
      cakefile = Cakefile.new do |c|
        c.target
      end

      expect(cakefile.targets.count).to eq(1)
    end

    context "when creating application" do
      before :each do
        @cakefile = Cakefile.new do |c|
          @target = c.application_for :ios, 8.0
        end
      end

      it "should store targets when created" do
        expect(@cakefile.targets.count).to eq(1)
      end

      it "should set type to application" do
        expect(@target.type).to eq(:application)
      end

      it "should set platform" do
        expect(@target.platform).to eq(:ios)
      end

      it "should set deployment target" do
        expect(@target.deployment_target).to eq(8.0)
      end

      it "should default to objective c" do
        expect(@target.language).to eq(:objc)
      end

      context "when specifying language" do

        before :each do
          @cakefile = Cakefile.new do |c|
            @target = c.application_for :ios, 8.0, :swift
          end
        end

        it "should set lanuggae" do
          expect(@target.language).to eq(:swift)
        end
      end
    end

    it "should have the correct default settings" do
      @cakefile = Cakefile.new

      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])

      expect(@cakefile.default_settings).to eq(settings)
    end

    it "should have the correct default debug settings" do
      @cakefile = Cakefile.new

      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])
      settings = settings.merge!(Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:debug]))

      expect(@cakefile.default_debug_settings).to eq(settings)
    end

    it "should have the correct default release settings" do
      @cakefile = Cakefile.new

      common_settings = Xcodeproj::Constants::PROJECT_DEFAULT_BUILD_SETTINGS
      settings = Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:all])
      settings = settings.merge!(Xcodeproj::Project::ProjectHelper.deep_dup(common_settings[:release]))

      expect(@cakefile.default_release_settings).to eq(settings)
    end

    #TODO: Some of the node system stuff.
  end
end
