Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603E369985
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041086; cv=pass; b=M6pPu0VGDy6H5lkfY5YRrHMMOTRi1cUhu1cQsnfNJuB4lYEF+vyaTNA6K3CRghGxIXXeRyt14Oq1YzOHDAiQH6Y1oqXBg4CKjAF3gVwl2nOkz1FgFFyLEQx4zOCjsAGendhacMn5YBttTZSBW+ULyGzROUd2qQ+y4bFErxg0Hfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041086; c=relaxed/simple;
	bh=eo+0pyXBETP/5tHfnjU7hhQjMnjOusmHkdVPCmYKnbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oag+zv+yT2oH1jRXWVR2mEnSrIcLBm867iT5QcfMf5A8P5UUZUR3sj96lTUzYBjX/OFJy3o2DG2AyoPSgyu8NgxGx89Thf5TBDL052l7Up1TMt3lkYhRZnnjLg9jQ0VYK+6jjYSbXdaWoPT9+PZb0EuSp7EDR9mLF2XXN0K+2Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BsITxyFv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BsITxyFv"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGf6qsQzyW9;
	Fri, 20 Mar 2026 23:11:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxj/sGiAq522ZAsYHprNRZK2rt1H5SEItoz5H0mMlcU=;
	b=BsITxyFvJ3I/AyoDoJMDiByJ4QluNvPS8Gjz8RGHaPen79lRthROB5HtTfS1z3XThhFxDl
	YDr0fBJ+qkHHd1zX6sPbeMB/vNw9+bm6uVnloukoiskwXsxGhoaY1Etait0nxGaS0TfPlD
	AMZFRhkaclwogMK5z/5DWTS92My1+28=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041083;
	b=HuANASiOf1Q88GxV7u2sw+gyup/QV5nhds3+CNAq9FG9n0imnvtvYHqZKN17R+U1h02dLx
	Kmuxxgb0vq/0eNVLWv1ld4n/uuj7u3NYtr+AbIp/qkKeRLxjNhoa7eRzBESS7DXVgENYa7
	RBqWO7tpBI9Z/6NpnjIJ1vyGofJwlaU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxj/sGiAq522ZAsYHprNRZK2rt1H5SEItoz5H0mMlcU=;
	b=uhemsWdnTwJJXPjK0r/CqAvKZxEODacqB2PoSIAaDofglOKUZsgOKnvz+PLGqWObpqzZXm
	UXkYL11J1gEMYEwBOXSmrL3peAOQYlXn4qLPRJ2crDSEUnSiCZ9hcVj8pAmU51VTs1dYri
	Mh0KFlbXSq+Ff1upo34izmuzAG8Alw4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 14/20] test: functional: add --btmon option to start btmon
Date: Fri, 20 Mar 2026 23:10:58 +0200
Message-ID: <12d28808037fafaa4b821d013ed3604ae680d1b2.1774041047.git.pav@iki.fi>
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
index 0135b05d2..6254f01c1 100644
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
index a47f097cc..786493ffb 100644
--- a/test/pytest_bluez/plugin.py
+++ b/test/pytest_bluez/plugin.py
@@ -10,6 +10,7 @@ from pathlib import Path
 import pytest
 
 from . import utils, env
+from .btmon import Btmon
 
 
 __all__ = [
@@ -109,6 +110,11 @@ def pytest_addoption(parser):
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
@@ -447,6 +453,9 @@ def _hosts_impl(request, vm, setup, name, reuse):
 
         h.set_instance_name(f"{name}.{idx}")
 
+        if request.session.config.option.btmon:
+            plugins = (Btmon(),) + plugins
+
         for p in plugins:
             h.start_load(p)
 
@@ -465,18 +474,24 @@ def _close_hosts(request, vm, name):
     if name is None:
         return
 
-    success = True
     try:
-        vm.close_hosts()
-    except:
-        success = False
-        raise
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
+            raise
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

