Received: from mail-ua2-f34.google.com (mail-ua2-f34.google.com [74.125.226.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C435F61A
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258179; cv=none; b=G9DJBP/WFhvbNSs9dUSGWsvAOLL3E1TxZFLC5AFzbLloYKBn6+T2XqnX0icJ3hi2zdVmj37Zl47Vrr3wQCTgZuHwJ9bMrm4pBE5H0hzCWpVK20rh1QeoCKqjP1Fd3JoeQkIR7e0IJZC0qIAAfMW2N4efCQtyu5mdwJDoj6S+xtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258179; c=relaxed/simple;
	bh=krH4sRu3P1H4OQgWWOZlu/EpxOhLOwP+XvzCZ4BTvcQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxUtGZROqa2hUv5n+Dub3jCW4KEiVa2eKTPgAOANkMG/H1IrU7RTSkwDWXiGsskMKqWVNH0MGSFje+ooVbnmek2WGImcuUsPoTvRjHq+FXHmEbHtUEwslh38dIvAAzPLpx4VSe59xlF52YsOzrknSLcCXvHTQjD/C89Yfgk0LoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEZIn5rF; arc=none smtp.client-ip=74.125.226.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEZIn5rF"
Received: by mail-ua2-f34.google.com with SMTP id a1e0cc1a2514c-982db8d3ab8so1040780241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258177; x=1790862977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FHXO0KwwclyEFwfTkFf1oqSasFhEUn/4IjIXRG/71xU=;
        b=OEZIn5rFTRhjdZRtmMmL5qfvByKVG9quGlD8QQeBm13C/jZyo3jE+f9t40Ohj3/LHQ
         f0rxrGe4F/FlYmZpXQftqsrYKzpcyPJTdDA/TmzraJss5+1q8xK08dTnWifrzncR5NE5
         kuuw4KdDoxGuYvDEeEIb33xH3GS/2gSP2xNFJ0TpFB/KmbJ0fJeHmh4mCb6fbdpx+vgD
         /EfpkZ+o11IeFLdblwk0guR0t9psCfG7BuqrbVqBPXZ69hvzyQUnbqAa4Azns0DTnc1S
         RNk3d1eifNAdXwfuCEMFl8gLiYPPoaTRL/BPHvU8TReJVq6T1tOyQ+ZZGzVQ2KIosUx3
         ZP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258177; x=1790862977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FHXO0KwwclyEFwfTkFf1oqSasFhEUn/4IjIXRG/71xU=;
        b=nhfEA0qZDjigAyuhZbp/1qq0z4qR8JQALecQ2AZgSPed6fZgT0KcxO6YHXinEfN+eb
         OjDeM4vjRErcPGlyoVsp9B3rz52jAJYMwxPAHkbeaNtEaWeyWsLc2xcc6Z6dEgZDzHw9
         I7mAbBcjEgLJSYBdFcDSxa28Oj6tVJiBpAqHR+OTL8n/07DPVKVwQuZwkfPLhXAbPMZR
         uHOT7tbSrcis5Dei96PKdHV4epjuRoMUsxUwk8Of/3Lh3/6R96+7F+n56ueelZY/jWja
         od98sOMel+bnwhggJM4i3lGwor+PbDTNqmBVPFpfwDWldVYYwrBflRXB7v7tqjHd/r+i
         Scrw==
X-Gm-Message-State: AFuF++kaRiAeir1q7Ia1WCxGq2ENpFzUy3nOwGi6M0hw5kqQGAIy0QRX
	8LUK1jKpsWkAEAFEPVCZBioyoUyxtfPqnqYkQsGfm5B7kGfz3DkqudnbFr3ojJ11YIYWCQ==
X-Gm-Gg: AYBFou2rXJWikBftN1rzbUeVEdzlXb1RhBboSnJww0qcHlcG+0kxlPWY7Kx1D4wy+Fn
	Q2bioBbImELBLvgtRa8XsVL1cD0QlIckjDl1kJwD5jrzVV85F3kGyjSLWfJYa0xfVIdT9blR0Vy
	I1TWgtgarZwD3JaCXz0w7cAE1DEXogKfc9Ba/a7JWSOBEc8pfya+ClYObNlSwws6JT+ly6s/58O
	m6LUNRHudTUNENPjmtGRWpHGLXOWIsGdpfej6q/3zJGd3yOC//QcDDpmuGo3K92X8pUhmO3Nnvh
	hbuiuiYazZ6d3EoyV8aFn5T6VuBL3WVXn20+KRLjgS/P4ENAyDTtJpB64ef24CB8k6LrL0epx5h
	4Jp+2KVTJZ3z4m6GRgfLvXoC5pOKBYpN9558esv0xo6KUGCftiZUP765uxEhXnwn1eMVJj4JApX
	ueb7lh0NdUFGHD2A+KnOj/4XKUybgGOzOPnHM0JeoaOkIO7++W6goMT0NELGn7G3aAapXN9z+LE
	JNyJoyOWo/Q6nUt0rYUVsi3AKzYZAMLquGDqxojBJuk0oyd9x2pNEatMrS7gTX8
X-Received: by 2002:a67:e703:0:b0:7a7:36ac:b17a with SMTP id ada2fe7eead31-7af1e4f6353mr1101992137.20.1790258176795;
        Thu, 24 Sep 2026 06:56:16 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7af8bdcde81sm1493194137.10.2026.09.24.06.56.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:56:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/8] client/scripts: Add HoG device scripts
Date: Thu, 24 Sep 2026 09:55:58 -0400
Message-ID: <20260924135601.330277-6-luiz.dentz@gmail.com>
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

Add scripts registering a HID Service (HIDS) acting as a HID over GATT
keyboard, with and without Shorter Connection Interval (SCI) support.

HID SCI Mode can be notified so the device can confirm a mode change.
---
 client/scripts/hog-device-sci.bt | 49 ++++++++++++++++++++++++++++++++
 client/scripts/hog-device.bt     | 38 +++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 client/scripts/hog-device-sci.bt
 create mode 100644 client/scripts/hog-device.bt

diff --git a/client/scripts/hog-device-sci.bt b/client/scripts/hog-device-sci.bt
new file mode 100644
index 000000000000..1bf3a0a90db7
--- /dev/null
+++ b/client/scripts/hog-device-sci.bt
@@ -0,0 +1,49 @@
+#
+# Register a HID Service (HIDS) acting as a HID over GATT (HoG) keyboard
+# with Shorter Connection Interval (SCI) support.
+#
+gatt.register-service 0x1812
+# Primary
+yes
+#
+# HID Information: bcdHID 1.11, bCountryCode 0x00,
+# Flags: NormallyConnectable and SCI Supported
+gatt.register-characteristic 0x2a4a read
+0x11 0x01 0x00 0x06
+#
+# Report Map: keyboard with Report ID 1
+gatt.register-characteristic 0x2a4b read
+0x05 0x01 0x09 0x06 0xa1 0x01 0x85 0x01 0x05 0x07 0x19 0xe0 0x29 0xe7 0x15 0x00 0x25 0x01 0x75 0x01 0x95 0x08 0x81 0x02 0x95 0x01 0x75 0x08 0x81 0x01 0x95 0x06 0x75 0x08 0x15 0x00 0x25 0x65 0x05 0x07 0x19 0x00 0x29 0x65 0x81 0x00 0xc0
+#
+# Report: Input Report ID 1
+gatt.register-characteristic 0x2a4d read,notify
+0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+# Report Reference: Report ID 1, Input
+gatt.register-descriptor 0x2908 read
+0x01 0x01
+#
+# Protocol Mode: Report Protocol Mode
+gatt.register-characteristic 0x2a4e read,write-without-response
+0x01
+#
+# HID Control Point
+gatt.register-characteristic 0x2a4c write-without-response
+0x00
+#
+# HID SCI Mode: None (0x00), notified when changed
+gatt.register-characteristic 0x2c39 read,write,notify
+0x00
+#
+# HID SCI Information (intervals in units of 0.125 ms):
+# Minimum Supported Connection Interval: 0x08 (1 ms)
+# Number of Supported Subgroups: 1
+# Subgroup[0]: Min 0x0008 (1 ms) Max 0x0050 (10 ms) Stride 0x0008 (1 ms)
+gatt.register-characteristic 0x2c3a read
+0x08 0x01 0x08 0x00 0x50 0x00 0x08 0x00
+#
+gatt.register-application
+#
+# Advertise as a keyboard with HIDS
+advertise.uuids 0x1812
+advertise.appearance 0x03c1
+power on
diff --git a/client/scripts/hog-device.bt b/client/scripts/hog-device.bt
new file mode 100644
index 000000000000..42b324eda020
--- /dev/null
+++ b/client/scripts/hog-device.bt
@@ -0,0 +1,38 @@
+#
+# Register a HID Service (HIDS) acting as a HID over GATT (HoG) keyboard
+# without Shorter Connection Interval (SCI) support.
+#
+gatt.register-service 0x1812
+# Primary
+yes
+#
+# HID Information: bcdHID 1.11, bCountryCode 0x00,
+# Flags: NormallyConnectable
+gatt.register-characteristic 0x2a4a read
+0x11 0x01 0x00 0x02
+#
+# Report Map: keyboard with Report ID 1
+gatt.register-characteristic 0x2a4b read
+0x05 0x01 0x09 0x06 0xa1 0x01 0x85 0x01 0x05 0x07 0x19 0xe0 0x29 0xe7 0x15 0x00 0x25 0x01 0x75 0x01 0x95 0x08 0x81 0x02 0x95 0x01 0x75 0x08 0x81 0x01 0x95 0x06 0x75 0x08 0x15 0x00 0x25 0x65 0x05 0x07 0x19 0x00 0x29 0x65 0x81 0x00 0xc0
+#
+# Report: Input Report ID 1
+gatt.register-characteristic 0x2a4d read,notify
+0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+# Report Reference: Report ID 1, Input
+gatt.register-descriptor 0x2908 read
+0x01 0x01
+#
+# Protocol Mode: Report Protocol Mode
+gatt.register-characteristic 0x2a4e read,write-without-response
+0x01
+#
+# HID Control Point
+gatt.register-characteristic 0x2a4c write-without-response
+0x00
+#
+gatt.register-application
+#
+# Advertise as a keyboard with HIDS
+advertise.uuids 0x1812
+advertise.appearance 0x03c1
+power on
-- 
2.55.0

