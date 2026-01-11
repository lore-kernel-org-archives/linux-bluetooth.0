Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F52459E5
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768117087; cv=none; b=quR+JI56gnaUh6/2990RH2iqoD7ANTCxd60OSEhW3wPrG8Pkkku634lK0jA5Hw6dWTKmyJ+RCyv37aPjpNzGriMTr7N8XvwU0Af4d8DBMzXZRDcMyzsCr8WeGYb9IkTOd2BuhN9KGrmJNEQy9b2kI1scyu3ttMCApfza010BZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768117087; c=relaxed/simple;
	bh=8YWDGn2quZ8cbmFPRi8FPM8AVrZZq/vhntH+NfL5590=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KV3wSEycqUduy+xiWy4ey2XF/omh9mpye4lIIopm+iX1GKCc02M9vO+gl33Xa/Peox6e2zwnuuscXmvX1e42Zl6K4jZ22PyCKUhzCjtYCCw/OEzwxDepiosj9U9jx9h/68EIa4wDMvAJvqGZth3BJlvRBoVNi7MC+d2XV10jWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvRRF6Qh; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvRRF6Qh"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927b3e5253so4568877b3.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Jan 2026 23:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768117085; x=1768721885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J28f9STca0IvabJHCR1bcxitwIEw1zt9tin63z4xQM8=;
        b=GvRRF6Qh7hk0iC3m//Ld8boT/W3rRirIIfWZOQ+FHlMU5SbWElEsbGakp/J4d7db8B
         ZAxe2gsVzpVrvxKVWWGUxemxwZRWsVY2aYpZNPxea0YxtftUMBjonXnNY+Os89pMVvXA
         w8jJYzhGOYLvUPatSrLAQxk1nrHp6/q2mkXz0Ty6h91iVQVttV0ho3cXAbDxNLnBykEW
         RYX2pW2/WsZZXzevxst0WLp1HBobpjfLQEruS0zpeRd/KRIXvzBJctW3rXTdmMnNYEk3
         gC+FS2pLbteWgIABotDlvz/jdSA92fvjcyw/6mVpLm7Pa9Y+yg/aXAr7hT3i0R9FmWpg
         VwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768117085; x=1768721885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J28f9STca0IvabJHCR1bcxitwIEw1zt9tin63z4xQM8=;
        b=cMOk79jq8xVuwGXOhcEQYbfbGuNwWlhNzPprOQSh1WW0t/tUX/pHuPuS/xV27a2/U8
         SkAUVDL5bDXiOxet7ZTdiQfimODrXJ8i/HMj5TIxrhBluHfDXipGXKuoTs2gAlHIdTzh
         Y3vEpN6KgnGiVnpCShmYG6fN7JKQU3C8BXPGJLw4E9oHp8mS/8qA9RW5M0mPmLaITQI+
         Zs6UYrJPpH3l5AeKovYROHolm6QFoeoiw4bP+hqgH3lOSA5Z29TE8KIpBLdSuPcRY6fx
         FZtU7G6XNMruUSDTWjq0dHh99l6hHa5PHUQNCXP4NCmM2J5W8hR3hYBizqEoj/8ABP0e
         NoRg==
X-Gm-Message-State: AOJu0YxHhNolRGioi5uUlHNulG3JkjhofrLl28LMJAbtE13aYeoI7tPE
	yEIxKwEYdR23y/2GxbBaR0lCZUSsqP3IML/hfizX/grGtgXnuS6/3XiQ
X-Gm-Gg: AY/fxX4M+T2hBzlH7igzTKSMm+Mc6dzwByAe10qFe6szp0p70QJxIGM2TEdnftCfBkO
	5hNfRkHmJE9bNC6gRgswYKAwrWgNfpQuUlIoPwaaTcRQmnkizQHUaq3gB1V1wLM0ptz3HGxeSQG
	GYaagqD5l5f0FKuY3TRqCjNUwjCphVL+RI4cI48iOR2dK4/hc7HRybyl3ooI052wuGKyjUrHLPo
	SGzvpnEycjoKWujN/X+IRMZYgwylo2cfdIzme7Y2YzPFPFErMOD6X7qrWDEw1s+poRrCBw0dLqw
	E0Vp67pOPNe9+gXcX7yAX+uj4oYW+FM6gRnLUShr3qJCHj4WiaM+9pVjnybvPSh1C2BdVOv4oLm
	36v4pelAwscJWr0cS7GzmyRHPvzINRohz3UPI3GHeZNB6fGvfVpbMp5sPa2pbtkvqKkEweVyaJG
	7X4irUyA==
X-Google-Smtp-Source: AGHT+IGUSueGP287fE2u768wBT2YxDHPRtOM7ZgDRonXB83vqrcetLMFChoc1LK4D7lO6DBK4cOOHw==
X-Received: by 2002:a05:690e:14ce:b0:640:e5e1:192f with SMTP id 956f58d0204a3-64716b2690cmr11499258d50.33.1768117085400;
        Sat, 10 Jan 2026 23:38:05 -0800 (PST)
Received: from fedora ([200.119.176.46])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa553172sm57977337b3.11.2026.01.10.23.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 23:38:04 -0800 (PST)
From: Santiago Cruz <santiagocr@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Santiago Cruz <santiagocr@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add support for Mercusys MA530 Bluetooth adapter
Date: Sun, 11 Jan 2026 01:37:48 -0600
Message-ID: <20260111073748.105957-1-santiagocr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Realtek-based Mercusys MA530 Bluetooth 5.3 USB dongle.

The device with USB ID 2c4e:0115 was not recognized by the kernel and
thus was non-functional. This patch adds the device to the quirks table
with BTUSB_REALTEK and BTUSB_WIDEBAND_SPEECH flags, enabling full
functionality.

Tested on:
- Fedora 43, kernel 6.18.3-200.fc43.x86_64
- Device: Mercusys MA530 Adapter (USB ID 2c4e:0115)
- Firmware: rtl8761bu

Signed-off-by: Santiago Cruz <santiagocr@gmail.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1234567..abcdefg 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -560,6 +560,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },

+	/* Mercusys MA530 Adapter */
+	{ USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
--
2.52.0

