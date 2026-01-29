Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D11F0E34
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653708; cv=none; b=nVb0noeAyOaYrs4bp0jzhddlZQ0taK++hNTXt0tysJtJ0tOjFVrPMSnCRdZuy8uwr3lkbv9vbAWGebs4Cddl3SqryYyTlHiMRDD+8E5YQwiw1kwF+sUGAC2LCLg6lfz7E4ne06fGfZWLm8cS3tBdCOWdqnCuzYsQ/leEQQJ7M/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653708; c=relaxed/simple;
	bh=jke16qGYYZ/PPyh9bOnhUq/mxF6cZ5UQRXZewvQRH2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZjxhGHhIf2dLvRc6cEnH41KE3Ltlpi0qD9S23F87qPtPEyHFy5fS0bJOLZS8y/r11W7oTrB6rYQ9dQaXZRsY7dKGpxub623PswkX4H5/r1va8XZeozTVYpwpwRCf5Cjj0d8sOo7M7sfBYr8KQHYvhqkwJyirkNu7WH5YEs36PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9I/wtM2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9I/wtM2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35305538592so351138a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 18:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769653706; x=1770258506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EGo4hoj4EdUYYd7PUFglCgfUu6wH660sspS1uAlnjzA=;
        b=A9I/wtM2D33VPGlfxefNG3u0gT3CwNkAa8x5jOre22yqRWd60pST4xhQZZbrl1EDrr
         ktWYj+y0ff7XB/3F4bUL/R0cAJkx0E1QEXxnfOLhirTXOL5OZrTsRnjaAYFSOwOko8v/
         C2mHp2K3v8DvGlUvdkyB3IkYQCjW/7FuXkD4omg/I3eZYon8a1Jfher6KCCANEJzP92H
         2+Xzh0fmvxSCzT2/n+AXS/1erIblWNfVhJyf6GwEysv5Ay9SsR/DkmwV6mkuFPyAMBNg
         Yr5X1CnoVZDI8EchD7FiPfSJ5H/PZ1ubiTRGr0X0oL3xewkBH01kjxA0eNm3UhUKCuaT
         ewEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653706; x=1770258506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGo4hoj4EdUYYd7PUFglCgfUu6wH660sspS1uAlnjzA=;
        b=l/Lnxr47w8E0PxdKsgVLryBQo6oxNMpWSowCtaPb/RE6AKvwrCRwZTL6u1uyQPYdXG
         +sneKD0oRTt3Afp/LfETGDqC+1+q3bYOYHxSjb25xHD/GHwB3VhI7pRwVrvwiiVF/6Oh
         6uXCNYRS37zCVlllNuvY4qCuadqIJa2apZD6Ua+2aOJAnpeVF9PWs7/wmLevQw324aGd
         k0RBDX+HksFyn+6IUdcq4ACRzn2+AuxGF8MbqYUXIY81w2hNQNso4yzGGaQNrLhhOZRW
         T3IJNX3iHlsCfpAEFZuuHPTt8IcAqFKnsL7uoebrL6/yCI9MPirf11Ns/4IzD6eaoVvn
         /pWA==
X-Forwarded-Encrypted: i=1; AJvYcCV5VIB+rnm/jTKWCNMwek26+4PFOPUJPb7mEuPDYAt9eAIGZvdYsY5vfwySKOtsxg7w9L/+XDa6XX96N+Ez+mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKLEsm20B6leZSU2GC4QH+Z4+3jGKdpEbzqLUFhS32hcv1fIl
	yfgQ/+OOta4RO5fnYm7svL1xvbS1Zh0NnO/ZJTcgtiJzoDNad05UafQ9
X-Gm-Gg: AZuq6aLcbREmRA7zgRXnvf0xWBB/IPFaVd3qzgmXd/6nXltuKOMUv4imDxC/ibJU5oM
	XYohJtAZn+DDxBQn11VtvBporiSQv9fxQVWYllIJfycAkYjiqLGZVv3cRAHvo9SWZ0g7CGBA8tv
	ZVy8oSzflPWmqjSjSDRGX9CIH/ltCZp3sGKG3k1w98i4auN5z+Uq3ZA6eAIcyI5Vv9yMSXk/10+
	PGEJYLgKsCpYUUuK9uKmmC4URYX3ra13Zr3o7ad9W7IuPTsmgY3PgrQ6EsMj+S8/QtfUHH9lQG/
	+DPxMhl3iII2HB80VZ1U3lfxYAoEACTfZXeF+bwxCl0yMt03W4ta7L2NcS8nW36Akp3BiFfO7FA
	ahDrx0ySdhFJ56LPlG8Fi2u+ri5eUvU9irZwXnn64M9DpowtvoFQWDRFQQtbdNblWaFHTWfnDXC
	etvWENZCDJqPb3FQ0EGUzRxzW8uo8BCidr7ojW0QGJ
X-Received: by 2002:a17:90b:544b:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-353fed907d7mr6446368a91.33.1769653706068;
        Wed, 28 Jan 2026 18:28:26 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-353f61e0230sm6783867a91.11.2026.01.28.18.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:28:25 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pkshih@realtek.com,
	max.chou@realtek.com,
	hildawu@realtek.com,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB
Date: Thu, 29 Jan 2026 10:28:19 +0800
Message-ID: <20260129022819.61290-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 7392:e611 for Edimax EW-7611UXB which is RTL8851BU-based
Wi-Fi + Bluetooth adapter.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=7392 ProdID=e611 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=802.11ax WLAN Adapter
S:  SerialNumber=00e04c000001
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtw89_8851bu_git
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8c34a17ed..fcec8e589 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -529,6 +529,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2001, 0x332a), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x7392, 0xe611), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
-- 
2.52.0

