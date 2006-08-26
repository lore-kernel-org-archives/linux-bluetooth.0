Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 26 Aug 2006 15:20:46 +0200
From: "Matteo 'Peach' Pescarin" <peach@smartart.it>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060826152046.2555a9c4@localhost>
In-Reply-To: <20060826151306.012c633a@localhost>
References: <20060826151306.012c633a@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] rfcomm hell
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0034965038=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0034965038==
Content-Type: multipart/signed; boundary="Sig_GTgHg0ms0mVOLXX/AW8rJ_L";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_GTgHg0ms0mVOLXX/AW8rJ_L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Aug 2006 15:13:06 +0200
Matteo 'Peach' Pescarin <peach@smartart.it> wrote:

> something in my machine is broken (udev?)

ok, after this message I tried to search along my udev rules.d files
and found this:

# cat /etc/udev/rules.d/10-udev.rules
KERNEL=3D"rfcomm[0-9]*", NAME=3D"bluetooth/%k", GROUP=3D"users", MODE=3D"06=
60"

after commenting out this line everything worked right: seems like the defa=
ult rules installed along with bluez conflicts with this.
That rule was suggested by an online tutorial found somewhere.

thanks anyway :)

--=20
Matteo 'Peach' Pescarin

ICQ UIN =3D 71110111
Jabber ID =3D smartart@unstable.nl
Web Site =3D http://www.smartart.it
GPG key =3D http://www.smartart.it/temp/peach.asc
Key fingerprint =3D C882 C029 540F 0EA3 5318  D2C3 1E4C 8167 0055 105D

--Sig_GTgHg0ms0mVOLXX/AW8rJ_L
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE8EqvHkyBZwBVEF0RAvWEAKCr9cDv6iVyumRtEkLNT4Dc/8BObgCfdv22
22hV85RvzNOy9nijNRhH348=
=JfJU
-----END PGP SIGNATURE-----

--Sig_GTgHg0ms0mVOLXX/AW8rJ_L--


--===============0034965038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0034965038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0034965038==--
