# EMC Confidential Information, protected under EMC Bilateral Non-Disclosure Agreement.
# Copyright © 2012 EMC Corporation, All Rights Reserved

require "socket"
require "logger"

# This class represents the ProjectRazor configuration. It is stored persistently in './conf/razor_server.conf' and editing by the user
# @author Nicholas Weaver
module ProjectRazor
  module Config
    class Server

      include(ProjectRazor::Utility)

      # (Symbol) representing the database plugin mode to use defaults to (:mongo)

      attr_accessor :image_svc_host

      attr_accessor :persist_mode
      attr_accessor :persist_host
      attr_accessor :persist_port
      attr_accessor :persist_timeout

      attr_accessor :admin_port
      attr_accessor :api_port
      attr_accessor :image_svc_port

      attr_accessor :mk_checkin_interval
      attr_accessor :mk_checkin_skew
      attr_accessor :mk_uri
      attr_accessor :mk_fact_excl_pattern
      attr_accessor :mk_register_path # : /project_razor/api/node/register
      attr_accessor :mk_checkin_path # checkin: /project_razor/api/node/checkin
      # mk_log_level should be 'Logger::FATAL', 'Logger::ERROR', 'Logger::WARN',
      # 'Logger::INFO', or 'Logger::DEBUG' (default is 'Logger::ERROR')
      attr_accessor :mk_log_level

      attr_accessor :image_svc_path

      attr_accessor :register_timeout
      attr_accessor :force_mk_uuid

      attr_accessor :default_ipmi_power_state
      attr_accessor :default_ipmi_username
      attr_accessor :default_ipmi_password

      # init
      def initialize
        use_defaults
      end

      # Set defaults
      def use_defaults
        @image_svc_host = get_an_ip
        @persist_mode = :mongo
        @persist_host = "127.0.0.1"
        @persist_port = 27017
        @persist_timeout = 10

        @admin_port = 8025
        @api_port = 8026
        @image_svc_port = 8027

        @mk_checkin_interval = 60
        @mk_checkin_skew = 5
        @mk_uri = "http://#{get_an_ip}:#{@api_port}"
        @mk_register_path = "/razor/api/node/register"
        @mk_checkin_path = "/razor/api/node/checkin"
        @mk_fact_excl_pattern = "(^uptime.*$)|(^memory.*$)"
        @mk_log_level = "Logger::ERROR"

        @image_svc_path = $img_svc_path

        @register_timeout = 120
        @force_mk_uuid = ""

      end

      def get_client_config_hash
        config_hash = self.to_hash
        client_config_hash = {}
        config_hash.each_pair do
        |k,v|
          if k.start_with?("@mk_")
            client_config_hash[k.sub("@","")] = v
          end
        end
        client_config_hash
      end

      def get_an_ip
        ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
        ip.ip_address
      end

      def get_mk_

      end


    end
  end
end
