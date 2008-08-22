Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Aug 2008 09:36:28 +0200
From: martin f krafft <madduck@madduck.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080822073628.GA5989@piper.oerlikon.madduck.net>
MIME-Version: 1.0
Subject: [Bluez-devel] SCO flowcontrol patch v4.4 on 2.6.25/6 causes
	hardlocks when	connecting to BT device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0390184249=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0390184249==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2008.04.11.0932 +0200]:
> I have just compiled a Debian 2.6.24 with the v4.4 patch: it applied
> and compiled cleanly.
>=20
> And it works most of the time with my BT500v headset (sco)! Thank
> you for that.

So I used to have a working Bluetooth setup with 2.6.24, and it also
still works. However, the kernel developers have moved on, and even
though the sco-flowcontrol v4.4 patch applies to 2.6.25/6 as well
[0], the resulting 2.6.25 and 2.6.26 kernels both freeze hard when
I try to connect to the headset.

0. http://bugs.debian.org/493098

Does anyone have an idea what could be going on? How can I help
debug this? Is there a newer patch floating around somewhere?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"we did rate the microsoft security researcher as
 less-bad than the people who prepare the carcasses for dissection in
 biology laboratories."
             -- michael moyer, executive editor of _popular science_
=20
spamtraps: madduck.bogus@madduck.net

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiubHwACgkQIgvIgzMMSnW3sACZAbNMp4OAQR4PC2SadG9fkMgR
qnUAn2TcBCTbIvNiRK6DzJZrjmXRh15S
=3BUf
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--


--===============0390184249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0390184249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0390184249==--
