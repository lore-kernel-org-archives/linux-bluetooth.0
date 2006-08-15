Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 15 Aug 2006 19:33:17 -0300
From: redondos <redondos@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060815223317.GJ15576@refinery.twat.com.ar>
References: <44E1187E.6030401@mackintoshweb.com>
	<20060815012354.GB15576@refinery.twat.com.ar>
	<44E1EAB3.8000308@mackintoshweb.com>
MIME-Version: 1.0
In-Reply-To: <44E1EAB3.8000308@mackintoshweb.com>
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
Content-Type: multipart/mixed; boundary="===============1076760469=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1076760469==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KjX7LgAomYr70Ka9"
Content-Disposition: inline


--KjX7LgAomYr70Ka9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15 11:39, Terry Mackintosh wrote:
> Hi
>=20
> redondos wrote:
> > On Mon, Aug 14 20:42, Terry Mackintosh wrote:
> >=20
> >>Hi
> >>
> >>
> >>There are so many pieces to the puzzle: hci* sdp* rfcomm others?
> >>
> >>What comes first? second? ...?
> >>
> >>I just want to get pictures off my Motorola V710 picture phone.
> >>Has anyone done this?
> >>
> >>What programs do I run in what order and what config/password files nee=
d=20
> >>to be messed with?
> >>
> > Check the many HOWTOs that can be found on the net.
>=20
> I have, none seem to directly apply and all are confusing at best.

I kind of noticed the same thing when I first started using BlueZ, but
after a while and many problems, things got clearer.

> > You can use obexftp(1) to fetch files from your phone.
> >=20
> > Something like:
> > $ obexftp -b AA:BB:CC:DD:EE:FF -B <channel> -c Pictures -g Pic1.jpg
> > should work.
>=20
> Will try it, however the manual for the phone says it does not support=20
> obex, so this probably will not work.

Check what services are supported by your phone with `sdptool browse'

> No other programs need run to setup the connection? no config files=20
> setup? no rfcomm? just obexftp by itself?

Yes, of course you need to edit some configuration files. You haven't
even read the man pages, have you? `man 5 hcid.conf' is a good starting
point, then edit /etc/bluetooth/hcid.conf properly.

No need to have a working rfcomm device, AFAIK.

Some important userspace tools that ship with BlueZ are hcitool, sdptool,=
=20
hcidump, l2ping, hciconfig... use your distribution's package manager to
find them all. (for instance, `qlist bluez|grep bin' or `dpkg -L
bluez|grep bin')

Good luck.

--=20
redondos

--KjX7LgAomYr70Ka9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE4kutJZ/yCc25j3IRAvk/AJ43YI5WCfPjP/RZxg5wJ2vsGVvHMwCgqPT1
fnj8exjnvBKiq2EkBmhTuYw=
=X7gi
-----END PGP SIGNATURE-----

--KjX7LgAomYr70Ka9--


--===============1076760469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1076760469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1076760469==--
