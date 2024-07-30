Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50721AA3C3;
	Tue, 30 Jul 2024 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377415; cv=none; b=klaaRGFJyNhYdiAFm4ZzCiVNcKb1dY6Jc+GEdk4NKIRnLyeMLMpfe9FkPssM5S+3KvuRLbrfYrdSNuM5xaRit2BFlRrkihxBzeM2WDiNEtXbvri8Q14ddZwm5V2diKlD4wOqw6nD1+huLowsfxXvYVXTyFL5a93b+6u/nUw8O8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377415; c=relaxed/simple;
	bh=oaBDzAiNweARh2YBJ/TpniEey9iDmA4MZbkYPg07MPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqDV2FB1g/xZA61BDWfAsoUHUTZCxgPLQVc8DiryRRqeyx3aSdkR+wQRStZfkOealUDENLvCI0efIR8AXhr9pHDPd2hsExFj22Y3UTNXWdBz6Qeft4Z9bxngpKERo3aUKz6fF+pQUWrfGSdZVdYhRXRGuWmiZ1dE2XTtaUmU60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiwDkB08; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiwDkB08"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d18112b60so280454b3a.1;
        Tue, 30 Jul 2024 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722377413; x=1722982213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul3wMxMCyuqyiQKRLMzSkYPeDtvquKgSAZvk3UdpdAI=;
        b=XiwDkB08JpoLIY9N0CocXf5Vq+6BcM1ZVEmNURnG0q2/KlPRLW/f0ogzDtMPmWR7Sn
         yvZEZn3CsqOL1amv/NiCCLJp+XGjPRWTSNLi+1fzHNxjAGsC6i6qje2qq84fQ3f43qE5
         ShCiTA9SAkmskgvfbrhVXjRxaaFZQ4Z6VV8eeeq5Tw7qCU5mlXcXPfip4XWtvq7OlPUI
         MIfA3aY4G7rLS+/aPXdNkg/SGqL1/If2ehLQSmY8oQfZkCTCclW4fMtLp1gn+lO4v3m9
         S+81S8XcoouDksPZSSR/IDQJbkf7hZ6RxfqcPxdsZm3amV9QA97hesI0T6ZFdYFmvSXg
         DDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722377413; x=1722982213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ul3wMxMCyuqyiQKRLMzSkYPeDtvquKgSAZvk3UdpdAI=;
        b=gAzcy4TGyFOgx42lHClV2KEtISGUbrKZWE2DiYbpJhtw/O6DoDDGjcoDT5WKm9j79q
         A6+P+o3YNkpbCnSe8bRFbl1qd62SzFkQTUPYyMarRMLg/D2fL37ETbhfHptrppVtS1Hy
         Nq1Hcgeu7w/BS9XpBMWyXsuUspNNV5Ksm8i91fXPnndnVW0CemmpWeAk3oAwopPYIWAb
         r12JpoekoghyIRpsDDPyP44XsrisMYsnUQA26m3YAZqgM9+jVVDiZyZ/T7SX7X/NlALm
         XTQ4zjC5RtgLwomfhL1p4hMj+oJgZMKuDLvF8gewU5B7Ih9ypqevCpWk0l632bBFeCVR
         FGWg==
X-Forwarded-Encrypted: i=1; AJvYcCWB0PI8q1kMYMyxXI4KxTj0p9Etd93WDIlDM+BPLcSTOHo3PE9LGqCiuoU2IE+Kx+2e2AGgCIXsEmPy3PXlMKQn+ByPcttd+lKz94PJ5VvIgBrS/WpNyE0nQr3cmUr2IwXSbQblGUd6pTUYcMZO
X-Gm-Message-State: AOJu0Yy0HJ3XeisNt9EcCRbEJNiyynSRfkhOTaCRspmow6im9en3SGLh
	HhfDkk5NNxhCcPg2dNzuOoVES9dQmyndsZeZsFLNJRlUhZlVVRD9
X-Google-Smtp-Source: AGHT+IEDt1eFM48dZvG+UKaY1ieJl4LuSH5ixaHLOwrBPTZOulu63KVgNXvjFCy9EZXeffAncACvbA==
X-Received: by 2002:a05:6a00:2171:b0:70c:e1ec:4233 with SMTP id d2e1a72fcca58-70efe42830dmr4416137b3a.6.1722377412938;
        Tue, 30 Jul 2024 15:10:12 -0700 (PDT)
Received: from OPEN-HORIZONS.attlocal.net ([2600:1700:65a0:8110::c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead87d58asm9159109b3a.177.2024.07.30.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:10:12 -0700 (PDT)
From: Alexander Hall <bearodark@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Alexander Hall <bearodark@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604
Date: Tue, 30 Jul 2024 15:08:25 -0700
Message-ID: <20240730220824.224298-3-bearodark@gmail.com>
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
Changes from v4:
  remove trailing whitespace that gitlint failed on


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

