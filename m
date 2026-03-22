Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19537E2E6
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215034; cv=pass; b=kXuIuRYdWduqAdJWlB2EJpSIjkymxPpkFmKsAj8ytxFyYX7rYzL9aoFMbql9ByxyqIU6Ood4+9pAjPk671OggkDp+oS+ML/sB7R+UgmXadcwR+LImAd7wIXKb4kZuxsDXjAly4hD9MAZyNCi+ks1D8ePUvZ5K1Cbk250s+Tplsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215034; c=relaxed/simple;
	bh=ypMV1Rt8VTHZIx9KHM3wfdtHyYZzBgEQiH/IVALmkXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFdoqxENl6wNGTY1NRXc654eAZIRRUlcTvUtOCVOy4OcB7CxGBmf3UOv28stpEMluVzwVieRFt7rQDFE93PQYg2He7DTCMQ2aj+Wh8n94J/QQS2f1EubXpsUukDuZJIFWE7q7rnjA5Cn7l59Fjt4JEpKCbT/2svB5gmCTtTcYUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=bC3785g1; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="bC3785g1"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8bl3pqczyXG;
	Sun, 22 Mar 2026 23:30:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/NMEMP7WaPUMSthf+uRs2A5O/0S1TmcKwP7WLvZKic=;
	b=bC3785g1xZV+KgCs95pdG0TyptYI7PzbyzEPgyQYYnMEazZk5MAQ1yaq3q4dJZzFBmtDTx
	nkTiJ4/QGZVGBt/D1OOwfC3JRFkIU3WAacbX7r+bVI2QKSJUawKQXU3DdlcM2/bSao8PVd
	+GBD6R8MpuKE3NVkGK68NxATglTCivc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215027;
	b=WHz+JgxnapFFjgGPgnkMomakFvdI2o68yzc26lQXxXJ6jpDBeBm8ML+nKJQr0WkC5jNYAg
	vD44r/w3GW06RpZKrn981Ow+6ktc5htrmg86xaKpgJdLvEN+RQXpqzdTdieNcWiEXT3aYL
	4Gu/0e9G2HCQl3AeDI7iMTeN+UUMnk8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/NMEMP7WaPUMSthf+uRs2A5O/0S1TmcKwP7WLvZKic=;
	b=es6uK6jmZB6OdW67arpUrqiJVe8ChC3mJcP4FZLeAEHMEit9j+jJTnaIB4Nu/1Sg+20bTg
	yyXX0Tt1r2fHDMCu6pO1GUdMQOQrQw1jK/aec9dZaCWVdz3qpRMc1LF4xuOiT3GcIVKI/N
	2v9XV8mDfD1qmEBCadtdydhKjDgXnQc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 12/20] test: add functional/integration testing framework
Date: Sun, 22 Mar 2026 23:30:01 +0200
Message-ID: <f620ff68b9407c6523d4724d43926a6b0e926781.1774214693.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
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

Implementation is factored into test/pytest_bluez/ support plugin that's
in principle reusable for other projects, and test/functional/ actual
test files.

Implements:

- RPC communication with tester instances running each of the VM hosts,
  so that tests can be written on the parent host which coordinates the
  execution.

- Extensible way to add stateful test-specific code inside the VM
  instances

- Logging control: output from different processes running inside the VM
  are separated and can be filtered.

- Test runner framework with Pytest, factored into a pytest plugin

- Grouping tests to minimize VM reboots

- Redirecting USB controllers to use for testing

There is no requirement that the tests spawn VM instances. The test
runner finds any tests in test/**/test_*.py
---
 doc/test-functional.rst                 |   7 +-
 test/functional/__init__.py             |   2 +
 test/functional/requirements.txt        |   4 +
 test/functional/test_bluetoothctl_vm.py | 152 +++++
 test/functional/test_btmgmt_vm.py       |  30 +
 test/pytest.ini                         |  13 +
 test/pytest_bluez/__init__.py           |  10 +
 test/pytest_bluez/env.py                | 784 ++++++++++++++++++++++++
 test/pytest_bluez/host_plugins.py       | 566 +++++++++++++++++
 test/pytest_bluez/plugin.py             | 559 +++++++++++++++++
 test/pytest_bluez/rpc.py                | 385 ++++++++++++
 test/pytest_bluez/runner.py             |  20 +
 test/pytest_bluez/tests/__init__.py     |   2 +
 test/pytest_bluez/tests/test_rpc.py     |  62 ++
 test/pytest_bluez/tests/test_utils.py   |  16 +
 test/pytest_bluez/utils.py              | 706 +++++++++++++++++++++
 test/test-functional                    |   7 +
 test/test-functional-attach             |  52 ++
 18 files changed, 3374 insertions(+), 3 deletions(-)
 create mode 100644 test/functional/__init__.py
 create mode 100644 test/functional/requirements.txt
 create mode 100644 test/functional/test_bluetoothctl_vm.py
 create mode 100644 test/functional/test_btmgmt_vm.py
 create mode 100644 test/pytest.ini
 create mode 100644 test/pytest_bluez/__init__.py
 create mode 100644 test/pytest_bluez/env.py
 create mode 100644 test/pytest_bluez/host_plugins.py
 create mode 100644 test/pytest_bluez/plugin.py
 create mode 100644 test/pytest_bluez/rpc.py
 create mode 100644 test/pytest_bluez/runner.py
 create mode 100644 test/pytest_bluez/tests/__init__.py
 create mode 100644 test/pytest_bluez/tests/test_rpc.py
 create mode 100644 test/pytest_bluez/tests/test_utils.py
 create mode 100644 test/pytest_bluez/utils.py
 create mode 100755 test/test-functional
 create mode 100755 test/test-functional-attach

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index 139f99c40..f51401930 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -81,9 +81,10 @@ The following Python packages are required:
 
 .. code-block::
 
-   pytest
-   pexpect
-   dbus-python
+	pytest>=8
+	pexpect
+	dbus-python
+	PyGObject>=3.40
 
 To install them via pip::
 
