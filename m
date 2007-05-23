Return-Path: <twaugh@redhat.com>
Subject: Re: [Bluez-devel] CUPS plugin discovery bits
From: Tim Waugh <twaugh@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1179935471.19944.6.camel@aeonflux.holtmann.net>
References: <1179933855.3629.75.camel@cookie.hadess.net>
	 <1179935471.19944.6.camel@aeonflux.holtmann.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3KMxXl/jrv2AN45hqAMc"
Date: Wed, 23 May 2007 16:57:07 +0100
Message-Id: <1179935827.4854.17.camel@cyberelk.elk>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>


--=-3KMxXl/jrv2AN45hqAMc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-23 at 17:51 +0200, Marcel Holtmann wrote:
> The thing that worries me is when you start CUPS it will list through
> all backends and make them list. So on every boot the system will scan
> for devices in range and that can slow down the system boot. So this
> might not be a good idea. Actually that is the reason why we wanna go
> for a printing service in the future.

This hasn't been true since CUPS 1.1.x.  In CUPS 1.2.x device discovery
is performed on demand.

Tim.
*/


--=-3KMxXl/jrv2AN45hqAMc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGVGRQFLeBZ6VVmn8RAsyUAJ9lAnOV9sBxHtZY3GgHtgJkJWQyNgCfbCrY
3wZAmKgb+jCxs/AC5nFWltQ=
=fJw9
-----END PGP SIGNATURE-----

--=-3KMxXl/jrv2AN45hqAMc--
