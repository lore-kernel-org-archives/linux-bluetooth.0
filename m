Received: from nuclearsunshine.com (nuclearsunshine.com [81.187.79.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B01FC19
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Aug 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.79.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722764682; cv=none; b=sCJoCfKnMMf7T1IiT0/RGD/494lrd5jUx8QANshtgVTAR9B4BijcDkDPY0ra1YPGu/TN2vwZ9IocpzKgYYhi6s3+oeOvVakOX8/up7vHEI7pfNhhb8dy1ZsNErTRmAnhl9KSbgUQqPRLOgzD9vzzGdSOCaaYHGHxhtj3WorQAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722764682; c=relaxed/simple;
	bh=vn2Ic3ndCMhWmFhdWbaBK/2ki7SxKzVDTwOHiqqUUKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UQxEmavR0bNKSjd9gKMVyvIHvZp5A3tl310Se2oHySdIDhbGv/8HngArAp3chR/Xr+OnT0FA+LCioboi+gV0kKBpAgMrlusBJxBHI4OSDtescFoN/dYFGIHSHl2p3reXTmUwBwPQyr2Po0+7LXIOej0Vd6+DSfQE/0cWdaVM2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuclearsunshine.com; spf=pass smtp.mailfrom=nuclearsunshine.com; arc=none smtp.client-ip=81.187.79.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuclearsunshine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuclearsunshine.com
Received: from desktop.internal.chaoschild.com (desktop.internal.chaoschild.com [192.168.1.2])
	by chaoschild.com (Postfix) with ESMTPSA id 633F31760D0B;
	Sun,  4 Aug 2024 10:44:37 +0100 (BST)
Message-ID: <53ccc7377341b64ff3fbdde3df28cbd14f245340.camel@nuclearsunshine.com>
Subject: [PATCH v2 1/1] Bluetooth: btusb: add 13d3/3608 VID/PID for MT7925
From: Nuclear Sunshine <kernel-2024-q3@nuclearsunshine.com>
To: linux-bluetooth@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sun, 04 Aug 2024 10:44:37 +0100
In-Reply-To: <5c82f430-a32d-40fb-8c64-643be3cddf0d@molgen.mpg.de>
References: 
	<a2cd95d91354168876eab963bb7e1cfa1b31e985.camel@nuclearsunshine.com>
	 <5c82f430-a32d-40fb-8c64-643be3cddf0d@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The VID/PID are as seen for this chipset in the Asus Zenbook S 16
(UM5606), and have been successfully tested with the mt7925e driver.

Device information from `/sys/kernel/debug/usb/devices` (on kernel
with this patch):

T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D480  Mx=
Ch=3D 0
D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D13d3 ProdID=3D3608 Rev=3D 1.00
S:  Manufacturer=3DMediaTek Inc.
S:  Product=3DWireless_Device
S:  SerialNumber=3D000000000
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
I:* If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us

Signed-off-by: Nuclear Sunshine <kernel-2024-q3@nuclearsunshine.com>
---
v1 -> v2: Added device information from `/sys/kernel/debug/usb/devices`.

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index acdba5d77694..fccefa57506a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -696,6 +696,9 @@ static const struct usb_device_id quirks_table[] =3D {
 	{ USB_DEVICE(0x13d3, 0x3603), .driver_info =3D BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3608), .driver_info =3D BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
=20
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTEK },
--=20
2.45.2


