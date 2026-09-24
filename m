Received: from mail-ua2-f39.google.com (mail-ua2-f39.google.com [74.125.226.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA71361954
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258182; cv=none; b=eKQZ66heV2veWD9bYjbk5z7CULpmUCOzt16DN+5VONRZVgQvjpfNT8JzTFcktkEDpz9AmiwuapMsnT6Wn7CXIr1Z0+O7jmR+N4OJjrTzHiGcE4rqb9jP4iX3uHbgi7i70zRtVT2tDJyH/WryIqZWDXLJPKCQHTaWcyWLOKwjuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258182; c=relaxed/simple;
	bh=Iy8UPHChv766YCQn/t/ewPfHSl8ZPtzuVBy8LGnLDN4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6WviWrBLl2u4tXGLn6fqG9SVQEJ6fOOIWA/lUfWECOiJTPV/vfNKy4meEJBAQum5k93ujML47VBt3O8HTaLB1bE2dm69mBJVznceqT7SzbUq+lN5mHt/DNN/wbFtryB63WNXm5p1c//GJojRUUaeyxJzjRYK8+ywscGLY1NS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtAi43kL; arc=none smtp.client-ip=74.125.226.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtAi43kL"
Received: by mail-ua2-f39.google.com with SMTP id a1e0cc1a2514c-982db8d3b1eso681549241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258179; x=1790862979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e2z2Iyn5JDjFQKQjN0TLPBXJlosUmaljJRWpgiaxZqA=;
        b=mtAi43kLsvYOwk99QKRrM1zhCptQm9V8D4SYL78gu7mY+/cJQrPKphbvd8Zgecerd8
         uj4bjRst0jSd9RXMIENwaAVuUjIXLl50bSri41JSmxFbZ3fMAFlvaGDvMGksj5XxTZJB
         LwW13NpopsNKBzSPAhujQAF5vPP+f/hOZs2Vqe0uAdEdlRQDfq9TxNRofNliKmK6n1Dq
         ZwoX3kKN8rAWwmttgs5+QsRMHb8OmUFLGKI+8iEKy8xwSA/rvIBUXGuv5tMq9NJM+7TN
         Ygqw4b2sqdtCoFydv6Fle/sdJSZTD7hTGd77HgnC2zn2vjp8JTew+E4jjWxZJL9Y211q
         ZFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258179; x=1790862979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e2z2Iyn5JDjFQKQjN0TLPBXJlosUmaljJRWpgiaxZqA=;
        b=P2wWULRe+aX9PWCT6bHYtLiSPY1WZ9lSubpfTlDfdzh0K4GFXiUqgy6KQtk0E7hxd9
         XcIIrDhv81jzNvxTJUyNinnIdHZ7UVxLaZLJeUZmnYDvkSGvYjhCYt4eyU4c6brJuNa9
         xs0WJ2fZHrbnTQ80f6wH9ggu4YrKsidGnGVGpDK0bMOmN26FKW/RasvYtIrNGntX34aV
         PtHmoI/Nfu/wNEdZM4inv0wORHkB1TBx2qWhcbGAI0du+Z7/brbXaclTxVviarfyLLGH
         I45fNesnB+ez2lACzHqMZAoRUa/sBfb8FQlcPsSw5Cx0ILHVtili/dW22+3VyVIFkd1n
         0x/g==
X-Gm-Message-State: AFuF++lP4zwUFUMQnogxtLjwNitYYN3xs2r6+w6+2VObYIo4SmOx9Qn9
	rksuTgARbt0TnImu4mAX4y2aCTPDCCauW6lrOITAhg3M5MhzZQluY73ZKVHlPQxXdhg7vA==
X-Gm-Gg: AYBFou1phn9zzRzPEUTXC+NJZSENZEqyje3PsgZ+AG9E+6eh836OYOj2N2byUzATkEe
	HyuiVD0R3+JXXwu9vgM8ob90/638zLvbcOu+nM0clMgjASEEDJCjMcAg63PZmtB20nZDpPe8ySE
	/l1TuJlcVVUl2X6xt0zpImynwefiujncbi+IJvHNV5V7CT9CyS6Hmz0vtHyipzAMnYUqWjAYl5r
	nW0CM8TFCaksi/0tLzIiQluuuNAdrX77joiiW3fiL28tE+hz13o0ry6J4IUWzrnmR+w0BqXbgis
	QffYFEI873v0LqSiegOerRRY4NE0th3gkWQYOIUmltZilk61n1F8VXXwijzoarZQjQB+wIkF0VB
	xQDatYtWwm/MRIOodz8kuVZ45rIkJt6mSkgeIsAEVvx2ajnxKNvxbvq9CXJBnhHRcJjVd5eGST2
	5BAtG6iaS3yf/DsWHEwktC6nxeqDHryNR11bPMBvzKp3U3J2JT8bS+l3bA3zmFGkSrq/POl6yQC
	5hywYYGsTEWlOagbQZpqsLlCO7YxkfG6rfHb1WFl4ylAjUjcWGZHzk4XcKdeJta
X-Received: by 2002:a05:6102:f0b:b0:797:e5aa:61c2 with SMTP id ada2fe7eead31-7af1c58e836mr1165342137.3.1790258178504;
        Thu, 24 Sep 2026 06:56:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7af8bdcde81sm1493194137.10.2026.09.24.06.56.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:56:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/8] test: functional: add HoG tests
Date: Thu, 24 Sep 2026 09:56:00 -0400
Message-ID: <20260924135601.330277-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924135601.330277-1-luiz.dentz@gmail.com>
References: <20260924135601.330277-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add tests where bluetoothctl registers a HID Service, with and without
SCI support, using client/scripts/hog-device*.bt, and the HID host
checks the service, receives Input Reports and, with SCI support,
changes the SCI mode and the connection rate.

See doc/functional-hog.rst for details.
---
 test/functional/test_hog.py | 252 ++++++++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)
 create mode 100644 test/functional/test_hog.py

