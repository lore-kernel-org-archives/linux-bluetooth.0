Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Schmid <annaeus@gmx.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5570790.dIUFOPZIBn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200602191048.03448.annaeus@gmx.de>
Subject: [Bluez-users] Sucessfully paired and used Broadcom BT-Dongle an BTH-100 Headset
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 19 Feb 2006 10:47:52 +0100

--nextPart5570790.dIUFOPZIBn
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
at least got it.
By applying this patch http://bluetooth-alsa.sourceforge.net/sco-mtu.patch =
to=20
Kernelsourcews 2.6.12, I was able to change=20

hciconfig hci0 revision
hci0: =C2=A0 Type: USB
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BD Address: 00:0B:0D:4A:53:0F ACL MTU: 1017:8 S=
CO MTU: 64:0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Firmware 8285.65 / 33

into:

hciconfig hci0 revision
hci0: =C2=A0 Type: USB
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BD Address: 00:0B:0D:4A:53:0F ACL MTU: 1017:8 S=
CO MTU: 64:8
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Firmware 8285.65 / 33

and also to hear sound by using xmms. (But I had to btsco -v 00:00:00:00:00=
=20
about three times, before a connection was established.)

Hope this helps somebody.

--nextPart5570790.dIUFOPZIBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+D7TX/3fbLg4U5MRAjEGAKCT4zIae3iulgToIcDO7NuGmnd+KQCgoJPC
m/GJUM5UBRRBiEdMLkno5dw=
=kbvI
-----END PGP SIGNATURE-----

--nextPart5570790.dIUFOPZIBn--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
