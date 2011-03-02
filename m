Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6EAA7D.70508@interlinx.bc.ca>
Date: Wed, 02 Mar 2011 15:37:17 -0500
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: cannot use multiple devices reliably
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig238E46C6671DFEBD102A5D54"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig238E46C6671DFEBD102A5D54
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using bluez 4.69[-0ubuntu2] on Ubuntu 10.10 (Maverick) with kernel
2.6.35[-24-generic].

I have a:

Bus 002 Device 003: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub
(part of BCM2046 Bluetooth)

bluetooth dongle which seems to work decently for the most part.

I also have a logitech B/T mouse and Jabra BT125 headset (i.e. mono
device with microphone typically used with a handsfree mobile phone)
which I'd like to use simultaneously.

I can seem to connect both the headset and the mouse at the same time
but typically as soon as I connect the headset (i.e. while the mouse is
already connected), the mouse stops working.  It remains connected
(according to the Bluetooth Preferences window) but moving the mouse
doesn't result in mouse cursor movement.

Additionally, as I move the mouse, there is crackling in the headset.

Disconnecting the headset causes the mouse to subsequently disconnect
and reconnect at which point it is again able to move the mouse cursor.

I also have an LG HBM-210 headset with which the mouse seems co-exist
with successfully.  I can connect the LG headset and the mouse continues
to work.  The mouse continues to work even if I am listening to audio on
the headset, so this problem seems unique to the Jabra BT125.

I'd happily just put the Jabra headset aside and use the LG headset but
it seems to have it's own problems with the audio in and out (i.e. both
the mic and earpeice) periodically dropping out for 5-20 seconds and
then coming back.  When such a dropout happens the mouse stops working
then disconnects and reconnects.

Perhaps related, perhaps not, but I have noticed also that the mouse
will occasionally just stop working (but not disconnect) and then just
start working again.

b.


--------------enig238E46C6671DFEBD102A5D54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk1uqn0ACgkQl3EQlGLyuXB6igCg0KWXkDCgiEjzqhMEV2EBko43
NNMAoMcKMwj8o3Zf1EPSxiZaQ1v/+w0F
=Wa+m
-----END PGP SIGNATURE-----

--------------enig238E46C6671DFEBD102A5D54--
