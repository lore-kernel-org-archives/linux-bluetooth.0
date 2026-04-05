Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DE34752A
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392886; cv=pass; b=OjYLkc/jSBQME1Qw3XXjQzKU5Ul42EhIaIyp/9zn7Zxh7HOPrt0Nr4KlK1wg7u8Wx/zxhxO+hoKiA6fEtT7kxvm9ENMG9ISmu4AheAM52b5eSzZx/ljnV2rVdRSY1QsNfsC6nHU3W1iEBsuVdDyxcKwK+VjspHYoen70LHLuM78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392886; c=relaxed/simple;
	bh=t6JpcX9hvH/kiPaZfXNnPG+t+8U7dl70qvtdtuvLrf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjLHrvUvi2BacybPiFlD1mUI56cgYESfvNerlG78CArWPCtHHW80g3qA083fR2odFp9L04TjcxUl2WvaDSEm7XAyyy9Ox3GviON9vypREavRMZsYiK7IhUyWerlq5D9dUHAlKrhmnjMCAh1+A37rj/vhcHfPrLoVnb6bI0aKjW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=P/JXrUQ8; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="P/JXrUQ8"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpXBk2NM6zyxJ;
	Sun, 05 Apr 2026 15:41:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3T8dqS3YL1lMe8iLj91OTICICWJNtnWRy+JtHSO/es=;
	b=P/JXrUQ8ork6A3gNPw+/W7YANXY5ypdpjzouh64DnhLF4k0HpHJ5AVg9lahdYCd80GlbZO
	P4DEyQIbZtyOabGC/mPpU0NLwaq6oR12AuHltRBX3+aZIHb3kM/puw8hTG5zdpCdrDYH9N
	FsWqi2eqSf+CX+jrQ4wfmKYymtYx9YE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3T8dqS3YL1lMe8iLj91OTICICWJNtnWRy+JtHSO/es=;
	b=U64Oi+SJW46JpatFLQNK+9TXDEHpvfqLOssLAqIpF0Fyy+ctVfUzznslaRQ52HaE07keqj
	aZlsiJf+A4yd0m2d6HJVfUkeqDSXAF7x4tztCIntxUdEom8NXoRR6au7rFWg1hwtx0WNXI
	ZbqExbeTftZH+AkOtxnkjavK/d9UNp0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392878;
	b=ab+PLL9I++gcm7qjaqirmqkKe5JMIMZjoXealImEOCnLeiJMY8/h1RAZlJjilr9IBKBz+E
	mVSpGY5qO62GVHyjjzthaLLqaEe0v5ZWdOcKbgEClU5UPgD0xch3/306Zx7C8V6fsCtSXw
	oNkj+F/mRA6Ed2UEyU20R6NS3BHixWU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 14/20] test: functional: add --btmon option to start btmon
Date: Sun,  5 Apr 2026 15:39:55 +0300
Message-ID: <8deb41a034f1c5d047a030a00534ad409658233d.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After test finishes, any btmon dumps created are copied to current
working directory.
---
 doc/test-functional.rst       |   9 +++
 test/pytest_bluez/__init__.py |   1 +
 test/pytest_bluez/btmon.py    | 116 ++++++++++++++++++++++++++++++++++
 test/pytest_bluez/plugin.py   |  33 +++++++---
 4 files changed, 150 insertions(+), 9 deletions(-)
 create mode 100644 test/pytest_bluez/btmon.py

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index f51401930..8c392ff73 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -34,6 +34,9 @@ The following additional options apply:
 	environment variable is used. If none, all USB controllers
 	with suitable permissions are considered.
 
+:--btmon: Launch btmon on all hosts to log events, and dump traffic to
+	test-functional-\*.btsnoop
+
 :--force-usb: Force tests to use USB controllers instead of `btvirt`.
 
 :--vm-timeout=<seconds>: Specify timeout for communication with VM hosts.
@@ -726,6 +729,12 @@ Bluetoothd
 
 Host plugin starting Bluetoothd.
 
+Btmon
+-----
+
+Host plugin providing btmon running in the background.
+Usually should be loaded via `--btmon`.
+
 Call
 ----
 
diff --git a/test/pytest_bluez/__init__.py b/test/pytest_bluez/__init__.py
index cb4dca71c..9e967d472 100644
--- a/test/pytest_bluez/__init__.py
+++ b/test/pytest_bluez/__init__.py
@@ -6,5 +6,6 @@ from .rpc import RemoteError
 from .env import *
 from .utils import *
 from .host_plugins import *
+from .btmon import *
 
 from .plugin import *
