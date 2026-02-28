Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B922689C
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283104; cv=pass; b=RVpmMo3BVfp4hymndr5nRGnz2ptz+c1e2uFoNNUE1oiAD/IVqJamsDTbqrTWvv6D3Ci+lkYFbcq7hKQO68wBJ8rOo7YSRO0Ex+LGUhpior7bCc11scb3Ht+Knt3nIIxM2UOZ6EwfRSZDZyg6wH2X2tjCWNbI10h3E0IzZKZUcoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283104; c=relaxed/simple;
	bh=kEJumh6A2xOgFnFyOzthwPfDLwprsbgJygrQDjypESk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBF50VGWvFliAqMTw95vjmlH0dPLtJG9O0oim/bvNKEd6Bfi1wroLvII1yi8j4JYPXDjtXL9YP6AMs5pZMXCCzkKCx8y0weB78uvDzSlVPnz6+m2MARsGhHIS6HacbvLy9jFUi5z3HykdDz/1mUvzphkviqAZuALqc3jpv/y5iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=UsC3iGG7; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="UsC3iGG7"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fNQ7F53BxzyZ1;
	Sat, 28 Feb 2026 14:51:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1772283098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=417oNViMZmBJaRGjwbD72EA/wGvU1WteJOg1oZCWleg=;
	b=UsC3iGG7e6yQ5CgJad1xqiPM5fcmPhWGNs0c7EFLRoEuWj1MfznsXnr+kdgD9uQv6wVcyx
	K9d4rYrZN0QWXf0IypQDYSu9rCH0levY17SEtHTtADW842gboAEh4vn5xbOOowxEk3CoLx
	Tqw/cofZYC26gwHr5zcUVWJIfDTHFQg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1772283098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=417oNViMZmBJaRGjwbD72EA/wGvU1WteJOg1oZCWleg=;
	b=LuqmZdXy8g8ivkWsWFMg9jLL5/R4Aj7frfIcW9dZh7G92XgutApG9BQYRE9uHBku9sbT4d
	NSa+XCHCPd49dE+fA6a0TpPhl//u2/uJrJifafAojkMfpL0NlrkhuGVhAOARF6kxfh6z4b
	jMiWtRHx8zzCnlbQYTQQQ9tHP1g1y2Y=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1772283098;
	b=IU7LX/aAvGZvYdWE2DfqYoZI4wIwTKpDtAEkCZHw/gEfnb/8Y8w/6mC7U2DdIhet+bskRB
	TRKkY9rmUVl+ID91yRKE5OvGebKfGWPjVjIKwPktgwGNV/JdmXQxHsPV5yz7niypDKCWo7
	HYBDglhqjQ2rjgIwjh1r7SEJMVHlUmo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 09/11] unit: add functional/integration testing framework
Date: Sat, 28 Feb 2026 14:51:15 +0200
Message-ID: <8d41b3f2c5529fe04f72cc16bee2c1c06643caf7.1772282574.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772282574.git.pav@iki.fi>
References: <cover.1772282574.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add framework for writing tests simulating "real" environments where
BlueZ and other parts of the stack run on different virtual machine
hosts that communicate with each other.

This uses tools/test-runner to launch VM instances, but does not use the
intra-VM setup code to allow reusing the same VM instances for multiple
tests.

Implements:

- RPC communication with tester instances running each of the VM hosts,
  so that tests can be written on the parent host which coordinates the
  execution.

- Extensible way to add stateful test-specific code inside the VM
  instances

- Logging control: output from different processes running inside the VM
  are separated and can be filtered.

- Test runner framework with Pytest (more convenient than Python/unittest)

- Grouping tests to minimize VM reboots

- Redirecting USB controllers to use for testing

There is no requirement that the tests spawn VM instances, the test
runner can be used for any tests written in Python.
---
 unit/func_test/__init__.py             |   0
 unit/func_test/conftest.py             | 277 ++++++++++++++
 unit/func_test/lib/__init__.py         |   5 +
 unit/func_test/lib/env.py              | 484 +++++++++++++++++++++++++
 unit/func_test/lib/host_plugins.py     | 269 ++++++++++++++
 unit/func_test/lib/rpc.py              | 293 +++++++++++++++
 unit/func_test/lib/runner.py           |  10 +
 unit/func_test/lib/tests/__init__.py   |   0
 unit/func_test/lib/tests/test_rpc.py   |  49 +++
 unit/func_test/lib/utils.py            | 266 ++++++++++++++
 unit/func_test/requirements.txt        |   3 +
 unit/func_test/test_bluetoothctl_vm.py |  76 ++++
 unit/func_test/test_btmgmt_vm.py       |  29 ++
 unit/pytest.ini                        |   6 +
 unit/test-functional                   |   8 +
 15 files changed, 1775 insertions(+)
 create mode 100644 unit/func_test/__init__.py
 create mode 100644 unit/func_test/conftest.py
 create mode 100644 unit/func_test/lib/__init__.py
 create mode 100644 unit/func_test/lib/env.py
 create mode 100644 unit/func_test/lib/host_plugins.py
 create mode 100644 unit/func_test/lib/rpc.py
 create mode 100644 unit/func_test/lib/runner.py
 create mode 100644 unit/func_test/lib/tests/__init__.py
 create mode 100644 unit/func_test/lib/tests/test_rpc.py
 create mode 100644 unit/func_test/lib/utils.py
 create mode 100644 unit/func_test/requirements.txt
 create mode 100644 unit/func_test/test_bluetoothctl_vm.py
 create mode 100644 unit/func_test/test_btmgmt_vm.py
 create mode 100644 unit/pytest.ini
 create mode 100755 unit/test-functional

