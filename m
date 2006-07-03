Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 3 Jul 2006 21:16:27 +0200
From: martin f krafft <madduck@madduck.net>
To: bluez users list <bluez-users@lists.sourceforge.net>
Message-ID: <20060703191627.GA21779@piper.madduck.net>
References: <20060703180130.GA19929@piper.madduck.net>
MIME-Version: 1.0
In-Reply-To: <20060703180130.GA19929@piper.madduck.net>
Subject: Re: [Bluez-users] btsco and not hearing or recording anything
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0107624158=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0107624158==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2006.07.03.2001 +0200]:
> Here's what I do to record:

     * Output from hciconfig hci0 revision (Run hciconfig as root)
          + If it prints "SCO mapping: HCI" then your adapter should
            work.

I have one of those...

          + If it prints "SCO mapping: PCM" then you might permanently
            change the setting using a command like "pskey mapsco 0"
            using bluez-utils-cvs but this is at your own risk.

and one of those...

          + If it doesn't print either of those, you probably need a
            different bluetooth adapter (preferably "CSR" based). You
            might be able to get a broadcom adapter to work if you apply
            a [8]patch to force sco mtu values (eg works for F8T012; let
            us know how it works on bluez-devel!)

and one of those...



It works on the first. Only on the first. What a shame, but I'll
just try to get ahold of a CSR adapter, as you say.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
gentoo: for when overclocking gets unexciting.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEqW0LIgvIgzMMSnURAuHCAKDlC+CjszzDd+yaEANgPHpj56BfLQCeP0eg
tEYH5pgG0WVDuAxZZmPeqTU=
=3xCS
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--


--===============0107624158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0107624158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0107624158==--
