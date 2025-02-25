Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7BB183CB0
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499525; cv=none; b=tradPuJX1QXAZoV6R5Y1g19B7LYgZxJa8tn+OPBNi8CyKpFLkE1xScsX1a6A4k0s+0NMd97fyXGOelZeAR1w2TPgEG0R+RQIWyQYY1Tyi5UvxxlPOi0wg6pQL2lPwjA1GveNtXgKB9bUQ2Hs2eTtRLiU4J1kyo4e9PDH0guZq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499525; c=relaxed/simple;
	bh=XK1zkzaCikUXtEYmYx2k7/oNH03FbT61gtjPhljYPkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffuPou9eWqKzrNxWfqLqm6mFDs/i/6Ff3PhFUUP4JXb8vR97+2qMbaX5p3v2Wf2Z5hgkhB8MAJ3qUEwHmXAvNEVYSPxJgJd4PINPXaAu74L4j1kJhBdSY007iAOvileE7CYYJGU9SUoL9YBN2+mkixOtDJY8558+Z2fBT+3gbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b=UWnZVUMZ; arc=none smtp.client-ip=193.222.135.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b="UWnZVUMZ"
Received: (wp-smtpd smtp.tlen.pl 24648 invoked from network); 25 Feb 2025 16:58:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=20241105;
          t=1740499120; bh=Hj7qAEgiQ50fp7uhcmsq7NZfp8iIKRdHrawCOPWVFaQ=;
          h=From:To:Cc:Subject;
          b=UWnZVUMZfiARyp73UoCOgpAM09aKIAYMW2srVFZsG7NEHuGXbEUzd6xB4NJSgybhX
           wgr/OzibQBxJJeaYOxRU11iaPHl8ruXXN4yQRubRaQWIdjFTnhB1/uwZLlH1IeCh9e
           B4QIdxkj3yv8/2ZCTgEeHEpiyEd3rrBPAmEJjV8Km7v388dJezu1hIQuiGPZs0YDXC
           ipYODhWwdeInT3Gz/i5IviIHg+Jl+3/+r2diLYAzi0wS5gLmnFPI/RyrX1QtsBtJSI
           YA6u3oelgMKAgLw4PwIt4P6sx3mxoAmkpreh5WUioIcltJYTEoZeNKdgIchNh9Dkbs
           l71Y9H1gY5atw==
Received: from public-gprs689392.centertel.pl (HELO M73..) (mprnk@o2.pl@[5.184.236.49])
          (envelope-sender <mprnk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <marcel@holtmann.org>; 25 Feb 2025 16:58:40 +0100
From: Michal Piernik <mprnk@o2.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Michal Piernik <mprnk@o2.pl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add Mercusys MA530 HWID 0x2c4e/0x0115 for Realtek 8761BUV
Date: Tue, 25 Feb 2025 16:58:25 +0100
Message-Id: <20250225155825.1504841-1-mprnk@o2.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 400995f43b953aaecd84dd38b06430a3
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gTPE]                               

/sys/kernel/debug/usb/devices:
T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c4e ProdID=0115 Rev= 2.00
S:  Manufacturer=
S:  Product=Mercusys MA530 Adapter
S:  SerialNumber=30169D905719
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

dmesg:
[11106.761376] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
[11106.762370] Bluetooth: hci0: RTL: rom_version status=0 version=1
[11106.762374] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
[11106.762554] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
[11106.762579] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
[11106.910393] Bluetooth: hci0: RTL: fw version 0xdfc6d922
[11106.977569] Bluetooth: MGMT ver 1.22

Signed-off-by: Michal Piernik <mprnk@o2.pl>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f5609110f..0fc1dde8f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -739,6 +739,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8761BUV Bluetooth devices */
+	{ USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
-- 
2.34.1

