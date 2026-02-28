Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76342847C
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283106; cv=pass; b=b2TQ2eXsEOSrxFMnDgfA+31+D5QKN8DstoZhpTMyBkji7wEgXSAf36a7C/rhEDFIlNVULPUC8xKHv777thoSa0aQyfpFbrR9CkIDxeJ+XGmm9aHFPRvw4p2vwzX9SyLEHcFyactrRfMy1aJZ/ng+8dVcmmgdsV+EFvfLSkByoe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283106; c=relaxed/simple;
	bh=HG6hh6UG2/EJRjAncAkZFIRXepbOo2UXVoa6om2jiKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjcGBG4HXoYc7bB1zqme/Jn23Vvh9Fqlqv89pZeX0+xhhtI5Os/m/zCUp1Mkr76ilaRs6ENVja+fvaBw+ywavLSeDSQXiZO8Sr/ai1H7G673uoi1+c3e0aL8IMr/EuPa4Sl0Ph/eyB/d+pdIDHR8IoQ/Pm8R597rGuDuny+KIGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dslfblS9; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dslfblS9"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fNQ7H3gNHzyQL;
	Sat, 28 Feb 2026 14:51:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1772283099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S55xfYXbE2JD88Xmi6+GMII/7kWxBnRpu07vB/JNgQ=;
	b=dslfblS91zL2KP8mqSMWE3j6m9IUzLa5a0Sja+3099Q0z30aJ1ESGWUBURuo4Bwha00hKn
	e7RVYfm7DDUNZYKuRQBUEISZdL8N6IUKrPC/Cq7a5+uH1X1S7rYe+wwSXlja3Cn/4hWQJe
	ZMb8dmglCq3PglJEqLQ03G8/Gm/UdAE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1772283099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S55xfYXbE2JD88Xmi6+GMII/7kWxBnRpu07vB/JNgQ=;
	b=P2Hp6au9gZZCj2jgL+YPMa3f4WuyWDswLg+Xjri2dN3JU52XITzNXBXW+CHgadB622oGjp
	EzUIMlaIYIEkQwqQ4bx8LKgaIXTV8VfOBYA4k6zgb/qTqdp8pPqve5ItyVRl1B3BNmQeFt
	iygCU5l22wk0MvIfUwhYRG5MOKlw9+I=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1772283099;
	b=eCmfSK8oylogHUzjUEjQgthaz6L739XygfqKk0ti+8PSHVyYwVgDmi+56mYB/rDdrZNIZi
	d74A7lXKkpJAM9ElZtHMV+rmSSfg3oa5A4yzl525Fj9JzGB4KL43r2lo9ftBLMZAPSo25l
	3ZniG+KI32RnhEn7YV38o7K05OMO5KU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 10/11] unit: func_test: add Pipewire-using smoke tests
Date: Sat, 28 Feb 2026 14:51:16 +0200
Message-ID: <e7359d3f3a63605e288b25a843383f47d27dc657.1772282574.git.pav@iki.fi>
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

Add test for Pipewire hosts connecting A2DP/HFP BREDR services to each
other
---
 unit/func_test/test_pipewire.py | 137 ++++++++++++++++++++++++++++++++
 unit/pytest.ini                 |   1 +
 2 files changed, 138 insertions(+)
 create mode 100644 unit/func_test/test_pipewire.py

