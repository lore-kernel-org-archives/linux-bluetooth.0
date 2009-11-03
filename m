Return-Path: <cyrus@holtmann.org>
Subject: Persisting power state when set via rfkill directly
From: Ross Burton <ross@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-7vvBoXLPioSyK0G7wNt1"
Date: Tue, 03 Nov 2009 15:55:02 +0000
Message-ID: <1257263702.8893.101.camel@flashheart.burtonini.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-7vvBoXLPioSyK0G7wNt1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I see that bluez has support for saving the current power state to disk
(in /var/lib/bluetooth/[id]/config) when the Powered adaptor property is
toggled, so that the same state can be restored when restarted.
However, this only works if the powered state is toggled via the Bluez
DBus API, applications which directly touch rfkill (such as
gnome-bluetooth) don't cause the current mode to be persisted.

>>From a quick look at the code I'd say that rfkill_event() shouldn't
return early if the adaptor was powered down and instead get the adaptor
pointer and write the new mode state.  Does this sound reasonable?

Ross
--=20
Intel Open Source Technology Centre
http://oss.intel.com/

--=-7vvBoXLPioSyK0G7wNt1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQBK8FJWLQnkR9C0M98RAuc5AJ9om/u8YOsx2WorQSy6xynbFMV9AgCghBNc
Fd15CNWmjEu3shjD6bbAqXw=
=XeY4
-----END PGP SIGNATURE-----

--=-7vvBoXLPioSyK0G7wNt1--
