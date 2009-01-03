Return-Path: <cyrus@holtmann.org>
Subject: bnep module in 2.6.27 fails to provide bnep0 device
From: Mick Semb Wever <mick@semb.wever.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-IokPgmRJh5hc5DZtKhIW"
Date: Sat, 03 Jan 2009 12:52:47 +0100
Message-Id: <1230983567.6118.25.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-IokPgmRJh5hc5DZtKhIW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


This used to work for me but after some system updates is now broken.

I'm using the following combination on gentoo:

 linux-2.6.27 (64-bit)
 bluez-libs-3.36
 bluez-utils-3.36

Restarting bluetooth, with the usb bluetooth dongle in, gives in the
system log:

[hcid] Bluetooth HCI daemon
[hcid] Parsing /etc/bluetooth/main.conf failed: No such file or directory
[hcid] Starting SDP server
[hcid] Unix socket created: 11
[hcid] Registered manager path:/org/bluez/audio
[hcid] Registered input manager path:/org/bluez/input
[hcid] Starting experimental netlink support
[kernel] pan0: Dropping NETIF_F_UFO since no NETIF_F_HW_CSUM feature.
[hcid] Failed to find Bluetooth netlink family
[hcid] Can't init plugin /usr/lib64/bluetooth/plugins/netlink.so
[hcid] bridge pan0 created
[hcid] Registered manager path:/org/bluez/network
[hcid] Registered server path:/org/bluez/network/nap
[hcid] Registered server path:/org/bluez/network/gn
[hcid] Registered server path:/org/bluez/network/panu
[hcid] Registered manager path:/org/bluez/serial
[hcid] HCI dev 0 registered
[hcid] HCI dev 0 already up
[hcid] Device hci0 has been added
[hcid] Starting security manager 0
[hcid] Device hci0 has been activated


Then running "pand -c XX" I get:

[pand] Connecting to 00:19:63:14:8C:6C
[hcid] link_key_request (sba=3D00:10:60:D1:7C:31, dba=3D00:19:63:14:8C:6C)
[pand] bnep0 connected
[/etc/init.d/net.bnep0] ERROR: interface bnep0 does not exist
[/etc/init.d/net.bnep0] Ensure that you have loaded the correct kernel modu=
le for your hardware
[/etc/init.d/net.bnep0] ERROR: net.bnep0 failed to start


It seems pand connects through the bnep0 device, and indeed the mobile
phone i'm connecting to registers the connection and itself connects to
the 3g network, but the kernel complains and the connection is quickly drop=
ped...

I have googled around without any luck at all.
The bnep module is definitely loaded, i have tried reloading it, and
restarting the system. And recompiling the kernel with modules built-in
instead.

I'm quite lost here and hoping anybody can help, or instruct what more
information is required.


~mck




ps this was original posted to http://gmane.linux.network which i
presumed, too late, is an advanced development list. I gather this is
the right list as it is the conglomeration of the previous bluez.users
and bluez.devel lists.

--=20
"Don't use Outlook. Outlook is really just a security hole with a small
e-mail client attached to it." Brian Trosko=20
| semb.wever.org | sesat.no | sesam.no |

--=-IokPgmRJh5hc5DZtKhIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklfUY8ACgkQkdPrePiuutM+xgCeLu0i6npDPOApopW6dhvrOwxY
N20An2GWzx4+id0tp/CgyMhjbznnVv5H
=mk3V
-----END PGP SIGNATURE-----

--=-IokPgmRJh5hc5DZtKhIW--

