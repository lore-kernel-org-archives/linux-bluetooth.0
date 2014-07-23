Return-Path: <cyrus@holtmann.org>
Message-ID: <1406119074.21242.55.camel@pc.interlinx.bc.ca>
Subject: phone connects and then disconnects immediately
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 23 Jul 2014 08:37:54 -0400
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-2qB53CKVLhwofdunZi2U"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-2qB53CKVLhwofdunZi2U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am using Bluez 5.18 on my Fedora 20 machine and trying to play music
from my Android (Nexus 4 with KK 4.4.4) phone to the F20 as a Bluetooth
sink.

I have successfully paired the phone and the F20 machine and the phone
sees it as advertising an Audio Sink but when I try to connect the phone
bluetoothctl shows the connect immediately followed by a disconnect:

[CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
[CHG] Device XX:XX:XX:XX:XX:XX Connected: no

No messages in the syslog to indicate any problems.

Any ideas why the immediate disconection or next steps to debug?

Cheers,
b.


--=-2qB53CKVLhwofdunZi2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTz6yiAAoJENrB0DQWy8igOZ0H/0UhYwTTag8Tw654B+LMd0n9
Vld07a1+q8mZ/PosIdmdzxIkiUxF1PD08X5HyqKVYir0sFeaHzF0TaVGTPKbWL84
ArFzDv4VBem47/xweewazUIFLB0aJ+wqNlDa8jNdN8KHL0WBQKLh9Fs0O2GUl1oy
rXgnd9cKC5R5udWYMR/HbZ6I+QypfzV2ptYT3ijLqp20m5HnRZ0E0k+qQXcjxGUC
gWZjCQy+WR8GfDYYexeawgHNV9AYn52wf03KhRyRBNQL37Ndsvu1RRpA6uGJTdw6
faeHmZRRdev5swUaHdKzjaPz+NGBK+n6fS/yXFa4Phs9BAzToVbON8dGHf+k03c=
=9fqH
-----END PGP SIGNATURE-----

--=-2qB53CKVLhwofdunZi2U--

