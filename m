Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Kear <thomas.kear@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Thu, 26 Oct 2006 13:19:36 +1300
MIME-Version: 1.0
Message-Id: <200610261319.41239.thomas.kear@gmail.com>
Subject: [Bluez-users] hidd connect permissions
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
Content-Type: multipart/mixed; boundary="===============2103212129=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2103212129==
Content-Type: multipart/signed; boundary="nextPart1461664.QE1I2S6d2N";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1461664.QE1I2S6d2N
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

# hidd -n --server
hidd[32412]: Bluetooth HID daemon
hidd[32412]: Rejected connection from unknown device 00:12:EE:07:95:48
(same result running as non-root user)

Remote device is a Sony Ericsson K750i, using inbuilt HID controller.  Phon=
e=20
is paired with the computer, file transfer (using kdebluetooth or obexftp)=
=20
and rfcomm devices both work.

This used to work with bluez-2.25, current (non-working) version is 3.7. =20
Installed from ebuilds out of liquidx's overlay, on gentoo/amd64 2006.1=20
(http://overlays.gentoo.org/dev/liquidx/browser/net-wireless). =20

Does hidd have a configuration file that isn't documented anywhere?


hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:B0:36:D7 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2797012 acl:12150 sco:0 events:5242 errors:0
        TX bytes:68770 acl:3782 sco:0 commands:786 errors:0
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

hcid.conf:
options {
        autoinit yes;
        security auto;
        pairing multi;
        passkey "0000";
}
device {
        name "insanity";
        class 0x3e0100;
        iscan enable; pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;
        discovto 0;
}

--nextPart1461664.QE1I2S6d2N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFP/8d8/Qi7qeDfygRAjotAJ935U6vuTNoKd1qGKk/WS7fZjuxvACfbhQ5
aylMQ5jjb63ZNQv5Bkdy9a0=
=0oK3
-----END PGP SIGNATURE-----

--nextPart1461664.QE1I2S6d2N--


--===============2103212129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2103212129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2103212129==--
