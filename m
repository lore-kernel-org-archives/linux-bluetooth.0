Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411235949
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 03:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913025; cv=none; b=nWUOrK68guyzBYxvDdgq2l0Aol+vUvztV1Nq/My+4zVDqrSXycD/U9b63XOcFBMTOMAgnTl181UYUCez3KG3BA9KR60606lUqZ86dMeeS7gkDcGFC56HD+EqFNeB3JmmUIlT8LhZTX39DsctAsCcFUcuDTk5uNGtE8+PLxED4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913025; c=relaxed/simple;
	bh=SQeZSs3fjZTm/d2JUDvde9hFjG2wrLvI3Y7DviBDdro=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kZOVuIbDonzmdT7VCxSFW8YmzhGTP3pyFeg0o8O9GVp4ClEDd6CgAK3EI5m3K1KgcmL2yUd/GDhUNHmNYHmz0totrXwzA7fD5yX429vFt25tnvyxsyjInx8mBpQPXrYhFARiwhY5pwvBa2W3GRNBeeWPPhoIVoREhschYaU6K7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wVURA8qC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wVURA8qC"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A9563F287
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 03:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736913021;
	bh=zmTk/bLQEATrkW5ZhuNgtPLCeoO7OY3pblXNYUWXoMQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=wVURA8qCISVH2Q3zrJxeSfxPMkTZlfoac433Ej/48ghAjZFHpj2NE5Jd0pw0X51xN
	 1a/8BKzBhdwV4Cplk/DorM4Yfu/s0RlaiXnSHC1qajuJt2Uym9Z4ZNstVYE2NdKJvB
	 DryR1IbEbxfxLSMYbvRb61k+Cg6Jt4SKA24KqgS8+HrmGMUlwfRf/hL22Z0iGr9ito
	 /P/qyTTYit254TFyOwRRbbNP391v6W5WWSKfpZp52QWDgGTw+tfUspi6PrGwuMrHsM
	 2U1mXtEDWRhOnzQpmfQ68MOd4/eYb+N+WUW/zPR8X/qW6ZFmNneQ5ZR77G17bVEypl
	 e61ZdiD2YO6iw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2165433e229so123712075ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 19:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736913018; x=1737517818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmTk/bLQEATrkW5ZhuNgtPLCeoO7OY3pblXNYUWXoMQ=;
        b=FmcpjNndleUCC/sl83bxEFT8LDffQ6iaG9M1zhiw5vd1k+fC19bMxwWlF2/+p51d3h
         YNxkJc7UsvU7fiN8NOo/E77T0vdhm2ty882E+vOSnhKLF4lVHLNugKRQbTxsk5EXYLe/
         LAngwIQ0LHHvph1kA1mO0vNw8RfByh+Tc7UAzCcBpwrsJILk9A3H/qYf3CD/ft5+i1S+
         1ZPnXPPLooeZTW6JsY1RnAfVjjP8rspgtpTRBwKIDMj6mR3B6QF6GbLwtYXfj8ma5UXG
         NAqw6baCRr0rAWT8t4za8eXpqYBuDtAR+6mD8T8SAQbyLkjQIm4+lpi660cJl62X8Nru
         aaSg==
X-Forwarded-Encrypted: i=1; AJvYcCX8rdjqc2lMryzCljZMtBAqZCX2KwK3LnodtvCO7jUafy//r+qiMhhOHX0uXpbpi92upEyGowyhMXWppZ6tBSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqYUbD0DKwUsSGzzXwNOev2mwNnyjHmWHktF9FEDLQMbH02/j
	tahODl3EeE3WIGM31WX+z4Ry+l3Lb568+sbYKo/nyfUwgvzx6UzH/ddAi4EeP4XpoH7qPQCKFsK
	pm+298atUm1Y8Yzc3js9KOPHgKII07APX96SyHMXj7G8GHgbjO09SoD5MESMllZknDesGuwsHA/
	fI3QsiiaPWTvlfuQ==
X-Gm-Gg: ASbGncuWtmc50FEHx6cNoAUiDI8AEGYRDe71Eep7ux2YDlKGlTztUOgTwuUzPpfzWkS
	XRrDjDDupcScBnJrnq+O9f5hFXtK49+oCrB/Jc+RKtpCZixsYCLhdbg2Aa/XrZJLuMu7F7AIeMJ
	v+ZG1B3t4ilh3fPDBX0smfD9NcyTuysNe/R0oru6XysV80bvjC99bpwtXgm48NB9z97oUrH0lJ6
	SYnFHEMBpvQJPhbTzg5iZXKX/gWq75xl0MoYPWFdVitox5PUa0o8mbwIUTGhZ2NhAtPB+gTIhzY
	SHJ2tunly+NshUo43lwhbu+rs7Cw5e68xqBrOjgiVREMC5Fb7Fawc4tZQ3g=
X-Received: by 2002:a05:6a21:a24b:b0:1d9:6c9c:75ea with SMTP id adf61e73a8af0-1e88d0df9efmr40851128637.5.1736913018502;
        Tue, 14 Jan 2025 19:50:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCRZAqhVw8foOk1OIl2qpIcD0DruNGaySXa5ctO9kYYvKzmQ9H2wJPDs4RPvGzdNGJq9rVJg==
X-Received: by 2002:a05:6a21:a24b:b0:1d9:6c9c:75ea with SMTP id adf61e73a8af0-1e88d0df9efmr40851103637.5.1736913018125;
        Tue, 14 Jan 2025 19:50:18 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40548489sm8529543b3a.15.2025.01.14.19.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:50:17 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 0489/e14e for MT7925
Date: Wed, 15 Jan 2025 11:50:14 +0800
Message-ID: <20250115035014.208090-1-en-wei.wu@canonical.com>
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

