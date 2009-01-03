Return-Path: <cyrus@holtmann.org>
Subject: Works in 2.6.26, broken in 2.6.27 & 2.6.28 [WAS: Re: bnep module
 in 2.6.27 fails to provide bnep0 device]
From: Mick Semb Wever <mick@semb.wever.org>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1230983567.6118.25.camel@localhost>
References: <1230983567.6118.25.camel@localhost>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-SrsmjCgWl1vmaoEbkgoR"
Date: Sat, 03 Jan 2009 16:06:09 +0100
Message-Id: <1230995170.10252.7.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-SrsmjCgWl1vmaoEbkgoR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I'm using the following combination on gentoo:
>=20
>  linux-2.6.27 (64-bit)
>  bluez-libs-3.36
>  bluez-utils-3.36

The problem exists the same after an upgrade to kernel-2.6.28

Downgrading to 2.6.26 everything works well.
The same environment is being used so the userspace seems not at fault.

Working on 2.6.26 gives the kernel logging:

[pand] Bluetooth PAN daemon version 3.36
[pand] Connecting to 00:19:63:14:8C:6C
[hcid] link_key_request (sba=3D00:10:60:D1:7C:31, dba=3D00:19:63:14:8C:6C)
[pand] bnep0 connected
[ifplugd(bnep0)] ifplugd 0.28 initializing.
[ifplugd(bnep0)] Using interface bnep0/00:10:60:D1:7C:31
[ifplugd(bnep0)] Using detection mode: IFF_RUNNING
[ifplugd(bnep0)] Initialization complete, link beat detected.
[ifplugd(bnep0)] Executing '/etc/ifplugd/ifplugd.action bnep0 up'.
[dhcpcd] bnep0: dhcpcd 4.0.7 starting
[ifplugd(bnep0)] client: bnep0: dhcpcd 4.0.7 starting
[dhcpcd] bnep0: broadcasting for a lease
[ifplugd(bnep0)] client: bnep0: broadcasting for a lease
[dhcpcd] bnep0: offered 89.8.70.95 from 89.8.70.93
 ...etc etc from a working connection...


~mck

--=20
"Do or do not there is no try." Yoda=20
| semb.wever.org | sesat.no | sesam.no |

--=-SrsmjCgWl1vmaoEbkgoR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklffuEACgkQkdPrePiuutPPCACeIvSfDX3g1hsD6kCczws/ocCE
+TkAoLFN/Ry16eWhkCoP5J0mCdIwfgm0
=0H9Y
-----END PGP SIGNATURE-----

--=-SrsmjCgWl1vmaoEbkgoR--

