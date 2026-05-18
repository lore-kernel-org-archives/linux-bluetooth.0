Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF824501D
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138221; cv=none; b=MSryva/kME2/YTo29gacouJQ2Vqh7FgtvD5TsBaEz8WvZjKjEofWYIpbfOMkhscIp1YtW60cKaIdWmhNy7degz8K202Zh5UItys1qXgGnO09Gz+fJHTBu574E1YTn8zXh3l7Dr5nEBijwRIyQrAWc+My1cN2XdWZgrrMGPIuzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138221; c=relaxed/simple;
	bh=rvhUwGfHUijegushTrtPuM1U9phm27YzwPvN9Y58MCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXL1wEnE4LQYH4DPY6p76r+zm8eEPl1b+GWM7BFYPGlgg8Zh9MxEqUSwg0I1yXs1Y5hi5Pu4+/qr0xWNwjG68k2RbfVt7Y5p/LklUz3j17XMsEKqJMWzLM3jkjO+iHtZSQDdXgMaUGypEXiJswYlT8srxOd1p+gb/TMUrEWiaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC5kCQYa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC5kCQYa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so41354155e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779138218; x=1779743018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcfHzkvFcK1Kvn+Ki27zDsAk+C6WkA6MZMHQlLQTfDQ=;
        b=QC5kCQYaBTXzLao41t45MRo6nQbjfmvaqYjvwcvDw8yj6P1GiueTGoWjxUI3mzSVuB
         4NhwgGiHyWzwIc3jcsvq/EfS/z6bg/aYhTHbNtaLAMbQTrMHDz4AhcPAE1p433WKY0WH
         Im3DVt5lx2FJKwUyoSBK/dk08TCNd2cJ78DVZCTu6HGXkyQjgpjQHAuGFldjtjV/oMvC
         sj01+lIVxvo4Xnn1jV5ZrVMl7pCI2UuhY3KRMuzxc8tzKu63Jl9W+Fgh40btzY19zShp
         r2UxvvU6/rfajq6pWvogOaQfLVOgcD8U1pgTLWCcNjAQTm5I7Af+GaHQ4cVRBeaJ/tho
         S8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779138218; x=1779743018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcfHzkvFcK1Kvn+Ki27zDsAk+C6WkA6MZMHQlLQTfDQ=;
        b=kFAwZhSGJ2AafBrHpzI9OvjXcLSSEIM7phvu1xDCKtCBIx0Kp0vdb/U+r0WuQuEbLN
         68JXp0ZRMXn6CFRF0j6t9hbnFDOyUTZwsTKg2ZHzoPIjomrtXcRAmfM8rO4yzOqy7aJg
         Khj1H7qtATLKt2hFl3C83L1KUI0ug9ox4SSi1cY+mhU4Am+Miv7sqY2PV4l56RlNoqge
         aGmNc3LnddRLduumwvSGZfuzFxiLjvv2G5RTMb+/F9o/EixuW3GfSiqc6tVDPzMXhfYf
         kAoy3PvmlrrhlvRMFr4oy3b26bMhwWHYHJ0Hr8VvCgYHdGbzaSkhYeYgpPL6H8nrU3rR
         qVoQ==
X-Gm-Message-State: AOJu0YyIOLSXSi0BNlS4x87li+60oKPW2cHXUGSTvVZAMgcz/E4EHEa+
	NBgM7NEis9HWvX2f+dxvU+f5CboShmxciVbyi2qVT6T5B4I01ivNfdeGBTnoTr5qOOg=
