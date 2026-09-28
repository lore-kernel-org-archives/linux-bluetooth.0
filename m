Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095053839A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625678; cv=none; b=roZ1mihbhWIClsblYAi+yczaqODoSBITPW4hH0xCry3jQZ6VEvr/CE6tYix/YcxAfT9E+qOOH8UYgqLgvGMiAXxDbUsw+Uoidsk5jVcCKQY0eoF97RH39/8MYRo9a55YgvJRkR0ocrItZLtjQYY6TR62DWvjBfxd8en2VOodlSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625678; c=relaxed/simple;
	bh=1SGxfSMRGl+9fc9c1Q8GuKW9LL7zBat4Ja4/t6Wg2mY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLkw50rUFwX1G74CkypsrSMt+ssOafEpLVyQBmkpOSRd4TNBGpdbVDmWCf5EohN+FmqjOsLkksDSQnGpaIzVb3vhZ3IG0poJdij1QaQqnZi4fNFj5nx9gRnSv58mJa2PRuCEfwtZ4BXyUpCI/OoMvsEpmvSgPRpOccDBWpTIz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWdOEyj0; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWdOEyj0"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-9833bd5daffso785294241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625676; x=1791230476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M+8Bm9PsjLuJxkzM+pquNz7uJGIXVQpDu0pf420C7lE=;
        b=BWdOEyj06pLwHZnz1Dj0CXhmno7jfrnM1gvInfKTBHx+6OgIP8m3jozc4ko96qcI0C
         pQKSZDk1aRkdHhqWcKntcdvHLJ4baf1ebiNZF3UywUREbmhkXrqxJ7E5keS6/7gwbqN4
         F3u14s08lPdcf80PA99jv+a7q0XZuo8+SYovoCJvliHshUgUsaQhS/VoR9yAzkuk4XEN
         EA3A8I2RGST+c0u+EkBwx/AVzIdQa4FfiNHXk5vl3gRBkzxPpe73OQKcAXpA4bpfrV+l
         RoCBdAO8xW49O9cw/iXh/6PdejMlXK6OKNl+/dnGK5hXYFU2CfmOUiJyshceRIHrQG/L
         dk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625676; x=1791230476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M+8Bm9PsjLuJxkzM+pquNz7uJGIXVQpDu0pf420C7lE=;
        b=eYQKAcqezycxkCkK1HF48FFgySplNys+H/F4ceg7xL40bH8/6KD8nIrydQ4ls6gGMB
         jft4GquIcqmt5rOdqNsaBkMdH73gJDDbQMPb/pGQ95CrxETZJMCiKUkhYccmqU5aeYgX
         W9UyJ+GucDfEijmHuMEPimeaV0oJFZ0LaM+coTJy2WZqTnTVc2iA8koetubQpL7RuJWq
         M9UxbiVPkffFw6tsJyqP1OC6wJaMqt/z3ey3bRoOPGGO2yxRzFx+hDjvWFvdYbsgQFes
         1MKZ6DJF60XJVGXsRfsNMxPYK/ZcMMZeW9hoFRL7hUSvwGBTH8dDlH7xZPC8JFO7vSvU
         qRHQ==
X-Gm-Message-State: AFq9FYKOGU+ItWJQILBpwuXpGIqlYlKcL2Rl3Q8PI+ZpR3D6296x94/W
	RKCe1+TNo3vhuQBmTclaRfqrrK4NCPM0i0RZnZaFVTcYI6hQAxCjRFOUgcHi681qEAc=
X-Gm-Gg: AYBFou1GhtsP2QnkTQP72FSyFs0qtL+K38kdT5zszoFz6ee/uD2Lrh7oOQOspWY+Dcx
	mB3MpnVVTy1ytSP4KPHyCejWTQByeTsAL2CoJXLQSdx40STioJbQSY9aNLjJsEjKKAPnnzXKcqg
	rLxt+LOBOAVuceD9t7HTdkOPG6f6Zt4hJeUiGtS1iyec3ILtTu33+IzVVdmg/dSNgzmWEGG3Vby
	Y1IEoA6wSkBdhS7VahjesGtZrL/OLARcaKOdJ02J0f+vXBqpPlkwManbFLo2F7s5BT5ILc+F76/
	LZQXFrp9EssgYLP2FYKf7aK8Hj6fjap975kPxQDvEtSLVqxKgt9hi3whYIGFRL8jVhnA70O+nIV
	wq056NQPI1JgAl7tXBpQxcfRBfPIatdwCPKiolR1Z9xp28QgZiDdYacra9aGd/EKd0V3tWwEMmI
	Wx/3vCbbpcgMYhW1MwDkhlNRbYPeabbzoztHjW5Xg2dkz87QwGHQwtDri7LZ9xYaHaOd7t6PVmC
	aB/DvbXF3BD4qOmo8frdM6Y0S4grBFFpO71j84hehDUqO3RsHqbOFdSiFO/KUT2gV6qPd+tYkY=
