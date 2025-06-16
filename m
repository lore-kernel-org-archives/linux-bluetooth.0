Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B53289358
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096518; cv=none; b=i7X+cmPxt3XyQbN21AtUwLyE/bEEj76JWLW3UYsbpOkmwKlOT6ZXL5JiO9OfmGzSEslKXjzErnK4G/78pirTFvCQ8SJVgn16cllGuppQ6UzCxnroi/DXpMfGcUed6xV4eiW6qHqVZve8RriIzuRqi9+GqL+011MeDKGr8e5emy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096518; c=relaxed/simple;
	bh=bzsKk+dlUPWzqXNcnCKHM4xQBVhCQiPZhSGKKZShaw8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rf1ONsOhzTpmAs8+A8WZ3D5wf86GGa/mRM5o/DS14ed87D/vYweu8R4PXO+WgUCXSiBsRZy6M52eKHa0B5CGKjlAuh22F7O0Kpb6xaS2hswu75j32ASn01QXc1cOX8Ouf8m4ssv5Kt2p1i6mZ7gR3GdeZQYwaERSXfjiCbbFFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsurUj8X; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsurUj8X"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87ec6f5e7c9so1264803241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750096515; x=1750701315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+L7TDHfZXW7sSdoeTzR8aFDx+INiwuK7V8AhZOLtic=;
        b=dsurUj8XjcNCCHmauBTbUi1ZAMBTZzdpgb5jqY2s2YKRcLs4OgFc0MAt1LcMZ5SUdy
         1R9f4a2u8k6YpWJpKEedp7b4SjuXxfZu70l+VLMNX9NkRGubtbbOjeJ2TWVOKczz2ifh
         RHgA7OJn/7vzhgSIoshfZFTl7dqMv1SqN4gScdMiUizpGEOjLQPPSoC7+Jzft66zaQRm
         j5DA6uxOlMkFGyalIbs8nrpCGa7kQ5MEwB2s4rvaLCnK+u3vXSSw8FECe2zK6Yk+Hf1z
         0ScL3wJ9J9E7SBG4ruLJ/kcvBcpQyJtJr20bkzwQRJsD/OOxZBrBJYOocEVKvxOMAR89
         llDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750096515; x=1750701315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+L7TDHfZXW7sSdoeTzR8aFDx+INiwuK7V8AhZOLtic=;
        b=JnNMv/Jp1iPoU0FlmjGkY2FBXz2ZohyoT1nrH23dsbnrzx22eBTkiVlR61bgnuaFBD
         AboYWmqqOtr1QxfYnW9blVbId+QnS+EBwaI6Vq103VkvHke/cKlD9ewgJFcqLFv5F/p1
         PjU/ZRAP39KQ0ei5XVSFruZDFidg9QRieuJOjwvSiyKjp+JtkkdLfWp9uJNlLkPTvjWl
         yZUUmT2TBGiHKVNHJZ94voO/JGG/7J21wkBxvGRC0/T7AwC16mo3axlbl6Emgd25lO10
         BHx4G8kc/lhNUmILfSytyS38uK6gPaKqQ83/9+Xml/6xG/kGbd8xswqaANityfxZCAyt
         BLmw==
X-Gm-Message-State: AOJu0Yxb+uWTQtDYF4eYqlhHgUYCQNlcdrMt6d6BNtSo1k5em/rj/qOZ
	EHxRAKmQ5QLlM12hoXLKMUh7aBiRzcpCaatLyUL7suicjlGFy8n2dfA7idsv2w==
X-Gm-Gg: ASbGncsxtmer5gDKgvevYNc+rMiPT2v9X80vEJPjXv+RnMPbqCwcaVAmN/exQ2xzYAd
	scbuyFRhGF8k1MybOh1JxbZqeVRi860ivBszHVt4guwzFryxVuh9Jix9ZKD/fZHeonp1zvBC5Bo
	oFO+cgHj3JRCLsLeT5yTQT7NiJQZPNHBJeoz4y3c39+B9By9QIzbnHP2ARHHbYFCX3eBIhf8zHl
	8P/01oyezbJdZ5iqI4JzIm7qJ6QVOH+qbHphCnOM1tAwNorL4tIfYmCwoBoaAAiFluMscVALq7d
	O9SOQix08TUlg7HospHvZWFL7n8abAaSFR92Xv3oryFPuxu0fRYOGzPaVVEuSvHHuAM5NuNYVdt
	5oIvpEHyHWtW1UMY/vvmIZu0rd1dhyvk=
X-Google-Smtp-Source: AGHT+IFSXMqy1NgD2DTs1ZnYrqB1DZLt275ygfx/1QIPt9s9+nb1QOP/imFEp6DLvOnQlzz0+E3Yxw==
X-Received: by 2002:a05:6102:2c8d:b0:4e5:a567:8e57 with SMTP id ada2fe7eead31-4e7f626491cmr7358195137.24.1750096515184;
        Mon, 16 Jun 2025 10:55:15 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7e709940fsm1328995137.16.2025.06.16.10.55.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:55:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] iso-tester: Fix crashing while attemping to access isodata
Date: Mon, 16 Jun 2025 13:55:11 -0400
Message-ID: <20250616175511.2608985-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some tests may not set any isodata causing the following crash:

Invalid read of size 1
   at 0x40067A8: setup_powered_callback (iso-tester.c:1691)
   by 0x40232D5: request_complete (mgmt.c:306)
   by 0x40242B3: can_read_data (mgmt.c:394)
   by 0x4028529: watch_callback (io-glib.c:173)
   by 0x493D87F: ??? (in /usr/lib64/libglib-2.0.so.0.8400.2)
   by 0x49467A7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.2)
   by 0x4946A4E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.2)
   by 0x402ABFD: mainloop_run (mainloop-glib.c:65)
   by 0x402B1D4: mainloop_run_with_signal (mainloop-notify.c:196)
   by 0x402A3F5: tester_run (tester.c:1076)
   by 0x40050FE: main (iso-tester.c:4010)
 Address 0xa8 is not stack'd, malloc'd or (recently) free'd
---
 tools/iso-tester.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 725fd3338c9f..56550882ea63 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1683,13 +1683,17 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 	for (i = 0; i < data->client_num; i++) {
 		struct hciemu_client *client;
 		struct bthost *host;
+		uint8_t sid = 0;
 
 		client = hciemu_get_client(data->hciemu, i);
 		host = hciemu_client_host(client);
 		bthost_set_cmd_complete_cb(host, client_connectable_complete,
 									data);
-		bthost_set_ext_adv_params(host, isodata->sid != 0xff ?
-						isodata->sid : 0x00);
+
+		if (isodata)
+			sid = isodata->sid;
+
+		bthost_set_ext_adv_params(host, sid != 0xff ? sid : 0x00);
 		bthost_set_ext_adv_enable(host, 0x01);
 
 		if (!isodata)
@@ -1903,7 +1907,7 @@ static int create_iso_sock(struct test_data *data)
 		addr->iso_family = AF_BLUETOOTH;
 		bacpy(&addr->iso_bdaddr, (void *) master_bdaddr);
 		addr->iso_bdaddr_type = BDADDR_LE_PUBLIC;
-		err = bind(sk, (struct sockaddr *) addr, sizeof(addr));
+		err = bind(sk, (struct sockaddr *) addr, sizeof(*addr));
 	}
 
 	if (err < 0) {
-- 
2.49.0

