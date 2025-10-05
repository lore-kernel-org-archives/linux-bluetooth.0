Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1863212566;
	Sun,  5 Oct 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759654455; cv=none; b=STwS9Qbc9EjMov+Gcdd5KfsnnbkS34dWTB9Dvove6qca4J5uGAStTtuwSJi1PnuMjGx/+5Qm0DwQlOraJM0HnQrZPowTZoisspLIUa14i5iU1QlQ8mQzJy+uUl08Whjgq9NdWowhzFvYlP0YGylqJDDVUuNPZxyRQ+v2yI1LTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759654455; c=relaxed/simple;
	bh=y6Thp0mTzrmk2k2RL8bTB/soX9MDqJ52ayiMM5B77A8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QlJW8DM9RvkYJ0+B1wrU54y2lMiCqwFsioe2eIKbpXwysPzIy8F7pa1W73gWbixtl3CJK44NoWMvzdvFZj2yZny3SKj7Q300/nvWHhgHXiZcNio4tKTyWrrv3+5NDIYYQlILEFhK3tMAGogkxKU7Q6sRkcKF2PALdL5GbObd7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ED0tJ2Qc; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ED0tJ2Qc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=3iYrGsULfLNOR8HeDH4+AMLiCUEZim8TOnC8ldZpHBE=;
	b=ED0tJ2QceYrdbqH5EgkeGSRj2qpdkEPdixUFbCQ9Vznz7xD7TIKjtgV3++CmLH
	ezImq5tBl/389PmTbCCKFSRww8VWarT3056BjPq/xOTTcYqdEYO2FbTH2cwOACtm
	6lCdrsRDvZGQ6cm959P1WaUesLgtFdyVuR0nrOTYa8jEA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3N0UkMuJo4u1sCA--.9915S2;
	Sun, 05 Oct 2025 16:53:56 +0800 (CST)
Date: Sun, 5 Oct 2025 16:53:56 +0800
From: Chingbin Li <liqb365@163.com>
To: marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV
Message-ID: <aOIyJOnP55mmZUut@9950x-Ubunbu-24-04-dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yalHI+Ut+nM983X2"
Content-Disposition: inline
X-CM-TRANSID:_____wD3N0UkMuJo4u1sCA--.9915S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF47Ww18Wr1kJrWkGr13CFg_yoW8ury7pF
	4rA3ZxXr1fKr1Uur909F18AayfW3s7u347X3W7Gw13WFZ5Aan7J3W7ArWrXFs2kw4Ig3Z0
	qrnxu3yfKryxJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USdgtUUUUU=
X-CM-SenderInfo: xoltujiwv6il2tof0z/1tbiRAHdcGjiJyR3mAABsP


--yalHI+Ut+nM983X2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From 5676b7b1029c11ec99b119a3b56945ba8a766c0a Mon Sep 17 00:00:00 2001
From: Chingbin Li <liqb365@163.com>
Date: Sun, 5 Oct 2025 16:28:28 +0800
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV

Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV

Add VID 2b89 & PID 6275 for Realtek RTL8761BUV USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  6 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2b89 ProdID=6275 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00E04C239987
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

Signed-off-by: Chingbin Li <liqb365@163.com>

Chingbin Li (1):
  Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

--
2.43.0

--yalHI+Ut+nM983X2
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Bluetooth-btusb-Add-new-VID-PID-2b89-6275-for-RTL876.patch"

From 5676b7b1029c11ec99b119a3b56945ba8a766c0a Mon Sep 17 00:00:00 2001
From: Chingbin Li <liqb365@163.com>
Date: Sun, 5 Oct 2025 16:21:26 +0800
Subject: [PATCH 1/1] Bluetooth: btusb: Add new VID/PID 2b89/6275 for
 RTL8761BUV

Add VID 2b89 & PID 6275 for Realtek RTL8761BUV USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  6 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2b89 ProdID=6275 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00E04C239987
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

Signed-off-by: Chingbin Li <liqb365@163.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5e9ebf0c5312..3ca17d283d26 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -781,6 +781,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2b89, 0x8761), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2b89, 0x6275), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },

 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
--
2.43.0


--yalHI+Ut+nM983X2--

