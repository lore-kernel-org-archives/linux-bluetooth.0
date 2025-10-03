Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83021273D9F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455655; cv=none; b=krM9tTe48QoWSHKjIBG9I30L9JU5//+3dmv/8AN+zIfEyYyUaB4B0Pb+PH3SLrJcAA9b0wao3efCMmIgpU0ukX5m/x+KP4GwpYKTvgvd7C3DsFNLjx5EaW/xhjJP/p/+6EsYkEuSYBfHTh0V40Qqrt+YnQ8GcSG+1kW/RxGLmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455655; c=relaxed/simple;
	bh=xUaGR4WoabITYgK3+xJFRn+e0Uq1vlAyOWZJhB35IMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHzkWyOSJhZSoT/m1983j7QxzsjgSJ5SNS4pjs98lY8PEO3uXNXNnpzlyWb4oyI3Z9QEoFDzLS0ecg8iAJ7tUfuVOJplvYTOwyP6eZBEURwPf7GV1BuLrZ75nrFe4OReSFHPlDLaShZEw1XHITABWmBrBAKu6BurBbUOvpNhquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXwuQV4C; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXwuQV4C"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1127023f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 18:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759455652; x=1760060452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWoIa0y9v6+gweKWrBOLXJwKYjleY3G/Bq8+yOF4xdI=;
        b=jXwuQV4CL1Urar4uRKNYG1mJ1rv2LTtpcS9LhSOYVGy5CPfclH83MYVkvCDoBnomej
         i5m9T6LBUyDlQWbtvuCAOH+o99qXJN3yRijGm6YrGHqiXy8Pw9/a6ZB6SlBZ2RD72vZa
         y9fno7b9/JkFL9F2km9BxI+F6YlIwGy7y4/TeuLG+yG/DYZh3XAAeI9Prl43f1n6BZEm
         30g2aQOhT4J4QJFEMsXf0sGx0ysdJGJYPvgzUdUO9g+c/yVaPfZ50eo2/IaEywhHdMxh
         dE5MxErC8boUAGk6Qdi04WH9BzSXrWz7XDQzEu2H/yE8aJKjlNr1FhiFng2GhZll3bTW
         dCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759455652; x=1760060452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWoIa0y9v6+gweKWrBOLXJwKYjleY3G/Bq8+yOF4xdI=;
        b=FoHZZmSDWTXk8/yQe8ipYnfeqFkRbvLGCtBlETV5fTMPSAkbgWDVIPQSVQvsMkBPed
         Q3LsrS0lZ3oJzD26LtGSrNY5Jr9r2ihewePPto4+jHNOeYQzQGSViPrnXYwqAwoCMU/2
         Us5qgTrW0i4zRRI16d4HaOT2J7QPzUXq93Q9w8TwWW+LpzKrCBWiVNWYLzA3OqZh4h+R
         aEZAT61e26VjjmLMHvrjI28n/m2GWNZW3OUJy3AUmYZpXkH6J64azf14JhMEQcPvlT3u
         vJejmpXeOMwgd9oQG+uHNmbCfcOhDU+u6aPGg7/fJMkvM4OH6bsoX0lh5sGfR08vmROD
         Gvjw==
X-Forwarded-Encrypted: i=1; AJvYcCXGwIPV7pu3PbqeDjr1urErDEq9XRDjDFIIYEJr0Vcu6+QDVH0pWv0hTQlgFUhlHYw9UnF8pZ2g1CRP4uLQ1JA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx32P0GJY5FVyX99v/XnibEbNXUIyqMs0BBUw6pqbtcVUVHKLW3
	H4BTRsw+ODN/23FH3831+VB7zcT/mzrOzlP6SffHzUMpO65lW8G4PqsT
X-Gm-Gg: ASbGncutpTMhSEYBMtOPNEbU6xQurAGm49JhbA73fArdELRPYU2XuAKQkChhgCkPQs0
	s/jkmpnw2D9CWz7ly6QkhPaKEP42DKdB8GoaLIFHcOtuuf/AhTsfwXPW4LVo7tr/+v6RNosNdCv
	eJjH/g6kpvTnCYHh0l8nLvLNBwXBEljQxIHUFX2ZNIIhNA2i9u2lsi8NqYPS4DedSLWDsczKU3d
	tIhsw0Ln0HnglYiG8FE7N9v0WJ1ac4oEk+it2/WRkdWp47Uo/65KZ/AhHwEQ8YBFtXeRLm3dPYV
	a7d1cq2tI1OtDso/6tEImgESWLGn6eZveK61dQHiN2IsoC+SahkNB8llJhVK52prUjoo9XWqFCk
	ubbLH8u6mVc1eSQD8LywkHIQt/4CyJGkbuxa/QaG8Zg==
X-Google-Smtp-Source: AGHT+IH5P4hHd3rDkULQwta1dCV/KcbG1IBpN7aEKqZ8F0Lkd/eZ3lu+K7BMNcGxH958CEVhBsYo1A==
X-Received: by 2002:a05:6000:288d:b0:3e5:190b:b04e with SMTP id ffacd0b85a97d-425671763d6mr545186f8f.37.1759455651622;
        Thu, 02 Oct 2025 18:40:51 -0700 (PDT)
Received: from desktop ([2a01:e0a:3fd:be60:6c8e:6cca:78e:dc8e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0392sm5814715f8f.42.2025.10.02.18.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:40:51 -0700 (PDT)
From: lespink <lespinks9@gmail.com>
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lespink <lespinks9@gmail.com>
Subject: [PATCH] Signed-off-by: lespink <lespinks9@gmail.com> Bluetooth: btusb: Add support for Mercusys MA530 (2c4e:0115)
Date: Fri,  3 Oct 2025 03:40:49 +0200
Message-ID: <20251003014049.3055848-1-lespinks9@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Realtek-based Mercusys MA530 Bluetooth 5.3 USB dongle
which was previously unrecognized by the kernel and thus non-functional.

The device is identified as USB ID 2c4e:0115 and shows up with no
manufacturer string and product "Mercusys MA530 Adapter".

The following is the relevant output from /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=05 Dev#= 10 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c4e ProdID=0115 Rev= 2.00
S:  Manufacturer=
S:  Product=Mercusys MA530 Adapter
S:  SerialNumber=30169DA2555D
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
...

The kernel dmesg log shows the firmware loading sequence works fine:

[  +0.002087] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b
[  +0.001000] Bluetooth: hci0: RTL: rom_version status=0 version=1
[  +0.000009] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
[  +0.002938] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
[  +0.000242] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
[  +0.148802] Bluetooth: hci0: RTL: fw version 0xdfc6d922

Signed-off-by: lespink <lespinks9@gmail.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5e9ebf0c5312..2c6dace7f0b1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -605,6 +605,10 @@ static const struct usb_device_id quirks_table[] = {
 	  .driver_info = BTUSB_MEDIATEK |
 			 BTUSB_WIDEBAND_SPEECH },
 
+    /* Mercusys MA530 Adapter */
+    { USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
+                             BTUSB_WIDEBAND_SPEECH },
+
 	/* Additional MediaTek MT7615E Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3560), .driver_info = BTUSB_MEDIATEK},
 
-- 
2.51.0

