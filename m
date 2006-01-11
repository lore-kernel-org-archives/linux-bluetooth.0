Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Developing a basic service for BlueTooth enabled
	devices
From: Stephen Crane <jscrane@maths.tcd.ie>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1136989762.3825.29.camel@localhost.localdomain>
References: <20060111093621.14949.qmail@web37008.mail.mud.yahoo.com>
	 <1136989762.3825.29.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Wmg2JxsFyInSEefwB9Lz"
Message-Id: <1137006621.7489.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 11 Jan 2006 19:10:21 +0000


--=-Wmg2JxsFyInSEefwB9Lz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello world,

On Wed, 2006-01-11 at 15:29 +0100, Marcel Holtmann wrote:
> > My first approach was to develep a web service with Apache for WAP
> > enabled  browsers that would run locally on each Linux server boxes
> > and serve WAP pages to the local ad-hoc mobile clients in order to
> > eliminate the client side development effort. However, it looks like
> > for many mobile devices I won't be able to do that. I have Motorola
> > RAZR V3 Java enabled phone at home and I could not do this by
> > establishing a piconet between my Kubuntu box and RAZR V3.=20
> >=20
> > What would be your suggestion? What kind of client/server platform
> > would ease the work on the client side ?
>=20
> I don't see easy way to avoid work on the client side. However the Java
> Bluetooth programming is not that big deal (RFCOMM channels only) from
> what I heard. I never did it and so I might be wrong.

JSR-82 (Java APIs for Bluetooth) provides access to L2CAP, RFCOMM and
OBEX. You don't get OBEX on Symbian OS v7.0s though. Quite a lot of
phones provide it these days.

Cheers,
Steve
--=20
Stephen Crane <jscrane@maths.tcd.ie>

--=-Wmg2JxsFyInSEefwB9Lz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDxVgdpsgfUm82ChQRAgyzAJ9zsVZh2iuQ52osOD88MxgvPAvUMwCfdSJ5
5FcN2uWQzlNBsvyz7cWNge0=
=yRNw
-----END PGP SIGNATURE-----

--=-Wmg2JxsFyInSEefwB9Lz--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