X-Received: by 2002:a05:6102:2914:b0:7a6:e08f:9fa with SMTP id ada2fe7eead31-7af1cc992f3mr4644707137.13.1790625675326;
        Mon, 28 Sep 2026 13:01:15 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 17/23] test: functional: change the HoG SCI mode with the HID Control Point
Date: Mon, 28 Sep 2026 16:00:23 -0400
Message-ID: <20260928200031.1209311-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As specified by HOGP.TS 4.6.1 and the HIDS/HOGP SCI FIPD, the HID host
requests a HID SCI mode by writing it to the HID Control Point, the HID
device then confirming it with a notification of HID SCI Mode, which is
Read and Notify only.

Write the mode to the HID Control Point instead of HID SCI Mode, which
is no longer writable, and don't expect HID SCI Mode notifications to
be subscribed by bluetoothctl as the input plugin of the HID host may
already have done it.

The connection rate is still changed by the HID host, as the kernel
only issues the LE Connection Rate Request as central.

Assisted-by: OpenCode:claude-opus-5.5
---
 client/scripts/hog-device-sci.bt |  6 ++--
 doc/functional-hog.rst           | 52 +++++++++++++++++++++-----------
 test/functional/test_hog.py      | 29 ++++++++++++++----
 3 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/client/scripts/hog-device-sci.bt b/client/scripts/hog-device-sci.bt
index 1bf3a0a90db7..7500eeb105bf 100644
--- a/client/scripts/hog-device-sci.bt
+++ b/client/scripts/hog-device-sci.bt
@@ -26,12 +26,12 @@ gatt.register-descriptor 0x2908 read
 gatt.register-characteristic 0x2a4e read,write-without-response
 0x01
 #
-# HID Control Point
+# HID Control Point: Suspend, Exit Suspend and Enable SCI modes
 gatt.register-characteristic 0x2a4c write-without-response
 0x00
 #
-# HID SCI Mode: None (0x00), notified when changed
-gatt.register-characteristic 0x2c39 read,write,notify
+# HID SCI Mode: None (0x00), notified once changed with the HID Control Point
+gatt.register-characteristic 0x2c39 read,notify
 0x00
 #
 # HID SCI Information (intervals in units of 0.125 ms):
diff --git a/doc/functional-hog.rst b/doc/functional-hog.rst
index d748f241a378..795a066a6f1a 100644
--- a/doc/functional-hog.rst
+++ b/doc/functional-hog.rst
@@ -16,7 +16,7 @@ SETUP
 Two hosts, connected over LE, both running **bluetoothd(8)** with
 ``ControllerMode = le`` and ``ExportClaimedServices = read-write``, as
 the HID Service is claimed by the input plugin of the HID host and
-bluetoothctl has to write HID SCI Mode:
+bluetoothctl has to write the HID Control Point:
 
 .. code-block::
 
@@ -102,24 +102,26 @@ test_hog[no-sci]
 
 		[bluetoothctl]> gatt.select-attribute 2a4a
 		[bluetoothctl]> gatt.read
-		Attempting to read /org/bluez/hci0/dev_XX/service0013/char001e
+		Attempting to read /org/bluez/hci0/dev_XX/serviceXX/charXX
 		  11 01 00 02                                      ....
 
 	6. ``Notify started``, and the Report subscribed on host1
-	   (``Notify sock acquired``, as the input plugin already
-	   subscribed with AcquireNotify).
+	   (``Notify sock acquired``, as bluetoothd on host1 forwards the
+	   subscription with AcquireNotify, the input plugin of host0
+	   having already enabled the notifications).
 	7. Each report is notified to host0, in order:
 
 	   .. code-block::
 
