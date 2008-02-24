Return-Path: <cyrus@holtmann.org>
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Sat, 23 Feb 2008 20:09:59 -0500
Message-Id: <1203815399.8021.10.camel@pc.ilinx>
Mime-Version: 1.0
Subject: [Bluez-users] hci_scodata_packet: hci0 SCO packet for unknown
	connection handle 1
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0085284238=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0085284238==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0bNVv3+4pKWUUJDBOHP7"


--=-0bNVv3+4pKWUUJDBOHP7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm running Ubuntu Hardy, so I have a nice bleeding edge installation of
kernel and bluez tools.  I am trying to get a Jabra headset to work but
it's just not happening for me.  I plug in the dongle and get the little
bluetooth applet showing in my taskbar.  My headset also beeps when this
happens.

lsusb reports:

Bus 001 Device 009: ID 0a5c:2121 Broadcom Corp.=20

lsbusb -v reports:

Bus 001 Device 009: ID 0a5c:2121 Broadcom Corp.=20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a5c Broadcom Corp.
  idProduct          0x2121=20
  bcdDevice            1.00
  iManufacturer           1 Broadcom Corp
  iProduct                2 BCM92045B3 ROM
  iSerial                 0=20
  bNumConfigurations      1
...

I believe it's all paired up nicely:

$ hcitool con
Connections:
	> ACL 00:1A:45:1B:19:89 handle 11 state 1 lm SLAVE AUTH ENCRYPT SECURE=20

I follow the steps in http://wiki.bluez.org/wiki/HOWTO/AudioDevices but
when I try to play something with:

$ sox /mnt/mp3/bad_mouth.wav -t wav -c 1 - | aplay -D plug:bluetooth
sox wav: Length in output .wav header will be wrong since can't seek to fix=
 it
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono

I hear nothing and the dmesg/console log shows:

Feb 23 20:05:48 pc kernel: [20205.288394] Bluetooth: L2CAP ver 2.9
Feb 23 20:05:48 pc kernel: [20205.288405] Bluetooth: L2CAP socket layer ini=
tialized
Feb 23 20:05:48 pc kernel: [20205.297727] Bluetooth: RFCOMM socket layer in=
itialized
Feb 23 20:05:48 pc kernel: [20205.297748] Bluetooth: RFCOMM TTY layer initi=
alized
Feb 23 20:05:48 pc kernel: [20205.297750] Bluetooth: RFCOMM ver 1.8
Feb 23 20:06:37 pc kernel: [20254.100422] Bluetooth: SCO (Voice Link) ver 0=
.5
Feb 23 20:06:37 pc kernel: [20254.100431] Bluetooth: SCO socket layer initi=
alized
Feb 23 20:06:37 pc kernel: [20254.788127] hci_scodata_packet: hci0 SCO pack=
et for unknown connection handle 1
Feb 23 20:06:37 pc kernel: [20254.798114] hci_scodata_packet: hci0 SCO pack=
et for unknown connection handle 1
Feb 23 20:06:37 pc kernel: [20254.798118] hci_scodata_packet: hci0 SCO pack=
et for unknown connection handle 1
Feb 23 20:06:37 pc kernel: [20254.798121] hci_scodata_packet: hci0 SCO pack=
et for unknown connection handle 1
Feb 23 20:06:37 pc kernel: [20254.808103] hci_scodata_packet: hci0 SCO pack=
et for unknown connection handle 1
Feb 23 20:06:37 pc kernel: [20254.808107] hci_scodata_packet: hci0 SCO pack=
et for unknown connection handle 1
Feb 23 20:06:37 pc kernel: [20254.808110] hci_scodata_packet: hci0 SCO pack=
et for unknown connection handle 1
Feb 23 20:06:37 pc kernel: [20254.818100] hci_scodata_packet: hci0 SCO pack=
et for unknown connection handle 1
[ and on and on and on ]

Anyone got any advise?

Thanx,
b.


--=-0bNVv3+4pKWUUJDBOHP7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHwMPnl3EQlGLyuXARArZCAJ41GKhWgD4PpXdMn1MQ6lw8AbkLcACdErXK
eOxps0RDfLjjKf/+o2J4nxo=
=iRmu
-----END PGP SIGNATURE-----

--=-0bNVv3+4pKWUUJDBOHP7--



--===============0085284238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0085284238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0085284238==--
