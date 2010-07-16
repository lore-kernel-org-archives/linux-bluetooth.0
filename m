Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez installs alsa related stuff under /etc/alsa instead of
 /usr/share/alsa
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
In-Reply-To: <20100716170135.GA22166@jh-x301>
References: <20100716170135.GA22166@jh-x301>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-HLBQyd7BPrNuedvGeNYl"
Date: Fri, 16 Jul 2010 19:21:45 +0200
Message-ID: <1279300905.29479.2.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-HLBQyd7BPrNuedvGeNYl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 16-07-2010 a las 14:01 -0300, Johan Hedberg escribi=C3=B3:
>=20
> On Fri, Jul 16, 2010, Pacho Ramos wrote:
> > Can this be finally committed please? Thanks a lot :-)
>=20
> It's strange the the patch has gone unnoticed ever since March. Anyway,
> could you please provide a git format-patch version of it since that's
> the convention for all patch submisions. That way I don't need to play
> manual tricks to get the git author name and email correct for the
> commit.
>=20
> Johan
>=20

Sadly I have always failed to create patches in a git format-patch
version :'(

This is what I have tried:
$ git clone git://git.kernel.org/pub/scm/bluetooth/bluez.git
Initialized empty Git repository in /home/pacho/bluez/.git/
remote: Counting objects: 35451, done.
remote: Compressing objects: 100% (8577/8577), done.
remote: Total 35451 (delta 27190), reused 34976 (delta 26858)
Receiving objects: 100% (35451/35451), 6.16 MiB | 1.39 MiB/s, done.
Resolving deltas: 100% (27190/27190), done.
$ cd bluez/
$ git checkout -b fix_alsa_path
Switched to a new branch 'fix_alsa_path'
$ patch -p0
</usr/portage/net-wireless/bluez/files/bluez-alsa_location.patch=20
patching file Makefile.am
Hunk #1 succeeded at 248 (offset 7 lines).
$ git format-patch master --stdout
$ (nothing is shown)



--=-HLBQyd7BPrNuedvGeNYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkxAlSkACgkQCaWpQKGI+9SdmgCfcE71C439EBxcfUR1/f795mol
Br8AoIfcvdlDCUtKFhsAEh1X0oqOvqkH
=W73v
-----END PGP SIGNATURE-----

--=-HLBQyd7BPrNuedvGeNYl--
