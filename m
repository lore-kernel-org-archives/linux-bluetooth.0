Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Aug 2009 20:58:10 +1200
From: Johannes Buchner <buchner.johannes@gmx.at>
To: linux-bluetooth@vger.kernel.org
Subject: Scatternets
Message-Id: <20090807205810.d5a69e67.buchner.johannes@gmx.at>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__7_Aug_2009_20_58_10_+1200_+3nGSN3xoGMXV+Yu"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Fri__7_Aug_2009_20_58_10_+1200_+3nGSN3xoGMXV+Yu
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I am doing a project to implement Scatternet formation algorithms and
am considering building upon bluez.=20
Not to make you do my project for me, but:

Is there already a scatternet formation algorithm implemented in bluez?
Where would be the right place to look?
Any reasons why this might be a bad idea or other solutions would be
preferred?

So far, I read through these:
http://registration.fossconf.in/smedia/slides/Bluetooth_and_scatternet.pdf
http://infocom.uniroma1.it/~franci/Pubb_pdf/CUOMO_REALMAN05.pdf
 (and its sf project http://jbluez.sf.net/ but BASkit misses)
and skimmed various scatternet formation algorithm articles.

It is my understanding so far, that all I need to do is scan, connect
devices, negotiate and set devices in master/slave mode so that
eventually, the right number of nodes are in each piconet. I don't have
to edit bluez code, the tools of bluez should suffice.=20

Looking forward to your insight.

Best regards,
Johannes

PS: I want to make my code public afterwards.


--=20
Emails k=F6nnen ge=E4ndert, gef=E4lscht und eingesehen werden. Signiere oder
versch=FCssele deine Mails mit GPG.
http://web.student.tuwien.ac.at/~e0625457/pgp.html

--Signature=_Fri__7_Aug_2009_20_58_10_+1200_+3nGSN3xoGMXV+Yu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkp77KUACgkQ7X1+MfqVcr2AdACfQ6+1XVoHjRLqIwcC/whdJGjk
5K0An1beSU5CmWm9aXe5RF+/mXdCQWTj
=TiaC
-----END PGP SIGNATURE-----

--Signature=_Fri__7_Aug_2009_20_58_10_+1200_+3nGSN3xoGMXV+Yu--
