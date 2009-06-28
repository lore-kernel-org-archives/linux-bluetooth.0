Return-Path: <cyrus@holtmann.org>
Subject: Re: [SOLUTION] Works in 2.6.26, broken in 2.6.27 & 2.6.28 [WAS:
 Re: bnep module in 2.6.27 fails to provide bnep0 device]
From: Mck <mick@semb.wever.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1230995170.10252.7.camel@localhost>
References: <1230983567.6118.25.camel@localhost>
	 <1230995170.10252.7.camel@localhost>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Vr45FuMFvLdgqYHZwSWT"
Date: Sun, 28 Jun 2009 20:40:47 +0200
Message-Id: <1246214448.20464.26.camel@localhost.localdomain>
Mime-Version: 1.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Vr45FuMFvLdgqYHZwSWT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > I'm using the following combination on gentoo:
> >=20
> >  linux-2.6.27 (64-bit)
> >  bluez-libs-3.36
> >  bluez-utils-3.36
>=20
> The problem exists the same after an upgrade to kernel-2.6.28
>=20
> Downgrading to 2.6.26 everything works well.
> The same environment is being used so the userspace seems not at
> fault.

Ok, 6 months down the track i lose my phone and buy a new Sony Ericsson
C901. I get the same behaviour but have found by luck a work around.

If i "Browse files on device..." (using gnome's bluetooth-applet) and
connect to my phone (creating a obex connection) then run
pand -c <bdaddr>

everything works fine, and it played well with NetworkManager.


The successful system log looked like:

> Jun 25 15:30:31 [pand] Connecting to 00:25:E7:0D:5E:6D
> Jun 25 15:30:32 [pand] bnep0 connected
> Jun 25 15:30:32 [NetworkManager] <info>  (bnep0): driver 'btusb' does not=
 support carrier detection.__You must switch to it manually._
> Jun 25 15:30:32 [NetworkManager] <info>  (bnep0): new Ethernet device (dr=
iver: 'btusb')_
> Jun 25 15:30:32 [NetworkManager] <info>  (bnep0): exported as /org/freede=
sktop/Hal/devices/net_00_03_7a_dc_47_18_
> Jun 25 15:30:37 [NetworkManager] <info>  (bnep0): device state change: 1 =
-> 2_
> Jun 25 15:30:37 [NetworkManager] <info>  (bnep0): bringing up device._
> Jun 25 15:30:37 [NetworkManager] <info>  (bnep0): preparing device._
> Jun 25 15:30:37 [NetworkManager] <info>  (bnep0): deactivating device (re=
ason: 2)._
> Jun 25 15:30:37 [NetworkManager] <info>  (bnep0): device state change: 2 =
-> 3_
> Jun 25 15:30:37 [nm-system-settings] Added default wired connection 'Auto=
 bnep0' for /org/freedesktop/Hal/devices/net_00_03_7a_dc_47_18
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) starting conn=
ection 'Auto bnep0'_
> Jun 25 15:30:37 [NetworkManager] <info>  (bnep0): device state change: 3 =
-> 4_
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 1 of 5 =
(Device Prepare) scheduled..._
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 1 of 5 =
(Device Prepare) started..._
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 2 of 5 =
(Device Configure) scheduled..._
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 1 of 5 =
(Device Prepare) complete._
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 2 of 5 =
(Device Configure) starting..._
> Jun 25 15:30:37 [NetworkManager] <info>  (bnep0): device state change: 4 =
-> 5_
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 2 of 5 =
(Device Configure) successful._
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 3 of 5 =
(IP Configure Start) scheduled._
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 2 of 5 =
(Device Configure) complete._
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 3 of 5 =
(IP Configure Start) started..._
> Jun 25 15:30:37 [NetworkManager] <info>  (bnep0): device state change: 5 =
-> 7_
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Beginning DHC=
P transaction._
> Jun 25 15:30:37 [NetworkManager] <info>  dhcpcd started with pid 20383_
> Jun 25 15:30:37 [NetworkManager] <info>  Activation (bnep0) Stage 3 of 5 =
(IP Configure Start) complete._
> Jun 25 15:30:37 [dhcpcd] bnep0: dhcpcd 4.0.13 starting
> Jun 25 15:30:37 [NetworkManager] <info>  DHCP: device bnep0 state changed=
 normal exit -> preinit_
> Jun 25 15:30:37 [dhcpcd] bnep0: broadcasting for a lease
> Jun 25 15:30:37 [dhcpcd] bnep0: offered ... from 10.252.177.241
> Jun 25 15:30:37 [dhcpcd] bnep0: acknowledged ... from 10.252.177.241
> Jun 25 15:30:37 [dhcpcd] bnep0: checking ... is available on attached net=
works
> Jun 25 15:30:42 [dhcpcd] bnep0: leased ... for 300 seconds
> Jun 25 15:30:42 [NetworkManager] <info>  DHCP: device bnep0 state changed=
 preinit -> bound_
> Jun 25 15:30:42 [NetworkManager] <info>  Activation (bnep0) Stage 4 of 5 =
(IP Configure Get) scheduled..._
> Jun 25 15:30:42 [NetworkManager] <info>  Activation (bnep0) Stage 4 of 5 =
(IP Configure Get) started..._
> Jun 25 15:30:42 [NetworkManager] <info>    address ..._
> Jun 25 15:30:42 [NetworkManager] <info>    prefix 29 (255.255.255.248)_
> Jun 25 15:30:42 [NetworkManager] <info>    gateway 10.252.177.243_
> Jun 25 15:30:42 [NetworkManager] <info>    nameserver '212.169.123.67'_
> Jun 25 15:30:42 [NetworkManager] <info>    nameserver '212.45.188.254'_
> Jun 25 15:30:42 [NetworkManager] <info>  Activation (bnep0) Stage 5 of 5 =
(IP Configure Commit) scheduled..._
> Jun 25 15:30:42 [NetworkManager] <info>  Activation (bnep0) Stage 4 of 5 =
(IP Configure Get) complete._
> Jun 25 15:30:42 [NetworkManager] <info>  Activation (bnep0) Stage 5 of 5 =
(IP Configure Commit) started..._
> Jun 25 15:30:43 [NetworkManager] <info>  (bnep0): device state change: 7 =
-> 8_
> Jun 25 15:30:43 [NetworkManager] <info>  Policy set 'Auto bnep0' (bnep0) =
as default for routing and DNS._
> Jun 25 15:30:43 [NetworkManager] <info>  Activation (bnep0) successful, d=
evice activated._
> Jun 25 15:30:43 [NetworkManager] <info>  Activation (bnep0) Stage 5 of 5 =
(IP Configure Commit) complete._

~mck

--=20
"Some husbands are living proof that a woman can take a joke."=20
| semb.wever.org | sesat.no | finn.no |

--=-Vr45FuMFvLdgqYHZwSWT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkpHuS8ACgkQkdPrePiuutOcsACeIbLetShHVVNZyVfFjMayzUEt
DK8AoMT0KMgoYMnL2Cw+s1FM5C4i/kXm
=iooi
-----END PGP SIGNATURE-----

--=-Vr45FuMFvLdgqYHZwSWT--
