Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F52E4258;
	Wed, 19 Nov 2025 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537637; cv=none; b=bICIDtkahlfF4q1BELRNydU2hXUHeJVk3fdcr3tn9Q1PGSozDcz5dZPWgVtzNJ5T+TkarrZVsT2pqxl97f5k5xAT2rZLYfYI5sKjCUhiB6DPm5g7vhh/CSEmCJlEjI+s66r/A0DSB5oGfDGZ3/lVahntZd20UmoxNkVV3RRXndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537637; c=relaxed/simple;
	bh=sexQnoXBYLpYyJzuseUGoM7u/Y7KPLLWucAg0jmap/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RHL6r8yWB8+OpD2JeIOIGVlCAL9nFWnLAZpIHVd2AY+ETx6+Fn4TZUhQxAZ/7fja/HogGh9ar6tXkJtTESHcnWAO+ffaKucnNyCxS1VzV5TE/vogy54FzoY2PI9UVMD3F5/ROiCwVT+COsz3x5BRK8F8mLboMd876hUoxOWo5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DA3XYoei; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DA3XYoei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/D
	u9SdLijF90OLYXMUhCcFxr6Vw1Km5iZy5GVV8O+KY=; b=DA3XYoeiyREm9zO7lb
	/F+4FW4UG/iUPgnRTcesMrRLdzHA4JN2LrfgaP8Z5nOYvRRpfSBX6g/CFk4nNTCN
	ndVs+Kvl8Z/tEkbzDJhALcAlEmGViBeDoknNPss1jofDENn5IhLjrv7DNo5hJNZn
	Vc6DL5FIo8T+yHFAGv5iFyUQM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBn3ZzTch1p0wvXBA--.305S2;
	Wed, 19 Nov 2025 15:33:42 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE
Date: Wed, 19 Nov 2025 15:33:38 +0800
Message-Id: <20251119073338.713247-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn3ZzTch1p0wvXBA--.305S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw4Uuw1fJFW8JF13GFW5GFg_yoW8KF4UpF
	45J3Z8ZF13KF15X3s0yF4rAayrW34xW34293Z7Kw15WFZ3Aan7JF1UAryfXFsayr4SgwnY
	qFsrC3yrKr13KrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jB2NZUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXAEKumkcONVibQADs5

From: Gongwei Li <ligongwei@kylinos.cn>

Add VID 13d3 & PID 3533 for Realtek RTL8821CE USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3533 Rev= 1.10
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

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fcc62e2fb..49ae202a2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -504,6 +504,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8821CE Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3529), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3533), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8822CE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |
-- 
2.25.1

