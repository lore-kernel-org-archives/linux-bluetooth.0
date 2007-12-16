Return-Path: <cyrus@holtmann.org>
From: =?ISO-8859-1?Q?M=EDla?= Kuchta <kuchta@geeks.cz>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1197299329.5651.6.camel@intel>
References: <1197299329.5651.6.camel@intel>
Date: Sun, 16 Dec 2007 23:43:38 +0100
Message-Id: <1197845028.9067.1.camel@intel>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Usage of network service
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0053444275=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0053444275==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2OmiSI2bPFvZzwVysKOU"


--=-2OmiSI2bPFvZzwVysKOU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm quite suprised that no one is using PAN network service...

On Po, 2007-12-10 at 16:08 +0100, M=C3=ADla Kuchta wrote:
> Hello,
>=20
> I've been using bluetooth PAN using pand daemon. Pand runs as a daemon
> and used to create network interface on demand calling dev-up and
> dev-down script which in turn runs ifup and ifdown to setup the device.
>=20
> In newer version of bluez, it's preffered to use network service, but I
> haven't found any documentation describing the process of creating and
> setting up the device.
>=20
> It is right that network service creates device and calls upon them
> ifup/ifdown or does some dbus (HAL, NetworkManager) magic?
>=20
> Regards
>=20
> Mila
> -------------------------------------------------------------------------
> SF.Net email is sponsored by:
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________ Bluez-users mailing list =
Bluez-users@lists.sourceforge.net https://lists.sourceforge.net/lists/listi=
nfo/bluez-users

--=-2OmiSI2bPFvZzwVysKOU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZaoZB/h+xQ5W7PoRAmCqAJ4hZwYQfMmLLRUHAKsf+8+Q/cxexgCfctC1
V1ExycUhQqoaJS3mct9vqww=
=4UxC
-----END PGP SIGNATURE-----

--=-2OmiSI2bPFvZzwVysKOU--



--===============0053444275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0053444275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0053444275==--
