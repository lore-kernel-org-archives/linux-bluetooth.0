Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7EE35AC16
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024895; cv=none; b=vGgk3ee2wyebV455Td20DKbeVwnhFrpx7+VWndBP8K2l6WxxJVFq2IekR1Ncoi4BZbYupqGmcl4dbl/LwCqAj0VPT5BHr43NKf2LYR4cYydmo8TEDQacTJhzH6zLRfBVuneepXTNLb/JYd+3wod0CZbIk/JzuCCHC2vHqKZh0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024895; c=relaxed/simple;
	bh=6GF+BCuFSO9B0rXrXZD++OFOnJlHjkLElastgE5PaZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o5VfMaEYSGs0CV12V3hKVS3E51Wg2Aa2aMZDhMfyDOyZZHKqGhfl3EEFa7dtpX1AItECfeRi768XEdRt/1Q0MKyLKBiqZSNR6bLdlizqCoNnaZvnjAgd6u2gp3wppJDLLy9nJuAl0XaFZ1hxII2Y9rojTrUGsU0sSihGF1wLEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BbRTogay; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BbRTogay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Y+
	YcfBvF/aWwrU+8Vj/dJlXw3ShUwrU7zlKEiP/P5T4=; b=BbRTogayBlj1lIY6QS
	RXMeJ0ksTX4bCmowsV0LrS/bvNjtO6DmBeQ6SyiFu8KjhpsZvas6x/vV4pUyn/K4
	azL/pnt8ihr58hS0yPKnnaha1ny7s+9sI+uSEPB37UbtsDxLTzDz3Zjs4gl6LjyJ
	7b9SkFx255i8fPKcGffFDY+TA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3NzQmP+tp+_6aBQ--.24713S2;
	Fri, 24 Apr 2026 18:00:08 +0800 (CST)
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
	Zhang Chen <zhangchen01@kylinos.cn>
Subject: [PATCH] Bluetooth: btusb: Add Realtek RTL8922AE support ID 0x0bda:0xd922
Date: Fri, 24 Apr 2026 18:00:03 +0800
Message-Id: <20260424100003.357700-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NzQmP+tp+_6aBQ--.24713S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF48JrW5tFy8JFW3KFW3ZFb_yoW5JF4xpF
	4UJ3ZxZF13KF15Wr90kr4rAayrW34xu3429a47Kw1rXFZ3A3Z7JF1UAryfXan2yr4Sg3Z0
	qFnrC3yrKr1ftrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCeHkUUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbC5wgvy2nrPyhWPQAA31

From: Zhang Chen <zhangchen01@kylinos.cn>

Add the support ID (0x0bda, 0xd922) to usb_device_id table for
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

Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a0a7da498466..278999ed9883 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -607,6 +607,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0xd922), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
-- 
2.25.1

