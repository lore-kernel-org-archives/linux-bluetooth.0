Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: martin f krafft <madduck@madduck.net>
To: bluez users list <bluez-users@lists.sourceforge.net>
Message-ID: <20040921190606.GA11925@cirrus.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Subject: [Bluez-users] pairing with headset
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 21 Sep 2004 21:06:06 +0200


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I am using a 2.6.8.1 kernel and successfully communicate with my
Nokia 6230. Today, I got a Jabra BT 250 headset, which also works
fine.

However, I cannot make bluez see it. What's more, if I pair phone
and headset (which also works), then `hcitool scan` does not find
the phone anymore. I have to delete the pairing between the headset
and the phone to be able to communicate with the phone again.

What's going on? Can the phone only pair with one other device? Or
is the problem elsewhere?

Also, I can't figure out how to pair the computer with the headset
(assuming that phone and headset are not paired). I set the voice
type to 0x0040 (not sure why, but I saw it on the Internet; it also
does not work with 0x0060, the default) and I added Audio and
Telephony to the dongle's classes; I even added the HF SDP service.
But when I execute `hcitool scan`, only the phone shows up.

Here is hciconfig -a hci:

hci0: Type: USB
  BD Address: 08:00:17:1D:35:D3 ACL MTU: 339:4  SCO MTU: 60:9
  UP RUNNING PSCAN ISCAN=20
  RX bytes:3116 acl:0 sco:0 events:107 errors:0
  TX bytes:1624 acl:0 sco:0 commands:81 errors:0
  Features: 0xff 0x3b 0x05 0x00 0x00 0x00 0x00 0x00
  Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
  Link policy: HOLD SNIFF PARK=20
  Link mode: ACCEPT MASTER=20
  Name: 'cirrus'
  Class: 0xf20100
  Service Classes: Networking, Object Transfer, Audio, Telephony, Informati=
on
  Device Class: Computer, Uncategorized
  HCI Ver: 1.1 (0x1) HCI Rev: 0x180 LMP Ver: 1.1 (0x1) LMP Subver: 0x180
  Manufacturer: RTX Telecom A/S (21)

and hciconfig hci0 voice

hci0: Type: USB
  BD Address: 08:00:17:1D:35:D3 ACL MTU: 339:4  SCO MTU: 60:9
  Voice setting: 0x0040
  Input Coding: Linear
  Input Data Format: 2's complement
  Input Sample Size: 8 bit
  # of bits padding at MSB: 0
  Air Coding Format: CVSD

Thanks for any tips. I am a complete bluetooth newbie.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"sailing is, after all, a kind of grace, a kind of magic."
                                                        -- phil berman

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBUHueIgvIgzMMSnURAhxOAJ4sZ/G3jgKl4+ZoaPbXhzncavd1AQCgvv5b
44qD0SehMI3HJNjuS8QFt2M=
=KTbg
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
