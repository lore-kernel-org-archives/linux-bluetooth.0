Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186428468E
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043512; cv=none; b=N2MlPC3sht4Ew4GPnPMZK+d6/qu97xFeyjDvakZ6MWEUIS8QmnAt0GPvQsR8r7+ydhXYroOHv8GSdpsbhfo5pblzrPod9rcWm6K0oAkezXpxKz8wxmiitbESqAiysk2VFyW2+u8vcCF4lFEDRxCQAESSSBFm6fHsShvR7tElcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043512; c=relaxed/simple;
	bh=SQeZSs3fjZTm/d2JUDvde9hFjG2wrLvI3Y7DviBDdro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+Q1P8tHZUR5PDNYnq6iRgrDvSDmBz77Fv44WdD5pvlIA4z/Pv64QtwtmxlR75x27rHverBaXcuKWAjxADdjb7czZNeAfpN/yKUpihT7nB0v/zK583c4Sz+P/DXmS1pQIVfbdQil+1cNC5e5B7u3R3FBWToTK05f7urS6K8CAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BBevW1VN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BBevW1VN"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 973DE3F546
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 06:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1752042971;
	bh=zmTk/bLQEATrkW5ZhuNgtPLCeoO7OY3pblXNYUWXoMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=BBevW1VNAuOl2BHRSpGcTIB4WXucGrcYA4Gno4sTV5GKDR9QB+vmyeWqyls0Jf6TF
	 wpKyKO6IuRwsDEssfjzpJWpkLfoc1vfJEhecR4Wf8h3hFnsTb471ulcp3ZQ/qf0shs
	 VSJCuKMuG85S+9f2HfIq3vkY+budM/7bmyjid/Dyjmr73LYnz32xcb6RAS+cRAbKDS
	 qbW6ClZsaLg9fmUGNJrDTlgw3G2mcCV9WkR8UNQMorfMkhWBwmox3IV3UaKdt7naId
	 BljDx7kPbPIkKnpNDD4KhdGJccLIWT0HSexT3qPBvBpSP0Ixn2FsEDUHkSMKB1kXTS
	 KY7C7yxJQKvRg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234b133b428so38997865ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 23:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752042970; x=1752647770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmTk/bLQEATrkW5ZhuNgtPLCeoO7OY3pblXNYUWXoMQ=;
        b=Q6yclH8kBZJoJHUTw92nJTCSkEdVqyKQ7FRKU6G6XlolyfgLJRgGNTinXh+/I0zX6L
         oHv8bmQ8yKlRSsvRAiao+UMLg9+s11g5IOIxPfcjqkQxesO0P8IxBZaMr05Lc02T6E8J
         S0R2pRnITcxio9PHWKHBfEJs5pZuUsEBrHLWfwHu64wLfzzrIQuqU+UAR+fY2UdrMNrx
         /EC4AY7Lr/xa3b26hnEstKvn0v/Y6ckz/eqz8EeoWRwbu6qXyvf7fLOrAm20P4PxmvaB
         RyVFSwCNDj2dZQj1TrLAynzQ8QTlPdAn2qe9zaxbIliAKciG/L45Kb5hirKSOvUUprPX
         cXuw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Mdoq8dnJS74hjEPYc6WG+3MVnsp71atcXb/29FQdN5RadyTF+tRosnpAtoKJR5MfwvvjUn2ymkCh2MWiHCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9f6nraTdSauM21KriEB7NHZo2T6H6aHo2bp2iWnccgw8XAxpE
	+J6DOHnwYeIlKk9wdBjar5qyT/kY22tX8rn6aFWSg07EEIg0zDatvezpkMkBDpBud2IF6g2adEm
	hV5erbXojFKfLSxRkMCRVAX2w4sUo0S8MvWE/OnLkPemvcIsIE5P9ZAKCxyKa8Br57FJy/lB1g7
	1BV4d2SLYtiA==
X-Gm-Gg: ASbGncugTcpqRVHQHLI2s+GdmJzbMyJ9QYO0PrtpAxu/2oubD/r1aG9mgv/FdOiEOeO
	RrHXAh1794yhC70cfREMac+cl2DdziAX9csiII5+1i00DauD3sJ/HR8hMxSeavUR2xlns96YoST
	/YD8MnMhZdGhx+Y8N0LgIXdGzf9CcwfJ59fvbPfQOe9KjR5IHif3jiEgNafU0QtlU5IHWKlf3Ma
	tx7h7xxCjyaKb212j9bYKK0Hp1sPhloXjhI5omvFdKu3j8MkXtvxzQpZFooHduNEHA09GPfTnt9
	gxhxSEZvSgFMbht50KWbEo9CSAMFdSk+wWsA7cs6bbpGKMgRtS0d1oSGbAdF9KZXy09/4kilVjp
	8ahC+VhC0HCTWIz6ST4cRSqjM
X-Received: by 2002:a17:902:ccc8:b0:236:6f7b:bf33 with SMTP id d9443c01a7336-23ddb2e6794mr24592355ad.24.1752042970063;
        Tue, 08 Jul 2025 23:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb1yK7GzVpWZ21nqMLdUIn2S5TE/zoZmGFxw6MqotPvtA6RRu0o+2eYJ78aGSZrUJzzS8CiA==
X-Received: by 2002:a17:902:ccc8:b0:236:6f7b:bf33 with SMTP id d9443c01a7336-23ddb2e6794mr24592035ad.24.1752042969658;
        Tue, 08 Jul 2025 23:36:09 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a4c6sm128172265ad.46.2025.07.08.23.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:36:09 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: cegolf@ugholf.net
Subject: [PATCH RESEND] Bluetooth: btusb: Add new VID/PID 0489/e14e for MT7925
Date: Wed,  9 Jul 2025 14:36:06 +0800
Message-ID: <20250709063606.25806-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add VID 0489 & PID e14e for MediaTek MT7925 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e14e Rev= 1.00
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
I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index abdb07d71be0..a2d423fd8663 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -669,6 +669,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe139), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe150), .driver_info = BTUSB_MEDIATEK |
-- 
2.43.0

