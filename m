Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79451231829;
	Mon,  6 Oct 2025 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740437; cv=none; b=r7VRqc0bcXsttt5B4Kd7UjezoKYBr8Xc94kmEv8+sdz3lAcT9ppjZiSWssS7oZH+BQ/mzawFPt9EytdzFYHXDcqAw7bUlS8FtDEBcIvJ7EWA3HEcjrmnie2YV4iOHos2vOjeTEd6UJ8ljkOFIMfwg2lfFlPsqlzbH4abfFWsex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740437; c=relaxed/simple;
	bh=IzIhp5dUepY9MmY78wLvtgLm9Fvq7PK6A4cvqTgpA/g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b5dDKYI6HU3+r+NxNnSB9UOu9wrYsvNxO1U2pfPxNOjal37e/9khhIwJHVuJt1A/OM2yqHx2/dqltoJK8oYdMtijMOvcxwY7EjQ+D+lPdYmJ2TudI32P3NqcxbVTHPhZqQ/zEjoIcGUuLMpi81p7Qj6iX0xtSFaA+CEYhBdL36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A0Mqpbu4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A0Mqpbu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Cc
	wnoxPqYyXU1wNy7MHuZsxfu9hybasnCZholcU269Q=; b=A0Mqpbu4Pjkt6ZmbpU
	lBNruBx4xAXmmpEpid/hmvqdpT3jbpIWdDUJOPjKJ/LtmpthQf6z96vt7i+Gsr93
	9bJKLi7x10xu2PWqrig3K80gJOjDcpteMi8qeKlRNLHYfVG+7X2ep2T9DMQgkmaf
	AFfluPut7bzJvJ6ioc48widSY=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHbzj4geNoWg8PCQ--.40488S2;
	Mon, 06 Oct 2025 16:46:49 +0800 (CST)
From: Chingbin Li <liqb365@163.com>
To: pmenzel@molgen.mpg.de,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV
Date: Mon,  6 Oct 2025 16:46:47 +0800
Message-ID: <20251006084647.19902-1-liqb365@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHbzj4geNoWg8PCQ--.40488S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF47KF4xWF47ZFW5Xw43KFg_yoW8Kr4DpF
	4UJ3ZxZF1fKF1UGr9IkF18CayrW34xu342g3ZrGw1fXFZ5Aan7J3WUAryfXrsayr4Sg3ZY
	qFnrC3yFkr17JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul_MfUUUUU=
X-CM-SenderInfo: xoltujiwv6il2tof0z/1tbiURPecGjjdy3PvwAAsN

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

