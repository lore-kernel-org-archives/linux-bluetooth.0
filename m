Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 26 Aug 2006 15:13:06 +0200
From: "Matteo 'Peach' Pescarin" <peach@smartart.it>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060826151306.012c633a@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] rfcomm hell
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0890781373=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0890781373==
Content-Type: multipart/signed; boundary=Sig_YmWPBt1ya70oibnrZXCWz7s;
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_YmWPBt1ya70oibnrZXCWz7s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I've tried everything, I'm going to suspect something in my machine is brok=
en (udev?), but I can go no further and I am here to ask any developer if h=
e can help me.

the hcitool works good as long as the usb BT dongle
I can't rfcomm connect in any way: the error is always reproducible and
here's the output:

# hcitool scan
Scanning ...
        00:12:62:A8:12:FE       Miditree
# rfcomm connect 0
Can't create RFCOMM TTY: Address already in use
# rfcomm
rfcomm0: 00:12:62:A8:12:FE channel 1 clean
# rfcomm release 0; rfcomm connect 0
Can't open RFCOMM device: No such file or directory

I can provide any output you need, but pls help me :(


--=20
Matteo 'Peach' Pescarin

ICQ UIN =3D 71110111
Jabber ID =3D smartart@unstable.nl
Web Site =3D http://www.smartart.it
GPG key =3D http://www.smartart.it/temp/peach.asc
Key fingerprint =3D C882 C029 540F 0EA3 5318  D2C3 1E4C 8167 0055 105D

--Sig_YmWPBt1ya70oibnrZXCWz7s
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE8EjtHkyBZwBVEF0RAkdoAKC/Ng8tvoCaTuB7Ofz2gZ2PB2EZrQCbBDyn
uHWCcmgg3LXbZjH13FigClk=
=X+Rw
-----END PGP SIGNATURE-----

--Sig_YmWPBt1ya70oibnrZXCWz7s--


--===============0890781373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0890781373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0890781373==--
