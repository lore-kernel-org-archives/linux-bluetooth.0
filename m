Return-Path: <hud@zurich.ibm.com>
From: dirk husemann <hud@zurich.ibm.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Renaming USB HID driver
Date: Mon, 29 Mar 2004 09:47:18 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>, Vojtech Pavlik <vojtech@suse.cz>,
   Greg Kroah-Hartman <greg@kroah.com>
References: <1079963694.2663.247.camel@pegasus>
In-Reply-To: <1079963694.2663.247.camel@pegasus>
Message-Id: <200403291047.19455.hud@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg="pgp-sha1"; boundary="Boundary-02=_XK+ZAfCZX8hpPlC"; charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>


--Boundary-02=_XK+ZAfCZX8hpPlC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 22 March 2004 14.54, Marcel Holtmann wrote to BlueZ Mailing List:
> Hi Folks,
>
> my plan is to move the HID parser out of the USB subsystem and provide a
> general HID parser implementation under drivers/hid/ which could then be
> used by the USB and the Bluetooth subsystem drivers. To avoid any naming
> conflict due and after the development I suggest to rename the USB HID
> module from hid.ko to usbhid.ko (see attached patch).
>
> I know that renaming a kernel module in a stable series is not a good
> idea, but doing it now will help us in the long term. However people
> which are using hotplug won't even notice it, because the kernel knows
> the right module name. And if the transition is finished we can simply
> remove the HID parser code from usbhid and everything will still work.

go for it...as to renaming kernel modules: the USB scanner module just=20
disappeared into thin air in the current 2.6 series (8=3D(()....so if that =
is=20
acceptable...

	cheers,
	dirk
=2D-=20
Dr Dirk Husemann, Mobile Computing, IBM Research, Zurich Research Lab
	hud@zurich.ibm.com --- http://www.zurich.ibm.com/~hud/
       PGP key: http://www.zurich.ibm.com/~hud/contact/PGP
  PGP Fingerprint: 983C 48E7 0A78 A313 401C  C4AD 3C0A 278E 6431 A149
	     Email only authentic if signed with PGP key.

Appended to this email is an electronic signature attachment. You can
ignore it if your email program does not know how to verify such a
signature. If you'd like to learn more about this topic, www.gnupg.org
is a good starting point.

--Boundary-02=_XK+ZAfCZX8hpPlC
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAZ+KXPAonjmQxoUkRAhaFAKCkHdp5VYm2pLkjEKwWC2MBuj139ACdH9Z3
3+sAAsgl0XYGUolUbSfuYxc=
=EAN9
-----END PGP SIGNATURE-----

--Boundary-02=_XK+ZAfCZX8hpPlC--
