Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F43F413A
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689128; cv=pass; b=btKCBruAx8GC281b68Zlwhermej30y7NxffKmvM6tUvzLvGViRV4ugiQnMemn+prKmFe+cLkUj86OO+Zqfy2WoTjby2YcZB1ho1BZWdtwVPYtSP1jU7OWUZ/CdRW8rwM1bJTue6Ohc7r6bpQavA+8io6DRZgGdYQkpfymqYlaeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689128; c=relaxed/simple;
	bh=h/Fb6eDRVBtOpVVoP+ZXlqLWPwJ7nl7uhfs67k016+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOVdgQtuYHL4gJ5SI9MkJalUolGyoTKMzBZpB2BdiNXc3qqtxXxgpb8Gef1dgNjjQ42lZy9UCBdJdfBiTM0Xknpl3SK/Nm2TFFZIDde4BE6MHiPv5Fz9BnJcErsRzEFVlViCg/cmCbt3PZRr49FcLitaMbMk3L2BcHP+tImGEgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nktepwVL; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nktepwVL"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzD42M4qzywN;
	Wed, 13 May 2026 19:18:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wk+K7BVUw2yIaEsdxfEVeJahgbo1XUkkX2gXTvyboI=;
	b=nktepwVLaDK6SAe2ANwef+0asm2DO2AyiiFp5wbEOqFj9mjrxMWsoDnXP1c5rZSGx0qYYn
	MeSEprVHQku3mEZWZrdrRPPkJiiq7HRQEGU/OCgFCzQggojevR0m7e+HpptJWbNVNFcUAY
	3vTpRQahAjK+zn1/L5Q1k03FMWg22AE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689124;
	b=geXR5tgPm99088A8Qahc/mlQKiWX4fMoGEUHcrFxQCzPwnrlWnpiZHp+gQziK7AlqLtbk2
	lkeYbeNF8Lcxmxvgcc0YaQktQ1mz/w3jzL8SuSpQ12LvsuHm2mlRFzeN9Vi2rMZAnPrdgF
	KEU5Dk3fPj6aRk4K8A6K4BRGlmzDDAs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wk+K7BVUw2yIaEsdxfEVeJahgbo1XUkkX2gXTvyboI=;
	b=zMNkUffUBFE3ia7pNBC3hLtdKQhWRoHF0zAsvWTgbg/2whMFjz2+QTsmpIaq8VHwIFgKVr
	jzcVqW9ZHqI8BqRTw7+pn1lxvJ4dyCLYW1ZsG/iO2lt4jrcKmEqKKCSFIAGlpcB9/hI646
	A2ayD6L6l9Rooc3eWFXZ+HDZIIAvlgY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 12/16] test: add functional/integration testing framework
Date: Wed, 13 May 2026 19:17:29 +0300
Message-ID: <8a61c539b1202984857340669c462f622a6bbc1c.1778688966.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
References: <cover.1778688966.git.pav@iki.fi>
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

Add some smoke tests for bluetoothctl and btmgmt.

The implementation for the VM setup is maintained separately in the
pytest-bluezenv plugin, https://pypi.org/project/pytest-bluezenv

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

There is no requirement that the tests spawn VM instances.
---
 test/functional/__init__.py             |   2 +
 test/functional/conftest.py             |  48 ++++++++
 test/functional/requirements.txt        |   2 +
 test/functional/test_bluetoothctl_vm.py | 152 ++++++++++++++++++++++++
 test/functional/test_btmgmt_vm.py       |  30 +++++
 test/pytest.ini                         |  17 +++
 test/test-functional                    |  21 ++++
 test/test-functional-attach             |   7 ++
 8 files changed, 279 insertions(+)
 create mode 100644 test/functional/__init__.py
 create mode 100644 test/functional/conftest.py
 create mode 100644 test/functional/requirements.txt
 create mode 100644 test/functional/test_bluetoothctl_vm.py
 create mode 100644 test/functional/test_btmgmt_vm.py
 create mode 100644 test/pytest.ini
 create mode 100755 test/test-functional
 create mode 100755 test/test-functional-attach

diff --git a/test/functional/__init__.py b/test/functional/__init__.py
new file mode 100644
index 000000000..fe1c85178
--- /dev/null
+++ b/test/functional/__init__.py
@@ -0,0 +1,2 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/test/functional/conftest.py b/test/functional/conftest.py
new file mode 100644
index 000000000..196afa08d
--- /dev/null
+++ b/test/functional/conftest.py
@@ -0,0 +1,48 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+import os
+import re
+from pathlib import Path
+
+
+def pytest_addoption(parser):
+    parser.addoption(
+        "--list",
+        action="store_true",
+        default=None,
+        help=("List tests"),
+    )
+
+
+def pytest_configure(config):
+    if config.option.list:
+        config.option.reportchars = "A"
+        config.option.no_header = True
+        config.option.verbose = -2
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
diff --git a/test/functional/requirements.txt b/test/functional/requirements.txt
new file mode 100644
index 000000000..98b0c31d4
--- /dev/null
+++ b/test/functional/requirements.txt
@@ -0,0 +1,2 @@
+pytest>=8
+pytest-bluezenv==0.1.5
diff --git a/test/functional/test_bluetoothctl_vm.py b/test/functional/test_bluetoothctl_vm.py
new file mode 100644
index 000000000..0ba75e9a9
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
+from pytest_bluezenv import host_config, find_exe, run, Bluetoothd, Bluetoothctl
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
index 000000000..3d11d7616
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
+from pytest_bluezenv import host_config, find_exe, run
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
index 000000000..0d4e48d69
--- /dev/null
+++ b/test/pytest.ini
@@ -0,0 +1,17 @@
+[pytest]
+log_format = %(asctime)s %(levelname)-6s %(name)-20s:  %(message)s
+log_date_format = %Y-%m-%d %H:%M:%S.%f
+log_level = 0
+log_file = test-functional.log
+markers =
+    vm: tests requiring VM image
+
+addopts =
+    -p pytest_bluezenv
+
+# Default timeout
+vm_timeout = 30
+
+# Default sources for kernel-build when requested
+kernel_upstream = https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/
+kernel_branch = master
diff --git a/test/test-functional b/test/test-functional
new file mode 100755
index 000000000..9f90207b2
--- /dev/null
+++ b/test/test-functional
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# See doc/test-functional.rst
+#
+TESTDIR="$(dirname "$0")"
+SRCDIR="$TESTDIR/.."
+
+BUILDDIR=
+for d in "$SRCDIR" "$SRCDIR/build" "$SRCDIR/builddir"; do
+    if [ -f "$d/src/bluetoothd" ]; then
+        BUILDDIR="$d"
+        break
+    fi
+done
+
+if [ -n "$BUILDDIR" -a -d "$BUILDDIR" ]; then
+    exec python3 -m pytest "$TESTDIR/functional" --bluez-src-dir "$SRCDIR" --bluez-build-dir "$BUILDDIR" "$@"
+else
+    exec python3 -m pytest "$TESTDIR/functional" --bluez-src-dir "$SRCDIR" "$@"
+fi
diff --git a/test/test-functional-attach b/test/test-functional-attach
new file mode 100755
index 000000000..6e65464f7
--- /dev/null
+++ b/test/test-functional-attach
@@ -0,0 +1,7 @@
+#!/bin/sh
+#
+# test-functional-attach
+#
+# Start Tmux and connect to active test-functional VM hosts.
+#
+exec python3 -mpytest_bluezenv attach "$@"
-- 
2.54.0

