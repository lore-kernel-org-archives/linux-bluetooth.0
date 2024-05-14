Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BCA64CCC;
	Tue, 14 May 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681302; cv=none; b=ARBOJRmpSfxF2GhMxgibbKwz2OXfU7NuR9VQQoTRUCI19yD/90KXH/cdBvYrH2YghtYUFPbmCutrA8IsAObcF6tV+UjyP1z17dJFzDs2Kuncl+npCEATf4nLJn1Zg3nPZ/OodEj0PEFNJFRX9roYYUJzPGOOo0D9tGNLS+S00ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681302; c=relaxed/simple;
	bh=QyKYD3PwPSFlPeTWf1A6/mdsJu/IVZlMnqS0/afEXBA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=huUI9fyTh5yHg44kXyQsULDqS/RtId4bQbvnWf9OMTPJYpmc0zxaEaCIUFwfut/T/MayGZ7ilt4XrPbDeJXpoMGYzXGcDPC38Z6TkB5k4SAO1I3lr4qTiI1TF/mKF3E90nH/zXU29mhOj3GgBD+mwxA7fd/cPUXD4ucE8ycHRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IkZtOLmk; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IkZtOLmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1715681292; x=1715940492;
	bh=pDQ/GZuN6/xzmKr4VIr850YYvdaKXfcBGi96KdzKmCs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IkZtOLmkcBx1CuMDvnT4u5THBvtDjLxi5uL5N9xM3lWpy/X2S6Lau3LNPzfodDras
	 zIJexQyRrWhfd+fWQPANY4nsrYGZ3FoL38tEwMU/KEVQjJvZNRGlk69yokNgiW8lPG
	 /NIbM289FXLpq9ltjROYy2nYFgwKzLT6GmOPY0qSx/hCeXZqYptHDmRwECp+5EuY5B
	 uhnrNd8UKvsoFHsrAGOx0r3Jgx2N32cg+LPG5QyGl530fsKk6Z4YpYANtu1C1xi0nj
	 9fYlnRcB+wReQj3vmz6CXdgLm3WRBSdXPdDBu56XYEmvACli58kuiaK4P4Gz8wBMMa
	 mI+Ae52wWREBQ==
Date: Tue, 14 May 2024 10:08:06 +0000
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
From: "SoloSaravanan@proton.me" <SoloSaravanan@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: Add device 13d3:3606 as MT7921 device
Message-ID: <JXwMChGqaA3oLmTz9wy26FlzjhHGqOWSO0HRbgYAeoy7jX3jcAaHmbwR6Dl-aMdkPzhdHO_kgV4MqoYahTdhn39W_GCOo-GbP1kU0C6kx2o=@proton.me>
Feedback-ID: 84438951:user:proton
X-Pm-Message-ID: a01415225bb1c36746ba7ebddec821c4357c5703
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From 6c5cec6d7a84c140958786bcb082d94f1b147ece Mon Sep 17 00:00:00 2001
From: SoloSaravanan <SoloSaravanan@proton.me>
Date: Tue, 14 May 2024 15:01:29 +0530
Subject: [PATCH] Bluetooth: btusb: Add device 13d3:3606 as MT7921 device

Add VendorID 13d3 & ProdID 3606 for MediaTek MT7921 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth device=
 is listed as the below.

T: Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D09 Cnt=3D03 Dev#=3D 4 Spd=3D480 MxCh=
=3D 0 D: Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D =
1 P: Vendor=3D13d3 ProdID=3D3606 Rev=3D 1.00
S: Manufacturer=3DMediaTek Inc.
S: Product=3DWireless_Device
S: SerialNumber=3D000000000
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
A: FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 I:* If#=3D=
 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3Dbtusb E: =
Ad=3D81(I) Atr=3D03(Int.) MxPS=3D 16 Ivl=3D125us
E: Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E: Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 0 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 0 Ivl=3D1ms
I: If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 9 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 9 Ivl=3D1ms
I: If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms
I: If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 25 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 25 Ivl=3D1ms
I: If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1ms
I: If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 49 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 49 Ivl=3D1ms
I: If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 63 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 63 Ivl=3D1ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E: Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 64 Ivl=3D125us
E: Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 64 Ivl=3D125us
I: If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
(none)
E: Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
E: Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us

Signed-off-by: SoloSaravanan <SoloSaravanan@proton.me>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index effa54629..65e4b7fc6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -615,6 +615,9 @@ static const struct usb_device_id quirks_table[] =3D {
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


