Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362934;
	b=vJ65o5IKQ9hqq1xwlRGW0uH9ZpSO2ujaZ3C2hlKYV1xptnUge3RSVJgXRkO/H6G6bs4q
	 sLSmdCLqJJ4QlU/yoYal6vD3JJbAjTRfR8MvV5rfeBnLpeolE+nA01XK5BWsWAemxQWGc
	 qjgQEyuIOmWKceUDLVOAbOCWTgfIkP6v9xw1UakQg4r8WnntAp51yMEqgdOfAOd5D13Fv
	 n0K/YOCrT6GnjeKV1dqqfzDz6jPAzEX5UqQXO+BG/+QsLFSKSdcisJZ+DklVDOuwUeBiR
	 nrzjF+fdSFxEbgj9hZybjjoD5Tqus/0td+LPVKccpchvLZuqy4ZPr2PEzdNeZO0yjyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ISpvwRfbsmA2blLd4AHPGsz9Evv/ayVSsp4pX3uD68E=;
	b=OvcrN9xtIEtMhmOKynv9r0vWidZkAeCkzn3MjUaJEUF+lgOc8wod3IWl0DAbgIak+oZl
	 UaFbpLB7aotrHwSQihCrdsLxBC1LettTaSNz8o+cKDBhEvt0fhUBc7wbYxg2Z0k1SL1E0
	 axUDPoBBymnIMUk96lLXK/UqCYLllXUz4MDIIHf28edv6xWRCa+bIEcHkbBO0NJWqbkYY
	 v8AhrLA3N1V2UtzZ/HIJJbAQaDpbAhaPhfzvRf8Olq665fg+ufkn2mKsSisj2mU0OhKvv
	 NNRefA1AQr7M7rrqNlpEhzQkiBZwAFRPGpLhZ3MQOAZWjMSphpOpslulIHrZbEw/XSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=lWh8HahE;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A8606A330
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 15:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 040A8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=lWh8HahE
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so13205045e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795362932; x=1795967732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ISpvwRfbsmA2blLd4AHPGsz9Evv/ayVSsp4pX3uD68E=;
        b=lWh8HahEYAw8N0zgPmB3rvxjmkDs/E0SWbwfE+N0rTy7kcFJSbMlikM2dcHNurzD3F
         +4lSMXVCAckyC+/hzD8QEyDzGqScttPG5uIxhSO9lbs2OdEUGwkZCD8fWu9G1WUws8GY
         Fs8g1LmarrYGAZzKxkUjaqvhpw/2Yr5QGf99I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362932; x=1795967732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISpvwRfbsmA2blLd4AHPGsz9Evv/ayVSsp4pX3uD68E=;
        b=PyCq8u75GkhWC6nKHaPDmCbwC9CKTn6MVefFa/CEoVrlSii+l2kLEFwc5i0kzOLQhk
         BxzYdzQ+fHtFf9ALNjbnm/SdSpYpCaRtCazrp29G0wBVIGFpEMYHWbTnrtYftVs02ngW
         RJWveBM+dmqdv9UYsMQIvMMI7OKO5yi/4TA6KSLkgBcp3bR4wROyC+SvDgjmhlyVLaxJ
         yIVjRcSaZkvXTAsLqt67q2HkM6JNI17VRrXPJrE+bzTka++m/MBbe0D/tDdaZ3XUE1v5
         81clgNlfIfAprQUbh6J9xzNrYuDrVuDWmroTAt2B3L7wVpq8u0/kgaOCQJ0YLCSrrXE6
         Ormg==
X-Gm-Message-State: APuU4Z/gb4Iwsz9vh9OGLEzzG8s+wcRMuSsI5MuSYyn3/wOn+ma4+7IS
	SZxgUGiyg7J4NZ1uUofnn/xCxvNFsZmevhev8qQpCSlw/1fE2UMpWn4+dFZtHYkScj6hBcpRo+q
	btx7p
X-Gm-Gg: AZFdTZfU3nj4hStN/Tp0qzkl4TBooEpb3w2NHMsQ238gMHOWPLfMMAwkgSMHF72LfWo
	5DnzMlnznNh+3clbaNqngFVD8ZJpqrVkk4HJXdGfxQo8KE11ddlsybYM35rTJvTGe+Xf+vFdp+6
	88gV3WIReSG0z2tKwu0Yz8u4Listhfrr7NiJocKby367ZLSL1zacLa5kUaMQXnsxF10n+L2A6mX
	u+9TnKXIh8bq8xXOQ5qJCJIIRdCwe9HMaambJU1w4+bIAgzauwYwD5kaQHQwxZ7StHseZQh9H3V
	uprIr4x2PEPg/9QbYzTfVnCppxBTrFuuQBlU1my6kqyT4viN+raKk10dfzjdpZ3SlqOYxXg0Eub
	VfKfe+D03kumDKZDruTeO6zPAeyFiaL5UTYcuYQ2OHTrwb+Jwve4wYBPKvqLuEMSQ+ByvR6nDAy
	5kbBxpW1pRK4uXvNoCwuExdmkchu8ILwf6gMMs4EptVQYqGJPTGNmrqWQjfGgvinYyxjITE3J59
	zUjb0KVaCy5+W4JvSrYMxvxB8L1GeCBvhgV0ik0Y8fSoOXtBYF2O6VKJelTjtcS54IH0SZR6lDe
	SWLW4mbWFGckc9S09c26dmoZujmcKF8UN4/78OmAvRXcZTv6iw==
X-Received: by 2002:a05:600c:470a:b0:4a1:d459:db4b with SMTP id 5b1f17b1804b1-4bb8893071fmr189722125e9.24.1795362932475;
        Sun, 22 Nov 2026 07:55:32 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm16804560f8f.56.2026.11.22.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:55:32 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: btbcm: Add default address for BCM4345C0
Date: Sun, 22 Nov 2026 16:55:27 +0100
Message-ID: <20261122155527.1553835-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

The BCM4345C0 (CYW43455) on the Raspberry Pi 3B+, 4 and 5 uses
43:45:C0:00:1F:AC as default address, so add it to the list of
default addresses. This way the address from the device tree is
used instead.

Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 drivers/bluetooth/btbcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 065536d4ec76..d0e30182813e 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -29,6 +29,7 @@
 #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
 #define BDADDR_BCM4334B0 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb0, 0x34, 0x43}})
+#define BDADDR_BCM4345C0 (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0xc0, 0x45, 0x43}})
 #define BDADDR_BCM4345C5 (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0xc5, 0x45, 0x43}})
 #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
 #define BDADDR_BCM4384B0 (&(bdaddr_t) {{0x93, 0x76, 0x00, 0xb0, 0x84, 0x43}})
@@ -121,6 +122,9 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	 *
 	 * The address AA:AA:AA:AA:AA:AA indicates a BCM43430A1 controller
 	 * with no configured address.
+	 *
+	 * The address 43:45:C0:00:1F:AC indicates a BCM4345C0 controller
+	 * with no configured address.
 	 */
 	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM20702A1) ||
@@ -128,6 +132,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4334B0) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A1) ||

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