diff --git a/unit/func_test/test_pipewire.py b/unit/func_test/test_pipewire.py
new file mode 100644
index 000000000..5cec35b2b
--- /dev/null
+++ b/unit/func_test/test_pipewire.py
@@ -0,0 +1,137 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+"""
+Tests for Pipewire audio
+"""
+import sys
+import os
+import pytest
+import subprocess
+import tempfile
+import time
+import logging
+import json
+import dbus
+from pathlib import Path
+
+from .lib import (
+    HostPlugin,
+    host_config,
+    find_exe,
+    Bluetoothd,
+    Bluetoothctl,
+    DbusSession,
+    LogStream,
+)
+
+pytestmark = [pytest.mark.vm, pytest.mark.pipewire]
+
+log = logging.getLogger(__name__)
+
+
+class Pipewire(HostPlugin):
+    name = "pipewire"
+    depends = [DbusSession(), Bluetoothd()]
+
+    def __init__(
+        self,
+        uuids=(
+            "0000110a-0000-1000-8000-00805f9b34fb",
+            "0000110b-0000-1000-8000-00805f9b34fb",
+        ),
+    ):
+        self.uuids = tuple(uuids)
+        try:
+            self.exe_pw = find_exe("", "pipewire")
+            self.exe_wp = find_exe("", "wireplumber")
+            self.exe_dump = find_exe("", "pw-dump")
+        except FileNotFoundError:
+            pytest.skip("skip", allow_module_level=True, reason="Pipewire not found")
+
+    def setup(self, impl):
+        self.tmpdir = tempfile.TemporaryDirectory(prefix="pipewire-", dir="/run")
+        conf_dir = Path(self.tmpdir.name) / "config"
+        runtime_dir = Path(self.tmpdir.name) / "runtime"
+
+        conf_dir.mkdir()
+        runtime_dir.mkdir()
+
+        environ = dict(os.environ)
+
+        environ["XDG_CONFIG_HOME"] = str(conf_dir)
+        environ["XDG_STATE_HOME"] = str(runtime_dir)
+        environ["XDG_RUNTIME_HOME"] = str(runtime_dir)
+        environ["PIPEWIRE_RUNTIME_DIR"] = str(runtime_dir)
+        environ["PIPEWIRE_DEBUG"] = "2"
+        environ["WIREPLUMBER_DEBUG"] = "3"
+
+        os.environ["PIPEWIRE_RUNTIME_DIR"] = str(runtime_dir)
+
+        log.info("Start pipewire")
+
+        self.logger = LogStream("pipewire")
+        self.pw = subprocess.Popen(
+            self.exe_pw,
+            env=environ,
+            stdout=self.logger.stream,
+            stderr=subprocess.STDOUT,
+        )
+        self.wp = subprocess.Popen(
+            self.exe_wp,
+            env=environ,
+            stdout=self.logger.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+        # Wait for Pipewire's bluetooth services
+        bus = dbus.SystemBus()
+        adapter = dbus.Interface(
+            bus.get_object("org.bluez", "/org/bluez/hci0"),
+            "org.freedesktop.DBus.Properties",
+        )
+        while True:
+            uuids = [str(uuid) for uuid in adapter.Get("org.bluez.Adapter1", "UUIDs")]
+            if all(uuid in uuids for uuid in self.uuids):
+                break
+            time.sleep(0.1)
+
+        log.info("Pipewire ready")
+
+    def pw_dump(self):
+        ret = subprocess.run(["pw-dump"], stdout=subprocess.PIPE, encoding="utf-8")
+        return ret.stdout
+
+    def teardown(self):
+        log.info("Stop pipewire")
+        self.pw.terminate()
+        self.wp.terminate()
+        self.pw.wait()
+        self.wp.wait()
+        self.tmpdir.cleanup()
+
+
+@host_config(
+    [Bluetoothctl(), Pipewire()],
+    [Bluetoothctl(), Pipewire()],
+)
+def test_pipewire(hosts):
+    from .test_bluetoothctl_vm import test_bluetoothctl_pair
+
+    host0, host1 = hosts
+
+    # Pair first
+    test_bluetoothctl_pair(hosts)
+
+    # Connect
+    host1.bluetoothctl.send(f"trust {host0.bdaddr}\n")
+
+    host0.bluetoothctl.send(f"scan off\n")
+    host0.bluetoothctl.send(f"connect {host1.bdaddr}\n")
+
+    # Wait for pipewire devices to appear
+    for j in range(20):
+        text = host0.pipewire.pw_dump()
+        if "bluez_output." in text:
+            break
+        time.sleep(1)
+    else:
+        assert False, "no pipewire devices seen within timeout"
diff --git a/unit/pytest.ini b/unit/pytest.ini
index 17b695861..af780f897 100644
--- a/unit/pytest.ini
+++ b/unit/pytest.ini
@@ -3,4 +3,5 @@ log_format = %(asctime)s %(levelname)-6s %(name)-20s:  %(message)s
 log_level = 0
 log_file = test-functional.log
 markers =
+    pipewire: tests requiring Pipewire
     vm: tests requiring VM image
-- 
2.53.0

