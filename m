Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: andy@beuth.info
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multisync Bluetooth No devices
Message-ID: <20040811083602.GA12856@puck.ch>
References: <1092127580.9886.56.camel@goya> <1092127904.4564.79.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <1092127904.4564.79.camel@pegasus>
From: Olivier Bornet <Olivier.Bornet@puck.ch>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 11 Aug 2004 10:36:02 +0200


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> > I run debian unstable with kernel 2.6.7 and mh4 from Marcel Holtmann
> > (thanx). My problem is the following. By booting my pc i got the message
> > No devices in HCI mode found.
> > The Bluetooth Button in the "Connect with" selection is only grey.
> > Any Idea??
>=20
> the Multisync package maintainer linked the Bluetooth plugin against the
> libsdp which is no longer present. File a Debian bug report, because
> this is not a BlueZ problem.

Now, the new libmultisync-plugin-irmc-bluetooth version 0.82-3 is
working as expected with libbluetooth1 2.9-1.

So, try to update/upgrade your system now, and it must works.

Good day.

		Olivier
--=20
Olivier Bornet                |    fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results      |    english  : http://puck.ch/e
http://puck.ch/               |    deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch        |    italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://pgp.mit.edu/

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGdpydj3R/MU9khgRAtT8AKDD9T6IHDVZfMVXgsfkVp2EtGOPEACeI9M8
jFI/fSKPFDsxHMHXT/6GH8c=
=dNmx
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
