Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix compilation when --enable-test is passed
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1268089292-18303-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1268089292-18303-1-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-cHNm+T/gOVVbskX8NkV9"
Date: Tue, 09 Mar 2010 21:53:20 +0100
Message-Id: <1268168000.28218.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-cHNm+T/gOVVbskX8NkV9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 08-03-2010 a las 20:01 -0300, Vinicius Costa Gomes escribi=C3=B3:
> When --enable-test is passed along with --disable-alsa and
> --disable-gstreamer, the SBC lib is not built, which breaks
> compilation of the ipctest test program.
> ---
>  acinclude.m4 |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/acinclude.m4 b/acinclude.m4
> index 2e4444d..0eaf236 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -316,7 +316,8 @@ AC_DEFUN([AC_ARG_BLUEZ], [
> =20
>  	AM_CONDITIONAL(SNDFILE, test "${sndfile_enable}" =3D "yes" && test "${s=
ndfile_found}" =3D "yes")
>  	AM_CONDITIONAL(USB, test "${usb_enable}" =3D "yes" && test "${usb_found=
}" =3D "yes")
> -	AM_CONDITIONAL(SBC, test "${alsa_enable}" =3D "yes" || test "${gstreame=
r_enable}" =3D "yes")
> +	AM_CONDITIONAL(SBC, test "${alsa_enable}" =3D "yes" || test "${gstreame=
r_enable}" =3D "yes" ||
> +			test "${test_enable}" =3D "yes")
>  	AM_CONDITIONAL(ALSA, test "${alsa_enable}" =3D "yes" && test "${alsa_fo=
und}" =3D "yes")
>  	AM_CONDITIONAL(GSTREAMER, test "${gstreamer_enable}" =3D "yes" && test =
"${gstreamer_found}" =3D "yes")
>  	AM_CONDITIONAL(AUDIOPLUGIN, test "${audio_enable}" =3D "yes")

Thanks a lot for the patch, I will try it as soon as I am able to :-)

--=-cHNm+T/gOVVbskX8NkV9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuWtUAACgkQCaWpQKGI+9RgfwCfUXa3+3Jm/Cs/ZsQj7rWrYE9Q
eyUAninO/+gpecLkmmEyLV8x/hj0zVW8
=znd4
-----END PGP SIGNATURE-----

--=-cHNm+T/gOVVbskX8NkV9--

