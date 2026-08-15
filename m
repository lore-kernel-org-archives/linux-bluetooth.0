Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA21A6822
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786764865; cv=none; b=RSvBPGDHduQ0G7bXwAB3lfzCy1sOgnJSj8vhi0eG+HJlsUyJSeslbGS43eBbP/gSAn5/xicgRXwroIKHN2N1RpGCuV+6wTbkEPlAzngALDqhazXPLc1Z2e0DrLJZt5kNFczQY0yhythKSQxB8eq6Uik2L9uasHFf8ntbL+XRegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786764865; c=relaxed/simple;
	bh=2u0GRHTzdqDBD60dVwcN2/IRZa0Z8/g54oETAYVAwRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEsknTfv5nXDkmCzNOnNbDVb9lKVBacAaFzZx65tKD07x+yZIJk9K/vl9+BnvIpVP53F9PW9XudZxTJ44EBRsrKos2UGJwPBnst8hQ1VrCzToY0VF2IprXPvQYHg1YHSiCyEHyjjKDVVYfeFQvfL+PnLinm9/gcA7/rZSvN4DSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruwgpQTA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruwgpQTA"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39faa67fabaso9650721fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 20:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786764861; x=1787369661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RyihwzFYKn6w8cGBkzYZ/sFWq9QB5ppf5XFLNqtPVvs=;
        b=ruwgpQTAxzKWB5GyoRCFo8ZIyrOfxxktRfWa4vk27yrhwnv2ljoAszXmNSRTBfBX0b
         T1QhWE2RHFI9koNaW1Xz8BHlQBbx3skidrDT9DUq1PYswT5Tv4y7DN+EtcNpbr/y5i+U
         LetAXqouV0kvav25n09c2XTTEb/MQkXoGr1ulMQeQ9e/tmSIJxyR9zuki4KQ84KAtfIO
         aCYtCa+WUZyJPWbFoHzkNWnJ52QcwAFA6p4osZyFY0P3nKczC9vQw1q5t4As1ixdVGiu
         O+y5AZAEwaRRiOQ64/zI8AieCRIscyT/EYY0sC+/EyyYoBdpfPSPt9jekF1RZVIiWO61
         A1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786764861; x=1787369661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RyihwzFYKn6w8cGBkzYZ/sFWq9QB5ppf5XFLNqtPVvs=;
        b=Y8zsj6Hfg+Crl8NbXmOXIbcImWKm0u8fMxkBjQizVN3LB+m3kjUqucQK+XLc9itlh0
         htY1/nlpBbH9NIQKYk4gE+1MZV39E3AbbLmmCxmton8uJUnOr8y/UoE805U+9kG60Aiu
         dEQrC6OY6PAje8MTH6mfqDEmLBZVfxO9MC8VAcZZRUqmSGoxTOiS4vlZEITzjwtX3sk/
         tZ3H52ZoJD1AD1q5OG+bHNXpCb2NX7flIAzj2oXOAh1GJSE49d+FAbYG2cPHNSKGxypr
         X9T1wYfTz4A0aOxmcU6TJ8YQPRCBpOtC9XxuKJbhbWENwMcXyuCGP8E7RtiW5YX4i1ww
         jJHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlqltAUuW3gYohDCEmm/R6HSNJNZJLyn1LQI9M5G6pxY9C8u72nxrWTVpbEsrqGhbZYLkoOrm7Tr4LHrXeYRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVJsJ0uRpuDI8LHCahMFjJpvcCOVRtKedxFCyeYZ2DFMM6oRc
	lUq4Xefsd07Dh5L5QVQFw6g/q6MJPlUZKH57X3gMFq2jPSHayJh6ZMl2
X-Gm-Gg: AR+sD11PbU9+HwlVdK/WxV9iXg22Y9BHBR75c4o3zrGgWEYGO4HXLVqoLn509YK09eA
	OLaIiDBDDi2ztY1mPrA4QY06E1Q90AQHH3HpVE95QDTP66YIjO0Fc3FyD+E4AxJFRB7NyfyVD2h
	fdPdHJLMI8+O+cjOXgxrHvfukazhIOOxUaG6H690Hq5ZE5l0YMyD5i9i3ZrZQm1wF3H3KyHQw6J
	hynQipm0L6z3t6MTbPEGFSdCpfBU///0AXAGIQzwNyh+Cootd/6Gux1YOdYDp6+KQT16bnfGhgu
	JyYx86G0/4us7FbifpeM5YyXyLcybvhnRQFpYYE108vNCCd83Urhtra0RzNzPVCC19Ucz7TbcHS
	cc9X2POnO4hsrBbSlRO5zI2kmViKyXAi6XZIrWCK1mPpaYtHU4dGBX5nq+UkiGOyWfPsY/piLpx
	BXaKBObOxNmkuWMUxxAXGbP2N9i+b7np+yoEkTcLByMZw/N+DoVMtcLfeMUrVI1P0LuvjqvBeHu
	w==
X-Received: by 2002:a05:6512:3094:b0:5b0:1df9:2aed with SMTP id 2adb3069b0e04-5b45915e5d4mr1551124e87.5.1786764861406;
        Fri, 14 Aug 2026 20:34:21 -0700 (PDT)
Received: from localhost.localdomain ([188.162.14.60])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458beda7fsm882707e87.43.2026.08.14.20.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 20:34:20 -0700 (PDT)
From: Andrew Bille <andrewbille@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Daniel Drake <drake@endlessm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Bille <andrewbille@gmail.com>
Subject: [PATCH] Bluetooth: btusb: treat 0bda:0002 as a generic HCI device
Date: Sat, 15 Aug 2026 10:33:46 +0700
Message-ID: <20260815033346.15882-1-andrewbille@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 0bda:0002 Bluetooth controller reports itself as "CSR BS8510"
and exposes a standard Bluetooth USB interface.

It currently matches the vendor-wide Realtek quirk and is therefore
initialized through btrtl. The controller does not respond to the
Realtek-specific register access and initialization fails with:

    Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)

No Bluetooth controller is then available to userspace.

Add an exact match for 0bda:0002 before the generic Realtek entry so
that the device is handled as a generic USB HCI controller.

With this change the controller registers successfully. Scanning,
pairing and A2DP audio have been tested successfully.

Fixes: a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support")
Cc: stable@vger.kernel.org
Assisted-by: ChatGPT:GPT-5.6-Sol
Signed-off-by: Andrew Bille <andrewbille@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 184e95c1625e..fb9fdf90a3b9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -615,6 +615,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* CSR BS8510 device using a Realtek USB vendor ID */
+	{ USB_DEVICE(0x0bda, 0x0002) },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
-- 
2.47.3

