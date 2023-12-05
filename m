Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="o8OZvkc5"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4749BA
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 05:34:02 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0a7b72203so18114935ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Dec 2023 05:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1701783242; x=1702388042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYWOBy7eNQZyXg3TkihTw7SU0aXCxLCNlcRtPQ8N2Rs=;
        b=o8OZvkc50euckuUUJFJlG1v847xaPsCYel5FBZkgUceCn6yW3BU+DtDDfeTTAumLyz
         ITKd21+nNSX7gGLcY0uyDHBLih+aAXCkDmhbeL9I3HQqZEd2zATywfRiKy8gp6y5Xknt
         HtfVHmbdy52Wqjfm9KRLH8t6ZszEYaiOwRQ8YgAHC3eBxWVZGPp6uFsyvdh/OUd248VB
         fz1P2uRIOR/HvBR/3bXTNwQeAhFtQpnLVtJ3A6b5ZdILmeyLKvUw9SsM1FlmHAyi6yFa
         8QB4r75ZLomjVi95lGnOkHfrx2jh3pM/MswHdCc/YE4FIWCHxAU2TsG0bK9YeKv4dsYl
         oB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701783242; x=1702388042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYWOBy7eNQZyXg3TkihTw7SU0aXCxLCNlcRtPQ8N2Rs=;
        b=bH8UaX0tsM1n4H1Awx5JiHx8CWY0EeLsckZBLJg5xzm2YGhbyPiyjV0A3CtFhivcuv
         3qzgvZNaVC4bwzeLZNV/sQwj2SjawM/Kl7y9rckv4N7dn7iM2pLCH+zHqi8kil7n1YLe
         WAXiszYjrB/hvc3Ctj19DZ8cY0tTV9D2as9faoQki9TBUoWWsuqkJzriKyejwNHIkYgW
         tVvKRoL9GUo19fnaxVGO+bhMHM60w0Oy/r+U0o69bhokOq49RF3H5PICf9KaqR2w16vJ
         6hKboaq3/0D6ileqYHh7OXNj27b283G64uk2eLJ5WjWIPFGIV3Zt7u1qFWKSAp6h3DTe
         SSFg==
X-Gm-Message-State: AOJu0Yw3W2CmgsYCXi2M/sxqBbDSo5VvKiveKCyf6TwLFZ2GR3Fzrkas
	rdRfqxHZ6nS15L1nlQ0OgQiIrQ==
X-Google-Smtp-Source: AGHT+IG/tkm2x4D+ctebVeaUIW9Sgd/N77c4YHt/ES9ulkG4q27qaI1gS1mjT6pXexhn+kDjTeXsvg==
X-Received: by 2002:a17:902:ce86:b0:1d0:7ed3:ea7c with SMTP id f6-20020a170902ce8600b001d07ed3ea7cmr5980012plg.29.1701783242306;
        Tue, 05 Dec 2023 05:34:02 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b001cfad034756sm5458471plb.138.2023.12.05.05.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 05:34:01 -0800 (PST)
From: Jagan Teki <jagan@edgeble.ai>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH] bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio
Date: Tue,  5 Dec 2023 19:03:48 +0530
Message-Id: <20231205133348.350364-1-jagan@edgeble.ai>
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