diff --git a/test/functional/__init__.py b/test/functional/__init__.py
new file mode 100644
index 000000000..fe1c85178
--- /dev/null
+++ b/test/functional/__init__.py
@@ -0,0 +1,2 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/test/functional/requirements.txt b/test/functional/requirements.txt
new file mode 100644
index 000000000..b796e03bb
--- /dev/null
+++ b/test/functional/requirements.txt
@@ -0,0 +1,4 @@
+pytest>=8
+pexpect
+dbus-python
+PyGObject>=3.40
diff --git a/test/functional/test_bluetoothctl_vm.py b/test/functional/test_bluetoothctl_vm.py
new file mode 100644
index 000000000..6049e6793
--- /dev/null
+++ b/test/functional/test_bluetoothctl_vm.py
@@ -0,0 +1,152 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for bluetoothctl using VM instances
+"""
+import sys
+import re
+import pytest
+import subprocess
+import tempfile
+import warnings
+
+import time
+import logging
+
+
+from pytest_bluez import host_config, find_exe, run, Bluetoothd, Bluetoothctl
+
+pytestmark = [pytest.mark.vm]
+
+bluetoothctl = find_exe("client", "bluetoothctl")
+
+bluetoothd_reuse_config = host_config([Bluetoothd()], reuse=True)
+
+
+@host_config(
+    [Bluetoothctl()],
+    [Bluetoothctl()],
+)
+def test_bluetoothctl_pair_bredr(hosts):
+    host0, host1 = hosts
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
+@host_config(
+    [Bluetoothd(conf="[General]\nControllerMode = le\n"), Bluetoothctl()],
+    [Bluetoothd(conf="[General]\nControllerMode = le\n"), Bluetoothctl()],
+)
+def test_bluetoothctl_pair_le(hosts):
+    host0, host1 = hosts
+
+    host0.bluetoothctl.send("scan on\n")
+    host0.bluetoothctl.expect(f"Controller {host0.bdaddr.upper()} Discovering: yes")
+
+    host1.bluetoothctl.send("advertise on\n")
+    host1.bluetoothctl.expect("Advertising object registered")
+
+    host0.bluetoothctl.expect(f"Device {host1.bdaddr.upper()}")
+    host0.bluetoothctl.send(f"pair {host1.bdaddr.upper()}\n")
+
+    # BUG!: if controller is power cycled off/on at boot (before bluetoothd)
+    # BUG!: which is what the tester here does,
+    # BUG!: bluetoothd MGMT command to enable Secure Connections Host Support
+    # BUG!: fails and we are left with legacy passkey. It seems we get randomly
+    # BUG!: one of these depending on what state controller/kernel were before
+    # BUG!: btmgmt power off/on
+
+    idx, m = host0.bluetoothctl.expect(
+        [r"\[agent\].*Passkey:.*m(\d+)", r"Confirm passkey (\d+).*:"]
+    )
+    key = m[0].decode("utf-8")
+
+    if idx == 0:
+        warnings.warn(
+            "BUG: we got passkey authentication, bluetoothd/kernel should be fixed"
+        )
+        host1.bluetoothctl.expect(r"\[agent\] Enter passkey \(number in 0-999999\):")
+        host1.bluetoothctl.send(f"{key}\n")
+    else:
+        host1.bluetoothctl.expect(f"Confirm passkey {key}")
+
+        host0.bluetoothctl.send("yes\n")
+        host1.bluetoothctl.send("yes\n")
+
+    host0.bluetoothctl.expect("Pairing successful")
+
+
+def run_bluetoothctl(*args):
+    return run(
+        [bluetoothctl] + list(args),
+        stdout=subprocess.PIPE,
+        stdin=subprocess.DEVNULL,
+        encoding="utf-8",
+    )
+
+
+def run_bluetoothctl_script(script):
+    with tempfile.NamedTemporaryFile(mode="w", encoding="utf-8") as f:
+        f.write(script)
+        f.write("\nquit")
+        f.flush()
+        return run_bluetoothctl("--init-script", f.name)
+
+
+@bluetoothd_reuse_config
+def test_bluetoothctl_show(hosts):
+    (host,) = hosts
+
+    result = host.call(run_bluetoothctl, f"show")
+    assert result.returncode == 0
+    assert f"Controller {host.bdaddr.upper()}" in result.stdout
+    assert "Powered: " in result.stdout
+    assert "Discoverable: no" in result.stdout
+
+
+@bluetoothd_reuse_config
+def test_bluetoothctl_list(hosts):
+    (host,) = hosts
+
+    result = host.call(run_bluetoothctl, "list")
+    assert result.returncode == 0
+    assert re.search(rf"{host.bdaddr.upper()}.*\[default\]", result.stdout)
+
+
+@bluetoothd_reuse_config
+def test_bluetoothctl_script_show(hosts):
+    (host,) = hosts
+
+    result = host.call(run_bluetoothctl_script, f"show")
+    assert result.returncode == 0
+    assert f"Controller {host.bdaddr.upper()}" in result.stdout
+    assert "Powered: " in result.stdout
+    assert "Discoverable: no" in result.stdout
+
+
+@bluetoothd_reuse_config
+def test_bluetoothctl_script_list(hosts):
+    (host,) = hosts
+
+    result = host.call(run_bluetoothctl_script, f"list")
+    assert result.returncode == 0
+    assert re.search(rf"{host.bdaddr.upper()}.*\[default\]", result.stdout)
diff --git a/test/functional/test_btmgmt_vm.py b/test/functional/test_btmgmt_vm.py
new file mode 100644
index 000000000..d51d32c6a
--- /dev/null
+++ b/test/functional/test_btmgmt_vm.py
@@ -0,0 +1,30 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for btmgmt using VM instances
+"""
+import sys
+import pytest
+import subprocess
+import tempfile
+
+from pytest_bluez import host_config, find_exe, run
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
diff --git a/test/pytest.ini b/test/pytest.ini
new file mode 100644
index 000000000..899871fa2
--- /dev/null
+++ b/test/pytest.ini
@@ -0,0 +1,13 @@
+[pytest]
+log_format = %(asctime)s %(levelname)-6s %(name)-20s:  %(message)s
+log_date_format = %Y-%m-%d %H:%M:%S.%f
+log_level = 0
+log_file = test-functional.log
+markers =
+    vm: tests requiring VM image
+
+addopts =
+    -p pytest_bluez
+
+# Default timeout
+vm_timeout = 30
diff --git a/test/pytest_bluez/__init__.py b/test/pytest_bluez/__init__.py
new file mode 100644
index 000000000..cb4dca71c
--- /dev/null
+++ b/test/pytest_bluez/__init__.py
@@ -0,0 +1,10 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from .rpc import RemoteError
+
+from .env import *
+from .utils import *
+from .host_plugins import *
+
+from .plugin import *
diff --git a/test/pytest_bluez/env.py b/test/pytest_bluez/env.py
new file mode 100644
index 000000000..cb920e714
--- /dev/null
+++ b/test/pytest_bluez/env.py
@@ -0,0 +1,784 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+import traceback
+import resource
+import warnings
+import subprocess
+from pathlib import Path
+from subprocess import Popen, DEVNULL, PIPE, run
+
+from gi.repository import GLib
+
+from . import rpc, utils
+
+__all__ = ["HostPlugin", "HostProxy", "PluginProxy"]
+
+log = logging.getLogger("env")
+
+
+class HostPlugin:
+    """
+    Plugin to insert code to VM host side.
+
+    Attributes:
+        name (str): unique name for the plugin
+        depends (tuple[HostPlugin]): plugins to be loaded before this one
+        value (object): object to appear as HostProxy attribute on parent side.
+            If None, the plugin is represented by a proxy object that does RPC
+            calls. Otherwise, must be a serializable value. If it is a subclass
+            of `PluginProxy`, the method `set_connection` is called after plugin
+            load.
+    """
+
+    name = None
+    depends = ()
+    value = None
+
+    def __init__(self):
+        """
+        Configure plugin (runs on parent host side).  This is
+        called at test discovery time, so should mainly store static
+        data.
+
+        """
+        pass
+
+    def presetup(self, config):
+        """
+        Parent host-side setup, before VM environment is started.  May
+        use pytest.skip() to skip tests in case plugin cannot be set up.
+
+        Args:
+            config (pytest.Config): pytest configuration object
+        """
+        pass
+
+    def setup(self, impl):
+        """
+        VM-side setup
+
+        Args:
+            impl (Implementation): plugin host object
+        """
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
+        """
+        Load given plugin to the VM host synchronously.
+        """
+        self.start_load(plugin)
+        self.wait_load()
+
+    def set_instance_name(self, name):
+        self.instance_name = name
+        self._conn.call_noreply("set_instance_name", name)
+
+    def start_load(self, plugin: HostPlugin):
+        """
+        Initiate loading the given plugin to the VM host.  Use
+        `wait_load` to wait for completion and make loaded plugins
+        usable.
+
+        """
+        if plugin.name in self._plugins:
+            # Already loaded
+            return
+        self._conn.call_noreply("start_load", plugin)
+        self._plugins[plugin.name] = None
+
+    def wait_load(self, timeout=None):
+        """
+        Wait for plugin loads to complete, and make plugins available.
+        """
+        for name, value in self._conn.call("wait_load", timeout=timeout).items():
+            if value is None:
+                value = PluginProxy()
+            if isinstance(value, PluginProxy):
+                value.set_connection(name, self._active_conn)
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
+        """
+        Shutdown this VM host tester instance.
+        """
+        self._plugins = {}
+        if self._active_conn is not None:
+            self._active_conn.close()
+            self._active_conn = None
+
+    def _close_start(self):
+        self._plugins = {}
+        if self._active_conn is not None:
+            self._active_conn.close_start()
+
+    def _close_finish(self, force=False):
+        if self._active_conn is not None:
+            self._active_conn.close_finish(force=force)
+            self._active_conn = None
+
+
+class PluginProxy:
+    """
+    Host-side proxy for a plugin: RPC calls
+
+    Attributes:
+        _name (str): plugin name
+        _conn (rpc.Connection): RPC connection
+    """
+
+    def __init__(self):
+        self._name = None
+        self._conn = None
+
+    def set_connection(self, name, conn):
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
+    def _call_noreply(self, name, *a, **kw):
+        self._conn.call_noreply("call_plugin", self._name, name, *a, **kw)
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
+    def set_instance_name(self, name):
+        self.instance_name = name
+        socket.sethostname(name)
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
+    def _unload(self, name):
+        self.plugin_order.remove(name)
+        p = self.plugins.pop(name)
+        method = getattr(p, "teardown", None)
+        if method is not None:
+            try:
+                method()
+            except BaseException as exc:
+                tb = traceback.format_exc()
+                log.error(f"Plugin {name} teardown error: {exc}\n{tb}")
+                return False
+        return True
+
+    def call_plugin(self, name, method, *a, **kw):
+        return getattr(self.plugins[name], method)(*a, **kw)
+
+    def teardown(self):
+        success = True
+        while self.plugin_order:
+            name = self.plugin_order[-1]
+            log.info(f"Plugin {name} teardown")
+            if not self._unload(name):
+                success = False
+            log.info(f"Plugin {name} teardown done")
+        if not success:
+            raise RuntimeError("teardown failure")
+
+
+def _find_vport(target_name):
+    """
+    Find RPC control virtio port
+    """
+    for port in Path("/sys/class/virtio-ports").iterdir():
+        with open(port / "name", "rb") as f:
+            name = f.read(64)
+            if name == target_name:
+                return f"/dev/{port.name}"
+
+    raise RuntimeError(f"No virtio port {target_name} found")
+
+
+class _RunnerLogHandler(logging.Handler):
+    def __init__(self, stream):
+        super().__init__()
+        self.stream = stream
+
+    def flush(self):
+        self.stream.flush()
+
+    def emit_simple(self, name, levelno, line, nsec):
+        self.stream.write(f"\x00{name}\x01{levelno}\x02{nsec}\x03{line}\n")
+
+    def emit(self, record):
+        try:
+            msg = record.getMessage()
+            if record.exc_info:
+                msg += "\n"
+                msg += traceback.format_exception(*record.exc_info)
+            name = record.name
+            levelno = record.levelno
+            nsec = getattr(record, "nsec", None)
+            if nsec is None:
+                nsec = int(record.created * 1e9)
+            for line in msg.splitlines():
+                self.emit_simple(name, levelno, msg, nsec)
+            self.stream.flush()
+        except RecursionError:
+            raise
+        except Exception:
+            self.handleError(record)
+
+    def start(self):
+        self.flush_thread = threading.Thread(target=self._flush_thread, daemon=True)
+        self.flush_thread.start()
+
+    def _flush_thread(self):
+        while True:
+            time.sleep(0.5)
+            self.stream.flush()
+
+
+def _main_runner_instance():
+    """
+    VM-side tester main instance
+    """
+    from dbus.mainloop.glib import DBusGMainLoop
+
+    # Start GLib mainloop early: dbus-python needs it
+    loop = GLib.MainLoop()
+    dbus_loop = DBusGMainLoop(set_as_default=True)
+    loop_thread = threading.Thread(target=loop.run, daemon=True)
+    loop_thread.start()
+
+    utils.SIMPLE_LOG_HANDLER.start()
+    try:
+        dev = _find_vport(b"bluez-func-test-rpc\n")
+        log.info(f"Test RPC server on {dev}")
+        rpc.server_file(dev, Implementation())
+    finally:
+        utils.SIMPLE_LOG_HANDLER.flush()
+        loop.quit()
+        log.info(f"Test RPC server quit")
+
+
+def _setup_vm_instance():
+    # Mount shared path
+    path = Path("/run/shared")
+    if not path.is_dir():
+        path.mkdir()
+        run(["mount", "-t", "9p", "/dev/shared", str(path)], check=True)
+
+    # Setup sys.path & defaults
+    with open("/run/shared/defaults", "rb") as f:
+        (sys.path, utils.SRC_DIR, utils.BUILD_DIR, utils.DEFAULT_TIMEOUT) = pickle.load(
+            f
+        )
+
+    # Set up core dumps
+    with open("/proc/sys/kernel/core_pattern", "w") as f:
+        f.write("|/usr/bin/env tee /run/shared/test-functional-%h-%e-%t.core")
+
+    resource.setrlimit(
+        resource.RLIMIT_CORE, (resource.RLIM_INFINITY, resource.RLIM_INFINITY)
+    )
+
+    # Set up default ASAN options
+    os.environ["ASAN_OPTIONS"] = (
+        "detect_leaks=1:leak_check_at_exit=0:print_summary=1:abort_on_error=1:"
+        "use_madv_dontdump=1:disable_coredump=0:unmap_shadow_on_exit=1:"
+        "strict_string_checks=1:detect_stack_use_after_return=1:"
+        "check_initialization_order=1:strict_init_order=1:"
+        "quarantine_size_mb=16"
+    )
+    os.environ["UBSAN_OPTIONS"] = "print_stacktrace=1:print_summary=1:abort_on_error=1"
+    os.environ["LSAN_OPTIONS"] = "exitcode=0:log_threads=1"
+
+    # Start (a)getty
+    try:
+        exe = utils.find_exe("", "agetty")
+    except FileNotFoundError:
+        log.warning("agetty not available")
+        exe = None
+    try:
+        setsid = utils.find_exe("", "setsid")
+    except FileNotFoundError:
+        log.warning("setsid not available")
+        setsid = None
+
+    if exe is not None and setsid is not None:
+        # Use shell script for restarting getty: uses less memory than Python
+        script = Path("/tmp/getty.script")
+        with open(script, "w") as f:
+            f.write(
+                f'#!/bin/sh\nwhile true; do "{setsid}" "{exe}" -n -h -L -l /bin/bash ttyS1; done'
+            )
+
+        os.chmod(script, 0o755)
+
+        pid = os.fork()
+        if pid == 0:
+            os.setsid()
+            os.execv(script, [script])
+            os._exit(1)
+
+    _start_chronyd()
+
+
+def _start_chronyd():
+    global _CHRONYD
+
+    try:
+        exe = utils.find_exe("", "chronyd")
+    except FileNotFoundError:
+        log.warning("chronyd not available")
+        return
+
+    if not Path("/dev/ptp0").exists():
+        log.warning("/dev/ptp0 not available")
+        return
+
+    tmpdir = tempfile.mkdtemp(prefix=f"chronyd-")
+    config = Path(tmpdir) / "chronyd.conf"
+
+    with open(config, "w") as f:
+        text = f"makestep 0.1 3\nrefclock PHC /dev/ptp0 poll -2\n"
+        f.write(text)
+
+    cmd = [exe, "-n", "-f", str(config), "-q"]
+    log.debug("Synchronizing clock: {}".format(utils.quoted(cmd)))
+    subprocess.run(cmd, check=True)
+
+    cmd = [exe, "-n", "-f", str(config)]
+    log.debug("Starting chronyd: {}".format(utils.quoted(cmd)))
+    _CHRONYD = subprocess.Popen(cmd)
+
+
+def _reset_vm_instance():
+    # Power cycle controller to reset it between tests
+    btmgmt = utils.find_exe("tools", "btmgmt")
+    run([btmgmt, "power", "off"], check=True)
+    run([btmgmt, "power", "on"], check=True)
+
+
+def _main_runner():
+    """
+    VM-side tester supervisor
+    """
+    log_port = _find_vport(b"bluez-func-test-log\n")
+    log_stream = open(log_port, "w", encoding="utf-8", errors="surrogateescape")
+    utils.SIMPLE_LOG_HANDLER = _RunnerLogHandler(log_stream)
+    logging.basicConfig(level=0, handlers=[utils.SIMPLE_LOG_HANDLER])
+
+    # Basic VM setup
+    _setup_vm_instance()
+
+    # Preload libraries
+    import dbus
+    import pexpect
+
+    # Keep one instance running
+    while True:
+        log.info("Starting test instance")
+
+        _reset_vm_instance()
+
+        pid = os.fork()
+        if pid == 0:
+            os.setpgid(0, 0)
+            _main_runner_instance()
+            os._exit(0)
+        else:
+            try:
+                os.waitpid(pid, 0)
+            except ChildProcessError:
+                pass
+
+            log.info("Terminating test instance")
+
+            done = False
+
+            while not done:
+                for sig in [signal.SIGTERM, signal.SIGCONT, signal.SIGKILL]:
+                    try:
+                        os.kill(-pid, sig)
+                        time.sleep(0.5 if sig == signal.SIGCONT else 0.1)
+                    except ProcessLookupError:
+                        done = True
+                        break
+
+
+ENV_INDEX = -1
+
+
+class Environment:
+    def __init__(self, kernel, num_hosts, usb_indices=None, timeout=20, mem=None):
+        if Path(kernel).is_dir():
+            self.kernel = str(Path(kernel) / "arch" / "x86" / "boot" / "bzImage")
+        else:
+            self.kernel = str(kernel)
+
+        self.num_hosts = operator.index(num_hosts)
+        self.jobs = []
+        self.log_streams = []
+        self.hosts = []
+        self.timeout = float(timeout)
+        self.path = None
+        self.reuse_group = None
+        self.mem = mem
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
+            try:
+                self.hosts.pop().close()
+            except rpc.RemoteError:
+                # error already logged
+                pass
+
+        # Clean up tmpdir (btvirt, own sockets, rmdir)
+        if self.path is not None:
+            for f in list(self.path.iterdir()):
+                if f.name.startswith("bt-server-"):
+                    f.unlink()
+                if f.name.startswith("shared-"):
+                    shutil.rmtree(f.resolve(), ignore_errors=True)
+                    continue
+                if f.name.startswith("bluez-func-test-"):
+                    f.unlink()
+
+            self.path.rmdir()
+            self.path = None
+
+    def close_hosts(self):
+        try:
+            for h in self.hosts:
+                h._close_start()
+        finally:
+            errors = []
+            for h in self.hosts:
+                try:
+                    h._close_finish(force=bool(errors))
+                except Exception as exc:
+                    tb = "\n    ".join(traceback.format_exc().split("\n"))
+                    errors.append(
+                        f"{exc}\nError closing {h._name}: Traceback:\n    {tb}"
+                    )
+
+            if errors:
+                errors = "\n".join(errors)
+                raise RuntimeError(f"Errors closing hosts:\n{errors}")
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
+        cmd = [exe, f"--server={self.path}"]
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
+            tty_path = str(self.path / f"bluez-func-test-tty-{idx}")
+            log_path = str(self.path / f"bluez-func-test-log-{idx}")
+
+            shared_path = self.path / f"shared-{idx}"
+            shared_path.mkdir()
+
+            # Python import paths & timeout
+            with open(shared_path / "defaults", "wb") as f:
+                pickle.dump(
+                    (
+                        sys.path,
+                        utils.SRC_DIR,
+                        utils.BUILD_DIR,
+                        utils.DEFAULT_TIMEOUT * 3 / 4,
+                    ),
+                    f,
+                )
+
+            # RPC socket
+            qemu_args = [
+                "-chardev",
+                f"socket,id=ser0,path={socket_path},server=on,wait=off",
+            ]
+
+            qemu_args += [
+                "-device",
+                "virtio-serial",
+                "-device",
+                "virtserialport,chardev=ser0,name=bluez-func-test-rpc",
+            ]
+
+            # Separate TTY access
+            qemu_args += [
+                "-chardev",
+                f"socket,id=ser1,path={tty_path},server=on,wait=off",
+            ]
+
+            qemu_args += [
+                "-device",
+                "pci-serial,chardev=ser1",
+            ]
+
+            # Log socket
+            qemu_args += [
+                "-chardev",
+                f"socket,id=ser2,path={log_path},server=on,wait=on",
+            ]
+
+            qemu_args += [
+                "-device",
+                "virtio-serial",
+                "-device",
+                "virtserialport,chardev=ser2,name=bluez-func-test-log",
+            ]
+
+            # Shared filesystem
+            qemu_args += [
+                "-fsdev",
+                f"local,id=fsdev-shared,path={shared_path},readonly=off,security_model=none,multidevs=remap",
+                "-device",
+                "virtio-9p-pci,fsdev=fsdev-shared,mount_tag=/dev/shared",
+            ]
+
+            if self.mem:
+                qemu_args += ["-m", str(self.mem)]
+
+            extra_args = []
+            for q in qemu_args:
+                extra_args += ["-o", q]
+
+            extra_args += ["-H"]
+
+            cmd = (
+                [test_runner, f"--kernel={self.kernel}"]
+                + arg
+                + extra_args
+                + ["--"]
+                + self.runner
+            )
+
+            log.info("Starting host: {}".format(utils.quoted(cmd)))
+            log.info(f"TTY: socat {tty_path} STDIO,rawer")
+
+            host_names.append(f"host.{ENV_INDEX}.{idx}")
+
+            logger = self._add_log(host_names[-1])
+            self.jobs.append(Popen(cmd, stdout=logger, stderr=logger, stdin=DEVNULL))
+
+            # Start log reader
+            utils.wait_files(self.jobs, [log_path])
+
+            log_sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+            log_sock.connect(log_path)
+            self._add_log(
+                host_names[-1],
+                pattern=".*\x00([^\x00-\x03]+)\x01([^\x00-\x03]+)\x02([^\x00-\x03]+)\x03",
+                stream=log_sock,
+            )
+
+        utils.wait_files(self.jobs, socket_paths)
+
+        return socket_paths, host_names
+
+    def _start_hosts(self, socket_paths, host_names):
+        if len(socket_paths) != self.num_hosts:
+            raise RuntimeError("Wrong number of sockets")
+
+        for path, name in zip(socket_paths, host_names):
+            host = HostProxy(path, timeout=self.timeout, name=name)
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
diff --git a/test/pytest_bluez/host_plugins.py b/test/pytest_bluez/host_plugins.py
new file mode 100644
index 000000000..3b9cf7857
--- /dev/null
+++ b/test/pytest_bluez/host_plugins.py
@@ -0,0 +1,566 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+VM host plugins
+"""
+import os
+import sys
+import subprocess
+import collections
+import logging
+import tempfile
+import time
+import shutil
+import queue
+import signal
+import functools
+import threading
+import resource
+from pathlib import Path
+
+import pytest
+import pexpect
+import dbus
+from gi.repository import GLib
+
+from . import env, utils
+
+__all__ = [
+    "host_config",
+    "parametrized_host_config",
+    "Bdaddr",
+    "Bluetoothctl",
+    "Bluetoothd",
+    "Call",
+    "DbusSession",
+    "DbusSystem",
+    "Pexpect",
+    "Rcvbuf",
+]
+
+
+class Bdaddr(env.HostPlugin):
+    """
+    Host plugin providing `host.bdaddr`. Loaded by default.
+    """
+
+    name = "bdaddr"
+
+    def setup(self, impl):
+        self.value = utils.get_bdaddr()
+
+
+class Rcvbuf(env.HostPlugin):
+    """
+    Host plugin setting pipe buffer size defaults. Loaded by default.
+    """
+
+    name = "rcvbuf"
+
+    def __init__(self, rcvbuf=None):
+        self.rcvbuf = rcvbuf
+
+    def presetup(self, config):
+        if self.rcvbuf is None:
+            self.rcvbuf = config.getini("host_plugins.rcvbuf.default")
+
+        self.rcvbuf = int(self.rcvbuf)
+
+    def setup(self, impl):
+        self.log = logging.getLogger(self.name)
+
+        self.log.info(f"Set SO_RCVBUF default = {self.rcvbuf}")
+        with open("/proc/sys/net/core/rmem_default", "wb") as f:
+            f.write(f"{self.rcvbuf}".encode("ascii"))
+
+
+class Call(env.HostPlugin):
+    """
+    Host plugin providing ``host.call(func, *args, **kw)`` and `call_async`
+    which invoke the given functions on VM host side.  Loaded by default.
+
+    Example:
+
+        result = host0.call(my_func, 1, 2, 3)
+
+    Example:
+
+        result_async = host0.call(my_func, 1, 2, 3, sync=False)
+        ...
+        result = result_async.wait()
+    """
+
+    name = "call"
+
+    def setup(self, impl):
+        self._results = {}
+        self._id = 0
+        self.value = self.Proxy()
+
+    def __call__(self, func, *a, **kw):
+        return func(*a, **kw)
+
+    def call_async(self, func, *a, **kw):
+        value = None
+        try:
+            value = func(*a, **kw)
+        except BaseException as exc:
+            value = exc
+            raise
+        finally:
+            self._id += 1
+            self._results[self._id] = value
+
+    def wait_async(self, id_value):
+        return self._results.pop(id_value)
+
+    class Proxy(env.PluginProxy):
+        def __init__(self):
+            self._id = 0
+
+        def __call__(self, func, *a, **kw):
+            if kw.pop("sync", True):
+                return self._conn.call(
+                    "call_plugin", self._name, "__call__", func, *a, **kw
+                )
+            else:
+                self._conn.call_noreply(
+                    "call_plugin", self._name, "call_async", func, *a, **kw
+                )
+                self._id += 1
+                return Call.ResultProxy(self, self._id)
+
+    class ResultProxy:
+        def __init__(self, plugin, id_value):
+            self.plugin = plugin
+            self.id_value = id_value
+
+        def wait(self):
+            return self.plugin.wait_async(self.id_value)
+
+
+class _Dbus(env.HostPlugin):
+    def __init__(self):
+        self.exe = utils.find_exe("", "dbus-daemon")
+
+    def setup(self, impl):
+        self.log = logging.getLogger(self.name)
+        self.log_stream = utils.LogStream(self.name)
+
+        self.tmpdir = utils.TmpDir(prefix=f"{self.name}-")
+        self.config = Path(self.tmpdir.name) / "config.xml"
+
+        socket = f"/run/dbus-{self.dbus_type}.socket"
+        self.address = "unix:path={}".format(socket)
+
+        # Have to set both, dbus-python needs both early
+        os.environ["DBUS_SYSTEM_BUS_ADDRESS"] = "unix:path=/run/dbus-system.socket"
+        os.environ["DBUS_SESSION_BUS_ADDRESS"] = "unix:path=/run/dbus-session.socket"
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
+            <limit name="reply_timeout">{round(utils.DEFAULT_TIMEOUT * 1000)}</limit>
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
+        self.log.debug(
+            "Starting {} @ {}: {}".format(self.name, self.address, utils.quoted(cmd))
+        )
+
+        self.job = subprocess.Popen(
+            cmd,
+            stdout=self.log_stream.stream,
+            stderr=subprocess.STDOUT,
+        )
+        utils.wait_files([self.job], [socket])
+        self.log.debug(f"{self.name} ready")
+
+    def teardown(self):
+        self.job.terminate()
+        self.tmpdir.cleanup()
+        self.log_stream.close()
+
+
+class DbusSystem(_Dbus):
+    """
+    Host plugin providing system DBus, at address
+    `impl.plugins["dbus-system"].address`.
+
+    Warning:
+        dbus-python **MUST** be used only from the GLib main loop,
+        as the library has concurrency bugs. All functions using it
+        **MUST** either run from GLib main loop eg. via mainloop_wrap
+    """
+
+    name = "dbus-system"
+    dbus_type = "system"
+
+
+class DbusSession(_Dbus):
+    """
+    Host plugin providing system DBus, at address
+    `impl.plugins["dbus-session"].address`.
+
+    Warning:
+        dbus-python **MUST** be used only from the GLib main loop,
+        as the library has concurrency bugs. All functions using it
+        **MUST** either run from GLib main loop eg. via mainloop_wrap
+    """
+
+    name = "dbus-session"
+    dbus_type = "session"
+
+
+class Bluetoothd(env.HostPlugin):
+    """
+    Host plugin starting Bluetoothd.
+    """
+
+    name = "bluetoothd"
+    depends = [DbusSystem()]
+
+    def __init__(self, debug=True, conf=None, args=()):
+        super().__init__()
+
+        self.conf = conf
+        self.args = tuple(args)
+        if debug and "-d" not in self.args:
+            self.args += ("-d",)
+
+    @utils.mainloop_wrap
+    def setup(self, impl):
+        self.log = logging.getLogger(self.name)
+
+        exe = utils.find_exe("src", "bluetoothd")
+
+        self.tmpdir = utils.TmpDir(prefix="bluetoothd-state-")
+        state_dir = Path(self.tmpdir.name) / "state"
+        conf = Path(self.tmpdir.name) / "main.conf"
+
+        state_dir.mkdir()
+
+        if self.conf is None:
+            with open(str(conf), "w") as f:
+                pass
+        else:
+            with open(str(conf), "w") as f:
+                f.write(self.conf)
+
+        envvars = dict(os.environ)
+        envvars["STATE_DIRECTORY"] = str(state_dir)
+
+        cmd = [exe, "--nodetach", "-f", str(conf)] + list(self.args)
+
+        self.log.info("Start bluetoothd: {}".format(utils.quoted(cmd)))
+
+        self.log_stream = utils.LogStream("bluetoothd")
+        self.job = subprocess.Popen(
+            cmd,
+            env=envvars,
+            stdin=subprocess.DEVNULL,
+            stdout=self.log_stream.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+        # Wait for the adapter to appear powered
+        self.log.info("Wait for bluetoothd...")
+        bus = dbus.SystemBus()
+        bus.set_exit_on_disconnect(False)
+
+        def cond():
+            try:
+                adapter = dbus.Interface(
+                    bus.get_object("org.bluez", "/org/bluez/hci0"),
+                    "org.freedesktop.DBus.Properties",
+                )
+                if adapter.Get("org.bluez.Adapter1", "Powered"):
+                    return True
+            except dbus.DBusException:
+                return False
+
+        utils.wait_until(cond)
+
+        self.log.info("Bluetoothd ready")
+
+    def teardown(self):
+        self.log.info("Stop bluetoothd")
+        self.job.terminate()
+        self.tmpdir.cleanup()
+        self.log_stream.close()
+
+
+class Pexpect(env.HostPlugin):
+    """
+    Host plugin for starting and controlling processes with pexpect.
+
+    Example:
+
+        btmgmt = host0.pexpect.spawn(find_exe("tools", "btmgmt"))
+        btmgmt.send("info\n")
+        btmgmt.expect("hci0")
+        btmgmt.close()
+    """
+
+    name = "pexpect"
+    depends = []
+
+    def setup(self, impl):
+        self.ctls = {}
+        self.ctl_id = 0
+        self.log = logging.getLogger(self.name)
+
+        self.log_stream = utils.LogStream(self.name)
+        self.value = self.Proxy()
+
+    def spawn(self, cmd):
+        from pexpect.popen_spawn import PopenSpawn
+
+        self.log.info("Spawn {}".format(utils.quoted(cmd)))
+
+        ctl = pexpect.popen_spawn.PopenSpawn(
+            cmd,
+            logfile=self.log_stream.stream,
+            timeout=utils.DEFAULT_TIMEOUT,
+        )
+        self.ctl_id += 1
+        self.ctls[self.ctl_id] = ctl
+        return self.ctl_id
+
+    def teardown(self):
+        for ctl in self.ctls.values():
+            ctl.sendeof()
+            ctl.kill(signal.SIGTERM)
+        self.log_stream.close()
+
+    def close(self, ctl_id):
+        ctl = self.ctls[ctl_id]
+        ctl.sendeof()
+        ctl.kill(signal.SIGTERM)
+        del self.ctls[ctl_id]
+
+    def expect(self, ctl_id, *a, **kw):
+        ctl = self.ctls[ctl_id]
+        ret = ctl.expect(*a, **kw)
+        self.log.debug("match found")
+        return ret, ctl.match.groups()
+
+    def send(self, ctl_id, *a, **kw):
+        ctl = self.ctls[ctl_id]
+        return ctl.send(*a, **kw)
+
+    class Proxy(env.PluginProxy):
+        def spawn(self, cmd):
+            ctl_id = self._conn.call("call_plugin", self._name, "spawn", cmd)
+            return Pexpect.CtlProxy(self, ctl_id)
+
+    class CtlProxy:
+        def __init__(self, plugin, ctl_id):
+            self._plugin = plugin
+            self.ctl_id = ctl_id
+
+        def __getattr__(self, name):
+            method = getattr(self._plugin, name)
+            return lambda *a, **kw: method(self.ctl_id, *a, **kw)
+
+        def __enter__(self):
+            return self
+
+        def __exit__(self, type, value, tb):
+            self.close()
+
+
+class Bluetoothctl(env.HostPlugin):
+    """
+    Host plugin for starting and controlling `bluetoothctl` with pexpect.
+    """
+
+    name = "bluetoothctl"
+    depends = [Bluetoothd()]
+
+    def __init__(self):
+        self.exe = utils.find_exe("client", "bluetoothctl")
+
+    def setup(self, impl):
+        from pexpect.popen_spawn import PopenSpawn
+
+        self.log = logging.getLogger(self.name)
+        self.log_stream = utils.LogStream(self.name)
+
+        # Note: pexpect.spawn doesn't work under load: using a PTY
+        # appears to cause some messages be not received by
+        # bluetoothctl
+        self.ctl = pexpect.popen_spawn.PopenSpawn(
+            self.exe, logfile=self.log_stream.stream, timeout=utils.DEFAULT_TIMEOUT
+        )
+
+    def teardown(self):
+        self.ctl.sendeof()
+        self.ctl.kill(signal.SIGTERM)
+        self.log_stream.close()
+
+    def expect(self, *a, **kw):
+        ret = self.ctl.expect(*a, **kw)
+        self.log.debug("match found")
+        return ret, self.ctl.match.groups()
+
+    def send(self, *a, **kw):
+        return self.ctl.send(*a, **kw)
+
+
+HOST_SETUPS = 0
+DEFAULT_PLUGINS = [Rcvbuf(), Bdaddr(), Call()]
+
+
+def _expand_plugins(plugins):
+    """
+    Resolve plugin dependencies to linear load order
+    """
+    plugins = DEFAULT_PLUGINS + list(plugins)
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
+def parametrized_host_config(
+    param_host_setups, hw=False, mem=None, ids=None, reuse=False
+):
+    """
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
+    """
+    global HOST_SETUPS
+
+    host_setups = []
+    host_ids = []
+
+    if ids is not None:
+        if len(ids) != len(param_host_setups):
+            raise ValueError("Wrong number of ids")
+        host_ids = list(ids)
+
+    num_hosts = set(len(setup) for setup in param_host_setups)
+    if len(num_hosts) > 1:
+        raise ValueError("Parametrized host setups must have same host count")
+    num_hosts = num_hosts.pop()
+
+    for host_setup in param_host_setups:
+        setup = tuple(_expand_plugins(plugins) for plugins in host_setup)
+
+        name = f"hosts{HOST_SETUPS}"
+        HOST_SETUPS += 1
+
+        host_setup = dict(setup=setup, name=name, reuse=bool(reuse))
+        host_setups.append(host_setup)
+
+        if ids is None:
+            host_ids.append(name)
+
+    vm_setup = dict(num_hosts=num_hosts, hw=hw, mem=str(mem) if mem else "")
+    vm_ids = [
+        "vm{}{}{}".format(len(setup), f"-{mem}" if mem else "", "-hw" if hw else "")
+    ]
+
+    def decorator(func):
+        func = pytest.mark.parametrize(
+            "host_setup", host_setups, indirect=True, ids=host_ids
+        )(func)
+        func = pytest.mark.parametrize(
+            "vm_setup", [vm_setup], indirect=True, ids=vm_ids
+        )(func)
+        return func
+
+    return decorator
+
+
+def host_config(*host_setup, hw=False, mem=None, reuse=False):
+    """
+    Declare host configuration.
+
+    Args:
+        *host_setup: each argument is a list of plugins to be loaded on a host.
+            The number of arguments specifies the number of hosts.
+        hw (bool): whether to require hardware BT controller
+        mem (str): amount of memory for the VM instances
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
+    """
+    return parametrized_host_config([host_setup], hw=hw, mem=mem, reuse=reuse)
diff --git a/test/pytest_bluez/plugin.py b/test/pytest_bluez/plugin.py
new file mode 100644
index 000000000..a713b2f90
--- /dev/null
+++ b/test/pytest_bluez/plugin.py
@@ -0,0 +1,559 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+import os
+import re
+import shutil
+import logging
+import warnings
+import traceback
+from pathlib import Path
+
+import pytest
+
+from . import utils, env
+
+
+__all__ = [
+    # hooks:
+    "pytest_addoption",
+    "pytest_configure",
+    "pytest_collectreport",
+    "pytest_collection_finish",
+    "pytest_collection_modifyitems",
+    "pytest_sessionstart",
+    "pytest_sessionfinish",
+    "pytest_runtest_logstart",
+    "pytest_runtest_setup",
+    "pytest_runtest_call",
+    "pytest_runtest_teardown",
+    "pytest_report_teststatus",
+    "pytest_runtest_logfinish",
+    # fixtures:
+    "kernel",
+    "usb_indices",
+    "host_setup",
+    "vm_setup",
+    "vm",
+    "hosts",
+    "vm_once",
+    "hosts_once",
+]
+
+# For logging test status messages to test-functional.log
+status_log = logging.getLogger("pytest")
+status_log_seen = set()
+
+
+def pytest_addoption(parser):
+    group = parser.getgroup("pytest_bluez", "bluez test options")
+
+    group.addoption(
+        "--kernel",
+        action="store",
+        default=None,
+        help=("Kernel image to use"),
+    )
+    group.addoption(
+        "--usb",
+        action="store",
+        default=None,
+        help=("USB HCI devices to use, e.g. 'hci0,hci1'"),
+    )
+    group.addoption(
+        "--force-usb",
+        action="store_true",
+        default=None,
+        help=("Force tests to run with USB controllers instead of btvirt"),
+    )
+    group.addoption(
+        "--bluez-build-dir",
+        action="store",
+        default=None,
+        type=Path,
+        help=("Build directory to find BlueZ development binaries"),
+    )
+    group.addoption(
+        "--bluez-src-dir",
+        action="store",
+        default=None,
+        type=Path,
+        help=("Directory to find BlueZ sources"),
+    )
+    group.addoption(
+        "--list",
+        action="store_true",
+        default=None,
+        help=("List tests"),
+    )
+    group.addoption(
+        "--log-filter",
+        action="append",
+        default=None,
+        help=(
+            "Enable/disable loggers by name. Can be passed multiple times. Example: +host.0,-rpc"
+        ),
+    )
+    group.addoption(
+        "--no-log-reorder",
+        action="store_true",
+        default=False,
+        help="Don't reorder logs to timestamp order",
+    )
+
+    group.addoption(
+        "--vm-timeout",
+        action="store",
+        default=None,
+        type=float,
+        help="Timeout in seconds for waiting for RPC reply with VM (default: 30 s)",
+    )
+    parser.addini(
+        "vm_timeout", "Default timeout for communication with VM etc.", default="30"
+    )
+
+    # host_plugins.Rcvbuf:
+    parser.addini(
+        "host_plugins.rcvbuf.default",
+        "Set default SO_RCVBUF (/proc/sys/net/core/rmem_default) on hosts",
+        default="1048576",
+    )
+
+
+def pytest_configure(config):
+    if config.option.list:
+        config.option.reportchars = "A"
+        config.option.no_header = True
+        config.option.verbose = -2
+
+    if config.option.bluez_build_dir is not None:
+        utils.BUILD_DIR = config.option.bluez_build_dir.absolute()
+    if config.option.bluez_src_dir is not None:
+        utils.SRC_DIR = config.option.bluez_src_dir.absolute()
+
+    utils.DEFAULT_TIMEOUT = config.option.vm_timeout or float(
+        config.getini("vm_timeout")
+    )
+
+    worker_id = os.environ.get("PYTEST_XDIST_WORKER")
+    logfile = config.getini("log_file")
+    if worker_id is not None and logfile:
+        logfile = logfile.replace(".log", f"-{worker_id}.log")
+        with open(logfile, "wb"):
+            pass
+
+        logging.basicConfig(
+            format=config.getini("log_format"),
+            filename=logfile,
+            level=config.getini("log_file_level"),
+        )
+
+
+COLLECT_ERRORS = []
+
+
+def pytest_collectreport(report):
+    if report.outcome != "passed":
+        COLLECT_ERRORS.append((report.outcome, report.fspath))
+
+
+def pytest_collection_finish(session):
+    if session.config.option.list:
+        cwd = Path(".").resolve()
+        root = session.config.rootpath.absolute()
+
+        regex = re.compile(r"\[.*")
+        names = set(
+            (root.joinpath(item.location[0]), regex.sub("", item.location[2]))
+            for item in session.items
+        )
+
+        for path, name in sorted(names):
+            print(f"{path.resolve().relative_to(cwd, walk_up=True)}::{name}")
+        for outcome, name in COLLECT_ERRORS:
+            print(f"{outcome.upper()} {name}")
+        print()
+        os._exit(0)
+
+
+def _get_item_vm_host_setup(item):
+    callspec = getattr(item, "callspec", None)
+    if callspec is not None:
+        return (
+            callspec.params.get("vm_setup", None),
+            callspec.params.get("host_setup", None),
+        )
+    return None, None
+
+
+@pytest.hookimpl(tryfirst=True)
+def pytest_collection_modifyitems(session, config, items):
+    # Sort VM-using tests to minimize VM setup/teardown
+    def sort_key(item):
+        vm_setup, host_setup = _get_item_vm_host_setup(item)
+        key = ()
+        if vm_setup:
+            key += tuple(sorted(vm_setup.items()))
+        if host_setup:
+            key += (host_setup["name"],)
+        return key
+
+    if not config.option.list:
+        items.sort(key=sort_key)
+
+    # Specify default groups for pytest-xdist --dist loadgroup
+    if config.pluginmanager.has_plugin("xdist"):
+        for item in items:
+            if item.get_closest_marker("xdist_group") is not None:
+                continue
+
+            _, host_setup = _get_item_vm_host_setup(item)
+            if not host_setup or not host_setup["reuse"]:
+                continue
+
+            xdist_group = "reuse-{}".format(host_setup["name"])
+            item.add_marker(pytest.mark.xdist_group(xdist_group))
+
+
+#
+# Logging customization:
+#
+# - pattern-based log filtering
+# - log entry reordering to timestamp order
+# - logging test stages and outcomes to test log file
+#
+
+
+def pytest_sessionstart(session):
+    _enable_log_filters(session.config)
+
+
+def _enable_log_filters(config, handlers=None):
+    if handlers is None:
+        handlers = logging.root.handlers
+
+    allow = set()
+    deny = set()
+
+    if config.option.log_filter is not None:
+        for item in config.option.log_filter:
+            for name in item.split(","):
+                if name.startswith("+"):
+                    allow.add(name[1:])
+                elif name.startswith("-"):
+                    deny.add(name[1:])
+                else:
+                    allow.add(name)
+
+        utils.LogNameFilter.enable(handlers, allow, deny)
+
+    if not config.option.no_log_reorder:
+        utils.LogReorderFilter.enable(handlers)
+
+    for handler in handlers:
+        fmt = getattr(handler, "formatter", None)
+        if hasattr(fmt, "add_color_level"):
+            fmt.add_color_level(utils.OUT, "white")
+
+
+def pytest_sessionfinish(session):
+    utils.LogNameFilter.disable(logging.root.handlers)
+    utils.LogReorderFilter.disable(logging.root.handlers)
+
+
+@pytest.hookimpl(wrapper=True)
+def pytest_runtest_logstart(nodeid, location):
+    utils.LogReorderFilter.flush_all()
+    yield
+
+
+def status_log_stage(name, stage):
+    status_log.info(f"\n\n==== {name}: {stage} ====")
+
+    try:
+        yield
+    except:
+        utils.LogReorderFilter.flush_all()
+        raise
+
+
+@pytest.hookimpl(wrapper=True)
+def pytest_runtest_setup(item):
+    _enable_log_filters(item.session.config, logging.root.handlers[-1:])
+    yield from status_log_stage(item.nodeid, "setup")
+
+
+@pytest.hookimpl(wrapper=True)
+def pytest_runtest_call(item):
+    yield from status_log_stage(item.nodeid, "call")
+
+
+@pytest.hookimpl(wrapper=True)
+def pytest_runtest_teardown(item, nextitem):
+    yield from status_log_stage(item.nodeid, "teardown")
+    utils.LogReorderFilter.flush_all()
+
+
+@pytest.hookimpl(wrapper=True)
+def pytest_report_teststatus(report, config):
+    if not isinstance(report, pytest.TestReport):
+        return (yield)
+
+    key = (report.nodeid, report.when)
+    if key not in status_log_seen:
+        status_log_seen.add(key)
+        outcome = (
+            report.outcome.upper() if report.when == "call" or report.failed else "done"
+        )
+        status_log.info(f"\n==== {report.nodeid}: {report.when} {outcome} ====\n")
+        if report.failed:
+            status_log.error(str(report.longrepr))
+            for header, content in report.sections:
+                if header.startswith("Captured log"):
+                    continue
+                status_log.error(f"--- {header} ---\n{content}")
+                status_log.error(f"---")
+
+    return (yield)
+
+
+@pytest.hookimpl(wrapper=True)
+def pytest_runtest_logfinish(nodeid, location):
+    utils.LogReorderFilter.flush_all()
+    yield
+
+
+#
+# Fixtures
+#
+
+
+@pytest.fixture(scope="session")
+def kernel(pytestconfig):
+    """
+    Fixture for kernel image. Skips tests if no kernel available.
+
+    Yields:
+        kernel (str): path to the kernel image
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
+    Fixture for available HW USB controllers. Skips tests if not available.
+
+    Yields:
+        usb_indices: list of usb controller names (hci0, hci1, ...)
+        messages: error messages associated with each
+    """
+    usb_indices = pytestconfig.getoption("usb")
+
+    if usb_indices is None:
+        usb_indices = os.environ.get("FUNCTIONAL_TESTING_CONTROLLERS")
+
+    if usb_indices is None:
+        usb_indices = [item.name for item in Path("/sys/class/bluetooth").iterdir()]
+    else:
+        usb_indices = usb_indices.replace(",", " ").split()
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
+    """
+    Host setup configuration
+
+    Yields:
+        dict[setup: tuple[HostPlugin], name: str, reuse: bool]
+    """
+    if getattr(request, "param", None) is None:
+        raise pytest.fail("host setup not specified")
+
+    for plugins in request.param.get("setup", ()):
+        for plugin in plugins:
+            plugin.presetup(request.session.config)
+
+    return request.param
+
+
+@pytest.fixture(scope="session")
+def vm_setup(request):
+    """
+    VM setup configuration
+
+    Yields:
+        (num_hosts: int, hw_controllers: bool)
+    """
+    if getattr(request, "param", None) is None:
+        raise pytest.fail("env setup not specified")
+
+    return request.param
+
+
+def _vm_impl(request, kernel, num_hosts, hw, mem):
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
+    with env.Environment(
+        kernel,
+        num_hosts,
+        usb_indices=usb_indices,
+        mem=mem,
+        timeout=utils.DEFAULT_TIMEOUT,
+    ) as vm:
+        yield vm
+
+        _close_hosts(request, vm, vm.reuse_group)
+
+
+def _hosts_impl(request, vm, setup, name, reuse):
+    vm_timeout = utils.DEFAULT_TIMEOUT
+    timeout = vm_timeout
+
+    if not reuse or vm.reuse_group != name:
+        _close_hosts(request, vm, vm.reuse_group)
+
+    # Start VM if it was stopped
+    if vm.path is None:
+        vm.start()
+
+    for idx, (h, plugins) in enumerate(zip(vm.hosts, setup)):
+        timeout = max(vm_timeout * len(plugins) ** 0.5, timeout)
+
+        h.set_instance_name(f"{name}.{idx}")
+
+        for p in plugins:
+            h.start_load(p)
+
+    for h in vm.hosts:
+        h.wait_load(timeout=timeout)
+
+    yield vm.hosts
+
+    if not reuse:
+        _close_hosts(request, vm, name)
+
+    vm.reuse_group = name if reuse else None
+
+
+def _close_hosts(request, vm, name):
+    if name is None:
+        return
+
+    success = True
+    try:
+        vm.close_hosts()
+    except:
+        success = False
+        warnings.warn(traceback.format_exc())
+    finally:
+        _copy_host_files(vm)
+
+        # Stop VM if tester is not responding
+        if not success:
+            vm.stop()
+
+
+def _copy_host_files(vm):
+    for j, h in enumerate(vm.hosts):
+        path = Path(h._path).parent / f"shared-{j}"
+        for f in path.iterdir():
+            if f.name.startswith("test-functional-"):
+                shutil.copyfile(f, f.name)
+                os.unlink(f)
+                if f.name.endswith(".core"):
+                    warnings.warn(f"Core dump: {f.name}")
+
+
+@pytest.fixture(scope="package")
+def vm(request, kernel, vm_setup):
+    """
+    Session-scope virtual machine fixture. Used internally by `hosts`.
+
+    Yields:
+        env.Environment
+    """
+    yield from _vm_impl(request, kernel, **vm_setup)
+
+
+@pytest.fixture
+def hosts(request, vm, host_setup):
+    """
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
+    """
+    yield from _hosts_impl(request, vm, **host_setup)
+
+
+# Same with single-test scope:
+
+
+@pytest.fixture
+def vm_once(request, kernel, vm_setup):
+    """
+    Function-scope virtual machine fixture. Used internally by `hosts_once`.
+
+    Yields:
+        env.Environment
+    """
+    yield from _vm_impl(request, kernel, **vm_setup)
+
+
+@pytest.fixture
+def hosts_once(request, vm_module, host_setup):
+    """
+    Function-scope fixture. Same as `hosts`, but spawn separate VM
+    instances for this test only.
+
+    Example:
+
+        def test_something(hosts_once):
+            host0 = hosts_once[0]
+            host1 = hosts_once[1]
+    """
+    yield from _hosts_impl(request, vm_module, **host_setup)
diff --git a/test/pytest_bluez/rpc.py b/test/pytest_bluez/rpc.py
new file mode 100644
index 000000000..098c62f2a
--- /dev/null
+++ b/test/pytest_bluez/rpc.py
@@ -0,0 +1,385 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+    "RemoteTimeoutError",
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
+        tb = "\n    ".join(self.traceback.split("\n"))
+        return f"{self.exc}\nRemote traceback:\n    {tb}"
+
+
+class RemoteTimeoutError(TimeoutError):
+    pass
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
+    conn = Connection(stream, None)
+
+    while True:
+        try:
+            msg = conn._recv()
+        except BrokenPipeError:
+            log.info("server: end of input")
+            return
+
+        message = msg["message"]
+        ident = msg.get("ident", None)
+
+        if message in ("call", "call-noreply"):
+            log.info(f"server: {msg['method']} {msg['a']} {msg['kw']}")
+            try:
+                method = getattr(implementation, msg["method"])
+                result = method(*msg["a"], **msg["kw"])
+                if message == "call":
+                    conn._send("call:reply", result=result, ident=ident)
+            except BaseException as exc:
+                if message == "call":
+                    conn._send(
+                        "call:reply",
+                        error=exc,
+                        traceback=traceback.format_exc(),
+                        ident=ident,
+                    )
+                else:
+                    log.error(traceback.format_exc())
+            log.debug(f"server: reply")
+        elif message == "hello":
+            conn._send("hello:reply", ident=ident)
+        elif message == "quit":
+            method = getattr(implementation, "teardown", None)
+            exc_info = {}
+            if method is not None:
+                try:
+                    method()
+                except BaseException as exc:
+                    log.error(f"implementation quit() failed: {exc}")
+                    exc_info = dict(error=exc, traceback=traceback.format_exc())
+
+            log.info(f"server: quit")
+            conn._send("quit:reply", ident=ident, **exc_info)
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
+    log.debug(f"client: connect")
+
+    wait = 0.5
+    end = time.time() + timeout
+    while True:
+        dt = end - time.time()
+        if dt <= 0:
+            raise RemoteTimeoutError("Failed to establish connection")
+
+        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+        try:
+            sock.connect(str(socket_path))
+        except (FileNotFoundError, ConnectionRefusedError, OSError) as exc:
+            log.debug(f"client: retry connect ({exc})")
+            sock.close()
+            time.sleep(min(0.5, dt))
+            continue
+
+        conn = Connection(sock, timeout, name=name)
+        try:
+            conn._send_reply("hello", timeout=min(wait, dt))
+            break
+        except (BrokenPipeError, TimeoutError) as exc:
+            log.debug(f"client: retry connect ({exc})")
+            sock.close()
+            conn = None
+            wait *= 1.5
+            continue
+
+    log.debug(f"client: connected")
+    return conn
+
+
+class Connection:
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
+        self._close_async = None
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
+                    raise RemoteTimeoutError("Connection recv timed out")
+            else:
+                dt = None
+
+            try:
+                r, w, x = select.select([self.stream], [], [self.stream], dt)
+            except ValueError:
+                raise BrokenPipeError()
+
+            if x:
+                raise IOError("Connection failed")
+            elif not r:
+                continue
+
+            s = self._do_recv(size - len(data))
+            if not s:
+                raise BrokenPipeError()
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
+                    raise RemoteTimeoutError("Connection send timed out")
+            else:
+                dt = None
+
+            try:
+                r, w, x = select.select([], [self.stream], [self.stream], dt)
+            except ValueError:
+                raise BrokenPipeError()
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
+            dict(message=message, **kw),
+            protocol=pickle.HIGHEST_PROTOCOL,
+        )
+        size = struct.pack("<Q", len(data))
+        self._sendall(size + data, timeout=timeout)
+
+    def _send_reply_async(self, message, timeout=None, **kw):
+        """
+        Send-reply pair. If there are unprocessed messages in
+        input queue (e.g. failed send-reply pair), those are dropped.
+
+        """
+        ident = time.time_ns()
+
+        self._send(message, timeout=timeout, ident=ident, **kw)
+
+        yield
+
+        while True:
+            reply = self._recv(timeout=timeout)
+            if reply["message"] == f"{message}:reply" and reply["ident"] == ident:
+                return reply
+            if reply["message"] == "hello":
+                # hello from different instance on the other side: our
+                # session is gone
+                self.stream.close()
+                raise BrokenPipeError("Session was terminated")
+
+    def _send_reply(self, *a, **kw):
+        try:
+            coro = self._send_reply_async(*a, **kw)
+            coro.send(None)
+            coro.send(None)
+            raise RuntimeError()
+        except StopIteration as exc:
+            return exc.value
+
+    def call_noreply(self, method, *a, **kw):
+        timeout = kw.pop("timeout", None)
+
+        self.log.info(f"client: (noreply) {method} {a} {kw}")
+        self._send("call-noreply", method=str(method), a=a, kw=kw, timeout=timeout)
+
+    def call(self, method, *a, **kw):
+        timeout = kw.pop("timeout", None)
+
+        self.log.info(f"client: {method} {a} {kw}")
+
+        reply = self._send_reply(
+            "call", method=str(method), a=a, kw=kw, timeout=timeout
+        )
+        if reply.get("error"):
+            raise RemoteError(reply["error"], reply["traceback"])
+
+        self.log.debug(f"client-reply")
+        return reply["result"]
+
+    def close(self):
+        """
+        Close connection synchronously
+        """
+        try:
+            self.close_start()
+        finally:
+            self.close_finish()
+
+    def close_start(self):
+        """
+        Initiate connection close
+        """
+        self.log.info(f"client: quit")
+        if self._close_async is not None:
+            raise RuntimeError("double close start")
+        self._close_async = self._send_reply_async("quit")
+        try:
+            self._close_async.send(None)
+        except BrokenPipeError:
+            self._close_async = None
+        except:
+            self._close_async = None
+            raise
+
+    def close_finish(self, force=False):
+        """
+        Finish connection close
+        """
+        try:
+            if self._close_async is not None and not force:
+                self._close_async.send(None)
+        except BrokenPipeError:
+            pass
+        except StopIteration as exc:
+            reply = exc.value
+            if reply.get("error"):
+                raise RemoteError(reply["error"], reply["traceback"])
+        finally:
+            self._close_async = None
+            self.stream.close()
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, type, value, tb):
+        self.close()
diff --git a/test/pytest_bluez/runner.py b/test/pytest_bluez/runner.py
new file mode 100644
index 000000000..b533f73d1
--- /dev/null
+++ b/test/pytest_bluez/runner.py
@@ -0,0 +1,20 @@
+#!/usr/bin/python3 -P
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+import sys
+from pathlib import Path
+from importlib.machinery import PathFinder
+
+
+class SelfImport(PathFinder):
+    def find_spec(self, fullname, path=None, target=None):
+        if fullname == "pytest_bluez":
+            path = [str(Path(__file__).parent / "..")]
+        return super().find_spec(fullname, path, target)
+
+
+sys.meta_path.insert(0, SelfImport())
+
+import pytest_bluez.env
+
+sys.exit(pytest_bluez.env._main_runner())
diff --git a/test/pytest_bluez/tests/__init__.py b/test/pytest_bluez/tests/__init__.py
new file mode 100644
index 000000000..fe1c85178
--- /dev/null
+++ b/test/pytest_bluez/tests/__init__.py
@@ -0,0 +1,2 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/test/pytest_bluez/tests/test_rpc.py b/test/pytest_bluez/tests/test_rpc.py
new file mode 100644
index 000000000..1e7cbc366
--- /dev/null
+++ b/test/pytest_bluez/tests/test_rpc.py
@@ -0,0 +1,62 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+import os
+import pytest
+import subprocess
+import threading
+import traceback
+
+from .. import rpc
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
+        try:
+            rpc.server_unix_socket(socket_1, impl_1)
+        except:
+            traceback.print_exc()
+            raise
+
+    def server_2():
+        try:
+            rpc.server_unix_socket(socket_2, Impl2())
+        except:
+            traceback.print_exc()
+            raise
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
+    except:
+        traceback.print_exc()
+        raise
+    finally:
+        s_1.join()
+        s_2.join()
diff --git a/test/pytest_bluez/tests/test_utils.py b/test/pytest_bluez/tests/test_utils.py
new file mode 100644
index 000000000..6d56c42ec
--- /dev/null
+++ b/test/pytest_bluez/tests/test_utils.py
@@ -0,0 +1,16 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+import os
+import pytest
+import subprocess
+import threading
+
+from .. import utils
+
+
+def test_log_stream(caplog):
+    with utils.LogStream(__name__) as log_stream:
+        log_stream.stream.write(b"hello")
+
+    (record,) = (r for r in caplog.records if r.name == __name__)
+    assert "hello" in record.message
diff --git a/test/pytest_bluez/utils.py b/test/pytest_bluez/utils.py
new file mode 100644
index 000000000..d6bb21406
--- /dev/null
+++ b/test/pytest_bluez/utils.py
@@ -0,0 +1,706 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Utilities for end-to-end testing.
+
+"""
+import os
+import sys
+import io
+import re
+import logging
+import subprocess
+import shlex
+import shutil
+import threading
+import time
+import socket
+import struct
+import time
+import select
+import fnmatch
+import heapq
+import tempfile
+import queue
+import functools
+from pathlib import Path
+
+from gi.repository import GLib
+
+__all__ = [
+    "run",
+    "find_exe",
+    "wait_until",
+    "get_bdaddr",
+    "quoted",
+    "mainloop_invoke",
+    "mainloop_wrap",
+    "mainloop_assert",
+    "LogStream",
+]
+
+
+BUILD_DIR = None
+SRC_DIR = None
+DEFAULT_TIMEOUT = 20
+SIMPLE_LOG_HANDLER = None
+
+log = logging.getLogger(f"run")
+
+OUT = 5
+logging.addLevelName(OUT, "OUT")
+
+
+def quoted(args):
+    """
+    Quote shell command
+    """
+    return " ".join(shlex.quote(arg) for arg in args)
+
+
+def bluez_src_dir():
+    if SRC_DIR is not None:
+        return SRC_DIR
+
+    src_dir = Path(__file__).parent / ".." / ".."
+    if (src_dir / "src" / "org.bluez.service").exists():
+        return src_dir
+
+    return None
+
+
+def find_exe(subdir, name):
+    """
+    Find executable, either in BlueZ build tree or system
+    """
+    src = bluez_src_dir()
+    paths = [
+        src and src / "builddir" / subdir / name,
+        src and src / "build" / subdir / name,
+        src and src / subdir / name,
+        shutil.which(name),
+        src and src / subdir / name,
+        f"/usr/libexec/bluetooth/{name}",
+    ]
+    if BUILD_DIR is not None:
+        paths.insert(0, BUILD_DIR / subdir / name)
+    for exe in paths:
+        if exe is None:
+            continue
+        exe = str(exe)
+        if exe and os.path.isfile(exe):
+            return os.path.normpath(exe)
+
+    raise FileNotFoundError(name)
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
+def wait_until(predicate, *a, timeout=None, **kw):
+    if timeout is None:
+        timeout = DEFAULT_TIMEOUT
+
+    count = max(20, round(timeout))
+    for j in range(count):
+        if predicate(*a, **kw):
+            break
+        time.sleep(timeout / count)
+    else:
+        raise TimeoutError("Timeout reached")
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
+def mainloop_invoke(func, *a, **kw):
+    """
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
+    """
+    waits = queue.SimpleQueue()
+
+    def call():
+        value = None
+        try:
+            value = func(*a, **kw)
+        except BaseException as exc:
+            value = exc
+        finally:
+            waits.put(value)
+        return False
+
+    context = GLib.MainContext.default()
+    context.invoke_full(0, call)
+    result = waits.get()
+
+    if isinstance(result, BaseException):
+        raise result
+
+    return result
+
+
+def mainloop_wrap(func):
+    """
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
+    """
+
+    @functools.wraps(func)
+    def wrapper(*a, **kw):
+        return mainloop_invoke(func, *a, **kw)
+
+    return wrapper
+
+
+def mainloop_assert(func):
+    """
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
+    """
+
+    @functools.wraps(func)
+    def wrapper(*a, **kw):
+        context = GLib.MainContext.default()
+        if not context.is_owner():
+            raise AssertionError("Function not called from GLib mainloop")
+        return func(*a, **kw)
+
+    return wrapper
+
+
+class TmpDir(tempfile.TemporaryDirectory):
+    """Temporary directory in /run; with Python < 3.10 support"""
+
+    def __init__(self, *a, **kw):
+        kw.setdefault("dir", "/run")
+        if sys.version_info >= (3, 10):
+            kw.setdefault("ignore_cleanup_errors", True)
+        super().__init__(*a, **kw)
+
+    def cleanup(self):
+        try:
+            super().cleanup()
+        except:
+            pass
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
+class LogStream:
+    """
+    Logger that forwards input from a stream to logging, and
+    optionally tees to another stream.  The input pipe is in
+    `LogStream.stream`.
+
+    """
+
+    TS_STRUCT = struct.Struct("@qq")
+    LOG_THREAD = None
+    LOG_THREAD_LOCK = threading.Lock()
+    LOG_QUEUE = queue.SimpleQueue()
+
+    def __init__(self, name, pattern=None, tee=None, stream=None):
+        if pattern is not None:
+            self._logger_pattern = (re.compile(pattern), name)
+            self.log = None
+        else:
+            self._logger_pattern = None
+            self.log = logging.getLogger(name)
+
+        self._filter_re = re.compile(
+            r"\u001b\[=[0-9]+[hl] | \u001b\[\?7l | \u001b\[2J | \u001bc | \n | \r",
+            flags=re.X,
+        )
+
+        # Use SEQPACKET socketpair: this allows obtaining log
+        # timestamps, which is important as we want as close to ns
+        # precision as possible.  Read and log data in separate
+        # threads to decouple if output is slow/blocking.
+
+        if stream is None:
+            self._in, self._out = socket.socketpair(
+                socket.AF_UNIX, socket.SOCK_SEQPACKET
+            )
+            self.stream = self._in.makefile("wb")
+        else:
+            self.stream = None
+            self._in = None
+            self._out = stream
+
+        self._tee = tee
+        self._nsec = None
+        self._start_log_thread()
+        self._read_thread = threading.Thread(target=self._run_read)
+        self._read_thread.start()
+        self._flush_event = threading.Event()
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        self.close()
+
+    def _run_read(self):
+        buf = b""
+        anc = new_anc = None
+
+        try:
+            # Enable timestamping
+            cmsg_size = socket.CMSG_SPACE(self.TS_STRUCT.size)
+            SO_TIMESTAMPNS_NEW = 64
+            res = self._out.setsockopt(socket.SOL_SOCKET, SO_TIMESTAMPNS_NEW, 1)
+
+            # Read data
+            while True:
+                data, new_anc, _, _ = self._out.recvmsg(4096, cmsg_size)
+                while b"\n" not in data:
+                    block = self._out.recv(4096)
+                    if not block:
+                        break
+                    data += block
+
+                if not data:
+                    break
+
+                buf += data
+
+                # Log full lines
+                while b"\n" in buf:
+                    if anc is None:
+                        anc = new_anc
+                    j = buf.index(b"\n")
+                    self.LOG_QUEUE.put((self, buf[: j + 1], anc))
+                    buf = buf[j + 1 :]
+                    anc = new_anc if buf else None
+        finally:
+            self._out.close()
+
+            if buf:
+                self.LOG_QUEUE.put((self, buf, new_anc))
+
+            self.LOG_QUEUE.put((self, None, None))
+
+    @staticmethod
+    def _start_log_thread():
+        with LogStream.LOG_THREAD_LOCK:
+            if LogStream.LOG_THREAD is not None:
+                return
+
+            LogStream.LOG_THREAD = threading.Thread(
+                target=LogStream._run_log, daemon=True
+            )
+            LogStream.LOG_THREAD.start()
+
+    @staticmethod
+    def _run_log():
+        # Read data
+
+        while True:
+            logger, data, new_anc = LogStream.LOG_QUEUE.get()
+            if data is None:
+                logger._flush_event.set()
+                continue
+
+            if logger._tee:
+                logger._tee.write(data)
+
+            if data[-2:] == b"\n":
+                data = data[:-1]
+
+            logger._do_log(data, new_anc)
+
+    def _get_time(self, line, anc):
+        if anc:
+            cmsg_data = anc[0][2]
+            sec, nsec = self.TS_STRUCT.unpack(cmsg_data)
+            nsec = sec * 1_000_000_000 + nsec
+        else:
+            nsec = time.time_ns()
+
+        # Force monotonic time
+        if self._nsec is None or self._nsec < nsec:
+            self._nsec = nsec
+        else:
+            self._nsec += 1
+            nsec = self._nsec
+
+        return nsec
+
+    def _do_log(self, line, anc):
+        nsec = self._get_time(line, anc)
+
+        fmt_line = line.decode(errors="surrogateescape")
+        fmt_line = self._filter_re.sub("", fmt_line)
+
+        log = self.log
+        level = OUT
+        if log is None:
+            m = self._logger_pattern[0].match(fmt_line)
+            if m:
+                name = "{}.{}".format(self._logger_pattern[1], m.group(1))
+                fmt_line = fmt_line[: m.start()] + fmt_line[m.end() :]
+                try:
+                    level = int(m.group(2))
+                    nsec = int(m.group(3))
+                except ValueError:
+                    pass
+            else:
+                name = self._logger_pattern[1]
+        else:
+            name = log.name
+
+        if SIMPLE_LOG_HANDLER is not None:
+            SIMPLE_LOG_HANDLER.emit_simple(name, level, fmt_line, nsec)
+            return
+
+        if log is None:
+            log = logging.getLogger(name)
+
+        record = _OutputLogRecord(log.name, level, fmt_line, nsec)
+        log.handle(record)
+
+    def close(self, flush=True):
+        if self._read_thread is not None:
+            if self._in is not None:
+                self.stream.close()
+                self._in.shutdown(socket.SHUT_RDWR)
+                self._in.close()
+            else:
+                try:
+                    self._out.shutdown(socket.SHUT_RDWR)
+                except OSError:
+                    pass
+
+            self._read_thread.join()
+            self._read_thread = None
+            self._flush_event.wait()
+
+    def __del__(self):
+        self.close()
+
+
+class _OutputLogRecord(logging.LogRecord):
+    """Minimal (faster) log record for output lines"""
+
+    def __init__(self, name, level, msg, nsec):
+        self.args = ()
+        self.pathname = ""
+        self.filename = ""
+        self.module = ""
+        self.exc_info = None
+        self.exc_text = None
+        self.stack_info = None
+        self.lineno = 0
+        self.funcName = ""
+        self.thread = None
+        self.threadName = None
+        self.processName = None
+        self.taskName = None
+        self.relativeCreated = None
+
+        self.name = name
+        self.msg = msg
+        self.levelname = logging.getLevelName(level)
+        self.levelno = level
+        self.nsec = nsec
+        self.created = nsec / 1e9
+        self.msecs = (nsec % 1_000_000_000) / 1_000_000 + 0.0
+
+
+class LogNameFilter(logging.Filter):
+    """
+    Filter based on fnmatch deny/allow patterns on logger name
+    """
+
+    def __init__(self, allow=(), deny=()):
+        if allow:
+            allow_re = "|".join(self._re(x) for x in allow)
+            self.allow = re.compile(allow_re)
+        else:
+            self.allow = None
+
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
+        if self.allow is not None and not self.allow.match(record.name):
+            return False
+        return True
+
+    @classmethod
+    def enable(cls, filterers, allow=(), deny=()):
+        """
+        Enable filter for all of the filterers
+        """
+        f = cls(allow, deny)
+
+        for h in filterers:
+            if any(isinstance(f, cls) for f in h.filters):
+                continue
+            h.addFilter(f)
+
+    @classmethod
+    def disable(cls, filterers):
+        """
+        Disable filter for all of the filterers
+        """
+        for h in filterers:
+            for f in list(h.filters):
+                if isinstance(f, cls):
+                    h.removeFilter(f)
+
+
+class LogReorderFilter(logging.Filter):
+    """
+    Reorder handler's log records based on timestamp
+    """
+
+    FLUSH_THREAD = None
+    FLUSH_ITEMS = []
+    FLUSH_END = threading.Event()
+
+    def __init__(self, handler):
+        self._handler = handler
+        self._queue = []
+        self._records = {}
+        self._pos = time.time_ns()
+        self._delay = 1000_000_000
+        self._lock = threading.Lock()
+
+    def filter(self, record):
+        if getattr(record, "reordered", False):
+            return True
+        self._push(record)
+        self._flush()
+        return False
+
+    def _push(self, record):
+        ts = getattr(record, "nsec", int(record.created * 1e9))
+        with self._lock:
+            heapq.heappush(self._queue, (ts, id(record)))
+            self._records[id(record)] = record
+            self._pos = max(self._pos, ts)
+
+        self._delay = max(self._delay, 2 * (time.time_ns() - ts))
+
+    def _flush(self, force=False):
+        with self._lock:
+            while self._queue and (
+                self._queue[0][0] + self._delay < self._pos or force
+            ):
+                ts, rid = heapq.heappop(self._queue)
+                record = self._records.pop(rid)
+                record.reordered = True
+                self._handler.handle(record)
+
+    @classmethod
+    def flush_all(cls):
+        """
+        Flush all log reorder filters added via enable()
+        """
+        for f in cls.FLUSH_ITEMS:
+            f._flush(force=True)
+
+    @classmethod
+    def enable(cls, filterers):
+        """
+        Enable reordering for all of the filterers
+        """
+        for h in filterers:
+            if any(isinstance(f, cls) for f in h.filters):
+                continue
+
+            f = cls(h)
+            cls.FLUSH_ITEMS.append(f)
+            h.addFilter(f)
+
+        if cls.FLUSH_THREAD is None and cls.FLUSH_ITEMS:
+            cls.FLUSH_END.clear()
+            cls.FLUSH_THREAD = threading.Thread(target=cls._flush_thread, daemon=True)
+            cls.FLUSH_THREAD.start()
+
+    @classmethod
+    def disable(cls, filterers):
+        """
+        Disable reordering for all of the filterers
+        """
+        for h in filterers:
+            for f in list(h.filters):
+                if not isinstance(f, cls):
+                    continue
+
+                cls.FLUSH_ITEMS.remove(f)
+                h.removeFilter(f)
+                f._flush(force=True)
+
+        if cls.FLUSH_THREAD is not None and cls.FLUSH_ITEMS:
+            cls.FLUSH_END.set()
+            cls.FLUSH_THREAD.join()
+
+    @classmethod
+    def _flush_thread(cls):
+        # Timed flushing
+        while not cls.FLUSH_END.wait(1.0):
+            for f in cls.FLUSH_ITEMS:
+                f._flush()
diff --git a/test/test-functional b/test/test-functional
new file mode 100755
index 000000000..a739a9554
--- /dev/null
+++ b/test/test-functional
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# See doc/test-functional.rst
+#
+export PYTHONPATH="$(dirname "$0")"
+exec python3 -m pytest -c "$(dirname "$0")"/pytest.ini "$@"
diff --git a/test/test-functional-attach b/test/test-functional-attach
new file mode 100755
index 000000000..259a25bd9
--- /dev/null
+++ b/test/test-functional-attach
@@ -0,0 +1,52 @@
+#!/usr/bin/python3
+"""
+%(prog)s
+
+Start Tmux and connect to active test-functional VM hosts.
+"""
+import re
+import os
+import sys
+import argparse
+import subprocess
+import tempfile
+from pathlib import Path
+
+def main():
+    p = argparse.ArgumentParser(usage=__doc__.strip())
+    args = p.parse_args()
+
+    sockets = []
+
+    tmpdir = Path(tempfile.gettempdir())
+    for d in tmpdir.iterdir():
+        if not d.name.startswith("bluez-func-test-"):
+            continue
+
+        for s in d.iterdir():
+            if s.name.startswith("bluez-func-test-tty-"):
+                sockets.append(s)
+
+    if not sockets:
+        print(f"No sockets in {tmpdir} to attach to")
+        return
+
+    session = "bluez-func-test"
+
+    for j, sock in enumerate(sockets):
+        name = re.sub(r".*tty-", "host", sock.name)
+
+        cmd = ["tmux"]
+        if j == 0:
+            cmd += ['new-session', '-d', '-n', name, "-s", session]
+        else:
+            cmd += ['new-window', '-d', '-n', name, "-t", f"{session}:"]
+        cmd += ["--", "socat", sock, "STDIO,rawer"]
+
+        subprocess.run(cmd, check=True)
+
+    os.execvp("tmux", ["tmux", "attach-session", "-t", session])
+
+if __name__ == "__main__":
+    main()
+    sys.exit(0)
-- 
2.53.0

