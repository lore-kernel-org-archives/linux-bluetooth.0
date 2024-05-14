Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A51E4B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688271; cv=none; b=iXd2NvzDORIuAHTXFeAFWYXqR4cNKb8gjOsuGvGvMW+Pf0Sm2XuWpqjulKnqFUgFk1M24Akxq2GsGmZhVOmVbOagNwgJw51kAugEk75t0Uz5EMMSkD+73eB2wvUyX0SGx58X+U+vbdY9WzUnHrbh4ElwJHF//dSlVmbE1C5X7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688271; c=relaxed/simple;
	bh=FYTpbOaY7Dy+DEpwCa4cMMT++yt+6kZJgcgzapVs0HA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XFO+tP0Y9qLFFQFUD0uUMTsLRxbxe9w3/3KWJN9gr3LfHH4fKvGjod6UQvcj09nRbHcdhzhhPWgWB3D9K1LY90vfULLc+/bLH8aIbeS5j3aidUSQfeIz/i/zOhU+upDGD3cGgajviwTdzoQXVRRq4jQn5Utqh/m8246ckXIXRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cNn+qXFN; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cNn+qXFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1715688265; x=1715947465;
	bh=IvTnttTsA/cCJREUZ1zcG1o5RbLcaGHs8QcRvMdki1A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cNn+qXFNtKg8RLtPLQLMX1BiXqFURHdph6JsD3UA+WK3Z8E/Ia2H3298/0K00oMea
	 A8GyDdDPDldFlhC0LqtxHPnVOZ3/SGkC1HEkcuUSBJl2Q6FOqTvMJqUOWj/KYrttIF
	 fumalJBRxdG22E9wvqlVFy1DOAd3WQQBwTpzVfoLksb3z4W+vLFLJ5Yu7L5P1GAmgo
	 FUPYjv1Ta3vf9HxVhzTwFBv8DkELK9nRF6T2KX6i29KzTUCn+q4T0PqoLf3ZoHSobC
	 BAty8pwHbZfOWi7WUob1j+rkpJchXcrreg1nXCn0pK+UYw2YgSB5y+JezdJx1S6rHi
	 P4fDWVLGwFuCQ==
Date: Tue, 14 May 2024 12:04:22 +0000
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
From: "SoloSaravanan@proton.me" <SoloSaravanan@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: Add device 13d3:3606 as MT7921 device
Message-ID: <uhH49zEgffN2Dn70XKLwBv4_mxoAaSY0e51RI-YzQGTMKyK_BRvH1sz-Fb92NGHC1g5i3DqA86ykWYBoG7lOy3QTHAluqbc7bJcnbGS-I7k=@proton.me>
Feedback-ID: 84438951:user:proton
X-Pm-Message-ID: 56591b39972ad328808a57cd1ea5674e8d7673dc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add VendorID 13d3 & ProdID 3606 for MediaTek MT7921 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D09 Cnt=3D03 Dev#=3D  4 Spd=3D480  Mx=
Ch=3D 0
D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D13d3 ProdID=3D3606 Rev=3D 1.00
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
I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
I:  If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us

Signed-off-by: SoloSaravanan <SoloSaravanan@proton.me>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e3946f7b736e..aadab04c7456 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -618,6 +618,9 @@ static const struct usb_device_id quirks_table[] =3D {
 =09{ USB_DEVICE(0x0e8d, 0x0608), .driver_info =3D BTUSB_MEDIATEK |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH |
 =09=09=09=09=09=09     BTUSB_VALID_LE_STATES },
+=09{ USB_DEVICE(0x13d3, 0x3606), .driver_info =3D BTUSB_MEDIATEK |
+=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH |
+=09=09=09=09=09=09     BTUSB_VALID_LE_STATES },
=20
 =09/* MediaTek MT7922A Bluetooth devices */
 =09{ USB_DEVICE(0x0489, 0xe0d8), .driver_info =3D BTUSB_MEDIATEK |
--=20
2.45.0


