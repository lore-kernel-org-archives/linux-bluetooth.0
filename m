Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91D369990
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041083; cv=pass; b=tNkcSAmwvrDpDppTPodR4xqWpobJEqhE8vWTV9a0CyOxzsP58HXQtU++7DlmWQnj5r0SDCI1rcXQDm6xeRNl0xT0B5LUebEVw3jWjedamvJNdL+6t2LvH69MA9xChtGxjULd8LyLDRkMvG88dQkR3zTu99LQ9gt8GWo5MxwY4wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041083; c=relaxed/simple;
	bh=MSPEiBaxcXIV+m+Fjw00oq324ltQIWWTaHq4gqpIv1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoMfMUYCrO9Jw4QP0wmXC6rQVlt2Uxuus0t77PVnBtbasPGH7aMh4tmFRBJPrcK6e0EG1sIoaezTAndfmu1rgugl7TJWQnQpL0JI6Kvq3u2nLArnfs0Ns5MZXIhrU8lDuvG5Lo+jXr0gLC3BgkrE4qstV7U+claRD4iVadcPX7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Rd/aBBSR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Rd/aBBSR"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGb09T7zyd7;
	Fri, 20 Mar 2026 23:11:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JQh8TZUdyu35jAcViZLcAQGTFzRJuyWaZCJtw6jcVw=;
	b=Rd/aBBSRXtV8yi+nAMuoY0nEHjOLb2svGSqiXSRnuGobWSkIZe9aGFUPcza/y+86RHNxh1
	wEmicorGAOBKPT+Q7vXjceCySG0Vvu3EfXV2TrWph0n5gKcFZc7+9qTDLP8OunP4erqeAX
	izOXynuP4SpQVAH+lvR0vmL83i2w6x0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041079;
	b=eoSOST+iSAqqd5xw91t8YA6+3M8k866FRlGhoyj8UJwNVpkrBgdk41hUdhO73iHKAOiyco
	GMOIxtbPwuGEKrDTiByBjouj9BphhmNDzi16+IiZDzvDEepvd6TvyYh78r2+BFb8HGcHqn
	Glg6daa88dWi3xz2F4PYPjKCuzbrU88=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JQh8TZUdyu35jAcViZLcAQGTFzRJuyWaZCJtw6jcVw=;
	b=p9wGxKcOKlsDh7tgIH1hPnmQCmxjjJP9Rr07zNlH5jEHDqTv+qr4C9IEUMfCteMu9NMM+A
	/QeprpAUTMDzsbQjjjLZd+SeadNyzK6tScPgsiOgapsNyQsol84jZygnugbCw4Ouf19XJX
	TtmWH2rgiWKeYf1Lzkt7tJoqco/UZcQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 11/20] doc: add functional/integration testing documentation
