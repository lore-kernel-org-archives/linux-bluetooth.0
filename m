Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80856188717
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212475; cv=none; b=co7Em+/0qHifRNByiVUCL8yb3wkZe2umTMGj+tEtMc4fCt977fCHDa5kpuycpRfWIoeBNapezh1/tNsKg5XGp3oOqnb4XFVWG7hrNpgmXCVMyINJkbSzGEtordY7NIww7tDp4rXvrLA6kawjYKQUt/qz4i1qN9gELSAfHI5D1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212475; c=relaxed/simple;
	bh=6mFh8aWcmnOx3PFe9wnRnr6usTVWmUmEg15Hs+YLvuM=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NnOctTROxl5LkHj8UXDqnrdpBQyaXMWA89AUe6GTSHZGEZ2Q1Glke7gXPyeymIrtuNNFX0GehSAoJfdZzNcrFT0mZ8KykjI2BnQ/cJmH637hR21LjK3peV6M1QUg4ff8RHXC5ASeHC/m5jUfvziUINhjjFPl0VBsmD5M6rc/2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=zXxHufkU; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="zXxHufkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1732212471; x=1732471671;
	bh=r2xvjAwO29eEItBGYM5V6kOh2AA0Ww/PkWx4bG2QwHU=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=zXxHufkUZ1/70iPa3GDVQettmMR+C7MhlxAfe55Pkr/Rfh+0f7dstce9jzyN5g1xR
	 b2t0gtJBsNW4pUcgz7Q6VQzQkWFnjEeYTpqcf2FTlNhdwumt5O2FFBQueO2efcA5iO
	 Ejqtb4vmWtPF9VQAGbkZTZkHF8qzGdSrl7jwnodn/5QRJ8A2bAeZzmHmTYLKCTXfXU
	 E+BxmfOmVBgEuGhE6scUxbaKdwtQO5bQRceA+dyNl3slkx+3+E8WDU2jvDzkAlKH+m
	 8RDAhE04gAT+bCpkEmwMFZl6vmXBTMEApqLEXC5h+gac0ThXcZgpBsYDn8bfvOPDEC
	 LLsGUmzDVGnHQ==
Date: Thu, 21 Nov 2024 18:07:46 +0000
From: Gregoire Stein <greyxor@protonmail.com>
Cc: greyxor@protonmail.com, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add one more ID 0x0489:0xe10a for Qualcomm WCN785x
Message-ID: <20241121180742.156230-1-greyxor@protonmail.com>
Feedback-ID: 1917010:user:proton
X-Pm-Message-ID: c4ffef790b6f5c2606d9c24de641d8bed20764df
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add an additional entry with ID (0x0489, 0xe10a) to the usb_device_id
table to support the Qualcomm WCN785x.
The device information from /sys/kernel/debug/usb/devices is provided below=
:

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D04 Cnt=3D01 Dev#=3D  2 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0489 ProdID=3De10a Rev=3D 0.01
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
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
I:  If#=3D 1 Alt=3D 7 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  65 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  65 Ivl=3D1ms

Signed-off-by: Gregoire Stein <greyxor@protonmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..506e9d30111f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -375,6 +375,8 @@ static const struct usb_device_id quirks_table[] =3D {
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 =09{ USB_DEVICE(0x0489, 0xe0f3), .driver_info =3D BTUSB_QCA_WCN6855 |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
+=09{ USB_DEVICE(0x0489, 0xe10a), .driver_info =3D BTUSB_QCA_WCN6855 |
+=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 =09{ USB_DEVICE(0x13d3, 0x3623), .driver_info =3D BTUSB_QCA_WCN6855 |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
=20
--=20
2.47.0


