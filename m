Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560940B110
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289073; cv=none; b=rosiM/Z/mtUR9FQSSoxWqLcA14mbIXxwqPPdQ5by7qmxMFXsak4su8WLBEjEilYtxdePJzRDJe5yFewABs1A4QlgxtsLBIUDTGYqM/XvcbDTQ6Bf/56D8T5813X3oGAUFxJHEJdcFzetEOrdVlghpppPeq88WB5oWYmPBQwoojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289073; c=relaxed/simple;
	bh=1SGxfSMRGl+9fc9c1Q8GuKW9LL7zBat4Ja4/t6Wg2mY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpNlwJj9ru8A0l1UnDTFQP8N+ZelJYTahiluVRJ9TO/DAsXZm9INIvCMWbG5Cc8MqW0Dn28BhDWq2l9p/ekoEvavcqMdzhVLrHAnkrQG0cW849y77aziQx2kkecObK8Z6vXgQQH+j9VAgBkr3GaEpPNJtcSPcrnKqL86iPY9ZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rESMu5ky; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rESMu5ky"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c985f055b9so391344e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289070; x=1790893870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M+8Bm9PsjLuJxkzM+pquNz7uJGIXVQpDu0pf420C7lE=;
        b=rESMu5ky9g4k0ACe/48kVA2ZmYTtlFLm8JNHTkgmL9M3viWIJuhHA/a84QuPsUtsak
         JqUJOR0s6E45WvmBH7zXJNVWund0oHABAB6URpr1V8R3Tui/vthj5878mItQ9ZxRLTdH
         bDlceGsD614H4tdnp5SeIPgkxaM9xqN6U5kUsui2oAYwRlrKHA6grQgT5sOPh+tl8eCY
         a0QJz3l/CZyN26DbPKrNF7AmWY2HISH3aSiNVp/athGtDYDlutKNi3pBz4HHygxDeItm
         +MP6IZjElZkqCN/1Hshz2DQ4u5+sNPgnTItpSPOPybOguUwbhPbsGpty9AuCaS7Z7zgr
         rbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289070; x=1790893870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M+8Bm9PsjLuJxkzM+pquNz7uJGIXVQpDu0pf420C7lE=;
        b=BgLUIxbtsfLQRvKan/xAohwBCucV5Hl03miuk1fes8WzQpWPuXrpoyq9ISgRVgnbn1
         7Ee9fVjWJ2VABT66UTJRmC5oBpGrKqykC+q7+HUEIWNjmA9FCXfHYuzwD0Enu75gT6dp
         r2QfRjjgU2eIktTIb3km/v0vkAbgUjS1tJ7IdpDnW8s9FbM1h1Oww24t6qWgRxrK3LOD
         piPK8fLzRjCe8Ji/grpA+xO+ol/MwaEiNPkS6wdqjDdYHqB+YjY4ba7Gseev83v0/w/k
         cG9502WDqAMJEC0dLpVVuOyFPYgUPiq2PJND/gRJ1Bji1iecmokrgNieTgJInwjSkZ6y
         6K+g==
X-Gm-Message-State: AFuF++nrnlY75YR4JijBHyHpFqs3fGKwmb8siiMq9ROjQFXTW1Uj83l2
	ObUItQEjBV4a6kyxp1aOlOubuDjxH7Od1l045M4SGvSbPTK7BzlIhnHs52F6xWKrycPUMQ==
X-Gm-Gg: AYBFou1Vwc5ot0xNGoqSNjXOPa53Awz136zV8h8SA4AvlMKrJAndlO47J54yBKspv1F
	1QLRpamRP02mM7kLGvAu+bpC0aB9N7Zh3Y46pAPMdqXTbHW35idkLhYBwcgV14bd1knPe2e2x0b
	u4PZ1SvOMCH/ck23HyNMP3uLJ8/AZi068AHpluJgALJBKwgh7EnGAVmRIO1yg55Pjj215fR8wDj
	TUNaJYYS3SrAuE2VS8xhF1WDa3KFq0RGXlHQb8i2Z3nKtH7HN7OVXb6WMWkFMcy4pMvY/SgggJb
	tfmkXIJGjj4tybk5xCzaggGXV3GnXh+j0LcXMeTePTwUIRFz3joI2vMGqZVq5g1wOxQnQanW4Bt
	Sx00GB6GYM/0I8vETeQUFnzYosna+y3uvfrP1Tz/st6wT5KP3lwVva+THiWbOz3jxf//6HXwkdj
	N+Wj0Glf6qIIw5C8oH7xS7ZEXbo9pyktE4NXq/I4pDC+swd+TjzzXGCyEqjNz68S5hJB7U4Fzsg
	UoiySSQaquh3dXxueMAkzUrJs2KWNGA90tLEeKT8wINunFI1TVaFQ1lDmdECluU
X-Received: by 2002:a05:6123:592:20b0:5c9:a5b6:27b7 with SMTP id 71dfb90a1353d-5cb0c04820fmr1409698e0c.20.1790289069989;
        Thu, 24 Sep 2026 15:31:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 15/20] test: functional: change the HoG SCI mode with the HID Control Point
Date: Thu, 24 Sep 2026 18:30:40 -0400
Message-ID: <20260924223046.605543-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
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

