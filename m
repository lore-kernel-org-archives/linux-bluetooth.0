Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 10 Nov 2006 21:39:15 +0000
From: Paul LeoNerd Evans <leonerd@leonerd.org.uk>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061110213915.58e6cabf@nim.leo>
Mime-Version: 1.0
Subject: [Bluez-users] Disconnect errors on 2.6.18-mh7
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1567019229=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1567019229==
Content-Type: multipart/signed; boundary="Sig_riWaVTfqwZgpCfXUWr/giKx";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_riWaVTfqwZgpCfXUWr/giKx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I've got a custom-built 2.6.18 patched with mh7 on my desktop machine,
with a Logitech Cordless Elite Blutooth Keyboard and Mouse combo. Up
until 2.6.16 these worked fine. 2.6.17 has unrelated-to-bluez issues with
my graphics card. On 2.6.18, I can connect the keyboard/mouse on startup,
but if I let them idle too long, they disconnect in an unrecoverable way,
requiring me to ssh from another box and run "hidd --search" while
simultaneously pressing the "connect" button on the keyboard or mouse.

I'm not sure quite when it happens, but it would seem to be related to
lines of the following occuring in dmesg:

net/bluetooth/hidp/hid.c: event field not found

Is this a bug that's crept in to 2.6.18, or perhaps a hardware issue, or
what? Anything I can attempt to debug it with?

--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--Sig_riWaVTfqwZgpCfXUWr/giKx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVPGGqRXzCRLr5iQRAtpTAJ9lVIttl353luoBvh2aySoaepWZYwCcD90+
J0vRaRVrkHEQXdL5Hfcktvo=
=xW8z
-----END PGP SIGNATURE-----

--Sig_riWaVTfqwZgpCfXUWr/giKx--


--===============1567019229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1567019229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1567019229==--
