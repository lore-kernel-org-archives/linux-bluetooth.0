Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jul 2010 14:48:27 +0200
From: Michal 'vorner' Vaner <vorner@ucw.cz>
To: linux-bluetooth@vger.kernel.org
Subject: Problem connecting headset with bluez >= 4.64
Message-ID: <20100712124827.GA3012@hydra.kolej.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

I have a bluetooth headset/headphones. However, I have a problem to connect=
 to
them on one of my machines (while other two machines work well). Downgradin=
g to
version 4.63 helps. In that case, bluetooth outputs something like this (th=
is is
for the HSP profile, the A2DP acts similarly):

bluetoothd[19610]: State changed /org/bluez/19610/hci0/dev_00_19_7F_1B_E8_B=
E: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
bluetoothd[19610]: link_key_request (sba=3D00:19:86:00:10:FE, dba=3D00:19:7=
F:1B:E8:BE)
bluetoothd[19610]: kernel auth requirements =3D 0x00
bluetoothd[19610]: stored link key type =3D 0x00
bluetoothd[19610]: adapter_get_device(00:19:7F:1B:E8:BE)
bluetoothd[19610]: Discovered Handsfree service on channel 1
bluetoothd[19610]: /org/bluez/19610/hci0/dev_00_19_7F_1B_E8_BE: Connecting =
to 00:19:7F:1B:E8:BE channel 1
bluetoothd[19610]: /org/bluez/19610/hci0/dev_00_19_7F_1B_E8_BE: Connected t=
o 00:19:7F:1B:E8:BE
bluetoothd[19610]: Received AT+BRSF=3D24
bluetoothd[19610]: HFP HF features: "Voice recognition activation" "Remote =
volume control"

Then, the headphones appear in pulseaudio as a sink and I can hear sound.

While, with 4.64 or anything newer, it outputs this:
bluetoothd[23165]: State changed /org/bluez/23165/hci0/dev_00_19_7F_1B_E8_B=
E: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
bluetoothd[23165]: link_key_request (sba=3D00:19:86:00:10:FE, dba=3D00:19:7=
F:1B:E8:BE)
bluetoothd[23165]: kernel auth requirements =3D 0x00
bluetoothd[23165]: stored link key type =3D 0x00
bluetoothd[23165]: adapter_get_device(00:19:7F:1B:E8:BE)
bluetoothd[23165]: Discovered Handsfree service on channel 1
bluetoothd[23165]: /org/bluez/23165/hci0/dev_00_19_7F_1B_E8_BE: Connecting =
to 00:19:7F:1B:E8:BE channel 1
bluetoothd[23165]: hcid_dbus_bonding_process_complete: status=3D00
bluetoothd[23165]: adapter_get_device(00:19:7F:1B:E8:BE)
bluetoothd[23165]: hcid_dbus_bonding_process_complete: no pending auth requ=
est # Here is really long pause, 1-2 seconds
bluetoothd[23165]: Function not implemented (38)
bluetoothd[23165]: State changed /org/bluez/23165/hci0/dev_00_19_7F_1B_E8_B=
E: HEADSET_STATE_CONNECTING -> HEADSET_STATE_DISCONNECTED

And nothing appears, no sound, etc.

The string "Function not implemented" is not present anywhere in bluez sour=
ces,
so it must come from something else, but I do not know what it is.

I tried bisecting the sources and it seems the problem is introduced in com=
mit
aee26b30bbc24cde464ba1a557c2b258ddec6432 "Make BtIO default security level
MEDIUM". When I compile version with all commits up to master except this o=
ne,
it works, so this confirms my problem comes from this commit.

A wild guess is that the machines differ in which adapter they have and that
this one does not support something needed for the medium level security. T=
he
adaptor is "OMEGA MICRO BT140", while the other two computers are laptops a=
nd
have some onboard usb connected adaptors (I do not know which ones). Is it
possible? If so, is there a possibility forcing bluez not using the
not-implemented function in a cleaner way than omitting the commit?

Thank you

--=20
Michal 'vorner' Vaner

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEARECAAYFAkw7DxsACgkQ7/oWwynB3bJE5ACfXmXHY3oPCW8yJ/QabdvsGQB8
zYMAmQEZPQjyGcatYPml6vsUKchtsais
=gVkc
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