diff --git a/test/functional/test_hog.py b/test/functional/test_hog.py
new file mode 100644
index 000000000000..ea54882d059d
--- /dev/null
+++ b/test/functional/test_hog.py
@@ -0,0 +1,252 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for HID over GATT (HoG) using bluetoothctl in VM instances
+
+The HID device (host1) registers a HID Service (HIDS) with bluetoothctl,
+using client/scripts/hog-device.bt or client/scripts/hog-device-sci.bt,
+and the HID host (host0) pairs with it and checks the service over GATT.
+"""
+
+import warnings
+
+import pytest
+
+from pytest_bluezenv import Bluetoothd, Pexpect, find_exe, host_config
+from pytest_bluezenv.utils import bluez_src_dir
+
+pytestmark = [pytest.mark.vm]
+
+# The HID Service is claimed by the input plugin of the HID host, so it
+# has to be exported read-write for bluetoothctl to write HID SCI Mode
+HOG_CONF = """[General]
+ControllerMode = le
+
+[GATT]
+ExportClaimedServices = read-write
+"""
+
+HIDS_UUID = "00001812-0000-1000-8000-00805f9b34fb"
+
+# Local attributes registered by client/scripts/hog-device*.bt
+LOCAL_REPORT = "/org/bluez/app/service0/chrc2"
+LOCAL_SCI_MODE = "/org/bluez/app/service0/chrc5"
+
+# Keyboard Input Reports: Modifiers, Reserved, then 6 Key Codes
+REPORTS = [
+    "00 00 04 00 00 00 00 00",  # a pressed
+    "02 00 05 00 00 00 00 00",  # Left Shift + b pressed
+    "00 00 00 00 00 00 00 00",  # released
+]
+
+# HID SCI Mode: Fast Mode
+SCI_FAST_MODE = "03"
+
+# LE Connection Rate parameters requested with mgmt.conn-subrate once in
+# SCI Fast Mode: interval 1 ms to 2 ms (units of 0.125 ms), within the
+# range given in HID SCI Information, no subrating, no latency and 5 s
+# supervision timeout (units of 10 ms)
+SCI_RATE = ["0x0008", "0x0010", "1", "1", "0", "0", "0x01f4"]
+
+# Reported when an operation cannot complete, so a test does not have to
+# wait for its timeout to know it is not going to
+FAILURES = [
+    r"(Failed to \w+[^\r\n]*)",
+    r"(Device \S+ not available)",
+    r"(No device connected)",
+    r"(No attribute selected)",
+]
+
+# What a command reports is printed as it runs, unlike what the peers
+# report over the air, so waiting the default timeout for it only makes
+# a failure slower
+REPLY_TIMEOUT = 5
+
+
+def script(name):
+    src = bluez_src_dir()
+    if src is None:
+        pytest.skip("BlueZ source directory not known")
+
+    path = src / "client" / "scripts" / name
+    if not path.exists():
+        pytest.skip(f"{path} not found")
+
+    return str(path)
+
+
+def spawn_bluetoothctl(host, init_script=None):
+    exe = find_exe("client", "bluetoothctl")
+    # Accept pairing and authorize services without prompting, with a
+    # capability pairing Just Works, as there is no one to answer the
+    # entry of a passkey
+    args = [exe, "-a", "auto:NoInputNoOutput"]
+    if init_script:
+        args += ["--init-script", script(init_script)]
+    return host.pexpect.spawn(args)
+
+
+def expect(ctl, patterns, **kwargs):
+    """
+    Expect one of the patterns, failing as soon as one of the failures
+    shows up. Return the index of the pattern matched and its groups.
+    """
+    if isinstance(patterns, str):
+        patterns = [patterns]
+
+    idx, m = ctl.expect(FAILURES + list(patterns), **kwargs)
+    if idx < len(FAILURES):
+        raise AssertionError(m[0].decode("utf-8") if m else "failed")
+
+    return idx - len(FAILURES), m
+
+
+def expect_all(ctl, patterns, **kwargs):
+    """Expect all the given patterns, in any order."""
+    pending = list(patterns)
+
+    while pending:
+        idx, _ = expect(ctl, pending, **kwargs)
+        pending.pop(idx)
+
+
+def pair_le(host0, ctl0, host1, ctl1):
+    ctl0.send("scan on\n")
+    expect(ctl0, f"Controller {host0.bdaddr.upper()} Discovering: yes")
+
+    ctl1.send("advertise on\n")
+    expect(ctl1, "Advertising object registered")
+
+    expect(ctl0, f"Device {host1.bdaddr.upper()}")
+    ctl0.send(f"pair {host1.bdaddr.upper()}\n")
+
+    # See test_bluetoothctl_pair_le: passkey confirmation is handled by
+    # the auto agent, but legacy passkey entry still needs an answer
+    legacy = r"\[agent\].*Passkey:.*m(\d+)"
+    pending = [
+        r"Pairing successful",
+        f"Device {host1.bdaddr.upper()} ServicesResolved: yes",
+    ]
+
+    while pending:
+        idx, m = expect(ctl0, [legacy] + pending)
+        if idx == 0:
+            warnings.warn(
+                "BUG: we got passkey authentication, bluetoothd/kernel "
+                "should be fixed"
+            )
+            ctl1.expect(r"\[agent\] Enter passkey \(number in 0-999999\):")
+            ctl1.send(f"{m[0].decode('utf-8')}\n")
+            continue
+        pending.pop(idx - 1)
+
+    ctl0.send("scan off\n")
+
+
+def read_attribute(ctl, uuid):
+    """Read the given remote attribute, returning its value as hex string."""
+    ctl.send(f"gatt.select-attribute {uuid}\n")
+    ctl.send("gatt.read\n")
+    expect(ctl, r"Attempting to read \S+", timeout=REPLY_TIMEOUT)
+    return expect_hexdump(ctl)
+
+
+def hexbytes(value):
+    """Turn a hex string into the format taken by gatt.write."""
+    return " ".join(f"0x{byte}" for byte in value.split())
+
+
+def expect_hexdump(ctl, **kwargs):
+    """Expect a value printed by bluetoothctl, returning it as hex string."""
+    _, m = expect(ctl, r"((?: [0-9a-f]{2})+)  ", **kwargs)
+    return m[0].decode("utf-8").strip()
+
+
+def expect_notification(ctl):
+    """Expect a notification of the remote attribute, returning its value."""
+    expect(ctl, rf"CHG.*? Attribute /\S+ Value:")
+    return expect_hexdump(ctl)
+
+
+def enable_notifications(ctl, device, uuid, local):
+    """Enable notifications of the given attribute, on the HID host."""
+    ctl.send(f"gatt.select-attribute {uuid}\n")
+    ctl.send("gatt.notify on\n")
+    expect(ctl, r"Notify started", timeout=REPLY_TIMEOUT)
+    # Either subscribed with StartNotify, or with AcquireNotify as done by
+    # the input plugin of the HID host for the Input Reports
+    expect(
+        device,
+        rf"Attribute {local} (\S+ )?(notifications enabled|Notify sock acquired)",
+    )
+
+
+def notify(device, local, value):
+    """Notify the given value of a local attribute, on the HID device."""
+    device.send(f"gatt.select-attribute local {local}\n")
+    device.send(f'gatt.write "{hexbytes(value)}"\n')
+    expect(device, rf"Attribute {local} .*written", timeout=REPLY_TIMEOUT)
+
+
+@host_config(
+    [Bluetoothd(conf=HOG_CONF), Pexpect()],
+    [Bluetoothd(conf=HOG_CONF), Pexpect()],
+)
+@pytest.mark.parametrize(
+    "init_script, flags, sci",
+    [
+        ("hog-device.bt", "02", None),
+        ("hog-device-sci.bt", "06", ("00", "08 01 08 00 50 00 08 00")),
+    ],
+    ids=["no-sci", "sci"],
+)
+def test_hog(hosts, init_script, flags, sci):
+    host0, host1 = hosts
+
+    device = spawn_bluetoothctl(host1, init_script)
+    expect(device, "Application registered")
+
+    ctl = spawn_bluetoothctl(host0)
+    pair_le(host0, ctl, host1, device)
+
+    ctl.send(f"info {host1.bdaddr.upper()}\n")
+    expect(ctl, rf"Human Interface Device\s+\({HIDS_UUID}\)", timeout=REPLY_TIMEOUT)
+
+    # HID Information: bcdHID 1.11, bCountryCode 0x00 and Flags
+    assert read_attribute(ctl, "2a4a") == f"11 01 00 {flags}"
+
+    # Input Reports: the HID device notifies a few key presses
+    enable_notifications(ctl, device, "2a4d", LOCAL_REPORT)
+
+    for report in REPORTS:
+        notify(device, LOCAL_REPORT, report)
+        assert expect_notification(ctl) == report
+
+    if sci is None:
+        return
+
+    mode, info = sci
+    assert read_attribute(ctl, "2c39") == mode
+    assert read_attribute(ctl, "2c3a") == info
+
+    # SCI mode change: the HID host writes the new mode to the HID device
+    enable_notifications(ctl, device, "2c39", LOCAL_SCI_MODE)
+
+    ctl.send(f'gatt.write "{hexbytes(SCI_FAST_MODE)}"\n')
+    expect(device, rf"\[{LOCAL_SCI_MODE} .*\] WriteValue:")
+    assert expect_hexdump(device) == SCI_FAST_MODE
+
+    # The HID host, as central, changes the connection rate accordingly
+    ctl.send(f"mgmt.conn-subrate {host1.bdaddr} {' '.join(SCI_RATE)}\n")
+    # The connection rate may change before the command completes, so the
+    # event may be printed before the reply
+    rate = rf"{{}} type .* connection subrate interval {SCI_RATE[0]}"
+    expect_all(
+        ctl,
+        [r"Connection Subrate loaded successfully", rate.format(host1.bdaddr.upper())],
+    )
+    expect(device, rate.format(host0.bdaddr.upper()))
+
+    # Then the HID device confirms the mode has been changed
+    notify(device, LOCAL_SCI_MODE, SCI_FAST_MODE)
+    assert expect_notification(ctl) == SCI_FAST_MODE
-- 
2.55.0

