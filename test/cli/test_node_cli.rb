require 'helper'
require 'solusvm/cli'

class TestNodeCli < Test::Unit::TestCase

  def setup
    # Prevents mocha from stubbing non existent methods so that we now if the CLI is failing because
    # something was moved around.
    Mocha::Configuration.prevent(:stubbing_non_existent_method)
  end

  def test_should_delegate_node_available_ips_to_node
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Node.stubs(:new => mock{ expects(:available_ips).with("thevserverid").returns(["ip1", "ip2"]) })

    $stdout.expects(:puts).with("ip1\nip2")
    Solusvm::Cli.start(cli_expand_base_arguments(["node", "available-ips", "thevserverid"]))
  end

  def test_should_delegate_node_stats_to_node
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Node.stubs(:new => mock{ expects(:statistics).with("thevserverid").returns({
      :stat1 => "val1", :stat2 => "val2"
    })})

    $stdout.expects(:puts).with("stat1 => val1\nstat2 => val2")
    Solusvm::Cli.start(cli_expand_base_arguments(["node", "stats", "thevserverid"]))
  end

  def test_should_delegate_node_xenresources_to_node
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Node.stubs(:new => mock{ expects(:xenresources).with("thevserverid").returns({
      :stat1 => "val1", :stat2 => "val2"
    })})

    $stdout.expects(:puts).with("stat1 => val1\nstat2 => val2")
    Solusvm::Cli.start(cli_expand_base_arguments(["node", "xenresources", "thevserverid"]))
  end

  def test_should_delegate_node_virtualservers_to_node
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Node.stubs(:new => mock{ expects(:virtualservers).with("thevserverid").returns("thedata")})

    $stdout.expects(:puts).with("thedata")
    Solusvm::Cli.start(cli_expand_base_arguments(["node", "virtualservers", "thevserverid"]))
  end

  def test_should_delegate_nodes_list_to_node
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Node.stubs(:new => mock{ expects(:list).with("type").returns("thenodes")})

    $stdout.expects(:puts).with("thenodes")
    Solusvm::Cli.start(cli_expand_base_arguments(["node", "list", "type"]))
  end

  def test_should_delegate_nodes_ids_to_node
    Solusvm.expects(:config).with("thelogin", "thekey", { :url => "theurl" })
    Solusvm::Node.stubs(:new => mock{ expects(:ids).with("type").returns("thenodes")})

    $stdout.expects(:puts).with("thenodes")
    Solusvm::Cli.start(cli_expand_base_arguments(["node", "list-ids", "type"]))
  end

end