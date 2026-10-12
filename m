Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3005F49B5A5
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818940; cv=none; b=kwW3ZCflcIOVv1W75HYQC4/PCMm6UfKSvVspe75SBWHj31yLbL/SoWgEITL1zxj0GvjJ0weDfMYij0F2Yu6sU8Kw9P1rwk5nQWt5vWy6Nkmae8DBfFSDIE/ht3eSf15uBgiN1i8CRTWVGSyhOadaTrzTMsINExcl8Pi6CMlR7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818940; c=relaxed/simple;
	bh=jbC34RCgov9Nir9aNgADiC6EdP9LIwbAIPqlv3QyXcU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DhbkDhMlW6yDmQeLTDVIHCakO+/UyUbnQmjzthc4bGIWirIKaLBlKWtOKxl0BgBY5KUxilTgNzzU6jQlCyfLoWzIAL5Rhsta/cpIiNdYy9Ce5E/IHJz6jQSWJm8B1xSL3zwxfBsACaPSCuD0YwqGQMr1l5wkAB/oFpMNAHOAMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw88rn/o; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw88rn/o"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-988f270d308so1255086241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818938; x=1792423738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pnQ9JdyQSUNXSqwuhqbRLJPscoUXLnglPrurbDkhW1I=;
        b=Xw88rn/oJQ+JQikFsDj5Ai5Xr8ZtE8iisuyyZMosQL067kjK3D3smrMRi9QQXrM4+8
         hOApPGNpWwePmKYHzEEU/NKQJgQ6u7s/i/ufrQNoxdY4bb3iIQJ7NRovsKUxkKA936cC
         z5GCvhwhWOWKUNk1/isfcMpfAW4KiQpdSpdyAmSuo7CGQ21M7pFKLGxi8RDuJuL4FB0+
         eQVFozH+PJI5U7tPLBR+xhr547aHU8wazB4zSSHV8yayVBSNpkOkUjwv8/b7Vuz46uAb
         5avf8eYxN6WmriHihpa0C3nk/K1lWvdcuZjkrouJqohzVvTvRcgl6Hv1EteB9AwkkI1S
         qpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818938; x=1792423738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pnQ9JdyQSUNXSqwuhqbRLJPscoUXLnglPrurbDkhW1I=;
        b=LEJ9ubXvXo3lFrRhQPRTW1mlkR7skfvoelm1KdUdEa4F02uQvrlnTUGwa1Hdm8OdEd
         gj9HdxYgdK8hqxOBPy+tekAwohePrfcS/X8GBiybpF2cvZurwD7mJGzn+ioaRHNwKVjV
         GrXuM+IiN2u6qNuIMxv/1opsT+NKm8zc5ONHwcjJ6/gCpMRyicSviG2VQxT8ITdkgL2F
         LqGjW5DIT7B8lxjpTPBGjcnxelkCBMpWoM9mLSBwECvHuyAIRWXRwsU0hW7fINqk5ANY
         MPcVXpUtwrjZib17e1NwGxa+VF/M2azMUZtOnIyA+4j4zu/0xaCJbqLLlvRgY48+zBwz
         oZGQ==
X-Gm-Message-State: AFq9FYLN7LvZNMMIUQlBwRQTJGGVOT3jGjGqw8EAzxVQM60NgVa+cb4t
	X1nFe/iwm4xAGbBW4COHVlCKJLUhEJUChbtvCfRyImmgL4RzOfyf4vKPpeNw8n3H
X-Gm-Gg: AYBFou3UpA8e0o3m6iBl13y4IGAIVYVU/vbYUkckKwBiGcwQ3gdA9lZy1KrwkZKKEm1
	3PelccXsFFR36tHXlOryJQ6szM/JamfozTtEP+g8gGsZLPOzSlOoH9LAh1qqiGJ9CqcVRNS0n6e
	pGayfRZN2Hjopd27kXTUVi99QIAGNaK3ZbeSsxtWDr7HhWoUcTutaQ++2SSY5HTkBin8YbCi8fW
	70lSLUvrsEgSq7u04EEysbtvHy7Pw09OcDTHuAXXUPfij9SF7FgFk9A+WmrmVtGXFGyiaEyE4xY
	pPlUreE1/6SJvrlmhE2bU7NY4tUtAW5yH9NXTJ4B/n0hERiOiyp1lFtTxwxMevCN5h2HsBJO+yn
	kiCedKYi3OVzecW1bv+tS4bfQbyrSdd5egJAvzpEpo734i+mh37GkNUTzgB3ug4s+y9PcBroc37
	WFaKCvaupLP8EneaVx8GBrfosryeFWEmAi+kvVmE7HyL9LAStxR4n0yb0f6VzYsDSH4x28LjkTd
	POI8DFuWticJUIhaklkEXYRdIdYY0WD1BZIGrRN5blSBRDaOJRTjVcFHfkDbMT4
