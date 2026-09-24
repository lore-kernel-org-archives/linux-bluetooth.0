Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFAC349B19
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258180; cv=none; b=iSaMF0mI8cSCCy2c/WF8A3DIp1U59XEDn2CDwRYSVyJTVZAAZdF3gyYvUY7B5tlTPK1A4MppWbV/a7cAvpH1qSjgkPtbxJpLaLp/Gs+JFziIXjvW/xOrkRjBAj4kNdyUpJmkm1jluTm2aEciw7Ww5E29j3V+5PH74xiAGjBuBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258180; c=relaxed/simple;
	bh=+deHzx2uhrIBNkhbfxIJJl7HGwF/qV9u0MQ5gnwvkVo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WivqBak7bQLOts2Wlw7oQGwhovMHz0SY0Lj8o1Qmr4HTNIo0DQccvVB64kre3G4eWZasR/wOXPFpuq/FoFj8zoMbwpgcKWkCEoIE/pDowxf29j83IEMLIwrj3LNO7M8fKt/AIRP2qhgdupYCqiDT4dHdRjp4gQgaziW6cLHtoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7Hr1Wpu; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Hr1Wpu"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7aa0603e450so1213804137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258178; x=1790862978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X7TNVCO5X0IM2vYSTKR1bsaXci1daSisRKmHbRYJs0o=;
        b=a7Hr1Wpu9GWLV0urFC8/C0yFw/p40s6RAEgSMHD1LOCkp0Dxtsf1XQuHOkMUAtOivx
         UYnH3APgDI7EtPcpLLA0S2X4otojYzpUwJ8I3xJ36bqO7cXBD9DOvN8A2Zuga7vn7n2u
         obtXO3xqNLMsiF0ZRgD+65Thb7nos7uTMUOrT2YGMshRZWc6Nh0L7H/aljOwNVVTxuE9
         6ojiRMbjS+oJk53+VmxBsqGCQx21gCuuwWfcyqB8E+x4ahyV2VX6Dv1s7kv5DfpSfG/r
         WSTGlusVer4oOxgQfzFctyP/fKpMxephW5EuvClJ5RV9I7rtQYAKcAjFTKa5noGoMypn
         RKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258178; x=1790862978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X7TNVCO5X0IM2vYSTKR1bsaXci1daSisRKmHbRYJs0o=;
        b=Of/xTV9XDqqvcsOkWDfaU7yTvGEAKuqiH+WqbZ+s3VLV6r4gIVBfZwRTFqx6ObwyOY
         LmAbau2tUx2vyxuLAxVQLHEZfvTjZnBb4aQ+Ww4zDj5YvD/WbRoqtSs9KyGpmw5Lq70a
         ps0AoGT6G2BRkvAyLlb1Sgcf44OFjJWPkYh3jttgAHgFRopzIgKUdzQWTWediOPsly/8
         Vwag6xhIZpB9uCFijBl5WygKsEbV2hHT2PuXvFyBvVFJFR3hEb/5wIgyt48rTQRTUVFU
         RqOkYeBbPImhvtNmxfWCsWfLQDzcMwR+A8SUy/0usMTNoC1p6/62cHt1cBSQOc+/gcVF
         ALoQ==
X-Gm-Message-State: AFuF++lAWJ2TUk/6oayQ9tfd710T0xqzjWa1wdsbiitDODzhP6AfpzOz
	FNYpWTEst4xRu/hwqsUnjIr6GwKGT0vjKd0rDA9ppvLsN8uwUJVsUvmVHSUbO0hvp92s4Q==
