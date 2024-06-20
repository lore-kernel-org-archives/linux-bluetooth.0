Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A111803A;
	Thu, 20 Jun 2024 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869652; cv=none; b=Ogj0uvojcNoRb+cMgY2kyK388MPSVJ5yD1hfn4bHTrCitzH44hPVamVr5ixbipCAmCkeKVlurzJCuPYGm/XN98iYPnzkk/Qm8oSR5+lHURKwJnQisWXEw3IOKNJE0qJDzy4eExcBwn4ecoyoT2hloXRfUrwbeLL376kEfxFkgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869652; c=relaxed/simple;
	bh=TxPaQ2T2S+aityQLLGgH/Keifx6knkqZTKCZFINZBTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0cfEVkC7C8TnqSn8iFockHWi43MNQjTI2WzbLgPEPqKZtGL0+HaE8XLJeXLR1ujZizF/60YvtagR4mWDqsKO1J0mtcZGYLV5aQ/9w4/mgSPDHh8JLKlfAVYuPHrWSQGab8vTJCXZb70fjp+zTrjkbH27DQMUqCHw2iB95PmHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5EbUuzX; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5EbUuzX"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-63ba688bdc9so5570677b3.1;
        Thu, 20 Jun 2024 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718869649; x=1719474449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSwQ+pDHwc+ISBO+lO0fSxSzZGv3c3jhzP1gKh/lpU4=;
        b=b5EbUuzX062JxPKmBvkb0uwXJmCUpvvIeKLPu2q1/Sm8DLqJxHUNJq+MDGAkK8itWD
         3M/qG9WPOvXnCyO6jDq9ZkThQSa2h7rChM7GVXENUW7D/uehQiUEQtM1Kgr/qSzcdH1w
         a0HjwLsBZNQ/YJb3cc9o85Ac7oZsE4ukTMEpENEtj2dL6Ju8WZDzj2SxtkE0LINwK044
         QRfEJA7aS2+2ANH6dXb3VDri/bAhmtAzejRZ+fW/RH1Mox80q/3xAVO3m0w2s+3XVzzh
         AiyNh+348WjgMeNX8DP22GKbPfFxebd1PVMGlPNkfWdtcu8UEVzr5cVwMZg9ptZMKDFj
         KiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869649; x=1719474449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSwQ+pDHwc+ISBO+lO0fSxSzZGv3c3jhzP1gKh/lpU4=;
        b=OSQEXCQBZmfu4jmKCi4QKOcTj6Cs4GlwvwwgOWowcNJI3nc6Ph/laIfuh4bfidAEcc
         G2EKFNaZoL/+h60BIPV2yUh6Ms6vNg3wSUMlcg+HOioCc9g419afrnbd+ls9KnKmk1bH
         ciW+WHp4BNdvaMp5U5+EcER4s/1owrbYnnoSpPcmSrC3Ote0HDSGXLZNEmpjse8yo4PM
         BeyW7qLlQwxkZEOB1LV+VLrJP0XKLQiYFUYnFKpgDgObyhp4nLfOIyQFWQ4VkZnixlgK
         LTaSjNysUFkTbw1o0y8TaEmRhuZCJJK7gkL71RSInS4PznpnTROKMWLIs/7qST1kGMX6
         iUlw==
X-Forwarded-Encrypted: i=1; AJvYcCU9/Qo/kkIVzAiHJwxaY1ElBL/HoIt63sIbEK4xIiqw3c32M2WAXaqlgc6TUacgzhf5acMnTPDnthOVIKFCxISE13XigKGSVdIqCLmg9OZA1foVSKMP79DC52IRuh5oS2m/FoynXr+MaHK9oeJn
X-Gm-Message-State: AOJu0YxCmQy9Cj+w9Tpbh1NhWXGZtJflKWkrLaHqsXDhGhKQvqjIR1Sj
	ZtX4Rb+vuDO1+/oSDtJkp6n9LAXnO8TTZfzG8FrRYsmT3+8SFpXrZLDqoU4sUcU=
X-Google-Smtp-Source: AGHT+IEC523RrI5z07NZ3GIZ65U03GKcNMI5pwUwivutIWjvpUxld3QXGJKogByY4HM1spaTxJx3Pg==
X-Received: by 2002:a05:6902:260b:b0:dfa:5748:124c with SMTP id 3f1490d57ef6-e02be0fc596mr6124441276.10.1718869649391;
        Thu, 20 Jun 2024 00:47:29 -0700 (PDT)
Received: from OPEN-HORIZONS.attlocal.net ([2600:1700:65a0:8110::3e])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dff048767e2sm3354998276.17.2024.06.20.00.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:47:28 -0700 (PDT)
From: ultrabear <bearodark@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: ultrabear <bearodark@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: mt7925e: Add extra mt7925 btusb target
Date: Thu, 20 Jun 2024 00:33:21 -0700
Message-ID: <20240620073321.401822-2-bearodark@gmail.com>
X-Mailer: git-send-email 2.45.1
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

