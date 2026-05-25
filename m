Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE43ED5A6
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726004; cv=none; b=O8O7Cot2fvi+CfzTg0ovLvkw43ZGSbA+bitn0RMB2LBztdc5MiEwLQi92o4QeGY0n6Ujex79ywg8khdwX95UREFXIUf1zUjw1MyQAcqwrPQ+tAY/E5h+KSmrqWO37UcJhNTQUE4Xzwiv0+srx/AxYsrhGXFg7Jh59wOlxsleTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726004; c=relaxed/simple;
	bh=iyS+b9DSSYsGAsvugwS4FzAaGls8ZbHNFyXqF0iuyRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/0dADBwtvknXN6c5dct/JktEH1irl/DUY8D1ebUK0ZqRA9qDUkSBrpnadbh+NdCKPzNh0wiMW854TluqlVj8kmtRCM4Tp6mB17fxiIJ7JdeDlU2Z+6dv69r2Nk6mwgQwSinKfwsmaWoXIJN5pLSYCf2qc/AmlvbCFWQliGkVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oh2plauP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh2plauP"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f8b60e485so4034241b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779726001; x=1780330801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RoWP+5iXGGorIrPHxGK0nyTarrooaD3pQuWFHKUsdE=;
        b=Oh2plauPg9BoMXTAPAtY6M2bGtha2aWiwt6mSqqBWxBabQ3DQ5bGAfS2HgVxjc5z4F
         /UuoV1Js4oGmZeYwJzNofrw6x49KXprqGbph9kOtrGjtcK8Dts/KAgTshs+1XqZdnpBw
         lIZ79j1P1ZDMo0On89LwicnlXfiPtgsBezTm1jZwq5XIZWz+n7lzgUgUC3IfP7MUGGPZ
         SbJRwtCNXDE32J4vzwjjBBzdeDlJbFyhuHKthVe4kKBPE43TTU5+xlGcizM/zb5Cjtmh
         6jQDiFMHaePEGjTcFE679FIMRDNRJSrYbRSlRWeYFV33290s6NHJRTccIMTrFhBifIG3
         sTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726001; x=1780330801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RoWP+5iXGGorIrPHxGK0nyTarrooaD3pQuWFHKUsdE=;
        b=lP72yhbusGj2YNi1b81EvJeu3QyCDO62uZM46dKvImqPJ4WtPkBFf9nsiQHnUavXih
         otFGw6XawJTVuCznFyDJzbZLzlts85IUCtM9cTzc3x7MzLcObNPcWGNmCoIAhtnZU1iU
         QC5FAvXR2cGIRFz3/gJ/j/gfg7XTPq5UoNb1ZL4Fw8AlOfGTNwbK1PVKcjF1xASKKle4
         h6/bVk+jk9THcyAjIrz242nHJ4mkSeqr4mUVkvII9pO8wITfhzfrdmzJmL6TJDR6jThZ
         oKKilWktpdl+6lBMM0T2l4fJWWnDp++f3TjE5Nm9922mrt9q75iCGgqGU9GKzScn7Lnw
         +VVA==
X-Forwarded-Encrypted: i=1; AFNElJ/0GvyHxXs+wgOnvVMeEoFDtJOEGzLMsza3BWbCqEwIHkX2NlNZPy8p/X3yJQmdgo/iKTuOwN6KaV5fkmZNqs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/HgcFabFiHCdKNM8RtbcS2IK54JHskfCGlLtWT293dlsUz/CB
	VqMHtYqCt18jvW9OC6Mfy8i1bBrcpXVYEwUvW8eCVbHscMCH5FsjJQA9
X-Gm-Gg: Acq92OFnWvtOKVU3t8ctBRM/GfFje9en1aOiyKWPjqmzAh2kqdMxcgx/Mi7s5gBkb4n
	aR/KDU1hm67EsHekcOzdspfDxIsdReVIxSTy7X4h0ByFMpGERgmErHEbJ06gZR36oEQs8wDKa+J
	b77+FBhB3Rers7XwznnXOZ8jhWzh91qsNilO4D6eXhHYHNOr4Xd5OZlkD5MIzAVPlZ2Ph++i4Og
	sm36zktPLzW4o+VvqKebQU4UvxU1LhXxHsT+jNi40jE2C/iqOIFmNutE3iCqC4PebcZvIUqaRPT
	WaAjii3IPWBxZhCM6glYUJlu/64SAav5DwTCBTlg39Etgm4/8ydXqrScajiAL5fCkMraG1GipJr
	yk7IxFkc2yt80vKr9ag1pCT4V/aaCG/GjNKUEy1DiDRiuRzA+8P1Yele9m69eEr1nSFgsXW06Bg
	FbEvW76SIEqlUIKYIMCnrqm8GsJVkDaZXfTFzPKNjgYfrRJvHoxWroV+g=
X-Received: by 2002:a05:6a00:421a:b0:838:af72:fb44 with SMTP id d2e1a72fcca58-8415f0f16ddmr15242462b3a.2.1779726001426;
        Mon, 25 May 2026 09:20:01 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84164ac9fa5sm9871585b3a.1.2026.05.25.09.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:20:00 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pkshih@realtek.com,
	max.chou@realtek.com,
	hildawu@realtek.com,
	rtl8821cerfe2@gmail.com,
	guillem@gservera.com,
	zenmchen@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB
Date: Tue, 26 May 2026 00:19:42 +0800
Message-ID: <20260525161942.5206-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 2c4e:0128 for Mercusys MA60XNB, an RTL8851BU-based
Wi-Fi + Bluetooth adapter.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T:  Bus=03 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c4e ProdID=0128 Rev= 0.00
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
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtw89_8851bu
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
index 3523d86a4..a13f10c7a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -532,6 +532,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x7392, 0xe611), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2c4e, 0x0128), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
-- 
2.53.0

