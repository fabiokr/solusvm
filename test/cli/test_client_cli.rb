require 'helper'
require 'solusvm/cli'

class TestClientCli < Test::Unit::TestCase

  def setup
    # Prevents mocha from stubbing non existent methods so that we now if the CLI is failing because
    # something was moved around.
    Mocha::Configuration.prevent(:stubbing_non_existent_method)
  end

  def test_should_delegate_client_create_to_client
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Client.stubs(:new => mock{ expects(:create).with() do |options|
      expected = {
        :username => "theusername",
        :password => "thepassword",
        :email => "theemail",
        :firstname => "thefirstname",
        :lastname => "thelastname",
        :company => "thecompany"
      }

      expected.all? { |k,v| options[k] == v }

      end.returns("theresult") 
    })

    $stdout.expects(:puts).with("theresult")
    Solusvm::Cli.start(cli_expand_base_arguments([
      "client", "create", 
      "--username", "theusername",
      "--password", "thepassword",
      "--email", "theemail",
      "--firstname", "thefirstname",
      "--lastname", "thelastname",
      "--company", "thecompany"
    ]))
  end

  def test_should_delegate_client_change_password_to_client
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Client.stubs(:new => mock{ expects(:change_password).with("theusername", "thepassword").returns("theresult") })

    $stdout.expects(:puts).with("theresult")
    Solusvm::Cli.start(cli_expand_base_arguments(["client", "change-password", "theusername", "thepassword"]))
  end

  def test_should_delegate_client_authenticate_to_client
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Client.stubs(:new => mock{ expects(:authenticate).with("theusername", "thepassword").returns("theresult") })

    $stdout.expects(:puts).with("theresult")
    Solusvm::Cli.start(cli_expand_base_arguments(["client", "authenticate", "theusername", "thepassword"]))
  end

  def test_should_delegate_client_check_exists_to_client
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Client.stubs(:new => mock{ expects(:exists?).with("theusername").returns("theresult") })

    $stdout.expects(:puts).with("theresult")
    Solusvm::Cli.start(cli_expand_base_arguments(["client", "check-exists", "theusername"]))
  end

  def test_should_delegate_client_delete_to_client
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Client.stubs(:new => mock{ expects(:delete).with("theusername").returns("theresult") })

    $stdout.expects(:puts).with("theresult")
    Solusvm::Cli.start(cli_expand_base_arguments(["client", "delete", "theusername"]))
  end

  def test_should_delegate_client_list_to_client
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Client.stubs(:new => mock{ expects(:list).returns("theresult") })

    $stdout.expects(:puts).with("theresult")
    Solusvm::Cli.start(cli_expand_base_arguments(["client", "list"]))
  end
end