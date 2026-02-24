Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48ED2D0C72
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913661; cv=none; b=nLR11zu/6jFG75+e+VqWWAj/HmL15H4MyQ1krTH/K29o5iD69lbuOSSnlIRNU6hux0fuZMJu2PkvUWCGxOJKDO2S2eKP4/yHzz5ahtk1O/t4Cu2YVSA/zrY4+UtDzYzX3uB4zL/bFNw6XwHsdSihiBD6PmjT1Ld8DgW390yHlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913661; c=relaxed/simple;
	bh=L3JPGXDiP1nPq1zzzrt0cdTsid0rDKor3iu3Kio+Tgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTSz/yXkGvwRO1LrRY1jjoWFIUO6H76wxzLTAifeRW4uZJUxxoFjGpYor9QB+v/46E7KLUpd8ZtaBqJAbo1QO2xx4IlugXlgF3N5N5gVGLiHLtuUB5lS/8wrDFNK/BpDLG13g9GnAEcvPBCGeDlkfsM6cZXK/1wgdx6egNG1ggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6774d63d2e0so1500074eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913660; x=1772518460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBi0KV4tHa8KBD7kEKQpz1gga08zIPx2odpRduDjg3g=;
        b=wvaO94m7QFJ8vvwPNApHuWGRAKt9U/aC/BZ3xss+RROH28SJ/ucERx4IIry74wT2m8
         zp19icvyV2QCJvQOtG5JEL9kXX/wZPLhmHGs+KOH3I2J3D46u3ou6gXdRrqrhsliVBVw
         JHWjS7YfrtU0vZJANAgd9gZUI2BC1qELYMKCtsPv7TATm47lkRFC4mWwYI+iGrhYK7Os
         hhg/nnISYI1/TUBwjednDG68c6etrq9nLQssisxSo6q7mu5DZ2cD6UcpWDsAvIjMLR3t
         4gCH+pMJseDKScEwd3J56PPPMK0NM1aLeEWhJaWydq2RrbOGqfx2EY5NpEhmbPVXnodi
         ePPA==
X-Gm-Message-State: AOJu0YzIJL+KV2j7973UK5V4gAcEE9vU5wPADm8r8R/sVZ55rQWj4zDy
	yQRGXofke/v0e2wd2PfGKuWyo8DFeug4mHFNwo5asAMny9hIQsYU5opi
X-Gm-Gg: AZuq6aKORQ2Z7swFI7QT66rB6zRgNzkSwXoTT/mkBAtJiCBRVLlS0KdQ3NM3XpQB8Qk
	W3uzpBhWS3P784Du+e1pmR9yezlSRGcu0Ov0C1q4xft0WT8AlKORMBFpDWHHJPSzstCCfMRXboW
	YUxHJMZndqngy2O/BuRf7quyj5gK4t9g36wbgWlhlnnbgYxD86+yyZHTh0cp+z0g+8gkG+npNti
	Dytj61pF9wOQKzPL4aIjYwQMqy/SiAsjBk51LrEmcJ1xt3feLlPiXWNo5T/EamK0kGRHYLk0lH7
	+pdXXqC6vsAEzpqWU1O75oSR7CMzSfnep1hRIK7krn7ryGl0A2rEKBs1V+GQRP+zKyuLJ/h1FEn
	0Y2iJyTMck954h2ZgfotEQYHUYlbG6+6qmZakkEngQKtNsneIZKbWJ6tmIxogIpJVlXi2qu3Hd6
	f0N8GF0zfmiCxZM4y0ZAtl5RNWhgG9HypuerDLwfK4IOEiigeb1+KBqRIbCOJ5/DU=
X-Received: by 2002:a4a:e7d3:0:b0:679:dcb5:b848 with SMTP id 006d021491bc7-679dcb5c59amr953575eaf.63.1771913659653;
        Mon, 23 Feb 2026 22:14:19 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:14:18 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Subject: [PATCH v2 5/8] Bluetooth: btusb: Add new VID/PID 13d3/3594 for MT7902
Date: Tue, 24 Feb 2026 00:13:22 -0600
Message-ID: <20260224061325.20189-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224061325.20189-1-sean.wang@kernel.org>
References: <20260224061325.20189-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add VID 13d3 & PID 3594 for MediaTek MT7902 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T: Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#= 3 Spd=480 MxCh= 0
D: Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=13d3 ProdID=3594 Rev= 1.00
S: Manufacturer=MediaTek Inc.
S: Product=Wireless_Device
S: SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A: FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=125us
E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
I: If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 63 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E: Ad=8a(I) Atr=03(Int.) MxPS= 64 Ivl=125us
E: Ad=0a(O) Atr=03(Int.) MxPS= 64 Ivl=125us
I: If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E: Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E: Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Co-developed-by: Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Signed-off-by: Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>

---
v2: newly added
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3a45b16c6b08..0f1bd9b5d296 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -676,6 +676,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3580), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3594), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.43.0

