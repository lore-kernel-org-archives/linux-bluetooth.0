Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6E5672
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732381125; cv=none; b=fRDA+vULYchz/zR33Fw114JzoxJPa3C2DQNrBP56O8o2FCKY1JlW1K8NtTQ1FyRc8UGs/U/EGoZM95v7QSb2gEHtArCngXmVzzeOoU38G/Hr/6IaHh4e3NrHtVmmZg1IeneqSO56fQdtB/FmEVbGE/6ICTTKENd/msAoa9WmH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732381125; c=relaxed/simple;
	bh=lZh8au3GgUHFd5SYRbsdoNhRVKFLdf23I0uMtUr3vpY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6taKrJFd972SSYi75Q4Bty93GiO01L2kjQ/Iy+ULT2I37fi8wb7A/jEN24sALfpTjqj1NqUfumijAV9HxUvVx7Da2og5kQVwVDAdsiTKtCTmaxixEdq34t+dz3hkc8dG3+0ez/8mxj/duMS+NuaT03w43GXyZxghpe+lyCdLAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ZZi5DNWl; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ZZi5DNWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732381121; x=1732640321;
	bh=18wYwsy2iTtZgmOD6ClW3YWSAVn+xA4heYWMurVhnO0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ZZi5DNWlRavVyxEbtc3pvc5SlEbO82uJeF3bnELaaluB66XfYujPjrgtHIDerEAp6
	 mP5WceEg8cSWDwodRPG5doLLJWFwqdp4m5b07+8HnkAUuayljWFRCY8EvTm9ToGqRa
	 MWRZTjyzQbsYfIVZCh6xlrxHiqFBVuABS+AVW/Lh/3AKtbgdYZT2jFBA/sDgSJguyD
	 99cXXV7wWdoV8gfBp9hYIUkosK00GqArjeeUxYzaQrj+nbwM1gMYG5yJCCBDS51r5t
	 +8l8qMoabWwLnz2RFAovaRuufvymnxrr6XMhER1ixWTpq5CP/U9gVFv77xwArzvxX6
	 2nN2O1xGUr3Rg==
Date: Sat, 23 Nov 2024 16:58:36 +0000
To: Paul Menzel <pmenzel@molgen.mpg.de>
From: Alan Jones <j.alan.jones@pm.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Ignore Nintendo Wii module
Message-ID: <YmE6ab0qsNOKuIKLLo7f4W6P5IRvkzcs4RiBTQHKMVE6RGfuBqFm6PRnA7mNFcwFjaO2h1K6BxxPTs5UtuTY4-m0TqFs9vaDAVWG61qwJZU=@pm.me>
In-Reply-To: <8e793382-f058-4f88-92b3-bb99b1deaffc@molgen.mpg.de>
References: <HMjPEtiPDMAaCAIwvxGbpGc-F-pWc_xtxbsY_c8hA6_BLJjW8UJYvD2Znd2q8P21P3O2C4kkrei1ISdn4wBT5FIxf6tO1lr3EVcaFmZJjv4=@pm.me> <20241122051947.716313-1-j.alan.jones@pm.me> <8e793382-f058-4f88-92b3-bb99b1deaffc@molgen.mpg.de>
Feedback-ID: 106914784:user:proton
X-Pm-Message-ID: 48f08ce2bb1a5dbae637c7ff5f154ebe08e6d700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Attempting on re-send via webportal: Thunderbird is chewing-up the reply-to=
 header. If this fails to thread I'll walk-away for a bit.


Here's what happens when the module is plugged in and I press a button=20
on a previously paired remote.

     [483044.866453] usb 3-4: new full-speed USB device number 47 using=20
xhci_hcd
     [483045.477740] usb 3-4: New USB device found, idVendor=3D057e,=20
idProduct=3D0305, bcdDevice=3D 1.00
     [483045.477749] usb 3-4: New USB device strings: Mfr=3D1, Product=3D2,=
=20
SerialNumber=3D0
     [483045.477754] usb 3-4: Product: BCM2045A
     [483045.477757] usb 3-4: Manufacturer: Broadcom Corp
     [483047.572500] Bluetooth: hci0: Opcode 0x0c14 failed: -110

Beyond this is gets weird. The version of weird depends on the next steps.
The Nintendo stack is almost, but not quite, entirely unlike Bluetooth.


The unique vendor and product IDs are a result of the firmware payload.
In the manufacturing manual for the component there's a note regarding=20
this (after firmware install):
     "USD Vender ID and product ID of nintendo module is not same as it=20
of Pre-write module."

Link:
https://fccid.io/MCLJ27H002/User-Manual/Users-Manual-721663.pdf


So in theory: yes, this would apply to all BCM2045 devices re-flashed=20
with Nintendo's firmware.
I don't know how feasible this actually is: to my knowledge it isn't=20
widely done.
In practice, hobbyists extract the Foxconn WML-C43 or Foxconn/Panasonic=20
J27H002 module from a Wii console and add the wiring to interface to a PC.

Example using a daughtercard adapter here:
https://www.abbiedoobie.com/product/bluetooth-passthrough-adapter/


Ack on requested changes; I'll send a follow-up

Alan


On Friday, November 22nd, 2024 at 12:29 AM, Paul Menzel <pmenzel@molgen.mpg=
.de> wrote:

>=20
>=20
> Dear Alan,
>=20
>=20
> Thank you for your patch.
>=20
> Am 22.11.24 um 06:20 schrieb Alan Jones:
>=20
> > The Nintendo Wii uses a BCM2045 module running proprietary firmware.
> > This adapter is typically managed by emulation software via the raw
> > interface, and is incompatible with standard Bluetooth devices.
> >=20
> > Attempting to initialize this adapter breaks synchronization with all
> > previously connected Wii Remotes, requiring applications to
> > re-synchronize the remotes on each usage.
> >=20
> > Fix Wii Remote re-synchronization issues with the official Nintendo Wii
> > Bluetooth module by ignoring this adapter.
>=20
>=20
> Out of curiosity, is anything logged by Linux?
>=20
> > Signed-off-by: Alan Jones j.alan.jones@pm.me
> > ---
> > drivers/bluetooth/btusb.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index e9534fbc92e3..11c9ea182ea4 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -185,6 +185,9 @@ static const struct usb_device_id quirks_table[] =
=3D {
> > /* Broadcom BCM2045 devices */
> > { USB_DEVICE(0x0a5c, 0x2045), .driver_info =3D BTUSB_BCM2045 },
> >=20
> > + /* Broadcom BCM2045 with Nintendo Wii firmware */
> > + { USB_DEVICE(0x057E, 0x0305), .driver_info =3D BTUSB_IGNORE },
>=20
>=20
> Could you please write the ids lowercase? Also, sort it above 0x0a5c?
>=20
> The comment above the existing entry suggests it=E2=80=99s for all BCM204=
5
> devices. Could you explain, where the difference in the vendor id comes
> from?
>=20
> > +
> > /* Atheros 3011 with sflash firmware */
> > { USB_DEVICE(0x0489, 0xe027), .driver_info =3D BTUSB_IGNORE },
> > { USB_DEVICE(0x0489, 0xe03d), .driver_info =3D BTUSB_IGNORE },
>=20
>=20
>=20
> Kind regards,
>=20
> Paul
