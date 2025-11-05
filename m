Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352027EC7C;
	Wed,  5 Nov 2025 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762321835; cv=none; b=dWa7/+aSWm/dn+Fd9ISUYZWez4MWrNeLllLNZ6wL9VM3Cvs86wd9u+Q/eyGalZ7y17oBoJ8fez7zXaY0QgMSCLIGv/Hi2XofyH9G3zWg+0pgb8/8Zwa+5/+CoaUUeqa3Ts7oTVou8vKZNDdI+cNyUrz5nrpffiyICS4OnBk1UPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762321835; c=relaxed/simple;
	bh=ndXwHcC+v1Tj7iTMFp4P2YzItGT0Stl2gJRclPtsQAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5CDxBhWBDF5Ly49usl0AnFA1l1yrlQYQZzJnMSf5su+OFn3AomDh13h9dUPcakfGlU+Y+sVUIMlahm1zNEcmcIil81ALqd+/wK2mJMmwqLymsqzWavz8xPy9xu+7tgIOIOILLwfvZ0aZe59+QncN8hysvYYrsKu3dNaLMtyIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pfxxYSOO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pfxxYSOO"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A55oMSK1506871, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762321822; bh=CKmCBuHTvN5kXPTDoOtMHZLw1Axm8P9kDhwWluPT1JA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pfxxYSOOmQ2H/Ha4nUVjl2Of9Rzw1OU2uxsexWUROLyI1fw5nAgj745un2jBntrEF
	 qBgFSASPm+JnVFqE5DJilkjHMEiCpa2Tw9eFs2y4I8XHzCbjsxy+HnlMyGaOIgcl/b
	 XAmGTcSbNUDCGFrUEtmYJGLP2fIcmRDR2a27ouVJUZwtEmF0w1+5B9v4dtCCdgq094
	 bLZ4f6jyCJtKhK7akzIEomd2Sj0NDthl3NPlP6lFFWpRrw1HptHyzcnoSaW9uYwXBp
	 g8VmNgxw6o2cxIFSIrUgxB24rTCL3Hck5Npa6bRdmWj6T2k5VG3cQz+hckahSOWR9Z
	 LqDfFY2W5l4Tw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A55oMSK1506871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 13:50:22 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 13:50:22 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 13:50:21 +0800
Received: from rtkbt-D520MT-K.realtek.com.tw (172.24.54.67) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1544.27 via Frontend Transport; Wed, 5 Nov 2025 13:50:21 +0800
From: Max Chou <max.chou@realtek.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hilda Wu <hildawu@realtek.com>, alex_lu <alex_lu@realsil.com.cn>,
        <niall_ni@realsil.com.cn>, KidmanLee <kidman@realtek.com>,
        Max Chou
	<max.chou@realtek.com>
Subject: [PATCH 1/3] Bluetooth: btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT
Date: Wed, 5 Nov 2025 13:50:39 +0800
Message-ID: <20251105055041.456142-2-max.chou@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105055041.456142-1-max.chou@realtek.com>
References: <20251105055041.456142-1-max.chou@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the support ID(0x0489, 0xE12F) to usb_device_id table for
Realtek RTL8852BE-VT.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=04 Lev=02 Prnt=02 Port=05 Cnt=01 Dev#= 86 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e12f Rev= 0.00
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

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dcbff764122f..0308fb92c122 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -585,6 +585,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8852BT/8852BE-VT Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x8520), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe12f), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8922AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x8922), .driver_info = BTUSB_REALTEK |
-- 
2.43.0