X-Gm-Gg: AYBFou2P9iU8SgO2P0vrhF8eVcdx+VSRT4DEniOLDj3+wwTLrnPA/hH2J/r+jJ9BAI7
	DTSlPnM8ZZnlIok22/pgCgnpTiWnfpW41NrLW5moQb7e8OvjzZ94l/h6M90tK7mAXiTWW3lSp4n
	/wyP/+xSQlOnrcJWk7npDbjy08SOkWDR7QvtZ6gklwgUMf9pTIqvveOg4SDwaia1Cn+TtByPy3l
	n6rvnzsrLoKPHH+hlRpw2VbuYXivN5aqeQ+xr9wI5xYxbYJ9dM4lZy7Nd5kuPAL2KLA3eN8hfY2
	DLhlNvNvmfa/ICUuUSV0mL+Qu7EslTRtGhCtrz34mPE8KQdO8xw1u7bb7uRRmhLvt+2OiTuLtWy
	kY4m2TgF1STinv1CtpJiyaMGUC7WiDWBxh60yegkeitIY4cRVQY7fo/jF+R2zYIyzSrrjC+ccUB
	fJngWquteES3hsMPyAbhUw16ojEwu9mtRc/4JfHjVuw3CDxgSS/D3SsXPpQtq4pf+jbgIMYzB1+
	D5ZCJrtg0b91lH87qEpB9Y1WpMRZxk1LtI/PdEEBrD7o+fNuxL7YKCmdu/Jdr+l
X-Received: by 2002:a05:6102:358d:b0:79e:2b00:b4da with SMTP id ada2fe7eead31-7af1c692c06mr1456906137.6.1790258177645;
        Thu, 24 Sep 2026 06:56:17 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7af8bdcde81sm1493194137.10.2026.09.24.06.56.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:56:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/8] doc: Add functional-hog documentation
Date: Thu, 24 Sep 2026 09:55:59 -0400
Message-ID: <20260924135601.330277-7-luiz.dentz@gmail.com>
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

Document the HoG functional tests, where bluetoothctl registers a HID
Service with and without Shorter Connection Interval (SCI) support
using client/scripts/hog-device*.bt, and the HID host:

- checks HID Information, HID SCI Mode and HID SCI Information with
  gatt.select-attribute/gatt.read
- receives a few Input Reports notified by the HID device
- changes the SCI mode, followed by the connection rate with
  mgmt.conn-subrate, and receives the notification from the HID device
  confirming the mode has been changed
---
 Makefile.am                |   1 +
 doc/functional-hog.rst     | 188 +++++++++++++++++++++++++++++++++++++
 doc/functional-testing.rst |   1 +
 3 files changed, 190 insertions(+)
 create mode 100644 doc/functional-hog.rst

diff --git a/Makefile.am b/Makefile.am
index 1d46b9b938cf..17348788a30b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -501,6 +501,7 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/functional-a2dp.rst \
 				doc/functional-avrcp.rst \
 				doc/functional-bap.rst \
+				doc/functional-hog.rst \
 				doc/functional-mpris-proxy.rst \
 				doc/functional-obex.rst \
 				doc/settings-storage.txt
