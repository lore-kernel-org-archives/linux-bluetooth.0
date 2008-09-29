Return-Path: <cyrus@holtmann.org>
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: bluez-users@lists.sourceforge.net
Date: Sun, 28 Sep 2008 20:20:30 -0400
Message-Id: <1222647630.31501.7.camel@pc.ilinx>
Mime-Version: 1.0
Subject: [Bluez-users] can't get a Jabra BT125 working
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8459086671465238140=="
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============8459086671465238140==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-jTKSi0nVxSZKnExUB62z"


--=-jTKSi0nVxSZKnExUB62z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I was hoping that the 2.6.27 kernel that is being packaged with Ubuntu's
Intrepid release which also includes Bluez 3.36 would be a lot better in
terms of trying to get this headset working but alas, it seems to be
(i.e. not) working as well as it did 9 months ago.  :-(

Maybe somebody can help me get this thing working.  I'm trying to use it
in a Gnome environment along with the Gnome Bluetooth Applet 0.25.  I
think I have been successful at some point in pairing this device as the
applet did ask for the passphrase at some point.  It does not seem to
ask any more so I presume it's being cached some where.

Here's some of the info which I've kind of discovered I have to gather:

$ hcitool info 00:1A:45:1B:19:89
Requesting information ...
	BD Address:  00:1A:45:1B:19:89
	Device Name: Jabra BT125
	LMP Version: 2.0 (0x3) LMP Subversion: 0x978
	Manufacturer: Cambridge Silicon Radio (10)
	Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00
		<encryption> <slot offset> <timing accuracy> <role switch>=20
		<hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>=20
		<HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>=20
		<paging scheme> <transparent SCO> <AFH cap. slave>=20
		<AFH cap. master>
$ hcitool conn
Connections:
	> ACL 00:1A:45:1B:19:89 handle 11 state 1 lm MASTER AUTH ENCRYPT SECURE=20
$ hciconfig -a
hci0:	Type: USB
	BD Address: 00:0D:18:01:3B:9B ACL MTU: 1017:8 SCO MTU: 64:0
	UP RUNNING PSCAN ISCAN=20
	RX bytes:1785565 acl:222 sco:34651 events:453 errors:2
	TX bytes:6067 acl:211 sco:0 commands:190 errors:0
	Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
	Link policy: RSWITCH HOLD SNIFF PARK=20
	Link mode: SLAVE ACCEPT=20
	Name: 'pc-0'
	Class: 0x080104
	Service Classes: Capturing
	Device Class: Computer, Desktop workstation
	HCI Ver: 2.0 (0x3) HCI Rev: 0x4000 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
	Manufacturer: Broadcom Corporation (15)
$ cat ~/.asoundrc
pcm.bluetooth {
   type bluetooth
   device 00:1A:45:1B:19:89
   profile "auto" #optional, supported profiles are: auto, hifi and voice
}
$ aplay -D bluetooth -f S16_LE sample.wav=20
Playing WAVE '/mnt/mp3/bad_mouth.wav' : Signed 16 bit Little Endian, Rate 4=
4100 Hz, Stereo
aplay: set_params:959: Channels count non available

Anyone have any advise on how to get this thing working (reliably)?

Thanx much!

b.


--=-jTKSi0nVxSZKnExUB62z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjgHz8ACgkQl3EQlGLyuXBEIwCfe6a+qqyyDmlcJap05QWbsfAh
1lAAoNB21eXlbBBP9BWyl1QWfYX4JAHJ
=3+ra
-----END PGP SIGNATURE-----

--=-jTKSi0nVxSZKnExUB62z--



--===============8459086671465238140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============8459086671465238140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============8459086671465238140==--