-		[CHG] Attribute /org/bluez/hci0/dev_XX/service0013/char0018 Value:
+		[CHG] Attribute /org/bluez/hci0/dev_XX/serviceXX/charXX Value:
 		  00 00 04 00 00 00 00 00                          ........
 
 :Notes: The service is checked at the GATT level only, so the test
 	does not depend on the kernel supporting uhid. The HID Service is
-	claimed by the input plugin on host0, but it is still exported
-	read-only over D-Bus by default (see ``ExportClaimedServices`` in
-	**bluetoothd(8)**), so it can be read with bluetoothctl.
+	claimed by the input plugin on host0, but it is still exported over
+	D-Bus, read-write as configured in SETUP (see
+	``ExportClaimedServices`` in **bluetoothd(8)**), so it can be read
+	with bluetoothctl.
 
 test_hog[sci]
 -------------
@@ -131,25 +133,30 @@ test_hog[sci]
 	8. host0: ``gatt.select-attribute 2c39`` and ``gatt.read``.
 	9. host0: ``gatt.select-attribute 2c3a`` and ``gatt.read``.
 	10. host0: ``gatt.select-attribute 2c39`` and ``gatt.notify on``.
-	11. host0: ``gatt.write "0x03"``, i.e. SCI Fast Mode.
+	11. host0: ``gatt.select-attribute 2a4c`` and ``gatt.write "0x03"``,
+	    i.e. Enable SCI Fast mode written to the HID Control Point.
 	12. host0: ``mgmt.conn-subrate <host1 bdaddr> 0x0008 0x0010 1 1 0 0
 	    0x01f4``, i.e. interval 1 ms to 2 ms, within the range given in
 	    HID SCI Information, no subrating, no latency and 5 s
 	    supervision timeout.
 	13. host1: ``gatt.select-attribute local
-	    /org/bluez/app/service0/chrc5`` and ``gatt.write "0x03"``.
+	    /org/bluez/app/service0/chrc5`` and ``gatt.write "0x03"``,
+	    notifying the new mode with HID SCI Mode.
 
 :Expected: As for test_hog[no-sci], except HID Information reads
 	``11 01 00 06``, then:
 
 	8. HID SCI Mode reads ``00``.
 	9. HID SCI Information reads ``08 01 08 00 50 00 08 00``.
-	10. ``Notify started`` and HID SCI Mode subscribed on host1.
-	11. host1 receives the write:
+	10. ``Notify started``. HID SCI Mode is already subscribed on host1,
+	    by the input plugin of host0 once HID Information tells SCI is
+	    supported.
+	11. host1 receives the write, over the socket acquired with
+	    AcquireWrite as it is a Write Without Response:
 
 	    .. code-block::
 
-		[/org/bluez/app/service0/chrc5 (HID SCI Mode)] WriteValue: XX offset 0 link LE
+		[CHG] Attribute /org/bluez/app/service0/chrc4 (HID Control Point) written:
 		  03                                               .
 
 	12. ``Connection Subrate loaded successfully``, then the MGMT
@@ -160,11 +167,12 @@ test_hog[sci]
 		hci0 XX type LE Public connection subrate interval 0x0008 subrate 0x0001 latency 0x0000 cont_num 0x0000 timeout 0x01f4
 
 	13. The new mode is notified to host0, confirming it has been
-	    changed:
+	    changed, which the input plugin reports in the
+	    **bluetoothd(8)** debug output (``SCI Mode changed: 0x03``):
 
 	    .. code-block::
 
-		[CHG] Attribute /org/bluez/hci0/dev_XX/service0015/char0018 Value:
+		[CHG] Attribute /org/bluez/hci0/dev_XX/serviceXX/charXX Value:
 		  03                                               .
 
 	.. code-block::
@@ -180,9 +188,17 @@ test_hog[sci]
 :Notes: As the SCI Supported flag is set, the input plugin on host0
 	reads HID SCI Mode and HID SCI Information as well, which can be
 	seen in the **bluetoothd(8)** debug output (``SCI Mode:`` and
-	``SCI Info:``).
+	``SCI Info:``), and enables the notifications of HID SCI Mode.
 
