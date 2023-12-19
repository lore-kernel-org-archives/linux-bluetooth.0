Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765B225D9
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edgeble.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="BNOV7vYW"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d939e2f594so591832b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 09:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1703007359; x=1703612159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6xt47F6+JMYpd47p3WKPJhNZy2Q7x7jTZWa1cFTuXk=;
        b=BNOV7vYWwrC0yEzLevvV0VFxy+oP0P3m3UjVu28FpzADsOLHqj9MfUW9qjS/Pvzhod
         Tdht/tTUV9xfvinVNrASjWL0US8z+gv3VQIXadaB5AR6JuMZ8p7llMEnhClEBW2TDbC/
         EsKmQ0GFVKbFmA1e9xozADTH4EwSeb84DnGuccIa10IuS8rO+um7KZt2uSmt1ldxNsLu
         Er33ICC0hbhmwcayxbGmdBMaMV82zV2NaKZ72Ht2lb8KBa9tc/BZBzdGbSFXS/cZHQBv
         oVtP3brE2/OTiZQJYPEVzZZgMZ5SGJdRc4MlHUQoC1YOsp+AiHzDhO7qOxm1aNEeIS5x
         glGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007359; x=1703612159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6xt47F6+JMYpd47p3WKPJhNZy2Q7x7jTZWa1cFTuXk=;
        b=EkAKvjCYRp9nCC0yjJHV/TWyafSAHA/bjtquX222P9gi+8Dk4Jabzjz2hXDg3MQjHf
         jiklUj5SMfYVnr0uEGpVQmAj4kW2QgK67qA+lmAdLMB0R9EoPWiHedHvUX1NSCgZK0YM
         au0jQXhPT2nT1kMf0f34qx5jhxUFpzqJXoVfTvJcJZUrQLzgbTGz5YNTu6LMRw4wMnyk
         U9u2ZITrc6nUivRcGd/bQXF9F68vEG3ASnFo79eRToTn83PZB6EWbIlJqMsW+5D9hBn9
         ydU6OTSFN26o/A4dRvyrz6RrqsBkf8Or50nWg12CZkmB4LUPfHjVZGRs5Whg3KY801yl
         xrjA==
X-Gm-Message-State: AOJu0YxTq+EwhpQ2vk4p3oEWwnQb0dx7+6/sodMQx7tZWElyb/oL1F5s
	TJgT5asaJXH9X7P7Mq9tteAHQg==
X-Google-Smtp-Source: AGHT+IFuIjfPPhUgNG20nv+lrGIptqD32HCiqbY2/e0VfxtoijefGrGDm4/4REVh7jdUYPgRAlqYAA==
X-Received: by 2002:aa7:93c4:0:b0:6d6:aa3d:b44 with SMTP id y4-20020aa793c4000000b006d6aa3d0b44mr3951067pff.53.1703007359399;
        Tue, 19 Dec 2023 09:35:59 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a208:b4aa:2f82:a5a:52d7])
        by smtp.gmail.com with ESMTPSA id o11-20020a056a001b4b00b006d926329cd3sm2238479pfv.212.2023.12.19.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:35:59 -0800 (PST)
From: Jagan Teki <jagan@edgeble.ai>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2] Bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio
Date: Tue, 19 Dec 2023 23:05:47 +0530
Message-Id: <20231219173547.337962-1-jagan@edgeble.ai>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This 13d3:3572 is part of  Realtek RTW8852BE chip.

The device table is:
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3572 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
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

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- Change commit prefix from bluetooth to Bluetooth

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8e9de887b5d..cf976a54dc20 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -550,6 +550,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3572), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
-- 
2.25.1