X-Gm-Gg: Acq92OHUZI1f/CJLWcDeSHPBXNJeGqvqOvkH5a844+1AlX+77EgQPLf9QMbHtVFdBXM
	gRmmjz4snoyOv/hlWVFscPvlqCfN/B3WFAD1c1ZQ1U1YC1QHBUMrz+3MaJ/m+aqMMG/v4d9axDC
	bkdGW4hBLPQgWGw2ggSSzheZFXCmbv9iftjDRE2ZDZXWogFc+FVUSNqXdEy5rpsT/esthm3I/8Q
	CyDEmwExgU04ty3PefzekK4m4tmifUTPF7p8Jzg0JaQ7UW5XQUAbxy8O1+GUFxoagjD1MsCja1C
	azqU18stqt7K2aI7V8tQ6nNQlU8EHZaqzJOiLnCYr8Ea9UOA14e5M+F0dUPJugHLmsES/9huXAh
	jzhNJOCiGZt2JpRMrovtlYnXlVtbdB7MEBgukORpmTNKt15Z46RM9JsmN313PriZ1Riz/9AXbag
	eFwsJiW2E+wzehF5hFM2TJS9/ifT1vBQzV5XDdYLU=
X-Received: by 2002:a05:600c:6992:b0:48f:e230:2a20 with SMTP id 5b1f17b1804b1-48fe662a1b2mr257792115e9.31.1779138217870;
        Mon, 18 May 2026 14:03:37 -0700 (PDT)
Received: from fujitsu.lan (nat-103d.starnet.cz. [109.164.51.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49008c047absm45601415e9.0.2026.05.18.14.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:03:37 -0700 (PDT)
From: Jaroslav Srba <jarys.cz@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jarys.cz@gmail.com
Subject: [PATCH v2] Bluetooth: btusb: Add Realtek RTL8852BE BT 0x04c5/0x1670 (Fujitsu)
Date: Mon, 18 May 2026 23:03:35 +0200
Message-ID: <20260518210335.1105068-1-jarys.cz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260518191654.615129-1-jarys.cz@gmail.com>
References: <20260518191654.615129-1-jarys.cz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Fujitsu LIFEBOOK E5512A ships with a Realtek RTL8852BE combo chip
whose Bluetooth half is exposed as a Fujitsu-rebranded USB device
0x04c5/0x1670. Without this entry in quirks_table, btusb binds via the
generic Bluetooth class match but never sets the BTUSB_REALTEK quirk,
so btrtl_setup_realtek() is never called and the rtl8852bu firmware
patch is never loaded. As a result HCI works (hci0 UP RUNNING), but
RF reception is non-functional: inquiry and LE scan find nothing and
pairing is impossible.

Other Fujitsu OEM rebrands of Realtek chips are already in quirks_table
(0x04c5/0x165c, 0x04c5/0x1675, 0x04c5/0x161f). Add 0x04c5/0x1670 in
the same "Realtek 8852BE Bluetooth devices" block, alongside 0x04c5/0x165c.

USB descriptors of the device:

    Bus 001 Device 004: ID 04c5:1670 Fujitsu, Ltd Bluetooth Radio
      bDeviceClass          224 Wireless
      bDeviceSubClass         1 Radio Frequency
      bDeviceProtocol         1 Bluetooth
      iManufacturer           1 Realtek
      iProduct                2 Bluetooth Radio

Tested on Fujitsu LIFEBOOK E5512A (Ryzen 7 PRO 5875U, Ubuntu 25.10,
kernel 6.17.0-29-generic). After the patch:

  Bluetooth: hci0: RTL: rom_version status=0 version=1
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
  Bluetooth: hci0: RTL: fw version 0x098b154b
  Bluetooth: hci0: AOSP extensions version v1.00

Scanning, pairing and A2DP audio playback to BT headphones all work
after the firmware patch is loaded.

Signed-off-by: Jaroslav Srba <jarys.cz@gmail.com>
---
Changes in v2:
 - Drop a long "RTL: examining hci_ver=..." line from the commit body
   to satisfy checkpatch/gitlint 75-char limit. Chip identification is
   conveyed by the firmware filename (rtl8852bu_fw.bin) and the
   subsequent rom_version line, so no information is lost.

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f5fce93d..93fcc02e0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -543,6 +543,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04c5, 0x165c), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x04c5, 0x1670), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x4006), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cb8, 0xc549), .driver_info = BTUSB_REALTEK |
-- 
2.51.0