-	The kernel only issues the LE Connection Rate Request as central,
-	so the connection rate is changed by the HID host. This requires
+	As specified by HOGP.TS 4.6.1, the HID host requests a HID SCI
+	mode by writing it to the HID Control Point (0x02 Default, 0x03
+	Fast, 0x04 Low Power, 0x05 Full Range), HID SCI Mode being Read and
+	Notify only. The Control Point is written with bluetoothctl, as the
+	input plugin has no D-Bus API to request a mode.
+
+	The HID device is meant to change the connection rate once the
+	mode is written, but the kernel only issues the LE Connection Rate
+	Request as central, so the connection rate is changed by the HID
+	host. This requires
 	the controllers to support Shorter Connection Intervals, which
 	btvirt emulates as a BR/EDR/LE 6.2 controller.
diff --git a/test/functional/test_hog.py b/test/functional/test_hog.py
index ea54882d059d..7ff0965275d1 100644
--- a/test/functional/test_hog.py
+++ b/test/functional/test_hog.py
@@ -18,7 +18,8 @@ from pytest_bluezenv.utils import bluez_src_dir
 pytestmark = [pytest.mark.vm]
 
 # The HID Service is claimed by the input plugin of the HID host, so it
-# has to be exported read-write for bluetoothctl to write HID SCI Mode
+# has to be exported read-write for bluetoothctl to write the HID Control
+# Point
 HOG_CONF = """[General]
 ControllerMode = le
 
@@ -30,6 +31,7 @@ HIDS_UUID = "00001812-0000-1000-8000-00805f9b34fb"
 
 # Local attributes registered by client/scripts/hog-device*.bt
 LOCAL_REPORT = "/org/bluez/app/service0/chrc2"
+LOCAL_CP = "/org/bluez/app/service0/chrc4"
 LOCAL_SCI_MODE = "/org/bluez/app/service0/chrc5"
 
 # Keyboard Input Reports: Modifiers, Reserved, then 6 Key Codes
@@ -39,7 +41,8 @@ REPORTS = [
     "00 00 00 00 00 00 00 00",  # released
 ]
 
-# HID SCI Mode: Fast Mode
+# HID Control Point: Enable SCI Fast mode, the value then notified with
+# HID SCI Mode
 SCI_FAST_MODE = "03"
 
 # LE Connection Rate parameters requested with mgmt.conn-subrate once in
@@ -229,14 +232,27 @@ def test_hog(hosts, init_script, flags, sci):
     assert read_attribute(ctl, "2c39") == mode
     assert read_attribute(ctl, "2c3a") == info
 
-    # SCI mode change: the HID host writes the new mode to the HID device
-    enable_notifications(ctl, device, "2c39", LOCAL_SCI_MODE)
+    # The input plugin of the HID host enables the notifications of HID
+    # SCI Mode on its own, so they only have to be started on bluetoothctl
+    # to be printed
+    ctl.send("gatt.select-attribute 2c39\n")
+    ctl.send("gatt.notify on\n")
+    expect(ctl, r"Notify started", timeout=REPLY_TIMEOUT)
 
+    # SCI mode change, see HOGP.TS 4.6.1: the HID host writes the mode to
+    # enable to the HID Control Point, with Write Without Response
+    ctl.send("gatt.select-attribute 2a4c\n")
     ctl.send(f'gatt.write "{hexbytes(SCI_FAST_MODE)}"\n')
-    expect(device, rf"\[{LOCAL_SCI_MODE} .*\] WriteValue:")
+    # Received with WriteValue, or over the socket acquired with
+    # AcquireWrite
+    expect(
+        device,
+        rf"\[{LOCAL_CP} .*\] WriteValue:|Attribute {LOCAL_CP} .*written:",
+    )
     assert expect_hexdump(device) == SCI_FAST_MODE
 
-    # The HID host, as central, changes the connection rate accordingly
+    # The HID device is meant to change the connection rate, but the kernel
+    # only requests it as central, so the HID host does it instead
     ctl.send(f"mgmt.conn-subrate {host1.bdaddr} {' '.join(SCI_RATE)}\n")
     # The connection rate may change before the command completes, so the
     # event may be printed before the reply
@@ -248,5 +264,6 @@ def test_hog(hosts, init_script, flags, sci):
     expect(device, rate.format(host0.bdaddr.upper()))
 
     # Then the HID device confirms the mode has been changed
+    ctl.send("gatt.select-attribute 2c39\n")
     notify(device, LOCAL_SCI_MODE, SCI_FAST_MODE)
     assert expect_notification(ctl) == SCI_FAST_MODE
-- 
2.55.0

