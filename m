Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 15 Aug 2006 19:22:03 -0300
From: redondos <redondos@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060815222203.GI15576@refinery.twat.com.ar>
References: <44E1187E.6030401@mackintoshweb.com>
	<20060815012354.GB15576@refinery.twat.com.ar>
	<44E1A281.3090803@ipb.pt>
MIME-Version: 1.0
In-Reply-To: <44E1A281.3090803@ipb.pt>
Subject: Re: [Bluez-users] Totally confused
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0267049812=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0267049812==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15 11:31, Rui Pedro Lopes wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> redondos wrote:
> > Check the many HOWTOs that can be found on the net.
> >
> Is there any HOWTO focusing on the connection with a stereo headset?
> I have only found the one on http://bluetooth-alsa.sourceforge.net/,
> but it is not working because of some PIN Code Request Negative Reply
> error...

Have you tried following the Gentoo wiki? You're probably not using
Gentoo, but they are well-known for providing pretty good documentation
to the open source community.

http://www.gentoo-wiki.com/HOWTO_use_a_bluetooth_headset

About the PIN code: have you configured a pin helper correctly in
hcid.conf? It's pretty simple, you can just write a shell script:

#!/bin/sh
echo "PIN:1234

Make it executable, then edit hcid.conf with the line:

pin_helper /path/to/the/script

--=20
redondos

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE4kkLJZ/yCc25j3IRAuZbAJ0WJqZ4GZWA9NZVYdvD/b5HzT5MTACeJcrg
O9uPOE2uujGUG0mcUwQU3oE=
=lD7D
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--


--===============0267049812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0267049812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0267049812==--