X-Received: by 2002:a05:6102:148c:b0:7a6:c647:cf50 with SMTP id ada2fe7eead31-7cb37230539mr3186280137.8.1791818937803;
        Mon, 12 Oct 2026 08:28:57 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990138f4fe2sm4919318241.6.2026.10.12.08.28.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:28:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] test: functional: change the HoG connection rate from the HID device
Date: Mon, 12 Oct 2026 11:28:47 -0400
Message-ID: <20261012152847.66886-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As specified by the HIDS/HOGP SCI FIPD, the HID device initiates the
Connection Rate Update procedure once the HID host writes the mode to
the HID Control Point, so load the connection subrate on the HID device
instead of the HID host.

This requires the kernel to issue the LE Connection Rate Request as
peripheral.

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/functional-hog.rst      | 13 ++++++-------
 test/functional/test_hog.py | 21 +++++++++++----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/doc/functional-hog.rst b/doc/functional-hog.rst
index 795a066a6f1a..6d0b0132d5dd 100644
--- a/doc/functional-hog.rst
+++ b/doc/functional-hog.rst
@@ -135,7 +135,7 @@ test_hog[sci]
 	10. host0: ``gatt.select-attribute 2c39`` and ``gatt.notify on``.
 	11. host0: ``gatt.select-attribute 2a4c`` and ``gatt.write "0x03"``,
 	    i.e. Enable SCI Fast mode written to the HID Control Point.
-	12. host0: ``mgmt.conn-subrate <host1 bdaddr> 0x0008 0x0010 1 1 0 0
+	12. host1: ``mgmt.conn-subrate <host0 bdaddr> 0x0008 0x0010 1 1 0 0
 	    0x01f4``, i.e. interval 1 ms to 2 ms, within the range given in
 	    HID SCI Information, no subrating, no latency and 5 s
 	    supervision timeout.
@@ -196,9 +196,8 @@ test_hog[sci]
 	Notify only. The Control Point is written with bluetoothctl, as the
 	input plugin has no D-Bus API to request a mode.
 
-	The HID device is meant to change the connection rate once the
-	mode is written, but the kernel only issues the LE Connection Rate
-	Request as central, so the connection rate is changed by the HID
-	host. This requires
-	the controllers to support Shorter Connection Intervals, which
-	btvirt emulates as a BR/EDR/LE 6.2 controller.
+	The HID device, the peripheral, then changes the connection rate
+	according to the mode, which requires the kernel to issue the LE
+	Connection Rate Request as peripheral, as well as the controllers
+	to support Shorter Connection Intervals, which btvirt emulates as a
+	BR/EDR/LE 6.2 controller.
diff --git a/test/functional/test_hog.py b/test/functional/test_hog.py
index 7ff0965275d1..a76c91602896 100644
--- a/test/functional/test_hog.py
+++ b/test/functional/test_hog.py
@@ -45,10 +45,10 @@ REPORTS = [
 # HID SCI Mode
 SCI_FAST_MODE = "03"
 
-# LE Connection Rate parameters requested with mgmt.conn-subrate once in
-# SCI Fast Mode: interval 1 ms to 2 ms (units of 0.125 ms), within the
-# range given in HID SCI Information, no subrating, no latency and 5 s
-# supervision timeout (units of 10 ms)
+# LE Connection Rate parameters requested by the HID device with
+# mgmt.conn-subrate once in SCI Fast Mode: interval 1 ms to 2 ms (units of
+# 0.125 ms), within the range given in HID SCI Information, no subrating,
+# no latency and 5 s supervision timeout (units of 10 ms)
 SCI_RATE = ["0x0008", "0x0010", "1", "1", "0", "0", "0x01f4"]
 
 # Reported when an operation cannot complete, so a test does not have to
@@ -251,17 +251,18 @@ def test_hog(hosts, init_script, flags, sci):
     )
     assert expect_hexdump(device) == SCI_FAST_MODE
 
-    # The HID device is meant to change the connection rate, but the kernel
-    # only requests it as central, so the HID host does it instead
-    ctl.send(f"mgmt.conn-subrate {host1.bdaddr} {' '.join(SCI_RATE)}\n")
+    # The HID device then changes the connection rate according to the
+    # mode, see the HIDS/HOGP SCI FIPD, which requires the kernel to issue
+    # the LE Connection Rate Request as peripheral
+    device.send(f"mgmt.conn-subrate {host0.bdaddr} {' '.join(SCI_RATE)}\n")
     # The connection rate may change before the command completes, so the
     # event may be printed before the reply
     rate = rf"{{}} type .* connection subrate interval {SCI_RATE[0]}"
     expect_all(
-        ctl,
-        [r"Connection Subrate loaded successfully", rate.format(host1.bdaddr.upper())],
+        device,
+        [r"Connection Subrate loaded successfully", rate.format(host0.bdaddr.upper())],
     )
-    expect(device, rate.format(host0.bdaddr.upper()))
+    expect(ctl, rate.format(host1.bdaddr.upper()))
 
     # Then the HID device confirms the mode has been changed
     ctl.send("gatt.select-attribute 2c39\n")
-- 
2.56.0

