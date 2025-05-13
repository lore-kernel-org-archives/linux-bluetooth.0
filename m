Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2320D286A1;
	Tue, 13 May 2025 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117833; cv=none; b=LAqh1KCqXSSRVnonRZwEk0SU3efDO4tDe5F87KDcZ1o9lwtoq2xTTVFjy2rCX0pb1oUtU9ohWSHNdZInuOSNZ8oUa9hxLy/XwnA2oubZlrAdF+so52BZRpXil2mBRjE5UxKwIwMJzE3jLyN5uAP3wgOpICAr19DeeFJ5G81xiTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117833; c=relaxed/simple;
	bh=qsPeyMu38DJb/GKVWha5I6LxEG3eOawAAd39Sj+pjZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kb1urVE6DiN0S63r9vYFOXnY2DT9YDu7fIXeJ+vJMnvQ1BaklKu0euaDGQjPYFOlvGBzVtRJ4owaF6AqVuCn55RqQ+mmKuqzYiMQWIzpBzbkIZMJwkuNDnXlkK6BLvan7eDUQKHPQH8goGKc0BX/6y2j9B/VgUyeS7v1kQYPqto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MGceBvKs; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MGceBvKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FA
	nOl1rN79wdkEyXITWOwxgUUQ49yT5NL82Q+xLR0VM=; b=MGceBvKs4QOA57FtIE
	nghtLqhpGgHEGHs4yEs01XGESYxAHsMS2jSpxnRAQ0xO9wQ+yquy/B5pVcFFswEC
	B2rrGHbQy5gsn7EDSFWdIJDs8C4V/Ng3xrUchf3Y3TAJ8RTs6Qi4Rc2ZSfHIG8Yn
	MySMKhSRiUVj+WG5VzBCIxWRs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3v0tg4yJolyPXAA--.32121S2;
	Tue, 13 May 2025 14:14:58 +0800 (CST)
From: Liwei Sun <sunliweis@126.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liwei Sun <sunliweis@126.com>
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
Date: Tue, 13 May 2025 14:13:54 +0800
Message-ID: <20250513061353.13521-2-sunliweis@126.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v0tg4yJolyPXAA--.32121S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4UCrW5Xr4xJryrCw45KFg_yoWrAFyfpF
	n5t3Z8XryIgF1jqrnIyw1rAayFg3s7W342k3Zrtw13XFWrAan7J3WUArWfXFs2kr4ag3ZY
	qF1Du3yrKr15GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEcdj9UUUUU=
X-CM-SenderInfo: xvxqzxpzhl2qqrswhudrp/1tbiEwJLW2giZBVnkwABsP

A new variant of MT7922 wireless device has been identified.
The device introduces itself as MEDIATEK MT7922,
so treat it as MediaTek device.
With this patch, btusb driver works as expected:
[    3.151162] Bluetooth: Core ver 2.22
[    3.151185] Bluetooth: HCI device and connection manager initialized
[    3.151189] Bluetooth: HCI socket layer initialized
[    3.151191] Bluetooth: L2CAP socket layer initialized
[    3.151194] Bluetooth: SCO socket layer initialized
[    3.295718] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
[    4.676634] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.676637] Bluetooth: BNEP filters: protocol multicast
[    4.676640] Bluetooth: BNEP socket layer initialized
[    5.560453] Bluetooth: hci0: Device setup in 2320660 usecs
[    5.560457] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[    5.619197] Bluetooth: hci0: AOSP extensions version v1.00
[    5.619204] Bluetooth: hci0: AOSP quality report is supported
[    5.619301] Bluetooth: MGMT ver 1.23
[    6.741247] Bluetooth: RFCOMM TTY layer initialized
[    6.741258] Bluetooth: RFCOMM socket layer initialized
[    6.741261] Bluetooth: RFCOMM ver 1.11

lspci output:
04:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter

USB information:
T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3584 Rev= 1.00
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

Signed-off-by: Liwei Sun <sunliweis@126.com>
---
Resending this email due to format issues. Apologies for my previous
mistakes.

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5012b5ff92c8..9850272e83ef 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -678,6 +678,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3584), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3605), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3607), .driver_info = BTUSB_MEDIATEK |

base-commit: 7a13c14ee59d4f6c5f4277a86516cbc73a1383a8
-- 
2.49.0