diff --git a/unit/func_test/__init__.py b/unit/func_test/__init__.py
new file mode 100644
index 000000000..e69de29bb
diff --git a/unit/func_test/conftest.py b/unit/func_test/conftest.py
new file mode 100644
index 000000000..c9db1a457
--- /dev/null
+++ b/unit/func_test/conftest.py
@@ -0,0 +1,277 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+import os
+import re
+import logging
+import fnmatch
+import pytest
+from pathlib import Path
+
+
+def pytest_addoption(parser):
+    parser.addoption(
+        "--kernel",
+        action="store",
+        default=None,
+        help=("Kernel image to use"),
+    )
+    parser.addoption(
+        "--usb",
+        action="store",
+        default=None,
+        help=("USB HCI devices to use, e.g. 'hci0,hci1'"),
+    )
+    parser.addoption(
+        "--force-usb",
+        action="store_true",
+        default=None,
+        help=("Force tests to run with USB controllers instead of btvirt"),
+    )
+    parser.addoption(
+        "--build-dir",
+        action="store",
+        default=None,
+        type=Path,
+        help=("Build directory to find development binaries"),
+    )
+    parser.addoption(
+        "--list",
+        action="store_true",
+        default=None,
+        help=("List tests"),
+    )
+    parser.addoption(
+        "--log-filter",
+        action="append",
+        default=None,
+        help=(
+            "Enable/disable loggers by name. Can be passed multiple times. Example: +host.0,-rpc"
+        ),
+    )
+    parser.addoption(
+        "--vm-timeout",
+        action="store",
+        default=20,
+        type=float,
+        help="Timeout in seconds for waiting for RPC reply with VM (default: 20 s)",
+    )
+
+
+def pytest_configure(config):
+    from .lib import utils
+
+    if config.option.build_dir is not None:
+        utils.BUILD_DIR = config.option.build_dir
+
+
+def pytest_report_collectionfinish(config, start_path, items):
+    if config.option.list:
+        print()
+        for item in items:
+            print(f"unit/{item.nodeid}")
+        print()
+        os._exit(0)
+
+
+def pytest_collection_modifyitems(session, config, items):
+    # Sort VM-using tests to minimize VM setup/teardown
+
+    def sort_key(item):
+        for m in item.own_markers:
+            setup = item.callspec.params.get("vm_setup", None)
+            if setup is not None:
+                return tuple(sorted(setup.items()))
+        return ()
+
+    if not config.option.list:
+        items.sort(key=sort_key)
+
+
+def pytest_sessionstart(session):
+    from .lib import utils
+
+    config = session.config
+
+    if config.option.log_filter is not None:
+        allow = set()
+        deny = set()
+        for item in config.option.log_filter:
+            for name in item.split(","):
+                if name.startswith("+"):
+                    allow.add(name[1:])
+                elif name.startswith("-"):
+                    deny.add(name[1:])
+                else:
+                    allow.add(name)
+
+        filter = _LogFilter(allow, deny)
+
+        for handler in logging.root.handlers:
+            if any(type(f) == _LogFilter for f in handler.filters):
+                continue
+
+            handler.addFilter(filter)
+
+    for handler in logging.root.handlers:
+        fmt = getattr(handler, "formatter", None)
+        if hasattr(fmt, "add_color_level"):
+            fmt.add_color_level(utils.OUT, "yellow")
+
+
+@pytest.fixture(autouse=True)
+def setup_logging(pytestconfig, caplog):
+    caplog.set_level(0)
+
+
+class _LogFilter(logging.Filter):
+    def __init__(self, allow=(), deny=()):
+        if allow:
+            allow_re = "|".join(self._re(x) for x in allow)
+            self.allow = re.compile(allow_re)
+        else:
+            self.allow = None
+        if deny:
+            deny_re = "|".join(self._re(x) for x in deny)
+            self.deny = re.compile(deny_re)
+        else:
+            self.deny = None
+
+    def _re(self, name):
+        pat = fnmatch.translate(name)
+        return f"{pat}$|{pat}\\."
+
+    def filter(self, record):
+        if self.deny is not None and self.deny.match(record.name):
+            return False
+        if self.allow is not None and self.allow.match(record.name):
+            return True
+        return self.allow is None
+
+
+@pytest.fixture(scope="session")
+def kernel(pytestconfig):
+    """
+    Fixture for kernel image
+    """
+    kernel = pytestconfig.getoption("kernel")
+
+    if kernel is None:
+        kernel = os.environ.get("FUNCTIONAL_TESTING_KERNEL")
+
+    if not kernel:
+        pytest.skip("No kernel image")
+
+    if Path(kernel).is_dir():
+        kernel = str(Path(kernel) / "arch" / "x86" / "boot" / "bzImage")
+
+    if not Path(kernel).is_file():
+        pytest.skip("no kernel image")
+
+    return kernel
+
+
+@pytest.fixture(scope="session")
+def usb_indices(pytestconfig):
+    """
+    Fixture for available USB controllers
+    """
+    from .lib import env
+
+    usb_indices = pytestconfig.getoption("usb")
+
+    if usb_indices is None:
+        usb_indices = os.environ.get("FUNCTIONAL_TESTING_CONTROLLERS")
+
+    if usb_indices is None:
+        usb_indices = [item.name for item in Path("/sys/class/bluetooth").iterdir()]
+    else:
+        usb_indices = usb_indices.split(", ")
+
+    messages = []
+    for name in list(usb_indices):
+        subsys = Path("/sys/class/bluetooth") / name / "device" / "subsystem"
+        if subsys.resolve() != Path("/sys/bus/usb"):
+            usb_indices.remove(name)
+            continue
+
+        try:
+            env.Environment.check_controller(name)
+            messages.append("")
+        except ValueError as exc:
+            usb_indices.remove(name)
+            messages.append(str(exc))
+
+    return usb_indices, messages
+
+
+@pytest.fixture(scope="session")
+def host_setup(request):
+    if getattr(request, "param", None) is None:
+        raise pytest.fail("host setup not specified")
+
+    return request.param
+
+
+@pytest.fixture(scope="session")
+def vm_setup(request):
+    if getattr(request, "param", None) is None:
+        raise pytest.fail("env setup not specified")
+
+    return request.param
+
+
+def _vm_impl(request, kernel, num_hosts, hw):
+    from .lib import Environment
+
+    config = request.session.config
+
+    if hw or config.option.force_usb:
+        usb_indices, messages = request.getfixturevalue("usb_indices")
+        if len(usb_indices) < num_hosts:
+            message = "\n".join(m for m in messages[:num_hosts] if m)
+            pytest.skip(reason=f"Not enough USB controllers: {message}")
+    else:
+        usb_indices = None
+
+    with Environment(
+        kernel, num_hosts, usb_indices=usb_indices, timeout=config.option.vm_timeout
+    ) as vm:
+        yield vm
+
+
+def _hosts_impl(request, vm, setup):
+    from .lib import Bdaddr, Call
+
+    for h, plugins in zip(vm.hosts, setup):
+        for p in plugins:
+            h.start_load(p)
+
+    for h in vm.hosts:
+        h.wait_load()
+
+    yield vm.hosts
+
+    for h in vm.hosts:
+        h.close()
+
+
+@pytest.fixture(scope="package")
+def vm(request, kernel, vm_setup):
+    yield from _vm_impl(request, kernel, **vm_setup)
+
+
+@pytest.fixture
+def hosts(request, vm, host_setup):
+    yield from _hosts_impl(request, vm, **host_setup)
+
+
+# Same with single-test scope:
+
+
+@pytest.fixture
+def vm_once(request, kernel, vm_setup):
+    yield from _vm_impl(request, kernel, **vm_setup)
+
+
+@pytest.fixture
+def hosts_once(request, vm_module, host_setup):
+    yield from _hosts_impl(request, vm_module, **host_setup)
diff --git a/unit/func_test/lib/__init__.py b/unit/func_test/lib/__init__.py
new file mode 100644
index 000000000..b2767105e
--- /dev/null
+++ b/unit/func_test/lib/__init__.py
@@ -0,0 +1,5 @@
+from .rpc import RemoteError
+
+from .env import *
+from .utils import *
+from .host_plugins import *
diff --git a/unit/func_test/lib/env.py b/unit/func_test/lib/env.py
new file mode 100644
index 000000000..70c0c6ffb
--- /dev/null
+++ b/unit/func_test/lib/env.py
@@ -0,0 +1,484 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+"""
+Test environment:
+
+- one or more qemu instances running Linux kernel + BlueZ + other stack
+- connected by btvirt, or real USB Bluetooth controllers
+- Python RPC connection to each via unix socket <-> qemu chardev
+
+"""
+import sys
+import os
+import signal
+import re
+import pwd
+import time
+import shlex
+import argparse
+import shutil
+import threading
+import tempfile
+import operator
+import logging
+import socket
+import pickle
+from pathlib import Path
+from subprocess import Popen, DEVNULL, PIPE, run
+
+from . import rpc, utils
+
+__all__ = ["HostPlugin", "Environment"]
+
+log = logging.getLogger(__name__)
+
+
+class HostPlugin:
+    value = None
+    depends = None
+
+    def __init__(self):
+        """Configure plugin (runs on host-side)"""
+        pass
+
+    def setup(self, impl: Implementation):
+        """VM-side setup"""
+        pass
+
+    def teardown(self):
+        """VM-side teardown"""
+        pass
+
+
+class HostProxy:
+    """
+    Parent-side proxy for VM host: load plugins, RPC calls to plugins
+    """
+
+    def __init__(self, path, timeout, name):
+        self._path = path
+        self._active_conn = None
+        self._timeout = timeout
+        self._plugins = {}
+        self._name = name
+
+    def load(self, plugin: HostPlugin):
+        self.start_load(plugin)
+        self.wait_load()
+
+    def start_load(self, plugin: HostPlugin):
+        if plugin.name in self._plugins:
+            # Already loaded
+            return
+        self._conn.call_noreply("start_load", plugin)
+        self._plugins[plugin.name] = None
+
+    def wait_load(self):
+        for name, value in self._conn.call("wait_load").items():
+            if value is None:
+                value = _PluginProxy(name, self._active_conn)
+            self._plugins[name] = value
+
+    @property
+    def _conn(self):
+        if self._active_conn is None:
+            self._active_conn = rpc.client_unix_socket(
+                self._path, timeout=self._timeout, name=self._name
+            )
+        return self._active_conn
+
+    def __getattr__(self, name):
+        if name not in self._plugins:
+            raise AttributeError(name)
+        return self._plugins[name]
+
+    def close(self):
+        self._plugins = {}
+        if self._active_conn is not None:
+            self._active_conn.close()
+            self._active_conn = None
+
+
+class _PluginProxy:
+    """
+    Host-side proxy for a plugin: RPC calls
+    """
+
+    def __init__(self, name, conn):
+        self._name = name
+        self._conn = conn
+
+    def __call__(self, *a, **kw):
+        return self._conn.call("call_plugin", self._name, "__call__", *a, **kw)
+
+    def __getattr__(self, name):
+        if name.startswith("_"):
+            raise AttributeError(name)
+        return lambda *a, **kw: self._conn.call(
+            "call_plugin", self._name, name, *a, **kw
+        )
+
+
+class Implementation:
+    """
+    VM-side main instance: setup/teardown plugins, plugin RPC server side
+    """
+
+    def __init__(self):
+        self.plugins = {}
+        self.plugin_order = []
+        self.load_error = False
+
+    def start_load(self, plugin):
+        try:
+            log.info(f"Plugin {plugin.name} load")
+            plugin.setup(self)
+        except:
+            self.load_error = True
+            raise
+        self.plugins[plugin.name] = plugin
+        self.plugin_order.append(plugin.name)
+        log.info(f"Plugin {plugin.name} ready")
+
+    def wait_load(self):
+        if self.load_error:
+            raise RuntimeError("load failed")
+        log.debug(f"Plugins ready")
+        return {p.name: getattr(p, "value", None) for p in self.plugins.values()}
+
+    def unload(self, name):
+        self.plugin_order.remove(name)
+        p = self.plugins.pop(name)
+        method = getattr(p, "teardown", None)
+        if method is not None:
+            try:
+                method()
+            except BaseException as exc:
+                log.error(f"plugin teardown error: {exc}")
+
+    def call_plugin(self, name, method, *a, **kw):
+        return getattr(self.plugins[name], method)(*a, **kw)
+
+    def teardown(self):
+        while self.plugin_order:
+            self.unload(self.plugin_order[-1])
+
+
+def _find_rpc_vport():
+    """
+    Find RPC control virtio port
+    """
+    for port in Path("/sys/class/virtio-ports").iterdir():
+        with open(port / "name", "rb") as f:
+            name = f.read(64)
+            if name == b"bluez-func-test-rpc\n":
+                return f"/dev/{port.name}"
+
+    return None
+
+
+def _main_runner_instance():
+    """
+    VM-side tester main instance
+    """
+    dev = _find_rpc_vport()
+    if dev is not None:
+        print(f"Test RPC server on {dev}", file=sys.stderr)
+        rpc.server_file(dev, Implementation())
+        return
+
+    import termios
+    import tty
+
+    with open(sys.argv[1], "r+b", buffering=0) as f:
+        mode = termios.tcgetattr(f.fileno())
+        tty.cfmakeraw(mode)
+        mode = termios.tcsetattr(f.fileno(), termios.TCSANOW, mode)
+        rpc.server_stream(f, Implementation())
+
+
+class _RunnerLogHandler(logging.Handler):
+    def flush(self):
+        sys.stderr.flush()
+
+    def emit(self, record):
+        try:
+            msg = record.getMessage()
+            if record.exc_info:
+                msg += "\n"
+                msg += traceback.format_exception(*record.exc_info)
+            name = record.name
+            levelno = record.levelno
+            for line in msg.splitlines():
+                sys.stderr.write(f"\x00{name}\x01{levelno}\x02{line}\n")
+            self.flush()
+        except RecursionError:
+            raise
+        except Exception:
+            self.handleError(record)
+
+
+def _main_runner():
+    """
+    VM-side tester supervisor
+    """
+    logging.basicConfig(level=0, handlers=[_RunnerLogHandler()])
+
+    # Preload libraries
+    import dbus
+    import pexpect
+
+    # Keep one instance running
+    while True:
+        log.info("Starting test instance")
+
+        pid = os.fork()
+        if pid == 0:
+            os.setpgid(0, 0)
+            _main_runner_instance()
+            os._exit(0)
+        else:
+            status = 1
+
+            try:
+                _, status = os.waitpid(pid, 0)
+            except ChildProcessError:
+                pass
+
+            log.info("Terminating test instance")
+
+            for sig in [signal.SIGTERM, signal.SIGCONT, signal.SIGKILL]:
+                try:
+                    os.kill(-pid, sig)
+                    time.sleep(0.5 if sig == signal.SIGCONT else 0.1)
+                except ProcessLookupError:
+                    break
+
+            if status != 0:
+                time.sleep(0.1)
+
+
+ENV_INDEX = -1
+
+
+class Environment:
+    def __init__(self, kernel, num_hosts, usb_indices=None, virtio=True, timeout=20):
+        if Path(kernel).is_dir():
+            self.kernel = str(Path(kernel) / "arch" / "x86" / "boot" / "bzImage")
+        else:
+            self.kernel = str(kernel)
+
+        self.num_hosts = operator.index(num_hosts)
+        self.jobs = []
+        self.log_streams = []
+        self.hosts = []
+        self.virtio = bool(virtio)
+        self.timeout = float(timeout)
+        self.path = None
+
+        if usb_indices is None:
+            self.usb_indices = None
+        elif usb_indices is not None and self.num_hosts <= len(usb_indices):
+            self.usb_indices = tuple(usb_indices)
+        else:
+            raise ValueError(
+                "USB redirection enabled, but not enough controllers for each host"
+            )
+
+        if sys.version_info >= (3, 12):
+            self.runner = [sys.executable, "-P"]
+        else:
+            self.runner = [sys.executable]
+        self.runner += [str((Path(__file__).parent / "runner.py").absolute())]
+
+        try:
+            self.stdbuf = [utils.find_exe("", "stdbuf"), "-o", "L", "-e", "L"]
+        except FileNotFoundError:
+            self.stdbuf = []
+
+    def start(self):
+        self.path = Path(tempfile.mkdtemp(prefix="bluez-func-test-"))
+
+        if self.usb_indices is None:
+            args = self._start_btvirt()
+        else:
+            args = self._start_usb()
+
+        paths, names = self._start_runners(args)
+        self._start_hosts(paths, names)
+
+    def stop(self):
+        for job in self.jobs:
+            if job.poll() is not None:
+                continue
+            job.terminate()
+
+        while self.jobs:
+            job = self.jobs.pop()
+            if job.poll() is None:
+                job.wait()
+
+        while self.log_streams:
+            self.log_streams.pop().close()
+
+        while self.hosts:
+            self.hosts.pop().close()
+
+        # Clean up tmpdir (btvirt, own sockets, rmdir)
+        if self.path is not None:
+            for f in list(self.path.iterdir()):
+                if f.name.startswith("bt-server-"):
+                    f.unlink()
+                if f.name.startswith("bluez-func-test-rpc-"):
+                    f.unlink()
+
+            self.path.rmdir()
+            self.path = None
+
+    def _add_log(self, *a, **kw):
+        f = utils.LogStream(*a, **kw)
+        self.log_streams.append(f)
+        return f.stream
+
+    def _start_btvirt(self):
+        exe = utils.find_exe("emulator", "btvirt")
+        logger = self._add_log("btvirt")
+
+        cmd = self.stdbuf + [exe, f"--server={self.path}"]
+        log.info("Starting btvirt: {}".format(utils.quoted(cmd)))
+
+        job = Popen(
+            cmd,
+            stdout=logger,
+            stderr=logger,
+            stdin=DEVNULL,
+        )
+        self.jobs.append(job)
+
+        socket = self.path / "bt-server-bredrle"
+        utils.wait_files([job], [socket])
+        return [[f"-u{socket}"]] * self.num_hosts
+
+    @classmethod
+    def check_controller(cls, name):
+        subsys = Path("/sys/class/bluetooth") / name / "device" / "subsystem"
+        if subsys.resolve() != Path("/sys/bus/usb"):
+            raise ValueError(f"{devname} is not an USB device")
+
+        devpath = Path(f"/sys/class/bluetooth/{name}/device/../")
+        with open(devpath / "busnum", "r") as f:
+            busnum = "{:03}".format(int(f.read().strip()))
+        with open(devpath / "devnum", "r") as f:
+            devnum = "{:03}".format(int(f.read().strip()))
+
+        devname = f"/dev/bus/usb/{busnum}/{devnum}"
+        if not Path(devname).exists():
+            raise ValueError(f"{devname} does not exist")
+
+        try:
+            with open(devname, "wb") as f:
+                pass
+        except IOError:
+            user = pwd.getpwuid(os.getuid()).pw_name.strip()
+            message = (
+                f"error: cannot open {devname} for {name} USB redirection. "
+                f"Run: 'sudo setfacl -m user:{user}:rw- {devname}' "
+                f"to grant the permission"
+            )
+            raise ValueError(message)
+
+        return busnum, devnum
+
+    def _start_usb(self):
+        args = []
+
+        for index in self.usb_indices[: self.num_hosts]:
+            busnum, devnum = self.check_controller(index)
+            args.append(["-U", f"usb-host,hostbus={busnum},hostaddr={devnum}"])
+
+        return args
+
+    def _start_runners(self, args):
+        global ENV_INDEX
+
+        test_runner = utils.find_exe("tools", "test-runner")
+
+        socket_paths = []
+        host_names = []
+
+        ENV_INDEX += 1
+
+        for idx, arg in enumerate(args):
+            socket_path = str(self.path / f"bluez-func-test-rpc-{idx}")
+            socket_paths.append(socket_path)
+
+            qemu_args = [
+                "-chardev",
+                f"socket,id=ser0,path={socket_path},server=on,wait=off",
+            ]
+            if self.virtio:
+                qemu_args += [
+                    "-device",
+                    "virtio-serial",
+                    "-device",
+                    "virtserialport,chardev=ser0,name=bluez-func-test-rpc",
+                ]
+            else:
+                qemu_args += [
+                    "-device",
+                    "pci-serial,chardev=ser0",
+                ]
+
+            extra_args = []
+            for q in qemu_args:
+                extra_args += ["-o", q]
+
+            extra_args += ["-H"]
+
+            tty = 1
+            if self.usb_indices is None:
+                tty += 1
+
+            cmd = (
+                [test_runner, f"--kernel={self.kernel}"]
+                + arg
+                + extra_args
+                + ["--"]
+                + self.runner
+                + [f"/dev/ttyS{tty}"]
+            )
+
+            log.info("Starting host: {}".format(utils.quoted(cmd)))
+
+            host_names.append(f"host.{ENV_INDEX}.{idx}")
+
+            logger = self._add_log(
+                host_names[-1],
+                pattern=".*\x00([^\x00-\x03]+)\x01([^\x00-\x03]+)\x02",
+            )
+            self.jobs.append(Popen(cmd, stdout=logger, stderr=logger, stdin=DEVNULL))
+
+        utils.wait_files(self.jobs, socket_paths)
+        return socket_paths, host_names
+
+    def _start_hosts(self, socket_paths, host_names):
+        if len(socket_paths) != self.num_hosts:
+            raise RuntimeError("Wrong number of sockets")
+
+        for path, name in zip(socket_paths, host_names):
+            host = HostProxy(path, timeout=self.timeout, name=name)
+            host._conn
+            self.hosts.append(host)
+
+    def __del__(self):
+        self.stop()
+
+    def __enter__(self):
+        try:
+            self.start()
+        except:
+            self.stop()
+            raise
+        return self
+
+    def __exit__(self, type, value, tb):
+        self.stop()
diff --git a/unit/func_test/lib/host_plugins.py b/unit/func_test/lib/host_plugins.py
new file mode 100644
index 000000000..bb6a451ab
--- /dev/null
+++ b/unit/func_test/lib/host_plugins.py
@@ -0,0 +1,269 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+"""
+Fixtures for testing
+"""
+import os
+import sys
+import subprocess
+import collections
+import logging
+import tempfile
+import time
+import shutil
+from pathlib import Path
+
+import pytest
+import pexpect
+
+from . import env, utils
+
+__all__ = ["host_config", "Bdaddr", "Call", "Bluetoothd", "Bluetoothctl", "DbusSession"]
+
+
+log = logging.getLogger(__name__)
+
+
+class Bdaddr(env.HostPlugin):
+    name = "bdaddr"
+
+    def setup(self, impl):
+        self.value = utils.get_bdaddr()
+
+
+class Call(env.HostPlugin):
+    name = "call"
+
+    def __call__(self, func, *a, **kw):
+        return func(*a, **kw)
+
+
+class _Dbus(env.HostPlugin):
+    def __init__(self):
+        self.exe = utils.find_exe("", "dbus-daemon")
+
+    def setup(self, impl):
+        self.logger = utils.LogStream(self.name)
+
+        self.tmpdir = tempfile.TemporaryDirectory(prefix=f"{self.name}-", dir="/run")
+        self.config = Path(self.tmpdir.name) / "config.xml"
+
+        socket = (Path(self.tmpdir.name) / "socket").resolve()
+        self.address = "unix:path={}".format(socket)
+
+        with open(self.config, "w") as f:
+            text = f"""
+            <!DOCTYPE busconfig PUBLIC
+                    "-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN"
+                    "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
+            <busconfig>
+            <type>{self.dbus_type}</type>
+            <listen>{self.address}</listen>
+            <policy context="default">
+            <allow user="*"/>
+            <allow own="*"/>
+            <allow send_type="method_call"/>
+            <allow send_type="signal"/>
+            <allow send_type="method_return"/>
+            <allow send_type="error"/>
+            <allow receive_type="method_call"/>
+            <allow receive_type="signal"/>
+            <allow receive_type="method_return"/>
+            <allow receive_type="error"/>
+            </policy>
+            </busconfig>
+            """
+            f.write(text)
+
+        cmd = [
+            self.exe,
+            "--nofork",
+            "--nopidfile",
+            "--nosyslog",
+            f"--config-file={self.config}",
+        ]
+
+        self.logger.log.debug(
+            "Starting dbus-session @ {}: {}".format(self.address, utils.quoted(cmd))
+        )
+
+        self.job = subprocess.Popen(
+            cmd,
+            stdout=self.logger.stream,
+            stderr=subprocess.STDOUT,
+        )
+        utils.wait_files([self.job], [socket])
+        self.logger.log.debug("dbus-session ready")
+
+        if self.dbus_type == "system":
+            os.environ["DBUS_SYSTEM_BUS_ADDRESS"] = self.address
+        elif self.dbus_type == "session":
+            os.environ["DBUS_SESSION_BUS_ADDRESS"] = self.address
+
+    def teardown(self):
+        self.job.terminate()
+        self.job.wait()
+        self.tmpdir.cleanup()
+
+
+class DbusSystem(_Dbus):
+    name = "dbus-system"
+    dbus_type = "system"
+
+
+class DbusSession(_Dbus):
+    name = "dbus-session"
+    dbus_type = "session"
+
+
+class Bluetoothd(env.HostPlugin):
+    name = "bluetoothd"
+    depends = [DbusSystem()]
+
+    def __init__(self, debug=True, conf=None, args=()):
+        self.conf = conf
+        self.args = tuple(args)
+        if debug and "-d" not in self.args:
+            self.args += ("-d",)
+
+    def setup(self, impl):
+        import dbus
+
+        exe = utils.find_exe("src", "bluetoothd")
+
+        self.tmpdir = tempfile.TemporaryDirectory(prefix="bluetoothd-state-")
+        state_dir = Path(self.tmpdir.name) / "state"
+        conf = Path(self.tmpdir.name) / "main.conf"
+
+        state_dir.mkdir()
+
+        if self.conf is None:
+            shutil.copyfile(utils.SRC_DIR / "src" / "main.conf", conf)
+        else:
+            with open(str(conf), "w") as f:
+                f.write(self.conf)
+
+        envvars = dict(os.environ)
+        envvars["STATE_DIRECTORY"] = str(state_dir)
+
+        cmd = [exe, "--nodetach", "-f", str(conf)] + list(self.args)
+
+        log.info("Start bluetoothd: {}".format(utils.quoted(cmd)))
+
+        self.logger = utils.LogStream("bluetoothd")
+        self.job = subprocess.Popen(
+            cmd,
+            env=envvars,
+            stdin=subprocess.DEVNULL,
+            stdout=self.logger.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+        # Wait for the adapter to appear powered
+        bus = dbus.SystemBus()
+        while True:
+            try:
+                adapter = dbus.Interface(
+                    bus.get_object("org.bluez", "/org/bluez/hci0"),
+                    "org.freedesktop.DBus.Properties",
+                )
+                if adapter.Get("org.bluez.Adapter1", "Powered"):
+                    break
+            except dbus.DBusException:
+                pass
+            time.sleep(0.5)
+
+        log.info("Bluetoothd ready")
+
+    def teardown(self):
+        log.info("Stop bluetoothd")
+        self.job.terminate()
+        self.job.wait()
+        self.tmpdir.cleanup()
+
+
+class Bluetoothctl(env.HostPlugin):
+    name = "bluetoothctl"
+    depends = [Bluetoothd()]
+
+    def __init__(self):
+        self.exe = utils.find_exe("client", "bluetoothctl")
+
+    def setup(self, impl):
+        self.logger = utils.LogStream("bluetoothctl")
+        self.ctl = pexpect.spawn(self.exe, logfile=self.logger.stream)
+
+    def teardown(self):
+        self.ctl.terminate()
+        self.ctl.wait()
+
+    def expect(self, *a, **kw):
+        ret = self.ctl.expect(*a, **kw)
+        log.debug("pexpect: found")
+        return ret, self.ctl.match.groups()
+
+    def expect_prompt(self):
+        prompt = "\\[[a-zA-Z0-9. -]+\\]>"
+        return self.expect(prompt)
+
+    def send(self, *a, **kw):
+        return self.ctl.send(*a, **kw)
+
+
+HOST_SETUPS = {}
+
+
+def _expand_plugins(plugins):
+    """
+    Resolve plugin dependencies to linear load order
+    """
+    plugins = [Bdaddr(), Call()] + list(plugins)
+    to_load = []
+    seen = set()
+
+    while plugins:
+        deps = []
+        for dep in plugins[0].depends or ():
+            if type(dep) not in seen:
+                deps.append(dep)
+                seen.add(type(dep))
+                continue
+
+        if deps:
+            plugins = deps + plugins
+            continue
+
+        to_load.append(plugins.pop(0))
+
+    return tuple(to_load)
+
+
+def host_config(*host_setup, hw=False):
+    """
+    Declare host configuration.
+
+    - *host_setup: each argument is a list of plugins to be loaded on a host.
+      The number of arguments specifies the number of hosts.
+
+    - hw (bool): whether to require hardware BT controller
+
+    """
+    setup = tuple(_expand_plugins(plugins) for plugins in host_setup)
+
+    host_setup = dict(setup=setup)
+    vm_setup = dict(num_hosts=len(setup), hw=hw)
+
+    vm_setup_name = "vm{}{}".format(len(setup), "hw" if hw else "")
+
+    idx = HOST_SETUPS.setdefault(tuple(sorted(host_setup.items())), len(HOST_SETUPS))
+    host_setup_name = f"hosts{idx}"
+
+    def decorator(func):
+        func = pytest.mark.parametrize(
+            "host_setup", [host_setup], indirect=True, ids=[host_setup_name]
+        )(func)
+        func = pytest.mark.parametrize(
+            "vm_setup", [vm_setup], indirect=True, ids=[vm_setup_name]
+        )(func)
+        return func
+
+    return decorator
diff --git a/unit/func_test/lib/rpc.py b/unit/func_test/lib/rpc.py
new file mode 100644
index 000000000..159c42ef5
--- /dev/null
+++ b/unit/func_test/lib/rpc.py
@@ -0,0 +1,293 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+"""
+Simple RPC over sockets / character devices
+
+"""
+import sys
+import os
+import struct
+import socket
+import fcntl
+import select
+import time
+import pickle
+import logging
+import traceback
+from pathlib import Path
+
+log = logging.getLogger("rpc")
+
+__all__ = [
+    "Connection",
+    "RemoteError",
+    "server_stream",
+    "server_file",
+    "server_unix_socket",
+    "client_unix_socket",
+]
+
+
+class RemoteError(Exception):
+    def __init__(self, exc, traceback):
+        super().__init__(str(exc))
+        self.exc = exc
+        self.traceback = traceback
+
+    def __str__(self):
+        tb = "    ".join(self.traceback)
+        return f"{self.exc}\nRemote traceback:\n    {tb}"
+
+
+def server_stream(stream, implementation):
+    """
+    Run client side on the given stream.
+
+    Parameters
+    ----------
+    stream : file
+        Stream to use for I/O
+    implementation : object
+        Object on which remote methods are called
+
+    """
+    conn = _Connection(stream, None)
+
+    conn._flush()
+    conn._send("hello")
+
+    while True:
+        sys.stdout.flush()
+        msg = conn._recv()
+        message = msg["message"]
+
+        if message in ("call", "call-noreply"):
+            log.info(f"server: {msg['method']} {msg['a']} {msg['kw']}")
+            try:
+                method = getattr(implementation, msg["method"])
+                result = method(*msg["a"], **msg["kw"])
+                if message == "call":
+                    conn._send("call:reply", result=result)
+            except BaseException as exc:
+                if message == "call":
+                    conn._send(
+                        "call:reply",
+                        error=exc,
+                        traceback=traceback.format_exception(exc),
+                    )
+                else:
+                    log.error(traceback.format_exc())
+            log.debug("server: done")
+        elif message == "quit":
+            method = getattr(implementation, "teardown", None)
+            if method is not None:
+                try:
+                    method()
+                except BaseException as exc:
+                    log.error(f"implementation quit() failed: {exc}")
+
+            log.info(f"server: quit")
+            return
+        else:
+            raise RuntimeError(f"unknown {message=}")
+
+
+def server_file(filename, implementation):
+    """Open given file and run server on it"""
+    with open(filename, "r+b", buffering=0) as stream:
+        server_stream(stream, implementation)
+
+
+def server_unix_socket(socket_path, implementation):
+    """Open given file and run server on it"""
+    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
+        sock.bind(str(socket_path))
+        sock.listen(1)
+
+        s, addr = sock.accept()
+        try:
+            server_stream(s, implementation)
+        finally:
+            s.close()
+
+
+def client_unix_socket(socket_path, timeout=10, name=None):
+    """
+    Connect client to Unix socket
+
+    Parameters
+    ----------
+    socket_path : str
+        Path to Unix socket to bind to and listen
+    proxy_cls : type
+        Proxy class to make instance of
+
+    Returns
+    -------
+    conn : Connection
+        Client connection object
+
+    """
+    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+
+    end = time.time() + timeout
+    while time.time() < end:
+        try:
+            sock.connect(str(socket_path))
+            break
+        except (FileNotFoundError, ConnectionRefusedError, OSError):
+            time.sleep(max(0, min(0.5, end - time.time())))
+    else:
+        sock.connect(str(socket_path))
+
+    conn = _Connection(sock, timeout, name=name)
+
+    reply = conn._recv()
+    if reply["message"] != "hello":
+        raise RuntimeError("Bad hello message")
+
+    return conn
+
+
+class _Connection:
+    """
+    Bidirectional message queue on a stream, pickle-based
+    """
+
+    def __init__(self, stream, timeout, name=None):
+        fd = stream.fileno()
+        flags = fcntl.fcntl(fd, fcntl.F_GETFL)
+        fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
+
+        self.stream = stream
+        self.timeout = timeout
+
+        if name is None:
+            self.log = log
+        else:
+            self.log = logging.getLogger(f"rpc.{name}")
+
+    def _do_recv(self, size):
+        recv = getattr(self.stream, "recv", None) or self.stream.read
+        try:
+            return recv(size)
+        except BlockingIOError:
+            return None
+
+    def _do_send(self, data):
+        send = getattr(self.stream, "send", None) or self.stream.write
+        try:
+            return send(data)
+        except BlockingIOError:
+            return 0
+
+    def _flush(self):
+        while self._do_recv(8192):
+            pass
+
+    def _recvall(self, size, timeout=None):
+        if timeout is None:
+            timeout = self.timeout
+        if timeout is not None:
+            end = time.time() + timeout
+
+        data = b""
+        while len(data) < size:
+            if timeout is not None:
+                dt = end - time.time()
+                if dt <= 0:
+                    raise TimeoutError("Connection recv timed out")
+            else:
+                dt = None
+
+            r, w, x = select.select([self.stream], [], [self.stream], dt)
+
+            if x:
+                raise IOError("Connection failed")
+            elif not r:
+                continue
+
+            s = self._do_recv(size - len(data))
+            if not s:
+                raise IOError("Connection has no data")
+
+            data += s
+
+        return data
+
+    def _sendall(self, data, timeout=None):
+        if timeout is None:
+            timeout = self.timeout
+        if timeout is not None:
+            end = time.time() + timeout
+
+        while data:
+            if timeout is not None:
+                dt = end - time.time()
+                if dt <= 0:
+                    raise TimeoutError("Connection send timed out")
+            else:
+                dt = None
+
+            r, w, x = select.select([], [self.stream], [self.stream], dt)
+
+            if x:
+                raise IOError("Connection failed")
+            elif not w:
+                continue
+
+            size = self._do_send(data)
+            if not size:
+                continue
+
+            data = data[size:]
+
+    def _recv(self, timeout=None):
+        (size,) = struct.unpack("<Q", self._recvall(8, timeout=timeout))
+        if size > 2**24:
+            raise ValueError("Invalid size")
+        data = self._recvall(size, timeout=timeout)
+        return pickle.loads(data)
+
+    def _send(self, message, timeout=None, **kw):
+        data = pickle.dumps(
+            dict(message=message, **kw), protocol=pickle.HIGHEST_PROTOCOL
+        )
+        size = struct.pack("<Q", len(data))
+        self._sendall(size + data, timeout=timeout)
+
+    def call_noreply(self, method, *a, **kw):
+        self.log.info(f"client: {method} {a} {kw}")
+
+        timeout = kw.pop("timeout", None)
+
+        self._send("call-noreply", method=str(method), a=a, kw=kw, timeout=timeout)
+
+    def call(self, method, *a, **kw):
+        self.log.info(f"client: {method} {a} {kw}")
+
+        timeout = kw.pop("timeout", None)
+
+        self._send("call", method=str(method), a=a, kw=kw, timeout=timeout)
+        reply = self._recv(timeout=timeout)
+        if reply["message"] != "call:reply":
+            raise RuntimeError("Invalid reply")
+
+        if reply.get("error"):
+            raise RemoteError(reply["error"], reply["traceback"])
+
+        self.log.debug(f"client-reply")
+        return reply["result"]
+
+    def close(self):
+        try:
+            self._send("quit")
+        except BrokenPipeError:
+            pass
+
+        self.stream.close()
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, type, value, tb):
+        self.close()
diff --git a/unit/func_test/lib/runner.py b/unit/func_test/lib/runner.py
new file mode 100644
index 000000000..bbfb00c12
--- /dev/null
+++ b/unit/func_test/lib/runner.py
@@ -0,0 +1,10 @@
+#!/usr/bin/python3 -P
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+import sys
+from pathlib import Path
+
+sys.path.insert(0, str(Path(__file__).parent / ".." / ".."))
+
+import func_test.lib.env
+
+sys.exit(func_test.lib.env._main_runner())
diff --git a/unit/func_test/lib/tests/__init__.py b/unit/func_test/lib/tests/__init__.py
new file mode 100644
index 000000000..e69de29bb
diff --git a/unit/func_test/lib/tests/test_rpc.py b/unit/func_test/lib/tests/test_rpc.py
new file mode 100644
index 000000000..3a7786bd7
--- /dev/null
+++ b/unit/func_test/lib/tests/test_rpc.py
@@ -0,0 +1,49 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+import os
+import pytest
+import subprocess
+import threading
+
+from func_test.lib import rpc
+
+
+def test_basic(tmp_path):
+
+    def impl_1(text):
+        print("pid", os.getpid())
+        return f"1: got {text}"
+
+    class Impl2:
+        def method(self, text):
+            print("pid", os.getpid())
+            return f"2: got {text}"
+
+        def error(self):
+            raise FloatingPointError("test")
+
+    socket_1 = tmp_path / "socket.1"
+    socket_2 = tmp_path / "socket.2"
+
+    def server_1():
+        rpc.server_unix_socket(socket_1, impl_1)
+
+    def server_2():
+        rpc.server_unix_socket(socket_2, Impl2())
+
+    s_1 = threading.Thread(target=server_1)
+    s_2 = threading.Thread(target=server_2)
+
+    s_1.start()
+    s_2.start()
+
+    try:
+        with rpc.client_unix_socket(socket_1) as c_1, rpc.client_unix_socket(
+            socket_2
+        ) as c_2:
+            assert c_1.call("__call__", "hello 1") == "1: got hello 1"
+            assert c_2.call("method", "hello 2") == "2: got hello 2"
+            with pytest.raises(rpc.RemoteError, match="Remote traceback"):
+                c_2.call("error")
+    finally:
+        s_1.join()
+        s_2.join()
diff --git a/unit/func_test/lib/utils.py b/unit/func_test/lib/utils.py
new file mode 100644
index 000000000..3d50b1fce
--- /dev/null
+++ b/unit/func_test/lib/utils.py
@@ -0,0 +1,266 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+"""
+Utilities for end-to-end testing.
+
+"""
+import os
+import io
+import re
+import logging
+import subprocess
+import shlex
+import shutil
+import threading
+import time
+from pathlib import Path
+
+__all__ = ["run", "find_exe", "get_bdaddr", "quoted", "LogStream"]
+
+
+SRC_DIR = (Path(__file__).parent / ".." / ".." / "..").absolute()
+BUILD_DIR = None
+
+_LOG_LOCK = threading.Lock()
+
+log = logging.getLogger(f"run")
+
+OUT = 5
+logging.addLevelName(OUT, "OUT")
+
+
+def find_exe(subdir, name):
+    """
+    Find executable, either in BlueZ build tree or system
+    """
+    paths = [
+        SRC_DIR / "builddir" / subdir / name,
+        SRC_DIR / "build" / subdir / name,
+        SRC_DIR / subdir / name,
+        shutil.which(name),
+    ]
+    if BUILD_DIR is not None:
+        paths.insert(0, BUILD_DIR / subdir / name)
+    for exe in paths:
+        exe = str(exe)
+        if exe and os.path.isfile(exe):
+            return os.path.normpath(exe)
+
+    raise FileNotFoundError(name)
+
+
+def run(*args, input=None, capture_output=False, timeout=None, check=False, **kwargs):
+    """
+    Same as subprocess.run() but log output while running.
+    """
+    if input is not None:
+        if kwargs.get("stdin") is not None:
+            raise ValueError("stdin and input arguments may not both be used.")
+        kwargs["stdin"] = subprocess.PIPE
+
+    if capture_output:
+        if kwargs.get("stdout") is not None or kwargs.get("stderr") is not None:
+            raise ValueError(
+                "stdout and stderr arguments may not be used " "with capture_output."
+            )
+        kwargs["stdout"] = subprocess.PIPE
+        kwargs["stderr"] = subprocess.PIPE
+
+    stdout = kwargs.get("stdout", None)
+    stderr = kwargs.get("stderr", None)
+    encoding = kwargs.pop("encoding", None)
+    errors = kwargs.pop("errors", "strict")
+
+    stdout_buf = None
+    stderr_buf = None
+
+    if stdout == subprocess.PIPE:
+        stdout = stdout_buf = io.BytesIO()
+    elif isinstance(stdout, int):
+        stdout = None
+
+    stdout_log = LogStream("run.out", tee=stdout)
+    kwargs["stdout"] = stdout_log.stream
+
+    if stderr == subprocess.STDOUT:
+        stderr_log = None
+    else:
+        if stderr == subprocess.PIPE:
+            stderr = stderr_buf = io.BytesIO()
+        elif isinstance(stderr, int):
+            stderr = None
+
+        stderr_log = LogStream("run.err", tee=stderr)
+        kwargs["stderr"] = stderr_log.stream
+
+    log.info("    $ {}".format(quoted(args[0])))
+
+    with subprocess.Popen(*args, **kwargs) as process:
+        try:
+            stdout, stderr = process.communicate(input, timeout=timeout)
+        except subprocess.TimeoutExpired:
+            process.kill()
+            process.wait()
+        except:
+            process.kill()
+            raise
+        finally:
+            stdout_log.close()
+            if stderr_log is not None:
+                stderr_log.close()
+
+        if stdout_buf is not None:
+            stdout = stdout_buf.getvalue()
+            if encoding not in ("bytes", None):
+                stdout = stdout.decode(encoding=encoding, errors=errors)
+
+        if stderr_buf is not None:
+            stderr = stderr_buf.getvalue()
+            if encoding not in ("bytes", None):
+                stderr = stderr.decode(encoding=encoding, errors=errors)
+
+        retcode = process.poll()
+        if check and retcode:
+            raise subprocess.CalledProcessError(
+                retcode, process.args, output=stdout, stderr=stderr
+            )
+
+    log.info(f"(return code {retcode})")
+
+    return subprocess.CompletedProcess(process.args, retcode, stdout, stderr)
+
+
+def wait_files(jobs, paths, timeout=2):
+    """
+    Wait for subprocess.Popen instances until `paths` have been created.
+    """
+    start = time.time()
+
+    for path in paths:
+        while True:
+            if time.time() > start + timeout:
+                raise TimeoutError(f"Jobs {jobs} timed out")
+            for job in jobs:
+                if job.poll() is not None:
+                    raise RuntimeError("Process exited unexpectedly")
+            try:
+                if os.stat(path):
+                    break
+            except OSError:
+                time.sleep(0.25)
+
+
+def get_bdaddr(index=0):
+    """
+    Get bdaddr of controller with given index
+    """
+    btmgmt = find_exe("tools", "btmgmt")
+    res = subprocess.run(
+        [btmgmt, "--index", str(index), "info"],
+        stdout=subprocess.PIPE,
+        check=True,
+        encoding="utf-8",
+    )
+    m = re.search("addr ([A-Z0-9:]+) ", res.stdout)
+    if not m:
+        hciconfig = find_exe("tools", "hciconfig")
+        res = subprocess.run(
+            [hciconfig, f"hci{index}"],
+            stdout=subprocess.PIPE,
+            check=True,
+            encoding="utf-8",
+        )
+        m = re.search("BD Address: ([A-Z0-9:]+)", res.stdout)
+        if not m:
+            raise ValueError("Can't find bdaddr")
+
+    return m.group(1).lower()
+
+
+def quoted(args):
+    """
+    Quote shell command
+    """
+    return " ".join(shlex.quote(arg) for arg in args)
+
+
+class LogStream:
+    """
+    Logger that forwards input from a stream to logging, and
+    optionally tees to another stream.  The input pipe is in
+    `LogStream.stream`.
+
+    """
+
+    def __init__(self, name, pattern=None, tee=None):
+        if pattern is not None:
+            self._logger_pattern = (pattern, name)
+            self.log = None
+        else:
+            self._logger_pattern = None
+            self.log = logging.getLogger(name)
+        self._ifd, self._ofd = os.pipe()
+        self.stream = os.fdopen(self._ofd, "wb", buffering=0)
+        self._pipeout = os.fdopen(self._ifd, "rb")
+        self._tee = tee
+        self._thread = threading.Thread(target=self._run)
+        self._thread.start()
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        self.close()
+
+    def _run(self):
+        while True:
+            line = self._pipeout.readline()
+            if not line:
+                break
+
+            fmt_line = line.decode(errors="surrogateescape")
+            fmt_line = self._filter(fmt_line)
+
+            with _LOG_LOCK:
+                log = self.log
+                level = OUT
+                if log is None:
+                    m = re.match(self._logger_pattern[0], fmt_line)
+                    if m:
+                        name = "{}.{}".format(self._logger_pattern[1], m.group(1))
+                        fmt_line = fmt_line[: m.start()] + fmt_line[m.end() :]
+                        try:
+                            level = int(m.group(2))
+                        except ValueError:
+                            pass
+                    else:
+                        name = self._logger_pattern[1]
+                    log = logging.getLogger(name)
+
+                log.log(level, fmt_line)
+
+                if self._tee is not None:
+                    self._tee.write(line)
+
+        self._pipeout.close()
+
+    def _filter(self, text):
+        # Filter out problematic ANSI codes etc
+        text = re.sub(r"\u001b\[=[0-9]+[hl]", r"", text)
+        text = re.sub(r"\u001b\[\?7l", r"", text)
+        text = re.sub(r"\u001b\[2J", r"", text)
+        text = re.sub(r"\u001bc", r"", text)
+        text = text.replace("\r", "")
+        text = text.rstrip("\n")
+        return text
+
+    def error(self, *a, **kw):
+        pass
+
+    def close(self):
+        if self._thread is not None:
+            self.stream.close()
+            self._thread.join()
+            self._thread = None
+
+    def __del__(self):
+        self.close()
diff --git a/unit/func_test/requirements.txt b/unit/func_test/requirements.txt
new file mode 100644
index 000000000..2ebe77723
--- /dev/null
+++ b/unit/func_test/requirements.txt
@@ -0,0 +1,3 @@
+pytest
+pexpect
+dbus-python
diff --git a/unit/func_test/test_bluetoothctl_vm.py b/unit/func_test/test_bluetoothctl_vm.py
new file mode 100644
index 000000000..e5bf3807a
--- /dev/null
+++ b/unit/func_test/test_bluetoothctl_vm.py
@@ -0,0 +1,76 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+"""
+Tests for bluetoothctl using VM instances
+"""
+import sys
+import pytest
+import subprocess
+import tempfile
+
+from .lib import host_config, find_exe, run, Bluetoothd, Bluetoothctl
+
+pytestmark = [pytest.mark.vm]
+
+bluetoothctl = find_exe("client", "bluetoothctl")
+
+
+@host_config(
+    [Bluetoothctl()],
+    [Bluetoothctl()],
+)
+def test_bluetoothctl_pair(hosts):
+    host0, host1 = hosts
+
+    host0.bluetoothctl.send("show\n")
+    host0.bluetoothctl.expect("Powered: yes")
+
+    host1.bluetoothctl.send("show\n")
+    host1.bluetoothctl.expect("Powered: yes")
+
+    host0.bluetoothctl.send("scan on\n")
+    host0.bluetoothctl.expect(f"Controller {host0.bdaddr.upper()} Discovering: yes")
+
+    host1.bluetoothctl.send("pairable on\n")
+    host1.bluetoothctl.expect("Changing pairable on succeeded")
+    host1.bluetoothctl.send("discoverable on\n")
+    host1.bluetoothctl.expect(f"Controller {host1.bdaddr.upper()} Discoverable: yes")
+
+    host0.bluetoothctl.expect(f"Device {host1.bdaddr.upper()}")
+    host0.bluetoothctl.send(f"pair {host1.bdaddr}\n")
+
+    idx, m = host0.bluetoothctl.expect(r"Confirm passkey (\d+).*:")
+    key = m[0].decode("utf-8")
+
+    host1.bluetoothctl.expect(f"Confirm passkey {key}")
+
+    host0.bluetoothctl.send("yes\n")
+    host1.bluetoothctl.send("yes\n")
+
+    host0.bluetoothctl.expect("Pairing successful")
+
+
+def bluetoothctl_script(script):
+    with tempfile.NamedTemporaryFile(
+        mode="w", encoding="utf-8", delete_on_close=False
+    ) as f:
+        f.write(script)
+        f.write("\nquit")
+        f.close()
+        return run(
+            [bluetoothctl, "--init-script", f.name],
+            stdout=subprocess.PIPE,
+            stdin=subprocess.DEVNULL,
+            encoding="utf-8",
+        )
+
+
+@host_config([Bluetoothd()])
+def test_bluetoothctl_script_show(hosts):
+    (host,) = hosts
+
+    result = host.call(bluetoothctl_script, f"show")
+    assert result.returncode == 0
+
+    assert f"Controller {host.bdaddr.upper()}" in result.stdout
+    assert "Powered: " in result.stdout
+    assert "Discoverable: no" in result.stdout
diff --git a/unit/func_test/test_btmgmt_vm.py b/unit/func_test/test_btmgmt_vm.py
new file mode 100644
index 000000000..0a8d3ace6
--- /dev/null
+++ b/unit/func_test/test_btmgmt_vm.py
@@ -0,0 +1,29 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+"""
+Tests for btmgmt using VM instances
+"""
+import sys
+import pytest
+import subprocess
+import tempfile
+
+from .lib import host_config, find_exe, run
+
+pytestmark = [pytest.mark.vm]
+
+btmgmt = find_exe("tools", "btmgmt")
+
+
+@host_config([])
+def test_btmgmt_info(hosts):
+    (host,) = hosts
+
+    result = host.call(
+        run,
+        [btmgmt, "--index", "0", "info"],
+        stdout=subprocess.PIPE,
+        stdin=subprocess.DEVNULL,
+        encoding="utf-8",
+    )
+    assert result.returncode == 0
+    assert f"addr {host.bdaddr.upper()}" in result.stdout
diff --git a/unit/pytest.ini b/unit/pytest.ini
new file mode 100644
index 000000000..17b695861
--- /dev/null
+++ b/unit/pytest.ini
@@ -0,0 +1,6 @@
+[pytest]
+log_format = %(asctime)s %(levelname)-6s %(name)-20s:  %(message)s
+log_level = 0
+log_file = test-functional.log
+markers =
+    vm: tests requiring VM image
diff --git a/unit/test-functional b/unit/test-functional
new file mode 100755
index 000000000..9b919f117
--- /dev/null
+++ b/unit/test-functional
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# Examples:
+#
+#	./test-functional
+#	./test-functional --log-cli-level=0 -s
+#
+exec python3 -m pytest "$(dirname "$0")"/func_test "$@"
-- 
2.53.0

