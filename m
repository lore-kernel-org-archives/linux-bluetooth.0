Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Kear <thomas.kear@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Sat, 28 Oct 2006 14:31:41 +1300
MIME-Version: 1.0
Message-Id: <200610281431.45651.thomas.kear@gmail.com>
Subject: [Bluez-users] Excessive output from snd-bt-sco in dmesg
Reply-To: thomas.kear@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1490564163=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1490564163==
Content-Type: multipart/signed; boundary="nextPart6642403.CTx0BNJLEr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6642403.CTx0BNJLEr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have my suspicions this could be something to do with a problem that is=20
causing audio output to my headset to go completely silent on random=20
occaisions (usually a 'killall -USR2 btsco' fixes it, but in extreme cases =
I=20
have had to unload the module and reload it).

=46rom dmesg, repeated nearly 1500 times:
snd-bt-sco: Shift problem detected! Fixing to 1.
snd-bt-sco: Shift problem detected! Fixing to 0.

And occaisionally this message (or some variation on the number of files):
snd-bt-sco: file_count is 4 (expected 3)

Headset is a Sony Ericsson HBH-IV835
        BD Address:  00:18:13:7e:bc:7a
        Device Name: HBH-IV835
        LMP Version: 2.0 (0x3) LMP Subversion: 0xe1b
        Manufacturer: Texas Instruments Inc. (13)
        Features: 0xff 0xfd 0x29 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <transparent S=
CO>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                <AFH cap. master> <AFH class. master> <extended features>

Adapter is 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mod=
e)
hci0:   Type: USB
        BD Address: 00:02:72:B0:36:D7 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:21511295 acl:351 sco:420012 events:8971 errors:0
        TX bytes:21398439 acl:305 sco:418646 commands:7868 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'insanity'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer,=
=20
Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x=
110
        Manufacturer: Cambridge Silicon Radio (10)

Since 99% of the time there is no problem that needs to be solved, is there=
 a=20
simple way to just reduce the verbosity of output to the system log?

=2D-Thomas

--nextPart6642403.CTx0BNJLEr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFQrMB8/Qi7qeDfygRAg0bAKCjgxZFkXOAVQlPZ4LgrderfuueowCZATzp
W4PW+fUpAsmOEka7eTEMCZg=
=d5nP
-----END PGP SIGNATURE-----

--nextPart6642403.CTx0BNJLEr--


--===============1490564163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1490564163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1490564163==--
