Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E51202F80
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510301; cv=none; b=CmHRLAhQB0oss6iadftJdjIglSdAFq7EHgkVj3Mpg9zr0o3flN25Q4syLL6Gq4lxxruQklmyF9O8SVYV35GqBwwfSgMpbLq/rS6qgUZRWLJ8/7vOLUUnRb6aoqtXdBdFUsV6skcp9rBHhmK++GljomuHGJVPmTnqV3Q+yZ72BNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510301; c=relaxed/simple;
	bh=aUIKdRCT9EsRGQCw/Bp6jXWF7Al3H/ffV1VFwnvuGlU=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=qTTbzGLaHLceqefLU4AQMQnTOjwJ8BevGvikzj9fGwKHBB2/T2fz6mBewB/rrQ0XNvJQR5Knt8zfBpzbZwMbaM2mv+wISXsLGXwaUV1ecuomXCrexdAmzA5U0zTL2NLIrQECuTH+0FvgO4xWwdcAWh6dP8+jAyqo2eF+bGNNoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melois.dev; spf=pass smtp.mailfrom=melois.dev; dkim=pass (2048-bit key) header.d=melois.dev header.i=@melois.dev header.b=QrTLbP9b; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melois.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melois.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melois.dev header.i=@melois.dev header.b="QrTLbP9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=melois.dev;
	s=protonmail2; t=1743510280; x=1743769480;
	bh=c8sTvbnI2NNk0RiAZ56AVzN48KLDHhMBgXR2F0rxwJA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=QrTLbP9b9f8BP8v5KiS9OkZCrCmKIl69qJzdfs1B7r881sesbqHR8TzI75NfloYix
	 2IxMeAWP8o2n32SIq2r29flTTmfSrjPUUBXsiD5LM2VaFpudbXmnV8S7JHT56eFHwO
	 Y8efbFUfcOWdwsRlWB/ToNUOnjlulhkCF6303vs7HEYNrt7JXB+SRptMihnwdWAm30
	 E8LCn9rawT1YXFnXUqzYKM0dLrTY/siFYnmSBcCE8jdhSPa3mdgg2Hy77TVrbi94hm
	 ssNTG1JmiiE7llI+tg0D0XpQC3hqG6vlmJaFAKD7hOVLDkFHY/iK0rlJ17ZS7ffvf0
	 K6iRkJl/fiYjg==
Date: Tue, 01 Apr 2025 12:24:35 +0000
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?utf-8?Q?Youn_M=C3=89LOIS?= <youn@melois.dev>
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3613 for MT7925
Message-ID: <TV5EwAth53CPjyEfnDT-hesfQb45wew-qCxhVuZeUL6oUcviiJ9nz83ctko6izmh6X1-O0pphWqltS2XToK2Pj2skYkWLPJ5a210TtQbYJ8=@melois.dev>
Feedback-ID: 38205484:user:proton
X-Pm-Message-ID: c329f63f07942d47e0f82b65915df4c1a5a88e32
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add VID 13d3 & PID 3613 for MediaTek MT7925 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D02 Cnt=3D01 Dev#=3D  4 Spd=3D480  Mx=
Ch=3D 0
D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D13d3 ProdID=3D3613 Rev=3D 1.00
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

Signed-off-by: Youn Melois <youn@melois.dev>

---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -716,6 +716,8 @@ static const struct usb_device_id quirks_table[] =3D {
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 =09{ USB_DEVICE(0x13d3, 0x3608), .driver_info =3D BTUSB_MEDIATEK |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
+=09{ USB_DEVICE(0x13d3, 0x3613), .driver_info =3D BTUSB_MEDIATEK |
+=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 =09{ USB_DEVICE(0x13d3, 0x3628), .driver_info =3D BTUSB_MEDIATEK |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 
