Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Rutger Hendriks <Loial@home.nl>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7194945.vNiaSdTuSC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200511262023.23140.Loial@home.nl>
Subject: [Bluez-devel] Sending arbitrary data to a connected device
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 26 Nov 2005 20:23:17 +0100

--nextPart7194945.vNiaSdTuSC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I have a bluetooth device here that has an LCD display. I want to be able t=
o=20
send arbitrary data to the device. This way I can (hopefully) make text=20
appear on the LCD display. The problem is, that I can not find enough=20
documentation to send the arbitrary data. So I'm hoping to find some help=20
here...

What I have done so far:
=2D Open the hci device
=2D Create a connection to the LCD device (I have no idea what all the ptyp=
e=20
flags (HCI_DM1 etc...) in hci_create_connection do :( ). This gives me a=20
handle to the LCD device.
=2D I now can send hci_send_req's by filling in ogf and ocf with e.g.=20
OGF_STATUS_PARAM and OCF_READ_RSSI to read the RSSI.

But, now I'm stuck. What function can I call to send arbitrary hex data?
Do I use hci_send_req and fill in other values for ogf/ocf and plug the dat=
a=20
into rparam? Or do I use another function? (which??)
Any help is appreciated!

Greetings
Rutger Hendriks

--nextPart7194945.vNiaSdTuSC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDiLYrZNkx8LIJzQ4RAi3vAJwL/kCJdLAGl9vfo1eOL5JHeqQQCgCfd6FE
kINEoBjLtfGq1mKRR1h0FQU=
=VAH2
-----END PGP SIGNATURE-----

--nextPart7194945.vNiaSdTuSC--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
