Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=195.140.195.201
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793381484;
	b=1EWzNflns8jSccSazyx+C0vnUvRX5vSa/m6hYNk3WT/K0cTeztxT10RbQsJGqe7ZcqXn
	 Em+rxQ444mRyNmwtE+Wjek6BissCuS7Q0s2M2h6v0BJUiWny8fzC1BlU9HwQajbxqFHov
	 ZZVd6KPZbWeFeLN06+fOjX6KpBNvwgCVgdiymzct+Q98I8FKslUK8h2XDsdsuoH+Rpin8
	 Cqjv/dJU274Pyygdgd+zsYdfznJ4XiGVFlWJwL67pxDD8mVsFueOc1AMPqyx5Dsu3fAt+
	 xJ3sbfAng1sBWA9vCMabV/F7z48yIJq63PCH2CHq9h+B+ZsXSHKYDbvi7R/xhaAMnzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381484;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7F0Sf8wPiQ5jV/xNnZHK0Gq3+iOyhEZ3KmpFQ07XjTE=;
	b=R12ZjPwHomzJ36kHDJNV9OqZ6+tZA/dr6sJSa7snLBPM/XV7XBmcCwrG+fFrfDMrGlW4
	 AC2DKqPM3I0H4vpwvXfXtNMPEHq1l99/eMcaJkgqqOctJBrCCH9IJ842W609gsa0SS6nE
	 yAlqYVNT5ufGPBIKvhtfWdRUUir8bycpiIJDBoOODCGR1ffu7c4m29kHXruL7B5yp3y6c
	 +R3zRI93Z8MnvSBBGk7tiRrBs8Dn97APL0cHj0gNtk3kAIpWyWZJ4AufJ5QrGwHKgYscu
	 CCS6TikTxdr7+cDwc3is5d8Dyq0A2aq/b0Ndrg62JTEHI1MyJ4uLK23nRDhAsdjtKYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=meesny header.b=Yq+LszaH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=195.140.195.201
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25E606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 17:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE25E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=meesny header.b=Yq+LszaH
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4jGSnJ2zCFzyQC;
	Fri, 30 Oct 2026 19:31:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1793381476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7F0Sf8wPiQ5jV/xNnZHK0Gq3+iOyhEZ3KmpFQ07XjTE=;
	b=Yq+LszaHzApyA6ECTTM2gAfxpEQWW7yj2MK6oCFSH2Mm+eBMgFmkZI2uVdzANasuIDFadj
	xPUZhQWm7p5w3sC/sESpMC/FggiuZP3nR3KxBAiGNrkt3CTt+Zteqx+QIIfNfOwxrw8IiW
	bWfHh7nTU4uLLxZdSAxo7ozUW7ZmJCU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1793381476;
	b=LEQtPnUs/7oASkkU02CvmDXucnRqxMR/tF2sZsdqdZzS14Ojd4G+xAiraHGhbIZvo2jDe0
	W9uT0QcYfb0TpEQpOpOsmXx96O1J4PfMkiJsP2Resi2+8oOsAQCt5t839IqRvKHMsDXJYk
	UyJXWtkx2TW5H8S0V8UeGYLf6ls3pgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1793381476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7F0Sf8wPiQ5jV/xNnZHK0Gq3+iOyhEZ3KmpFQ07XjTE=;
	b=tsKXnxAkHIXcozjMUlAG/XiCshPAuqAEaumz2CML0/ow0sRYkENWNdLLr8XUbvxRluGQUh
	jeoWbyT3c1XOND1yyJrJwK7fEttCpQKec38C/dQX9ODKRyMw9sDOM0Lkyo5XCNF3YBphGo
	i0wl3b8HZBB/F5ZeCg9i74dSLAOUDIs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RESEND BlueZ] test: functional: retry pairable when Busy
Date: Fri, 30 Oct 2026 19:31:12 +0200
Message-ID: <45f6af417f7b09d62d76bf128c1d6d22189bb2f7.1793381304.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
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

Link: https://lore.kernel.org/all/6ae4b5dc.60f493e6.387f6f.e5a9@mx.google.com/
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

