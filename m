Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Jul 2008 11:29:47 +0200
From: Matthias =?ISO-8859-1?Q?Bl=E4sing?=
	<matthias.blaesing@rwth-aachen.de>
Subject: Bluetooth audio and nokia HDW-3 do not work
To: linux-bluetooth@vger.kernel.org
Message-id: <1216632588.24708.9.camel@enterprise.glx>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-HgDKODQWmuCvey8HK9xN"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-HgDKODQWmuCvey8HK9xN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

I had a bluetooth headset (Nokia HDW-3)  running once (it was in the
times of btsco (I think the whole package was calles bluetooth-alsa). As
I understand bluetooth audio should be its successor. Ok - I tried it
and got nothing. I have the 0.36 Version of bluez installed (compiled
from the debian package).

This is the .asoundrc:

pcm.bluetooth {
   type bluetooth
   device 00:03:89:51:8F:12
   profile "voice"
}

ctl.bluetooth {
   type bluetooth
   device 00:03:89:51:8F:12
   profile "voice"
}

When I connect the headset and try to play sound from mplayer:

mplayer -ao alsa:device=3Dbluetooth <audio file>

I get these entries in syslog:

Jul 21 10:01:29 enterprise hcid[20068]: link_key_request (sba=3D00:03:7A:AA=
:A9:34, dba=3D00:03:89:51:8F:12)
Jul 21 10:01:30 enterprise hcid[20068]: link_key_notify (sba=3D00:03:7A:AA:=
A9:34, dba=3D00:03:89:51:8F:12)
Jul 21 10:01:38 enterprise hcid[20068]: Audio API: received BT_GETCAPABILIT=
IES_REQ
Jul 21 10:01:38 enterprise hcid[20068]: Audio API: sending BT_GETCAPABILITI=
ES_RSP
Jul 21 10:01:38 enterprise hcid[20068]: Audio API: received BT_SETCONFIGURA=
TION_REQ
Jul 21 10:01:38 enterprise hcid[20068]: config sco - device =3D 00:03:89:51=
:8F:12 access_mode =3D 2

Mplayer is frozen and when I try to stop mplayer (Control-C) it reports,
that it was interrupted in ao2_init (the name implies, that it didn't
send anything).

Trying to set the volume by using amixer leeds to a flood of the syslog
with these messages:

Jul 21 09:53:08 enterprise hcid[20068]: Audio API: sending BT_CONTROL_RSP
Jul 21 09:53:08 enterprise hcid[20068]: Audio API: received BT_CONTROL_REQ
Jul 21 09:53:08 enterprise hcid[20068]: Audio API: sending BT_CONTROL_RSP
Jul 21 09:53:08 enterprise hcid[20068]: Audio API: received BT_CONTROL_REQ
Jul 21 09:53:08 enterprise hcid[20068]: Audio API: sending BT_CONTROL_RSP
Jul 21 09:53:08 enterprise hcid[20068]: Audio API: received BT_CONTROL_REQ
Jul 21 09:53:08 enterprise hcid[20068]: Audio API: sending BT_CONTROL_RSP
Jul 21 09:53:08 enterprise hcid[20068]: Audio API: received BT_CONTROL_REQ
Jul 21 09:53:08 enterprise hcid[20068]: Audio API: sending BT_CONTROL_RSP

I really don't know where to look further - any help is appretiated=20

Thanks in advance

Matthias

--=20
So long and thanks for all the fish!

--=-HgDKODQWmuCvey8HK9xN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiEVwcACgkQwuNy6qcbS9XwZACfd/7mpgP00nSLB8P6tIyj+Osu
OzkAn3ZcJZlRJlMZ3hKh+uHv/AtPMt+A
=rcSH
-----END PGP SIGNATURE-----

--=-HgDKODQWmuCvey8HK9xN--