diff --git a/doc/functional-hog.rst b/doc/functional-hog.rst
new file mode 100644
index 000000000000..d748f241a378
--- /dev/null
+++ b/doc/functional-hog.rst
@@ -0,0 +1,188 @@
+==============
+functional-hog
+==============
+
+DESCRIPTION
+===========
+
+HID over GATT (HoG) functional tests, `test/functional/test_hog.py`,
+driven through **bluetoothctl(1)**. See **functional-testing(7)** for
+the conventions used here, and **test-functional(1)** for how to run
+the suite.
+
+SETUP
+=====
+
+Two hosts, connected over LE, both running **bluetoothd(8)** with
+``ControllerMode = le`` and ``ExportClaimedServices = read-write``, as
+the HID Service is claimed by the input plugin of the HID host and
+bluetoothctl has to write HID SCI Mode:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |       LE        | host1                  |
+	| central                | --------------> | peripheral             |
+	| bluetoothctl           |                 | bluetoothctl           |
+	| HID host               |   GATT (HIDS)   | hog-device[-sci].bt    |
+	|                        | <============== | HID Service            |
+	+------------------------+                 +------------------------+
+
+	--> connection is initiated by      ==> reports flow towards
+
+host1 starts `bluetoothctl` with a script registering a HID Service
+(HIDS, ``00001812-0000-1000-8000-00805f9b34fb``) acting as a keyboard,
+through the ``gatt.register-service``, ``gatt.register-characteristic``
+and ``gatt.register-descriptor`` commands:
+
+``client/scripts/hog-device.bt``
+	HIDS without Shorter Connection Interval (SCI) support:
+
+	- HID Information (0x2A4A): ``11 01 00 02``, i.e. bcdHID 1.11,
+	  bCountryCode 0x00 and Flags NormallyConnectable.
+	- Report Map (0x2A4B): keyboard with Report ID 1.
+	- Report (0x2A4D), with a Report Reference descriptor (0x2908)
+	  ``01 01``, i.e. Report ID 1, Input Report.
+	- Protocol Mode (0x2A4E): ``01``, i.e. Report Protocol Mode.
+	- HID Control Point (0x2A4C).
+
+``client/scripts/hog-device-sci.bt``
+	Same as above, with SCI support:
+
+	- HID Information (0x2A4A): ``11 01 00 06``, i.e. the SCI
+	  Supported flag (0x04) is set as well.
+	- HID SCI Mode (0x2C39): ``00``, i.e. None, with the notify
+	  property so the HID device can confirm a mode change.
+	- HID SCI Information (0x2C3A): ``08 01 08 00 50 00 08 00``, i.e.
+	  Minimum Supported Connection Interval 1 ms, and one subgroup
+	  with Min 1 ms, Max 10 ms and Stride 1 ms (in units of 0.125 ms).
+
+Both scripts set the advertising data to the HIDS UUID and the
+keyboard appearance (0x03C1). The same scripts can be used manually to
+emulate a HoG device:
+
+.. code-block::
+
+	$ bluetoothctl --init-script client/scripts/hog-device-sci.bt
+	[bluetoothctl]> advertise on
+
+host0 runs a plain `bluetoothctl`, and both use
+``-a auto:NoInputNoOutput`` so pairing is Just Works.
+
+TEST CASES
+==========
+
+test_hog[no-sci]
+----------------
+
+:Setup: As above, with ``client/scripts/hog-device.bt`` on host1.
+
+:Steps:
+	1. host1: start `bluetoothctl` with the script.
+	2. host0: ``scan on``; host1: ``advertise on``.
+	3. host0: ``pair <host1 bdaddr>``.
+	4. host0: ``info <host1 bdaddr>``.
+	5. host0: ``gatt.select-attribute 2a4a`` and ``gatt.read``.
+	6. host0: ``gatt.select-attribute 2a4d`` and ``gatt.notify on``.
+	7. host1: ``gatt.select-attribute local
+	   /org/bluez/app/service0/chrc2``, then for each report
+	   ``gatt.write "<report>"``: ``00 00 04 00 00 00 00 00`` (a
+	   pressed), ``02 00 05 00 00 00 00 00`` (Left Shift + b pressed)
+	   and ``00 00 00 00 00 00 00 00`` (released).
+
+:Expected:
+	1. ``Application registered`` on host1.
+	2. ``Advertising object registered`` on host1 and the device found
+	   on host0.
+	3. ``Pairing successful`` and ``ServicesResolved: yes``.
+	4. ``Human Interface Device (00001812-...)`` is listed in the UUIDs.
+	5. HID Information reads ``11 01 00 02``:
+
+	   .. code-block::
+
+		[bluetoothctl]> gatt.select-attribute 2a4a
+		[bluetoothctl]> gatt.read
+		Attempting to read /org/bluez/hci0/dev_XX/service0013/char001e
+		  11 01 00 02                                      ....
+
+	6. ``Notify started``, and the Report subscribed on host1
+	   (``Notify sock acquired``, as the input plugin already
+	   subscribed with AcquireNotify).
+	7. Each report is notified to host0, in order:
+
+	   .. code-block::
+
+		[CHG] Attribute /org/bluez/hci0/dev_XX/service0013/char0018 Value:
+		  00 00 04 00 00 00 00 00                          ........
+
+:Notes: The service is checked at the GATT level only, so the test
+	does not depend on the kernel supporting uhid. The HID Service is
+	claimed by the input plugin on host0, but it is still exported
+	read-only over D-Bus by default (see ``ExportClaimedServices`` in
+	**bluetoothd(8)**), so it can be read with bluetoothctl.
+
+test_hog[sci]
+-------------
+
+:Setup: As above, with ``client/scripts/hog-device-sci.bt`` on host1.
+
+:Steps: As for test_hog[no-sci], then:
+
+	8. host0: ``gatt.select-attribute 2c39`` and ``gatt.read``.
+	9. host0: ``gatt.select-attribute 2c3a`` and ``gatt.read``.
+	10. host0: ``gatt.select-attribute 2c39`` and ``gatt.notify on``.
+	11. host0: ``gatt.write "0x03"``, i.e. SCI Fast Mode.
+	12. host0: ``mgmt.conn-subrate <host1 bdaddr> 0x0008 0x0010 1 1 0 0
+	    0x01f4``, i.e. interval 1 ms to 2 ms, within the range given in
+	    HID SCI Information, no subrating, no latency and 5 s
+	    supervision timeout.
+	13. host1: ``gatt.select-attribute local
+	    /org/bluez/app/service0/chrc5`` and ``gatt.write "0x03"``.
+
+:Expected: As for test_hog[no-sci], except HID Information reads
+	``11 01 00 06``, then:
+
+	8. HID SCI Mode reads ``00``.
+	9. HID SCI Information reads ``08 01 08 00 50 00 08 00``.
+	10. ``Notify started`` and HID SCI Mode subscribed on host1.
+	11. host1 receives the write:
+
+	    .. code-block::
+
+		[/org/bluez/app/service0/chrc5 (HID SCI Mode)] WriteValue: XX offset 0 link LE
+		  03                                               .
+
+	12. ``Connection Subrate loaded successfully``, then the MGMT
+	    Connection Subrate event with the new interval on both hosts:
+
+	    .. code-block::
+
+		hci0 XX type LE Public connection subrate interval 0x0008 subrate 0x0001 latency 0x0000 cont_num 0x0000 timeout 0x01f4
+
+	13. The new mode is notified to host0, confirming it has been
+	    changed:
+
+	    .. code-block::
+
+		[CHG] Attribute /org/bluez/hci0/dev_XX/service0015/char0018 Value:
+		  03                                               .
+
+	.. code-block::
+
+		[bluetoothctl]> gatt.select-attribute 2c39
+		[bluetoothctl]> gatt.read
+		  00                                               .
+
+		[bluetoothctl]> gatt.select-attribute 2c3a
+		[bluetoothctl]> gatt.read
+		  08 01 08 00 50 00 08 00                          ....P...
+
+:Notes: As the SCI Supported flag is set, the input plugin on host0
+	reads HID SCI Mode and HID SCI Information as well, which can be
+	seen in the **bluetoothd(8)** debug output (``SCI Mode:`` and
+	``SCI Info:``).
+
+	The kernel only issues the LE Connection Rate Request as central,
+	so the connection rate is changed by the HID host. This requires
+	the controllers to support Shorter Connection Intervals, which
+	btvirt emulates as a BR/EDR/LE 6.2 controller.
diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
index ca7bfa672a76..7b3cad1c66b1 100644
--- a/doc/functional-testing.rst
+++ b/doc/functional-testing.rst
@@ -15,6 +15,7 @@ are documented separately:
 - **functional-a2dp(7)**: `test/functional/test_a2dp.py`
 - **functional-avrcp(7)**: `test/functional/test_avrcp.py`
 - **functional-bap(7)**: `test/functional/test_bap.py`
+- **functional-hog(7)**: `test/functional/test_hog.py`
 - **functional-mpris-proxy(7)**: `test/functional/test_mpris_proxy.py`
 - **functional-obex(7)**: `test/functional/test_obex.py`
 
-- 
2.55.0

