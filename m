Return-Path: <Richard.Williams@VITRONICS.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-devel] BNEP kernel oops
Date: Fri, 13 Aug 2004 15:12:13 -0400
Message-ID: <A1F0D47583A2D711919F00600819B3A4028BB9@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
List-ID: <bluez-devel.lists.sourceforge.net>

Thank you Marcel,

I had been using PAN with a 2.4.19 kernel on my embedded system, and =
this worked somewhat.=20
I could usually get the PAN up and running but I'd get a kernel panic =
after a few minutes.=20
Since my group had lots of other application problems, we decided to =
concentrate the group=20
effort to correct all our applications problems. Now our system is quite =
stable and we have=20
many BT devices connected and sending/receiving data via rfcomm. But we =
want to have PAN=20
running so we can use some common TCP applications.

Last week a 2.4.26 kernel became available for my embedded board, so I =
upgraded to 2.4.26,=20
and today I decided to look at PAN again. I tried plain 2.4.26 this =
morning, with the oops
behavior.=20

It was then that I discovered the 2.4.26-mh2 patch, applied the patch =
and retried.=20
But the same thing happens.

If you think it will help, I can try the 2.4.26-mh1 patch and give you =
the results.

Thank you, regards,

Rich

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Friday, August 13, 2004 2:55 PM
To: Williams, Richard
Cc: Bluez-Devel (E-mail)
Subject: Re: [Bluez-devel] BNEP kernel oops


Hi Richard,

> I am developing an application for a single board computer running an =
X-scale processor with a BT dongle in the USB port.=20
>=20
> I have the following:
> Linux 2.4.26, with the patch-2.4.26-mh2.gz patch applied.=20
> bluez-libs-2.8
> bluez-utils-2.8
>=20
> I've cross-compiled all this for the X-scale and everything seems to =
work OK for rfcomm connections.=20
> However as soon as I try to create a PAN connection to a remote =
device, I get a kernel panic.=20
> The remote device is an iPAQ 5550 with built-in BT, running OPIE. The =
iPAQ does not crash.

verify if a previous kernel (2.4.26-mh1 or 2.4.26) worked without a
kernel oops.

Regards

Marcel
