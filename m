Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679332F765
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032753; cv=none; b=HHJnzw7ZN8EDhdx5ae/+rGv/lUF6tN8ehfofNFJrLttFEv6OWobUacBuzpHRL/Gdt923ppNO5xtcA7P6bfESO3sbJXyPCijrxDqFI/dg0KfugUAVtu/2+wqJtos3HdTh9iliUIBmkosQbwrk+LSZXwvLgIO8zGB0KNNPT+vRdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032753; c=relaxed/simple;
	bh=YtxPv4id1DY8fExzcnX3S/OqquVBq6Xmf/aWdBzpdXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g7jQivASCVsifNs4twazM3lcABVGuM41Af8NgJjefGAo5sRGt8SGqSwZZ9YwSx61kQo1MGL3boG29Lt8u4VTrwKO7YFtjFZMlVOPjTUGd55BzqqNwg+GlAI69ln4FGNurDbmVU7dBd0rCYl7vh+S7sSfo48godsfqNH6+I2Zyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f2MojG/A; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f2MojG/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qd
	MkW+H5p8KM8m408oFhTfvR9xqPIozPjKl9Fh634XI=; b=f2MojG/ArIdHcVhdEY
	Wibq3jeGURu74pmctw+mTcIgctGSbSlBy4ImaQ3nNlQDQ6OveGcThei9M/aciuJx
	2kkfsjUQh+7Qw5yeyBS7tmEW3uu7z67hiurDqHlq1q3c35dXK9v9PNrRqpF14Vqz
	p5MlX3cEDciWil/jHXEdKG/Xs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAHTPR7XetpGqKqBQ--.57233S2;
	Fri, 24 Apr 2026 20:09:32 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.von.dentz@intel.com,
	chris.lu@mediatek.com,
	pmenzel@molgen.mpg.de,
	floss@jetm.me,
	sean.wang@mediatek.com,
	en-wei.wu@canonical.com,
	Zijun.Hu@oss.qualcomm.com,
	chharry@chromium.org,
	ceggers@arri.de,
	johan@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Chen Zhang <zhangchen01@kylinos.cn>
Subject: [PATCH v2] Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d922
Date: Fri, 24 Apr 2026 20:09:28 +0800
Message-Id: <20260424120928.397758-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHTPR7XetpGqKqBQ--.57233S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWrJr4kGF4rWFy8ZF4Dtwb_yoW5Gry5pF
	45J3Z8ZF1fKF15W3s0kF45AayrW34xW347K3W7tw1rXFZ3Aan7JF1UArWfXFs2yr4Sgwna
	qFnrG3yrKr1xKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPxhJUUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbCwB3LaGnrXX3f+wAA34

From: Chen Zhang <zhangchen01@kylinos.cn>

Add the vendor/product ID (0x0bda, 0xd922) to usb_device_id table for
Realtek RTL8922AE.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=10 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=d922 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00E04C885A01
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
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a0a7da498466..d84faad07dd7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -601,6 +601,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8922AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x8922), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0xd922), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3617), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3616), .driver_info = BTUSB_REALTEK |
-- 
2.25.1

