Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 14 Aug 2006 22:23:54 -0300
From: redondos <redondos@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060815012354.GB15576@refinery.twat.com.ar>
References: <44E1187E.6030401@mackintoshweb.com>
MIME-Version: 1.0
In-Reply-To: <44E1187E.6030401@mackintoshweb.com>
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
Content-Type: multipart/mixed; boundary="===============1343939575=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1343939575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14 20:42, Terry Mackintosh wrote:
> Hi
>=20
>=20
> There are so many pieces to the puzzle: hci* sdp* rfcomm others?
>=20
> What comes first? second? ...?
>=20
> I just want to get pictures off my Motorola V710 picture phone.
> Has anyone done this?
>=20
> What programs do I run in what order and what config/password files need=
=20
> to be messed with?
>=20
> I have read man pages and some of the howtos and such, that are totally=
=20
> confusing.  Do I really need to know about stacks and protocols and the=
=20
> inner workings of all the different programs?  Is there no single doc or=
=20
> howto that puts it all together in simple to the point terms?
>=20
> I am computer literate, especially on Linux, but bluetooth is causing me=
=20
> no end of frustration.

Check the many HOWTOs that can be found on the net.

You can use obexftp(1) to fetch files from your phone.

Something like:
$ obexftp -b AA:BB:CC:DD:EE:FF -B <channel> -c Pictures -g Pic1.jpg
should work.

Cheers.

--=20
redondos

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE4SIqJZ/yCc25j3IRAvnUAKCWdo30C98BRlMoIOZUpIbww+jxwACgrwU/
96YwopVSIC3uNX3BK3o3Rqk=
=GIWY
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--


--===============1343939575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1343939575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1343939575==--
