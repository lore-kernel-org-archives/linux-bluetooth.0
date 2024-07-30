Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98081BA880;
	Tue, 30 Jul 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354575; cv=none; b=Eh/Bf2OcfyYdYGqLk+hVCppo34jp02S8sy6xsPuXEAFbfo3gXSIBQ1HuH/OxezZyigVBe+eH5ZvpW7SQ9FeG/VqIql+zwS89XiBf7FB4vVlAdAeRxttIrDiLGHBO98MFR1MsV1URn/f7PBspyg49m7cvFH8ZITHwaSjgtYPRs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354575; c=relaxed/simple;
	bh=BM/Opj+kL4c7QeFGjSbLAKBiUolZPcSnxAdCnQtb8U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tphTSSnQtCbMxVznXykasUDkT94u2L8jiVPN/huDwdqEmq/mVnBWQrCl3ZEbjwM+77RggLuMB5m9wYsVaSl429MkljdRychvI+yhOXi6LDE4rZfyYBg9NVZc9J5cHd3Spl+3tIeYXQZqDBJJLuJA0KcPqL6mf6GE8JuazngDGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRGC+FYx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRGC+FYx"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70ef732ff95so1353135b3a.0;
        Tue, 30 Jul 2024 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722354573; x=1722959373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fzlR0gUQTK+JspvCAP1K6WdAPDoHJFZmXy8zZHI6HU=;
        b=nRGC+FYxyUy9fQ/KTwzfNO5Ak5bsAYuHmIGGkgCKzmQ5hwxAkz4BdSDNG2cvJP9Drg
         uIAu/wBALn5iOh3ULjFn0CyvBUuK0f4SSFMcPCdGMs1MtZCa/TQP+tlAoC8JzIQ0K+U4
         LGYRw2LHWBU2RZpbx/kMgyorkFSagx3xZGx9UyISFz+K5C0l99L7cygRr2l0cu45izLf
         GshxA4ARhvwU2AVyMkZl7Iko/7LodhUoGFDfGhAC0jsggeE2r0yIB9mEFswaQnaJ0kGB
         xr64Bcz1Go9MarS6S8HQrikgqWaxMj6cW5dyxKhaAxhrJVdfDh4gmmC6t5JKTKH2CCAT
         a/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354573; x=1722959373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fzlR0gUQTK+JspvCAP1K6WdAPDoHJFZmXy8zZHI6HU=;
        b=ad78PUFWMicJ2O3DuBlFMxwvaPINsT7aCaBOUNDT2NgCEAlOoZpxpw0G2P3pjEI//i
         c+yqSGLrfGW4Kb30dOYUcl4KShthnYs/Ca5cDFqjn10FABa4Zo8T1yzPRySZflu0WFOA
         ON3FXAOyIuqy2nrokZ3fPSry5XdPAEL1lJaag8JlVQOlUhe5ZBatLBRBQvqSOoI9eAJl
         FY7Sc0DG2/UGUHPTD5vfZ854r/N8Ra1JzTG8OIR39Pvrg3Unqtwc3fN0gfdmu6QsQp1F
         j6jMh5C/1sq6PuLyqkwh0egtekTgbnIVi/Q2/k1be7kfhKT4IhM4VB9SWMoJfVnghB78
         zLKA==
X-Forwarded-Encrypted: i=1; AJvYcCWXDDYLSqj2E7zwaaTrqrwfEZJQXWnSUqcmkwfi7tYDgSe/zSEH5PhjGdZ8WkfvhzTkaZQSxhk9gxiUHbhAobrAkaelsQWm1Ff2v5/loLKz63vbKQJ7ORhVxACAf7ZBD2O/dkBeKHYsYH6CISnB
X-Gm-Message-State: AOJu0Yw94GUDkiYlpsea8JEYxQakj3KNE40fE3UX8UVSxIn2JZZ2iysc
	4JlikRzGrhHYVOQbaklFh83IXqa4BjYvyhhqjAqNydmLo3rIimPZXRxV4jZek3s=
X-Google-Smtp-Source: AGHT+IFK3xcCzpXpB/s4nEqDyqFp8KQ6QA1toDF6ndOG/GhzzLYvkAh8ZzKRgN/1pZ0P42+CDl8gIQ==
X-Received: by 2002:a05:6a20:3d91:b0:1c4:81ab:1f5e with SMTP id adf61e73a8af0-1c4a13afd47mr11291549637.38.1722354573004;
        Tue, 30 Jul 2024 08:49:33 -0700 (PDT)
Received: from OPEN-HORIZONS.attlocal.net ([2600:1700:65a0:8110::c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead816722sm8600644b3a.106.2024.07.30.08.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:49:32 -0700 (PDT)
From: ultrabear <bearodark@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: ultrabear <bearodark@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604
Date: Tue, 30 Jul 2024 08:41:18 -0700
Message-ID: <20240730154116.25336-4-bearodark@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes bluetooth support on the MediaTek MT7925 WiFi 7 +
BT 5.3 M.2 chipset that I purchased from aliexpress (and which 
arrived today). The PCB states that it is an MT7925B22M.

Device from /sys/kernel/debug/usb/devices:

T:  Bus=03 Lev=02 Prnt=03 Port=02 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3604 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

High fidelity images I took of the chip itself for future reference:
https://archive.org/details/MediaTek-MT7925B22M/

Webpage the chip was purchased from, note it is different from the
images taken:
https://web.archive.org/web/20240620021119/https://www.aliexpress.
us/item/3256806821207897.html

Signed-off-by: Alexander Hall <bearodark@gmail.com>
---
Changes from v1:
It was suggested that the (now removed) aliexpress link be run through
	 archive.org, however aliexpress is incompatible with waybacks
	 scraping tool, and as an alternative I have taken high resolution
	 images of the actual chip I received and put them on archive.org.
The prefix of this patch was changed to `Bluetooth:` as suggested
Maintainers and open lists have been auto CC'd as suggested, via
	 get_maintainers.pl
Changes from v2:
  the commit name has been updated to include the device:vendor id to be
	clearer
	web archive eventually came through so I have readded the link to that
	aswell


 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e384ef6ff..2ea46a0e6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -691,6 +691,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3604), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.45.1

