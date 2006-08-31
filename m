Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 31 Aug 2006 15:43:16 -0300
From: redondos <redondos@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060831184315.GD22434@refinery.twat.com.ar>
References: <mailman.44465.1156973920.29847.bluez-users@lists.sourceforge.net>
	<44F68535.3060409@shaw.ca> <44F6DCB0.3030400@ibdcon.org.br>
	<44F7028D.3040502@shaw.ca>
MIME-Version: 1.0
In-Reply-To: <44F7028D.3040502@shaw.ca>
Subject: Re: [Bluez-users] bash: syntax error near unexpected token `newline'
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0211059320=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0211059320==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31 08:38, David Armour wrote:
> hello Paulo
> > Hi,
> > did it work? let me know.
> >  =20
> thanks for your interest. i'm keeping a record of this experience, in=20
> the hope that others can learn from it.
> now, running:
>=20
>  >> sudo hcitools auth 00:03:89:53:EC:7F   ## gives:
>  >> sudo: hcitools: command not found      ## !
>=20
> i'm *looking at* the hcitools icon in /usr/bin, as we speak... [slowly,=
=20
> i turn! inch by inch...step by step!]

The program is called 'hcitool' and is probably located in /usr/bin.
(Please note that you are referring to it as 'hcitools', with a tailing
's')

Check with which, whereis, or your favorite method, where in your
PATH this binary is located.

> what do you think? a permission issue? doesn't sudo take care of that? a=
=20
> path issue? i tried 'sudo /usr/bin/hcitools auth...' just to see. got=20
> same result. <curious>

--=20
redondos

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE9y3DJZ/yCc25j3IRAoswAJ9S05gVAh41Zwzq9z9G4vp19NTXUACfdBHl
iZPKKPu8WYDqf3VkbMXMs0k=
=ZbPq
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--


--===============0211059320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0211059320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0211059320==--