Date: Fri, 20 Mar 2026 23:10:55 +0200
Message-ID: <b65c3b8b33a1ebc9bd558819ce8c893cd43223db.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for functional/integration test suite.
---
 doc/test-functional.rst | 769 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 769 insertions(+)
 create mode 100644 doc/test-functional.rst

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
new file mode 100644
index 000000000..bb3d1ae46
--- /dev/null
+++ b/doc/test-functional.rst
@@ -0,0 +1,769 @@
+===============
+test-functional
+===============
+
+**test-functional** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+**test-functional(1)** is used for functional testing of BlueZ and
+kernel using multiple virtual machine environments, connected by real
+or virtual controllers.
+
+OPTIONS
+=======
+
+The `test-functional` script simply runs `Pytest
+<https://pytest.org>`__ which can take the following options:
+https://docs.pytest.org/en/stable/reference/reference.html#command-line-flags
+
+The following additional options apply:
+
+:--kernel=<image>: Kernel image (or built Linux source tree root) to
+	use.  See **test-runner(1)** and `tester.config` for required
+	kernel config.
+
+	If not provided, value from `FUNCTIONAL_TESTING_KERNEL`
+	environment variable is used. If none, no image is used.
+
+:--usb=hci0,hci1: USB controllers to use in tests that require use of
+	real controllers.
+
+	If not provided, value from `FUNCTIONAL_TESTING_CONTROLLERS`
+	environment variable is used. If none, all USB controllers
+	with suitable permissions are considered.
+
+:--force-usb: Force tests to use USB controllers instead of `btvirt`.
+
+:--vm-timeout=<seconds>: Specify timeout for communication with VM hosts.
+
+:--log-filter=[+-]<pattern>,[+-]<pattern>,...: Allow/deny lists
+	for filtering logging output. The pattern is a shell glob matching
+	to the logger names.
+
+:--build-dir=<path>: Path to build directory where to search for BlueZ
+        executables.
+
+:--list: Output brief lists of existing tests.
+
+Tests that require kernel image or USB controllers are skipped if none
+are available. Normally, tests use `btvirt`.
+
+VM instances share a directory ``/run/shared`` with host machine,
+located on host usually in ``/tmp/bluez-func-test-*/shared-*``.  Core
+dumps etc. are copied out from it before test instance is shut down.
+
+
+REQUIREMENTS
+============
+
+General
+-------
+
+The following are needed:
+
+- QEmu (x86_64)
+- ``dbus-daemon`` available
+
+Recommended:
+
+- KVM-enabled x86_64 host system
+- Preferably built BlueZ source tree
+- ``chronyd`` available
+- ``util-linux`` tools available
+- ``agetty`` available
+
+Python
+------
+
+The following Python packages are required:
+
+.. code-block::
+
+   pytest
+   pexpect
+   dbus-python
+
+To install them via pip::
+
+	python3 -m pip install -r test/functional/requirements.txt
+
+On Fedora / RHEL::
+
+	sudo dnf install python3-pytest python3-pexpect python3-dbus
+
+
+Kernel
+------
+
+The **test-functional(1)** tool requires a kernel image with similar
+config as **test-runner(1)**.  Simplest setup is
+
+.. code-block::
+
+	cp ../bluez/doc/tester.config .config
+	make olddefconfig
+	make -j8
+
+To get log timestamps right, the kernel should have the following
+configuration enabled:
+
+.. code-block::
+
+	CONFIG_HYPERVISOR_GUEST=y
+	CONFIG_PARAVIRT=y
+	CONFIG_KVM_GUEST=y
+
+	CONFIG_PTP_1588_CLOCK=y
+	CONFIG_PTP_1588_CLOCK_KVM=y
+	CONFIG_PTP_1588_CLOCK_VMCLOCK=y
+
+USB
+---
+
+Some tests may require a hardware controller instead of the virtual `btvirt` one.
+
+
+EXAMPLES
+========
+
+Run all tests
+-------------
+
+.. code-block::
+
+	$ test/test-functional --kernel=/pathto/bzImage
+
+	$ export FUNCTIONAL_TESTING_KERNEL=/pathto/bzImage
+	$ test/test-functional
+
+Show output during run
+----------------------
+
+.. code-block::
+
+	$ test/test-functional --log-cli-level=0
+
+Show only specific loggers:
+
+.. code-block::
+
+	$ test/test-functional --log-cli-level=0 --log-filter=rpc,host
+
+	$ test/test-functional --log-cli-level=0 --log-filter=*.bluetoothctl
+
+Filter out loggers:
+
+.. code-block::
+
+	$ test/test-functional --log-cli-level=0 --log-filter=-host
+
+	$ test/test-functional --log-cli-level=0 --log-filter=host,-host.*.1
+
+Run selected tests
+------------------
+
+.. code-block::
+
+	$ test/test-functional test/functional/test_cli_simple.py::test_bluetoothctl_script_show
+
+	$ test/test-functional -k test_bluetoothctl_script_show
+
+	$ test/test-functional -k 'test_btmgmt or test_bluetoothctl'
+
+Don't run tests with a given marker:
+
+.. code-block::
+
+	$ test/test-functional -m "not pipewire"
+
+Don't run known-failing tests:
+
+.. code-block::
+
+	$ test/test-functional -m "not xfail"
+
+Note that otherwise known-failing tests would be run, but with
+failures suppressed.
+
+Run previously failed and stop on failure
+-----------------------------------------
+
+.. code-block::
+
+	$ test/test-functional -x --ff
+
+List all tests
+--------------
+
+.. code-block::
+
+	$ test/test-functional --list
+
+Show errors from know-failing test
+----------------------------------
+
+.. code-block::
+
+	$ test/test-functional --runxfail -k test_btmgmt_info
+
+Redirect USB devices
+--------------------
+
+.. code-block::
+
+	$ test/test-functional --usb=hci0,hci1
+
+	$ export FUNCTIONAL_TESTING_CONTROLLERS=hci0,hci1
+	$ test/test-functional -vv
+
+This does not require running as root. Changing device permissions is
+sufficient. In verbose mode (``-vv``) some instructions are printed.
+
+Run all tests using the USB controllers:
+
+.. code-block::
+
+	$ test/test-functional --usb=hci0,hci1 --force-usb
+
+Run tests in parallel
+---------------------
+
+pytest-xdist is required for parallel execution. To run:
+
+.. code-block::
+
+	$ test/test-functional -n auto
+
+To reduce VM setup/teardowns:
+
+.. code-block::
+
+	$ test/test-functional -n auto --dist loadgroup
+
+Logging in to a test VM instance
+--------------------------------
+
+While test is running:
+
+.. code-block::
+
+	$ test/test-functional-attach
+
+For this to be useful, usually, you need to pause the test
+e.g. by running with ``--trace`` option.
+
+To do it manually, when starting the tester will log a line like::
+
+	TTY: socat /tmp/bluez-func-test-q658swgi/bluez-func-test-tty-0 STDIO,rawer
+
+with the location of the socket where the serial is connected to.
+
+WRITING TESTS
+=============
+
+The functional tests are written in files (test modules) names
+`test/functional/test_*.py`.  They are written using standard Pytest
+style.  See https://docs.pytest.org/en/stable/getting-started.html
+
+Example: Virtual machines
+-------------------------
+
+.. code-block:: python
+
+   from pytest_bluez import host_config, Bluetoothd, Bluetoothctl
+
+   @host_config(
+       [Bluetoothd(), Bluetoothctl()],
+       [Bluetoothd(), Bluetoothctl()],
+   )
+   def test_bluetoothctl_pair(hosts):
+       host0, host1 = hosts
+
+       host0.bluetoothctl.send("scan on\n")
+       host0.bluetoothctl.expect(f"Controller {host0.bdaddr.upper()} Discovering: yes")
+
+       host1.bluetoothctl.send("pairable on\n")
+       host1.bluetoothctl.expect("Changing pairable on succeeded")
+       host1.bluetoothctl.send("discoverable on\n")
+       host1.bluetoothctl.expect(f"Controller {host1.bdaddr.upper()} Discoverable: yes")
+
+       host0.bluetoothctl.expect(f"Device {host1.bdaddr.upper()}")
+       host0.bluetoothctl.send(f"pair {host1.bdaddr}\n")
+
+       idx, m = host0.bluetoothctl.expect(r"Confirm passkey (\d+).*:")
+       key = m[0].decode("utf-8")
+
+       host1.bluetoothctl.expect(f"Confirm passkey {key}")
+
+       host0.bluetoothctl.send("yes\n")
+       host1.bluetoothctl.send("yes\n")
+
+       host0.bluetoothctl.expect("Pairing successful")
+
+The test declares a VM setup with two Qemu instances, where both hosts
+run bluetoothd and start a bluetoothctl process.  The Qemu instances
+have `btvirt` virtual BT controllers and can see each other.
+
+The test itself runs on the parent host.
+
+The `host0/1.bluetoothctl.*` commands invoke RPC calls to one of the
+the two VM instances. In this case, they are controlling the
+`bluetoothctl` process using `pexpect` library to deal with its
+command line.
+
+When the test body finishes executing, the test passes. Or, it fails
+if any ``assert`` statement fails or an error is raised. For example,
+above ``RemoteError`` due to bluetoothctl not proceeding as expected
+in pairing is possible.
+
+The host configuration (bluetoothd + bluetoothctl above) is torn down
+between test (SIGTERM/SIGKILL sent etc.).
+
+By default the VM instance itself continues running, and may be used
+for other tests that share the same VM setup.
+
+Generally, the framework automatically orders the tests so that the VM
+setup does not need to be restarted unless needed.
+
+
+Example host plugin
+-------------------
+
+The `host.bluetoothctl` implementation used above is as follows:
+
+.. code-block:: python
+
+   from pytest_bluez import HostPlugin, Bluetoothd
+
+   class Bluetoothctl(Pexpect):
+       # Declare unique plugin name
+       name = "bluetoothctl"
+
+       # Declare plugin dependencies to be loaded first
+       depends = [Bluetoothd()]
+
+       # These run on parent host side:
+
+       def __init__(self, subdir, name):
+           self.exe = utils.find_exe(subdir, name)
+
+       def presetup(self):
+           pass
+
+       # These run on VM side at setup/teardown:
+
+       def setup(self, impl):
+           self.log = logging.getLogger(self.name)
+           self.log_stream = utils.LogStream(self.name)
+           self.ctl = pexpect.spawn(self.exe, logfile=self.log_stream.stream)
+
+       def teardown(self):
+           self.ctl.terminate()
+
+       # These define custom RPC methods that can be called
+
+       def expect(self, *a, **kw):
+           ret = self.ctl.expect(*a, **kw)
+           self.log.debug("match found")
+           return ret, self.ctl.match.groups()
+
+       def send(self, *a, **kw):
+           return self.ctl.send(*a, **kw)
+
+
+
+Host plugins are for injecting code to run on the VM side test hosts.
+The host plugins have scope of one test.  The VM side test framework
+sends SIGTERM and SIGKILL to all processes in the test process group
+to reset the state between each test.
+
+The plugins are declared by inheriting from `HostPlugin`. Their
+`__init__()` is supposed to only store declarative configuration on
+`self` and runs on parent side early in the test discovery phase.  The
+`presetup` runs on parent side in test setup phase, before VM
+environment is started. The plugin can for example do
+`pytest.skip(reason="something")` to skip the test.
+
+The `setup()` and `teardown()` methods run on VM-side at host
+environment start and end.  All other methods can be invoked via RPC
+by the parent tester, and any values returned by them are passed via
+RPC back to the parent.
+
+To load a plugin to a VM host, pass it to `host_config()` in the
+declaration of a given test.
+
+Test fixtures
+=============
+
+The following test fixtures are used to deal with spawning VM hosts:
+
+hosts
+-----
+
+.. code-block::
+
+    Session-scope fixture that expands to a list of VM host proxies
+    (`HostProxy`), with configuration as specified in `host_config`. The
+    VM instances used may be reused by other tests.  The userspace test
+    runner is torn down between tests.
+
+    Example:
+
+        def test_something(hosts):
+            host0 = hosts[0]
+            host1 = hosts[1]
+
+hosts_once
+----------
+
+.. code-block::
+
+   def test_something(hosts_once):
+       host0 = hosts_once[0]
+       host1 = hosts_once[1]
+
+Function-scope fixture. Same as `hosts`, but spawn separate VM
+instances for this test only.
+
+Others
+------
+
+The following fixtures are defined, but mainly for use as dependencies
+to `hosts`: `kernel` (selected kernel image), `usb_indices` (selected
+USB controllers), `host_setup` (current host plugin configurations),
+`vm_setup` (VM host configuration), `vm` (VM instances without
+userspace setup), `vm_once` (same but with function scope).
+
+Utilities
+=========
+
+In addition to standard Pytest features, the following items are
+available in the `pytest_bluez` module.
+
+host_config
+-----------
+
+.. code-block::
+
+    @host_config(*host_setup, hw=False, reuse=False)
+
+    Declare host configuration.
+
+    Args:
+        *host_setup: each argument is a list of plugins to be loaded on a host.
+            The number of arguments specifies the number of hosts.
+        hw (bool): whether to require hardware BT controller
+        reuse (bool): whether to define a setup where the test host processes
+            are not required to be torn down between tests. This is only useful
+            for tests that do not perturb e.g. bluetoothd state too much.
+
+    Returns:
+        callable: decorator setting pytest attributes
+
+    Example:
+
+        @host_config([Bluetoothd()], [Bluetoothd()])
+        def test_something(hosts):
+            host0, host1 = hosts
+
+    Example:
+
+        # Allow not restarting Bluetoothd between tests sharing this configuration
+        base_config = host_config([Bluetoothd()], reuse=True)
+
+        @base_config
+        def test_one(hosts):
+            host0, = hosts
+
+        @base_config
+        def test_two(hosts):
+            # Note: uses same Bluetoothd() instance as above
+            host0, = hosts
+
+parametrized_host_config
+------------------------
+
+.. code-block::
+
+    Declare parametrized host configurations.
+
+    See https://docs.pytest.org/en/stable/how-to/parametrize.html for the
+    concept.
+
+    Args:
+        param_host_setups (list): list of host setups
+        hw (bool): whether to require hardware BT controller
+        reuse (bool): whether to define a setup where the test host processes
+            are not required to be torn down between tests. This is only useful
+            for tests that do not perturb e.g. bluetoothd state too much.
+
+    Returns:
+        callable: decorator setting pytest attributes
+
+HostProxy
+---------
+
+.. code-block::
+
+   class HostProxy:
+       """
+       Parent-side proxy for VM host: load plugins, RPC calls to plugins
+       """
+
+       def load(self, plugin: HostPlugin):
+           """
+           Load given plugin to the VM host synchronously.
+           """
+
+       def start_load(self, plugin: HostPlugin):
+           """
+           Initiate loading the given plugin to the VM host.  Use
+           `wait_load` to wait for completion and make loaded plugins
+           usable.
+
+           """
+
+       def wait_load(self):
+           """
+           Wait for plugin loads to complete, and make plugins available.
+           """
+
+       def close(self)
+           """
+           Shutdown this VM host tester instance.
+           """
+
+       def __getattr__(self, name):
+           """
+   	Get a proxy attribute for one of the loaded plugins
+   	"""
+
+Parent host-side representation of one VM host with loadable plugins.
+
+Plugins are usually loaded based on `host_setup`, but can also be
+loaded during the test itself.
+
+Loaded plugins appear as attributes on the host proxy.
+
+find_exe
+--------
+
+.. code-block::
+
+   from pytest_bluez import find_exe
+   bluetoothctl = find_exe("client", "bluetoothctl")
+
+Find absolute path to the given executable, either within BlueZ build
+directory or on host.
+
+
+mainloop_invoke
+-------------
+
+.. code-block::
+
+    Blocking invoke of `func` in GLib main loop.
+
+    Note:
+
+        GLib main loop is only available for VM host plugins, not in tester.
+
+    Example:
+
+        value = mainloop_invoke(lambda: 123)
+        assert value == 123
+
+    Warning:
+        dbus-python **MUST** be used only from the GLib main loop,
+        as the library has concurrency bugs. All functions using it
+        **MUST** either run from GLib main loop eg. via mainloop_wrap
+
+mainloop_wrap
+-------------
+
+.. code-block::
+
+    Wrap function to run in GLib main loop thread
+
+    Note:
+
+        GLib main loop is only available for VM host plugins, not in tester.
+
+    Example:
+
+        @mainloop_wrap
+        def func():
+            bus = dbus.SystemBus()
+
+mainloop_wrap
+-------------
+
+.. code-block::
+
+    Wrap function to assert it runs from GLib main loop
+
+    Note:
+
+        GLib main loop is only available for VM host plugins, not in tester.
+
+    Example:
+
+        @mainloop_assert
+        def func():
+            bus = dbus.SystemBus()
+
+LogStream
+---------
+
+.. code-block::
+
+   from pytest_bluez import LogStream
+
+   log_stream = LogStream("bluetoothctl")
+   subprocess.run(["bluetoothctl", "show"], stdout=log_stream.stream)
+
+Utility to redirect a stream to logging with accurate kernel-provided
+timestamps.
+
+RemoteError
+-----------
+
+.. code-block::
+
+   from pytest_bluez import RemoteError
+
+   try:
+       host.call(foo)
+   except RemoteError as exc:
+       print(exc.traceback)
+       original_exception = exc.exc
+
+Exception raised on the VM side, passed through RPC. Properties:
+`traceback` is a traceback string and `exc` is the original exception
+instance raised on the remote side.
+
+Host plugins
+============
+
+The following host plugins are available:
+
+HostPlugin
+----------
+
+Base class for host plugins. See also example above.
+
+.. code-block::
+
+   class HostPlugin:
+       """
+       Plugin to insert code to VM host side.
+
+       Attributes:
+           name (str): unique name for the plugin
+           depends (tuple[HostPlugin]): plugins to be loaded before this one
+           value (object): object to appear as HostProxy attribute on parent side.
+               If None, the plugin is represented by a proxy object that does RPC
+               calls. Otherwise, must be a serializable value.
+
+       """
+
+       name = None
+       depends = ()
+       value = None
+
+       def __init__(self):
+           """
+           Configure plugin (runs on parent host side).  This is
+           called at test discovery time, so should mainly store static
+           data.
+
+           """
+           pass
+
+       def presetup(self):
+           """
+           Parent host-side setup, before VM environment is started.  May
+           use pytest.skip() to skip tests in case plugin cannot be set up.
+
+           """
+           pass
+
+       def setup(self, impl):
+           """
+           VM-side setup
+
+           Args:
+               impl (Implementation): plugin host object
+           """
+           pass
+
+       def teardown(self):
+           """VM-side teardown"""
+           pass
+
+Bdaddr
+------
+
+Host plugin providing ``host.bdaddr``.
+Loaded by default.
+
+Bluetoothctl
+------------
+
+.. code-block::
+
+   class Bluetoothctl(HostPlugin)
+       def expect(self, *a, **kw)
+       def send(self, *a, **kw)
+
+Host plugin for starting and controlling `bluetoothctl` with pexpect.
+
+Bluetoothd
+----------
+
+Host plugin starting Bluetoothd.
+
+Call
+----
+
+.. code-block::
+
+   class Call(HostPlugin):
+       def __call__(self, func, *args, **kwargs)
+
+Host plugin providing ``host.call(func, *args, **kw)`` which invokes
+the given function on VM host side.  Loaded by default.
+
+DbusSession
+-----------
+
+Host plugin providing session DBus, at address
+`impl["dbus-session"].address`.
+
+DbusSystem
+----------
+
+Host plugin providing system DBus, at address
+`impl["dbus-system"].address`.
+
+Pexpect
+-------
+
+.. code-block::
+
+   class Pexpect(HostPlugin)
+       def spawn(self, cmd)
+           """Returns: spawn_id"""
+       def close(self, spawn_id)
+       def expect(self, spawn_id, *a, **kw)
+       def send(self, spawn_id, *a, **kw)
+
+Host plugin for starting and controlling processes with pexpect.
+
+Rcvbuf
+------
+
+Host plugin setting pipe buffer size defaults.
+Loaded by default.
-- 
2.53.0

