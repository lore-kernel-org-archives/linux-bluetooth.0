Return-Path: <pomac@vapor.com>
Subject: Re: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
From: Ian Kumlien <pomac@vapor.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095881187.6223.108.camel@pegasus>
References: <1095807044.3211.9.camel@big> <1095842833.5762.27.camel@pegasus>
	 <1095877600.3211.15.camel@big>  <1095877744.6223.88.camel@pegasus>
	 <1095877955.3211.18.camel@big>  <1095878303.6223.93.camel@pegasus>
	 <1095878969.3211.23.camel@big>  <1095879167.6223.104.camel@pegasus>
	 <1095880805.3277.4.camel@big>  <1095881187.6223.108.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7fGdaTQnTITMDNSsO6hV"
Message-Id: <1095889873.3157.2.camel@big>
Mime-Version: 1.0
Date: Wed, 22 Sep 2004 23:51:13 +0200
List-ID: <bluez-devel.lists.sourceforge.net>


--=-7fGdaTQnTITMDNSsO6hV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-22 at 21:26, Marcel Holtmann wrote:
> This looks really like an ohci_hcd problem with interrupt URBs.

The reply i received:
Error -28 is -ENOSPC, which means the USB bandwidth was exhausted.  Too=20
many devices were plugged into the same controller.  Unplugging some of=20
the other devices ought to help.  Or even plugging the BT controller
into one of the other ports rather than the external high-speed hub,
since it is only a full-speed device.

Alan Stern
---

Then i moved the usb dongle around in the newly discovered 2 usb
ports...and suddenly it worked (only in one of the two usb ports though)
and now i'm not touching it! =3D)

Thanks for all the help =3D)
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-7fGdaTQnTITMDNSsO6hV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUfPQ7F3Euyc51N8RAjXGAJ9512vmrTWdjNqdaQjfdVeYIfy1ugCePAPk
5USETaj4AeRFPPoTuqKdtZY=
=AZ4B
-----END PGP SIGNATURE-----

--=-7fGdaTQnTITMDNSsO6hV--
