Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455E0CC1.3030706@gmail.com>
Date: Fri, 17 Nov 2006 12:25:53 -0700
From: Jonathan Steffan <jonathansteffan@gmail.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Motorola H500 - Fedora Core 6
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1801023428=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1801023428==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8095C784D5D5B5902929A7A3"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8095C784D5D5B5902929A7A3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I'm having issues sending audio to my new H500. Per the readme here is
all my info:

hci0:   Type: USB
        BD Address: 00:16:41:87:A9:6E ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN
        RX bytes:382 acl:0 sco:0 events:15 errors:0
        TX bytes:310 acl:0 sco:0 commands:15 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'damaestrojr-0'
        Class: 0x12010c
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Laptop
        HCI Ver: 1.2 (0x2) HCI Rev: 0x11 LMP Ver: 1.2 (0x2) LMP Subver:
0x6963
        Manufacturer: Broadcom Corporation (15)

hci0:   Type: USB
        BD Address: 00:16:41:87:A9:6E ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 17.105 / 99

00:0C:55:0D:A2:89       Motorola H500

Requesting information ...
        BD Address:  00:0C:55:0D:A2:89
        Device Name: Motorola H500
        LMP Version: 1.2 (0x2) LMP Subversion: 0x886
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch=
>
                <hold mode> <sniff mode> <RSSI> <channel quality> <SCO
link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD=
>
                <paging scheme> <power control> <transparent SCO>
                <AFH cap. slave> <AFH cap. master>

2.6.18-1.2849.fc6 - Fedora Core 6 x86
nome-bluetooth-devel-0.7.0-10.1
gnome-bluetooth-libs-0.7.0-10.1
gnome-bluetooth-0.7.0-10.1
bluez-libs-3.7-1
nautilus-sendto-bluetooth-0.7-5.fc6
bluez-utils-3.7-2
bluez-gnome-0.6-1.fc6
bluez-libs-devel-3.7-1

aplay -B 1000000 -D plughw:Headset sound.wav
Playing WAVE 'sound.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo

btsco v0.42
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0
speaker volume: 15 mic volume: 12
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D15
Sending up speaker change 15
speaker volume: 15 mic volume: 12
driver is not in use
disconnected SCO channel


I am able to make the device 'ring' by sending SIGUSR1. I am able to use
the microphone and make calls with skype. I am unable to use the device
to send audio data. Please advise.

Jonathan


--------------enig8095C784D5D5B5902929A7A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFXgzMrRJs5w2Gr1kRAtTJAKCNw7VoNWAu9tPXT1GqzPv9quDI3wCg0EMb
+qygHJNKVwLXNfbIqRx4w/k=
=jwlx
-----END PGP SIGNATURE-----

--------------enig8095C784D5D5B5902929A7A3--


--===============1801023428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1801023428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1801023428==--
