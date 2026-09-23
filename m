Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6E569F23
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191930; cv=none; b=WnkmNAtgfiRqYVg4wMKWlhsqJpbZvoCqtpyTU42PWpAEF04TsdRiq7x1/u1VGX82NTgTWzaiDfDACfACTm/wjJhMWrh7Xqu0xAd6D6azVgAPuwS9gx+TFrmazdaPiVyMkClBNVXFiIkdVzC3E3S30q4B+48U1dvwwXfZNiodLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191930; c=relaxed/simple;
	bh=krH4sRu3P1H4OQgWWOZlu/EpxOhLOwP+XvzCZ4BTvcQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8nkgb7t8/PfBJJMGcLcDqu+SFf/+QeUg+RGR7a1td1rWOzWbopMTx+vpuuRNrIXHngWf7Z2YFhzUofVRTKbkEcGEiVETPevYpjF1olzFeI+x3Nb8RTknnm2qclRfPJU4f4mJH6VaKyeE2hr8m975a9ZmWMdif4+BWzi77oK6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcT55d9Y; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcT55d9Y"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c675e64ffcso184878e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191928; x=1790796728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FHXO0KwwclyEFwfTkFf1oqSasFhEUn/4IjIXRG/71xU=;
        b=fcT55d9YRNJ5NBMiK/trsOUa6zEbHRQVHZQcJJVVWPn0Iogw2RjmWE2+5tc6a3oaav
         Joe7va4JgbAaY3A14sT57ifjv3eHvfnJsIr2v1ONhIXpi7U15g8/NVYpCwI50l4zSqWE
         O1ZbjGnOG2kE1fKtn0d2AL4MZqLRQLUlA3/BmdQxdGJoQoeNehH/H/YeR1uuy8fwB2jv
         pdisAwm/pik7uajb0Bus7OatjXHjp4nKkAMTikY+rapNEC1Zqgdhv9USeITFYTX8uYmi
         JynpeZxsg0nbI/ZRCxrD4fQfYCcdrbqkVe2bIvE6ezTnRbq1J9nnCfce1Gjjl+oobGGL
         Pgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191928; x=1790796728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FHXO0KwwclyEFwfTkFf1oqSasFhEUn/4IjIXRG/71xU=;
        b=26xwVZbgAfIkEbXaqudIDOnStAo0qDlR07qW+t/1MG1B122+IfuRBvyddl17P1Vr6Q
         5RA6aZlY2FcLxPMXW0yjKoMQ43FCAWQmtAlnxTgdP8PceVg+dDvx9Cr0OTAiFzGuxoGY
         7YWuB/QS/GGjB19uos7T18jU1zB1lcqOVAb9dsL7CBgE3Bf5aJiWfnLteVT5XU8imeuj
         k1tdj6CU3w07FuKofpGAVREg/u3KTAS2N82vEZdtn9Hj+vbyK0Ve2ZfdF45yPVoWbBrc
         ttFGJhclSw/tD6Gv9SdLg0qP9lH7BAMmD27uGTA7gexj7U1FeEIo+Odo+yanYkvs+Jql
         6xjA==
X-Gm-Message-State: AFuF++ldQo6eKfOr8Vs0laFwRCpLn86jzOW+G94C35PHEIZiqPYObjmm
	UuljaXp1jjgS3aQaTMuC+X0C75uAennXS48q+9wfiqugG9pv/y3+CC3qepkTHB75CzjuVQ==
X-Gm-Gg: AYBFou2OLiwuL/COkTvJ87BreIcKws6Rd/s5HF+36lfLNS4JlYVlvALTcRq2DqbznY0
	fU8ZZD+qHTNAQJqZ8APOznv5KPtiB+BDpzkpwAcvuc0aagFAhAjPr4ilS02T+vYrJvWMH+xLztx
	O6z0jMzSLz4z1u+nU7l43VrYPJYR/I9avftFq/BPBpSWR6LC7Kgk9rDHQgUBlkfbPoxpvUNrOMN
	XOLgNFcf1poikANbxx0NuSV5qJADzS0R1IVGf4/yzdqUGB3WH0727myXtewAxe//vUwWL5+tz5y
	ZAMXXetj0BAIvZx1CI9M0lg6KVZfsY9RLfyzxclzz3ye8PTdpTaHdSoaxxlOR2wKYpRVAofNBuI
	M4oyJ5vrOQxPPBcZV11hEm+ONILUQxXET38aKaIVOVIuEfCpo3DnnhF/9+Wyh26w6BycRg+Xvbd
	DOYiTRGyqUmtrmxmtnscsCTJF9VJbgcLR15fadQX+IkbtW+AbMB4sH6TBaGD7nksl6g6tPWzJY3
	db32YmlWyRU+MvlJaNgJs5JYm9YOGeNiwdGVFO2/gLM9p+0CxzNsKkYHy0dCA1OWA==
X-Received: by 2002:a67:eecf:0:b0:7ab:d498:aa69 with SMTP id ada2fe7eead31-7af1eae9c50mr122420137.23.1790191928091;
        Wed, 23 Sep 2026 12:32:08 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9851691693asm4666266241.2.2026.09.23.12.32.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:32:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/7] client/scripts: Add HoG device scripts
Date: Wed, 23 Sep 2026 15:31:54 -0400
Message-ID: <20260923193157.249636-5-luiz.dentz@gmail.com>
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

