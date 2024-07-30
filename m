Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F93149C41;
	Tue, 30 Jul 2024 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368669; cv=none; b=PkA1dP6VxZvj0LUSV7b3DWiY3d+UHEakN+svW96rAQUZYL9+5hI7CazgpGOJ9SRo038MpPA7prMRJ76VOuh/lFOg3JuQpjdc2hJlSUkSr8tXNeEu/sBk/oy+s2LLzT+HKv9b+xaptow34O0HDLu7YweSZfYLSwRMTmWW2Xaz3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368669; c=relaxed/simple;
	bh=I+MltSMS3fJwbWf/vbAZoKpKwSTSmjHX2ugCTSePSak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fY1HXL6XFJL30RUzNI49Zq3xUHrWUhpf2n3mtF2n+0dlpGdr4cXNRKhCnH2fhQv7WmLP4h+if28QuTjvoCkOihEiaRolHwzPVUbox+7XqGsOOQZNP6Wtpas565PxB6KjWA6s6aCUWbBeByJyEdDYo7maZP8wFXrCJehpye5qQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+F60rMn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+F60rMn"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70eec5f2401so2422216b3a.3;
        Tue, 30 Jul 2024 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722368667; x=1722973467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZF3btgT97s4Zp1oA1tWvH59JdAR8MZ3lk2QFNVm6fQ=;
        b=O+F60rMnkW45B0T+9BSEnyHBoVKKUZL7iW3/WDP8dqKgDiWrJlYQAs3wy2q2AFL2uG
         hGfYgTb2CJUNoFiW+Uy0GXIaBi7HKknEIEh05DRf8zmk1BHyPDp2/39n88dhlrtqXZ9E
         LtSkt4/X71+N64pqF56tY681Q2oBsKX3uqeCe7o97LQCruNPXPfbZN4568QzwzVf/aQE
         6KLoDvVyBByF0r767eOWZp1OzYZreSm7Al2TClAGKFBuUToJvPXd45nQyf+AsvWLA4Ha
         HXiru5XENEUzoKWSPLkij5uexhh5k/FtHzxXcFatH1Wp4AOs3oZAwWGQCkKFSccOT76Y
         Ft0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368667; x=1722973467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZF3btgT97s4Zp1oA1tWvH59JdAR8MZ3lk2QFNVm6fQ=;
        b=uegeydvPrzGIrLmjZU49MVk3wQGOTbPm8HTxnhiRkLTXTU0h36JdOAtRRUSTdCZWeh
         7aC8LBOqNo3kXLvft5/7ZDVR6kUsWbwrD50TtXeWcGzgWxRsJU/z/2rcDIxO5FQlHIUo
         jGWwOscv2Nb3KMXeeN9wFR8cTr/Hm3hCLr5nWtev1/kNRQl7mfL5u8RYmrZgPzIrooYq
         Hr+C31hFNDkBmzJCoKip4J06mwWPsCBQtkzDJlj1T+g42mydofZ6dD+SP5LOkF+pRIhH
         jKjHyS9ayDaC6oc2pt/sqyX/S8+HoU/zHviNLtE/F0KyMc7Z8utX9/DQ1K9njkAeWRrA
         cirg==
X-Forwarded-Encrypted: i=1; AJvYcCW8n1aWXTJBYNopANVgl//vlb4stNLzYYG/78t4vNqtsrn6kFF36Z5YdJQ4PV4D2GRhc9tXlEHwARZMG+JAl+0PcTz9AWwVVr0zGhUMaOaN9jHAfZP6hoHnoUOCx92Gabnj3zxmJZz9pmukZO9Z
X-Gm-Message-State: AOJu0YxM/WGeyLADofIUjsaxTR3HnSF46si9zPw8jB+J25GHFK8d4lVE
	834I4D37Fa1TgTfyMZ+b79iKhtV4pFHJ8pchJScUZqZJMjvaCAgz
X-Google-Smtp-Source: AGHT+IFt0v4jhFEoQCGWd0QBnzevTPz4WQYjsnJTLE9usRouXj6clPF7sQZqViQJog0W3ZULkwM0Tw==
X-Received: by 2002:a05:6a00:80a:b0:70d:2a5d:867f with SMTP id d2e1a72fcca58-70eceda1f9cmr14761580b3a.21.1722368667505;
        Tue, 30 Jul 2024 12:44:27 -0700 (PDT)
Received: from OPEN-HORIZONS.attlocal.net ([2600:1700:65a0:8110::c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8122ddsm8785561b3a.133.2024.07.30.12.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 12:44:26 -0700 (PDT)
From: Alexander Hall <bearodark@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Alexander Hall <bearodark@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604
Date: Tue, 30 Jul 2024 12:43:42 -0700
Message-ID: <20240730194342.129610-2-bearodark@gmail.com>
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
Changes from v3:
  tabs replaced with spaces, Signed-off-by now matches From sender


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

