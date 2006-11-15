Return-Path: <leonerd-bluez@leonerd.org.uk>
Date: Wed, 15 Nov 2006 20:21:45 +0000
From: Paul LeoNerd Evans <leonerd-bluez@leonerd.org.uk>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Cc: marcel@holtmann.org
Subject: Re: [Bluez-users] Disconnect errors on 2.6.18-mh7
Message-ID: <20061115202145.1a3415fe@nim.leo>
In-Reply-To: <1163405394.26272.31.camel@localhost>
References: <20061110213915.58e6cabf@nim.leo>
	<1163405394.26272.31.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_NOjwsiymXNgtl_c3WIyVbp.;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
List-ID: <bluez-users.lists.sourceforge.net>

--Sig_NOjwsiymXNgtl_c3WIyVbp.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Nov 2006 09:09:54 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> run "hcidump -X -V" and show us the result for the disconnect phase and
> the failed attempt to re-connect.

Well, I recently rebooted the kernel, to try out something else. Since
then (Monday), I've not actually noticed a single failing disconnect,
despite me leaving it alone during the day, overnight, and so on. I
suspect it was a transient error somehow in the previous boot of this
kernel.

I'll leave the hcidump running anyway, it's writing a logfile now, and if
it happens to start doing this again, I'll take a look.

--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--Sig_NOjwsiymXNgtl_c3WIyVbp.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFW3beqRXzCRLr5iQRAgHTAJ9y/hDrf5s2YDgccMxqR4wmdh/mbgCeNA5d
REK8PKxzuhqEIgXV4WFyP7Q=
=CWOQ
-----END PGP SIGNATURE-----

--Sig_NOjwsiymXNgtl_c3WIyVbp.--
