Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFA14C5B0
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730509866; cv=none; b=ezkkpO1uIGaoWIGAMsd2lalQJrerITgwm0DCifutzvh8VhybOQR28zoFVGhLBT2xayWm8K7NUsrSgZIcvp83RG9qCnGCvwRfBNlv49LMiwbgbMx99HYurslG7JVSaPATZAieqp+cP7J3HK3593N5U12QqRpT7b1BiLt9//PgYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730509866; c=relaxed/simple;
	bh=XHTuUaSI2qslpTnDXnZDnQyREyBCfh81ntVSqp75wPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0Yb/JP3ltUiMNJMwDHG6G+1F67Z6+WrSrPwajuQ1nk86MHmd/8dfbGVuWYJXhaMEPzU+onIIqzW77yghxL5mls8rhO6/S563d4Zm0EWuVefco12aNNROkybyyh3vSX3yNtKbu0a51kZkGmxM5LiQ9xl1WvVdgL2b03Rya+WJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUaoivr+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUaoivr+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so21794165e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730509863; x=1731114663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dacPVeR25GgUptGA4ZxrJZQdiJJOs5xomSIMydAflzU=;
        b=VUaoivr+2E81Do5d5ip5sk/DhVQ+pbPD9tej/OgzuNqpVQ4RZa+tJuwKIrugATc0aJ
         L5SnkNutiNxxxLmcsY8oDigEMqq7AfeBLX4CpdcW5JLau9PW+m4hq69+4PxM8WocU/Bw
         AB5SF1X4IttNPnuWBp714JDNoDHb7JLQazlmGk4nM7lqrtd+X3sr05kcyxNAbr0nJLFD
         aZcQnQUaI1Rtucspzbvctfk+oz64WavLsKQzB+FsJukMT1cHkYoh374V94dJ6nFSb9XT
         d26piBGaWX8IxYzDkRbc11hH/2hj2zK3bF2TcAN9QY19Ive4voQZHTar+2/peTeUJHra
         bq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730509863; x=1731114663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dacPVeR25GgUptGA4ZxrJZQdiJJOs5xomSIMydAflzU=;
        b=gT5cp0dDOY6KNa65wnLbpgc2bsldTWd4skrdIeobpgQeFqqhTzPgVwv7jXxR0rWow0
         L3iOiwIAgvX9tloVyxzS37bS/t/xbYuPfdpwcFCqvTJ1U16Xlo5DpaHqy4BATeJQenwE
         5n4WCAxYtH+teYVXQi3aIw8x1eP5Pw/w/uIrrD0LiMAWcpRDu8H/IZYmxiArGYvIA8eU
         VpybXsrxaz0vbbCGRAQS05TCThPTU20oXdaEWUuUi49XMPFybBFha5BOgHtEL7sFszom
         NyFBtJWAEC3SexVjnG4Gu+HGCrMA10uz7owgy2W5gwgpAMN9IEaX64GCrez/R/iJs/A0
         fBhQ==
X-Gm-Message-State: AOJu0YzclQLklR+crhlp8FLWJe+3lxcVadusNicfQjgZRnzal7NEAIJi
	Mx0iiGvAqfwGqoDPRwsBgI9iA3tadkkIjQJKIJH+kheFfCT1b9f4FFsOkw==
X-Google-Smtp-Source: AGHT+IHpHzXmIgZhGvuDg/KeyX9yPFrRUGOmZoEP0fr+uv7U4P9a4RNWPVTVC2xNhGdxVAdI3pY1Mg==
X-Received: by 2002:a05:600c:1c93:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-4327b70150fmr71299025e9.16.1730509862691;
        Fri, 01 Nov 2024 18:11:02 -0700 (PDT)
Received: from lambda.dereenigne.org ([109.255.70.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947c26sm110534855e9.26.2024.11.01.18.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 18:11:01 -0700 (PDT)
From: Jonathan McCrohan <jmccrohan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jonathan McCrohan <jmccrohan@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 0489/e124 for MT7925
Date: Sat,  2 Nov 2024 01:10:14 +0000
Message-ID: <20241102011048.34015-1-jmccrohan@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add VID 0489 & PID e124 for MediaTek MT7925 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e124 Rev= 1.00
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

Signed-off-by: Jonathan McCrohan <jmccrohan@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6dc5a7e76558..59bb146d556e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -656,6 +656,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe11e), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe124), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe139), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3602), .driver_info = BTUSB_MEDIATEK |
-- 
2.45.2

