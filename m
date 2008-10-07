Return-Path: <cyrus@holtmann.org>
Message-ID: <48EB9FCF.6070907@dell.com>
Date: Tue, 07 Oct 2008 12:43:43 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: SCO headset not working with 4.12
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0A5FC26C2879D58BF50FCF4F"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A5FC26C2879D58BF50FCF4F
Content-Type: multipart/mixed;
 boundary="------------060605040605020505070505"

This is a multi-part message in MIME format.
--------------060605040605020505070505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi:

I recently upgraded to bluez-4.12 and added in the SCO patch that came
shortly after the 4.12 release.  It seems that my SCO headset is
connecting, and receiving commands for volume levels, etc, but doesn't
actually play back any audio.  I was trying to use the test/hstest app
to verify like this:

    ./hstest play /usr/share/sounds/alsa/Front_Center.wav
    00:19:7F:30:47:AB 1
    Voice setting: 0x0060
    RFCOMM channel connected
    SCO audio channel connected (handle 1, mtu 64)

It just idles there sitting at that until I hit ctrl-c.  I've attached
bluetoothd -nd output as well.


Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------060605040605020505070505
Content-Type: text/x-log;
 name="bluetoothd.log"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="bluetoothd.log"


--------------060605040605020505070505--

--------------enig0A5FC26C2879D58BF50FCF4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkjrn88ACgkQ2CrZjkA73YtgpgCghTAD2FYx55Glw3AWrUsIq5/m
UcoAnj4cjdq9ZghfIuYVkNReq6SMKt0V
=OYXz
-----END PGP SIGNATURE-----

--------------enig0A5FC26C2879D58BF50FCF4F--
