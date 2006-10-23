Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 23 Oct 2006 00:32:53 -0400
Message-Id: <1161577973.9075.22.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Sony Ericsson HBH-610a Headset
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0973637708=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0973637708==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ejfNyO3DtYZEtobQmfBZ"


--=-ejfNyO3DtYZEtobQmfBZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've managed to get a Sony Ericsson HBH-610a workng on two platforms - a
laptop Dell 9400 with a core duo and a laptop Dell 5150 with a Pentium 4
HT. Both used a Kensington USB Bluetooth adapter.

Information on the HBH-610a:
        BD Address:  00:12:EE:E0:AB:CA
        Device Name: HBH-610a
        LMP Version: 2.0 (0x3) LMP Subversion: 0xe1b
        Manufacturer: Texas Instruments Inc. (13)
        Features: 0xff 0xfd 0x29 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>=20
                <timing accuracy> <role switch> <hold mode> <sniff
mode>=20
                <park state> <channel quality> <SCO link> <HV2 packets>=20
                <HV3 packets> <u-law log> <A-law log> <CVSD>
<transparent SCO>=20
                <enhanced iscan> <interlaced iscan> <interlaced pscan>=20
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>=20
                <AFH cap. master> <AFH class. master> <extended
features>=20

Information on the Kensington bluetooth USB adapter:
hci0:   Type: USB
        BD Address: 00:16:38:C1:ED:BD ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN=20
        RX bytes:1863 acl:0 sco:0 events:62 errors:0
        TX bytes:694 acl:0 sco:0 commands:38 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
        Link policy: RSWITCH HOLD SNIFF PARK=20
        Link mode: SLAVE ACCEPT=20
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

Both are able to use the snd-bt-sco kernel driver with skype 1.3.0.53
with good results.

The linux kernel being used in both instances is 2.6.18.1. The 5150
needed to be patched to force sco mtu values - manually done since
2.6.18.1 has code changes in the relevant area since the production of
the patch. Before the application of this, everything would work in the
connection step up to generating sounds. At that point, the sound
program would hang (e.g. aplay would hang and no sound would be
produced, although there was lots of activity shown in hcidump).

The 9400 required no patch.

The Sony Ericsson headset is Bluetooth 2.0, 1.2 and 1.1 compliant. The
Kensington Bluetooth USB Adapter is 2.0, 1.2 and 1.1 compliant.

--=-ejfNyO3DtYZEtobQmfBZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPEX1u2cEic/xsEARAgcKAJ4n1lLXIXmRZHStp5CPZsE4PV6fNgCgyzgX
1fR9cKij5CxyVqeMGEH+ZG8=
=HPbW
-----END PGP SIGNATURE-----

--=-ejfNyO3DtYZEtobQmfBZ--



--===============0973637708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0973637708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0973637708==--
