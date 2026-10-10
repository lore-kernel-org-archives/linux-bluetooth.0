Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A37331A6E
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791671583; cv=pass; b=gobrXWwXtPQ60iG4ImR78fI6m0S6hCWSWJ2rdjNSB2EGXqPk9Xk9yT2Xd6EznvtWAl2qANjspMNKq/9N67TKWLT2DRqNrHIX5NZm0t6266yWYOezyIjIBAMxPnj5sYNeIE/UD0HHEA6AsJ3LD7T1yE+BBWMG3gTaYQb7Lz/uf4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791671583; c=relaxed/simple;
	bh=K2AC1JLoD/6Ca5qPd/Z1f8Hkg7IsuspGY2ArWUaKX/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0hjlPdhSBJKQcxSXv++rYoNYu290BNsj7qxh0RO/OYWt+l4kZtxBE1T5FnM0rDsBRP2fKaPVg+B9KEqfymMRfS+/2WAmiqp5nhenZI7Xg84TMxmSdk9x5jcFXarLylX2ZePPOt5xDSqhe7Z5yPVA9B+fT9p/NXB9qXZ70fwycs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qq47JK/t; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qq47JK/t"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2JQZ1cs8zyRv;
	Sun, 11 Oct 2026 01:32:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791671574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BFBpnT6SxLOsgieFz3EXRnoc+Ng66YklPY1NGEN+Qkw=;
	b=qq47JK/tnZdMuLlT4CH6ZUwv3p07JXXP7tzjY1r+HprErYpHW0KGEH8Jg2dOHJ1OkxITqY
	mPCnMgEkxqVFcR6i4vX0083LxbOA46NUArvFMHO9pXcvJkoQnJBFuu1Rt/V3Ue7vrRGy23
	uE5+XTbaBG9DpdhF8kH5MlT3RC4MeL0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791671574;
	b=peaXi3oh16RqjN1LHZ58j/RQY4tcxaV6Fdy8e16vlGHMXQuZYtTCDeevz9CApShYKSmTLj
	ILb1AHjNIVHQuBG5/XOl23EunxhYQFfCbjqfJcltGIe6s/XQ7i4hgkbfQjXDged96Arxgs
	R5ZiEUK8I1MKZjPBu4T5tRsrWbjjGhg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791671574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BFBpnT6SxLOsgieFz3EXRnoc+Ng66YklPY1NGEN+Qkw=;
	b=eEEqPcFJh04ExgQymAi8swXWSDLMONbewu9qivabq8pLT+LrEtxpp6M19qE6tymq4smhej
	PhsTFit0mVgmOkWRAnggInQOcE/EpWqwfs2gt3dXk2KZMZ/iEOr6bc7/l4myyvrjwHyXeq
	WnBKBAKRo5XrI3bTRKgHcWERz0Axv/Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] test: functional: retry pairable when Busy
Date: Sun, 11 Oct 2026 01:32:50 +0300
Message-ID: <32b040dbaa0b8bffa4746203c5232791574604ee.1791671481.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bluetoothctl registers an agent on connect, which toggles bondable.
Before it completes, "pairable on" fails with org.bluez.Error.Busy.

Retry "pairable on" until accepted via a pairable_on() helper.

Fixes flaky test_bluetoothctl_pair_bredr / a2dp tests.

Log:
src/agent.c:add_default_agent() Default agent set to :1.2 /org/bluez/agent
src/adapter.c:set_mode() sending set mode command for index 0
src/agent.c:agent_ref() 0x7c1fb6700110: ref=1
src/agent.c:register_agent() agent :1.2
[:1.2:method_return] < [#22]
[:1.2:method_call] > org.freedesktop.DBus.Properties.Set [#31]
[:1.2:error] < org.bluez.Error.Busy [#31]
src/shared/mgmt.c:send_request() [0x0000] command 0x0009
src/shared/mgmt.c:can_read_data() [0x0000] command 0x0009 complete: 0x00
src/adapter.c:new_settings_callback() Settings: 0x03fc0ad1
src/adapter.c:settings_changed() Changed settings: 0x00000010
[bluetoothctl]> 	SupportedUUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[bluetoothctl]> 	SupportedUUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[bluetoothctl]> Agent registered
[bluetoothctl]> Failed to set pairable on: org.bluez.Error.Busy

Assisted-by: opencode:qwen3.8-flash-next
---
 test/functional/test_a2dp.py         |  5 +++--
 test/functional/test_bluetoothctl.py | 25 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/test/functional/test_a2dp.py b/test/functional/test_a2dp.py
index 12348ea05..4cf4eb296 100644
--- a/test/functional/test_a2dp.py
+++ b/test/functional/test_a2dp.py
@@ -9,6 +9,8 @@ import pytest
 from pytest_bluezenv import Bluetoothd, Pexpect, find_exe, host_config
 from pytest_bluezenv.utils import bluez_src_dir
 
+from .test_bluetoothctl import pairable_on
+
 pytestmark = [pytest.mark.vm]
 
 A2DP_SOURCE_UUID = "0000110a-0000-1000-8000-00805f9b34fb"
@@ -50,8 +52,7 @@ def pair(host0, ctl0, host1, ctl1):
     ctl0.send("scan on\n")
     ctl0.expect(f"Controller {host0.bdaddr.upper()} Discovering: yes")
 
-    ctl1.send("pairable on\n")
-    ctl1.expect("Changing pairable on succeeded")
+    pairable_on(ctl1)
     ctl1.send("discoverable on\n")
     ctl1.expect(f"Controller {host1.bdaddr.upper()} Discoverable: yes")
 
diff --git a/test/functional/test_bluetoothctl.py b/test/functional/test_bluetoothctl.py
index e8c813a7a..1486d9e99 100644
--- a/test/functional/test_bluetoothctl.py
+++ b/test/functional/test_bluetoothctl.py
@@ -20,6 +20,28 @@ from pytest_bluezenv import host_config, find_exe, run, Bluetoothd, Bluetoothctl
 pytestmark = [pytest.mark.vm]
 
 
+def pairable_on(ctl):
+    """pairable on for given Bluetoothctl/Pexpect
+
+    Allow failure with org.bluez.Error.Busy, which can occur due to
+    bluetoothctl toggling bondable on startup. Retry until accepted.
+    """
+    while True:
+        ctl.send("pairable on\n")
+        idx, groups = ctl.expect(
+            [
+                "Changing pairable on succeeded",
+                r"Failed to set pairable on: (\S+)\r?\n",
+            ]
+        )
+        if idx == 0:
+            return
+
+        error = groups[0].decode()
+        if error != "org.bluez.Error.Busy":
+            raise AssertionError(f"Failed to set pairable on: {error}")
+
+
 @pytest.fixture
 def bluetoothctl():
     try:
@@ -41,8 +63,7 @@ def test_bluetoothctl_pair_bredr(hosts):
     host0.bluetoothctl.send("scan on\n")
     host0.bluetoothctl.expect(f"Controller {host0.bdaddr.upper()} Discovering: yes")
 
-    host1.bluetoothctl.send("pairable on\n")
-    host1.bluetoothctl.expect("Changing pairable on succeeded")
+    pairable_on(host1.bluetoothctl)
     host1.bluetoothctl.send("discoverable on\n")
     host1.bluetoothctl.expect(f"Controller {host1.bdaddr.upper()} Discoverable: yes")
 
-- 
2.56.0