diff --git a/test/pytest_bluez/btmon.py b/test/pytest_bluez/btmon.py
new file mode 100644
index 000000000..6a03353dd
--- /dev/null
+++ b/test/pytest_bluez/btmon.py
@@ -0,0 +1,116 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+VM host plugin for btmon
+"""
+import os
+import re
+import subprocess
+import tempfile
+import logging
+import time
+
+from . import env, utils
+
+__all__ = [
+    "Btmon",
+]
+
+
+class Btmon(env.HostPlugin):
+    """
+    Host plugin running btmon and forwarding output to logging. Parses
+    timestamps output by btmon.
+
+    """
+
+    name = "btmon"
+
+    def __init__(self, args=None):
+        self.args = None if args is None else list(args)
+        self.end_time = None
+
+    def setup(self, impl):
+        self.log = logging.getLogger(self.name)
+
+        subprocess.run(["mount"])
+
+        self.dumpfile = f"/run/shared/test-functional-{impl.instance_name}.btsnoop"
+
+        if self.args is None:
+            self.args = [
+                "-S",
+                "-A",
+                "-I",
+                "--color=always",
+                f"--columns=160",
+                "-w",
+                self.dumpfile,
+            ]
+
+        exe = utils.find_exe("monitor", "btmon")
+        self.log_stream = BtmonLogStream("btmon")
+        cmd = [exe, "-T"] + self.args
+        self.log_stream.log.info("Starting btmon: {}".format(utils.quoted(cmd)))
+        self.job = subprocess.Popen(
+            cmd,
+            stdin=subprocess.DEVNULL,
+            stdout=self.log_stream.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+    def stop(self):
+        if self.job.poll() is None:
+            self.job.terminate()
+
+        if self.end_time is None:
+            self.end_time = time.time_ns()
+
+    def teardown(self):
+        self.stop()
+
+        self.log.info("Wait for btmon shutdown...")
+        while self.job.poll() is None and self.log_stream._nsec < self.end_time:
+            time.sleep(0.5)
+
+        self.log_stream.close()
+
+        self.job.kill()
+        self.job.wait()
+
+        self.log.info("Teardown done.")
+
+
+class BtmonLogStream(utils.LogStream):
+    """
+    Log streams that parses timestamps from btmon output
+    """
+
+    def __init__(self, name):
+        super().__init__(name)
+        self._localtime_tail = time.localtime()[6:]
+        self._time_pat = re.compile(
+            rb"\s(\d+)-(\d+)-(\d+) (\d+):(\d+):(\d+)\.(\d+)(?:$|\x1b)"
+        )
+
+    def _get_time(self, line, anc):
+        m = self._time_pat.search(line)
+        if m:
+            m = m.groups()
+            ts = (
+                int(m[0]),
+                int(m[1]),
+                int(m[2]),
+                int(m[3]),
+                int(m[4]),
+                int(m[5]),
+            ) + self._localtime_tail
+            ts = time.mktime(ts) + int(m[6]) / 10 ** len(m[6])
+            self._nsec = int(ts * 1e9)
+
+        if self._nsec is None:
+            return super()._get_time(line, anc)
+
+        nsec = self._nsec
+        self._nsec += 1
+        return nsec
diff --git a/test/pytest_bluez/plugin.py b/test/pytest_bluez/plugin.py
index 36de4a812..9f7e2b369 100644
--- a/test/pytest_bluez/plugin.py
+++ b/test/pytest_bluez/plugin.py
@@ -11,6 +11,7 @@ from pathlib import Path
 import pytest
 
 from . import utils, env
+from .btmon import Btmon
 
 
 __all__ = [
@@ -110,6 +111,11 @@ def pytest_addoption(parser):
     parser.addini(
         "vm_timeout", "Default timeout for communication with VM etc.", default="30"
     )
+    group.addoption(
+        "--btmon",
+        action="store_true",
+        help="Launch btmon on all hosts to log events, and dump traffic to test-functional-*.btsnoop",
+    )
 
     # host_plugins.Rcvbuf:
     parser.addini(
@@ -459,6 +465,9 @@ def _hosts_impl(request, vm, setup, name, reuse):
 
         h.set_instance_name(f"{name}.{idx}")
 
+        if request.session.config.option.btmon:
+            plugins = (Btmon(),) + plugins
+
         for p in plugins:
             h.start_load(p)
 
@@ -477,18 +486,24 @@ def _close_hosts(request, vm, name):
     if name is None:
         return
 
-    success = True
     try:
-        vm.close_hosts()
-    except:
-        success = False
-        warnings.warn(traceback.format_exc())
+        if request.session.config.option.btmon and name is not None:
+            for h in vm.hosts:
+                if hasattr(h, "btmon"):
+                    h.btmon._call_noreply("teardown")
     finally:
-        _copy_host_files(vm)
+        success = True
+        try:
+            vm.close_hosts()
+        except:
+            success = False
+            warnings.warn(traceback.format_exc())
+        finally:
+            _copy_host_files(vm)
 
-        # Stop VM if tester is not responding
-        if not success:
-            vm.stop()
+            # Stop VM if tester is not responding
+            if not success:
+                vm.stop()
 
 
 def _copy_host_files(vm):
-- 
2.53.0

