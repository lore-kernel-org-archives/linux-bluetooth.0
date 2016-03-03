Return-Path: <jerome.debretagne@gmail.com>
MIME-Version: 1.0
In-Reply-To: <187A08C2-4D49-4B28-9FCD-6E94BF9AD4F0@holtmann.org>
References: <CA+kEDGHWraudGyTcj9Og+hNKH2kCwFB7P7qvjQhTvQNCXfPOLw@mail.gmail.com>
	<187A08C2-4D49-4B28-9FCD-6E94BF9AD4F0@holtmann.org>
Date: Thu, 3 Mar 2016 02:58:53 +0100
Message-ID: <CA+kEDGGzDny1fy5wCMOY6oPPpuAw7FYq-+s4WknvDN2gfX7gVg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Add BCM2E55 ACPI ID used in Lenovo
 ThinkPad Tablet 8
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I sent the second one actually with git send-email (when I saw the
tabs being garbled in the first one, sorry about that).

Was the second one garbled as well? If that's the case, that's weird
and I will see how I can change my setup.

Regards,
J=C3=A9r=C3=B4me


Le 3 mars 2016 02:41, "Marcel Holtmann" <marcel@holtmann.org> a =C3=A9crit =
:
>
> Hi Jerome,
>
> > Lenovo ThinkPad Tablet 8 with BCM43241 rev B5 chipset uses the BCM2E55
> > ACPI ID for Bluetooth. Add it to the list of supported devices.
> >
> > Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.co=
m>
> > ---
> > drivers/bluetooth/hci_bcm.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> > index bb4c5a0..d8881dc 100644
> > --- a/drivers/bluetooth/hci_bcm.c
> > +++ b/drivers/bluetooth/hci_bcm.c
> > @@ -821,6 +821,7 @@ static const struct acpi_device_id bcm_acpi_match[]=
 =3D {
> >     { "BCM2E3F", 0 },
> >     { "BCM2E40", 0 },
> >     { "BCM2E54", 0 },
> > +    { "BCM2E55", 0 },
> >     { "BCM2E64", 0 },
> >     { "BCM2E65", 0 },
> >     { "BCM2E67", 0 },
>
> you need to use an email client or git send-email which does not garble u=
p the patch.
>
> Regards
>
> Marcel
>
