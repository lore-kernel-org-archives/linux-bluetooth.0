Received: from mail-ua2-f17.google.com (mail-ua2-f17.google.com [74.125.226.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F27568FC2
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191933; cv=none; b=ayAUctKbFfci3umLc95T1GPPRg8rko3uS8cHhoSa9SlUC2g8ITAqXLwAA1vxFh2XSCcCECV0UaRgLb1KQtBkbmWcFnAW7+g43NDMwPl4MCYfktK7qLPfVOhu8CmdLDMBpznoBdn5oLrHRHlmLWx5UUlRkASLtdldemJKo5+1W8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191933; c=relaxed/simple;
	bh=Iy8UPHChv766YCQn/t/ewPfHSl8ZPtzuVBy8LGnLDN4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIC4tsMpOn6jrFvTrNwWFqA06zS+nJxOsExYf6A8wx2gaRwQrPaQjCmV2v+pffSL7IhkbC8CAXhhoVFumdf9bCr3bA7qdqi7yhrN8WYUOzKKkItaEicDeI/DpsqTOxqhBJhEVqKAy8ZDji8ZITK2Tze4KyQ0K/92jm82tXl63DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS0j45G5; arc=none smtp.client-ip=74.125.226.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS0j45G5"
Received: by mail-ua2-f17.google.com with SMTP id a1e0cc1a2514c-97e7c6e580fso438398241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191930; x=1790796730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e2z2Iyn5JDjFQKQjN0TLPBXJlosUmaljJRWpgiaxZqA=;
        b=lS0j45G5vrgCqGhzaWMnGl/KaTDBz2eP7OFVLMze0XEcXhakmlkzJ5DRsifFfJjqdW
         bRFp3RwfKCnqnRctelaQuZfuiVkcIePvjkrUpOl8JDct3nShj6h+JENdtklKWmm1pEyy
         sgJe9hv7gM/XCWjYP1Fkpt1o/Rh2jbkwA54U5835NJbN+GXBWPXubd+bWEfznKNXIkic
         PyRwl2TY0PKiQUJx+RqIsk5pxcAS1YjbzPTqdvIkGY0vA8v+7SvXvv4mo3oFEMefwtlw
         Y1kU9N07KRGQFBPv7XmH+Rv05oxpvuGM74XeNzQ22xrWZHdVPf7drfOFXlluwFOuEh68
         LqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191930; x=1790796730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e2z2Iyn5JDjFQKQjN0TLPBXJlosUmaljJRWpgiaxZqA=;
        b=Hl1oRpIfmecHtx4QQ6m6dhp0tAKjOh7ZypBY1rluYwQ6VEuCZspm84AqmwnJUBTJ8K
         cqKV4gT4l8J1nxXVebuKE+WRtElunyvzjXcbXU8rku6d4i64RhDYzjRga/RfeVVT9xYN
         zGlQoXibmxAH2Rhw+/1emDlRiDeLUGqWvE7H3Bx9UrsEness7ujzvNpvuF+R3WV6EG6W
         2xTs6X6DNHMrcZcfwXtaugMPi0Ih65oajQNm3qQcVi6ym24AHAcSmEBYEFFrKuYh46/2
         T/wURIpnqf3eP07+qOxb6gYlYJq+5OFXlezY+R3s9pDEmg4+R1Qsbe+pC0tDdylGPdRW
         7Ufg==
X-Gm-Message-State: AFuF++kl7ncWHGo6b8u+W/aTu/nkH7KIdC7gABe6J11wunoU1Y/4xDIq
	3m3zn2GelMC+/QIVZURWAiVolHnQMlkQDe9AqzyVGhN2XAvSyKMMIRLn9hEM2Tp7petwCg==
X-Gm-Gg: AYBFou38gqJHz5G/GpYhbM6LFJF52F7ljxAvbtjeN/ikZVgYq9AiA2bZ1rvjwHK2Hjo
	tLdygu2yQY+AiKUTSr14zxhLOvgotKzssXO1IteFXopzs0ERzhdYp7xQ+pp0Ur6y+2lqK9HFCJd
	117X0PZ1jBYZPAGbfw8Ym7HmVPtIFAPGQinxPg4iIOesGdjy6mzV2/FXZGA0QeODuhDoV8q2FW6
	UD6oVPS1NtQ96JrC83WUflBikfALpclPT6CbzG/kpjnKPgQ6znmjpbAGOTD747ZMX3O5FPazN8L
	rcqn1d5A8sqZOJveV6aLc4P5VcbIRfQTJHJ6rMe0lETuNIa3cTa/PMSaxSo9nUXvHUyl8rWRe/q
	Euq0sbTf8sFteCrT8q6oVBOHW/vC0X8d/61KI7x4xFWlqivK2K3pfnA1TP5itQMwPZDTNBe+hfA
	4mKHs+OSs9RF1xZJf7r5zXdVytL+jrsG0UbqcZnEWsej8rbyTRsrXQq0D63Aul7+VxGT+KS6iH7
	ODbwLpwOoav7NAelQvB2kaRvAuFWn2YwXN39zmlfIXdZV+QGO+i/KFBqWwk0CRA4LjXghjJ6eCj
	BCrcY3tFsg==
X-Received: by 2002:a05:6102:5549:b0:7a1:f980:e934 with SMTP id ada2fe7eead31-7af1cea4275mr206582137.16.1790191929607;
        Wed, 23 Sep 2026 12:32:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9851691693asm4666266241.2.2026.09.23.12.32.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:32:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/7] test: functional: add HoG tests
Date: Wed, 23 Sep 2026 15:31:56 -0400
Message-ID: <20260923193157.249636-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193157.249636-1-luiz.dentz@gmail.com>
References: <20260923193157.249636-1-luiz.dentz@gmail.com>
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

