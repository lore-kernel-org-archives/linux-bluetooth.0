Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Dec 2011 22:47:53 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH BlueZ 3/4] Enable input/sixpair build (but no
 installation)
Message-Id: <20111230224753.6729859cbc78e1c68d8563af@studenti.unina.it>
In-Reply-To: <1325273171-24698-3-git-send-email-anderson.lizardo@openbossa.org>
References: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
	<1325273171-24698-3-git-send-email-anderson.lizardo@openbossa.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__30_Dec_2011_22_47_53_+0100_LXzz=.5rexbq5LTb"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Fri__30_Dec_2011_22_47_53_+0100_LXzz=.5rexbq5LTb
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Dec 2011 15:26:10 -0400
Anderson Lizardo <anderson.lizardo@openbossa.org> wrote:

> "sixpair" is a standalone tool to manage PS3 controllers. It was the
> only tool not being built by default.
>=20
> To build it, it is necessary to check for libusb-1.0 (besides the
> existing libusb 0.1 check). The check is optional, and sixpair will not
> be built if libusb-1.0 headers are not installed.
> ---
>=20
> I personally never used this tool. So I'm not sure if the best approach i=
s to
> completely remove it instead. If that's the case, let me know so I send a=
 patch
> removing the .c file instead.
>

Hi Anderson,

I'd say the .c file can be removed if you want to, when I have time I am
going to resend the playstation-peripheral plugin and the prerequisite
patches to have it as an _external_ plugin, I hope to do that next
week.

In my previous submissions of the playstation-peripheral plugin I was
removing this .c file just before adding the new plugin, and I am going
to "revert" this patch anyways, so you can choose to drop this patch
and let me remove the .c file when I add the plugin, or remove it right
now. I think there isn't much of a gain enabling the build of the
sixpair.c currently in BlueZ.

I am adding Bastien on CC as he was the author of the sixpair currently
in BlueZ, Bastien what do you think?

Thanks,
   Antonio

>  .gitignore     |    1 +
>  Makefile.tools |   10 ++++++++++
>  acinclude.m4   |    5 +++++
>  3 files changed, 16 insertions(+), 0 deletions(-)
>=20
> diff --git a/.gitignore b/.gitignore
> index badd1a0..0c5ef15 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -46,6 +46,7 @@ sbc/sbcinfo
>  sbc/sbctester
> =20
>  attrib/gatttool
> +input/sixpair
>  tracer/hcitrace
>  tools/avctrl
>  tools/avinfo
> diff --git a/Makefile.tools b/Makefile.tools
> index eea1a9b..400ed1b 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -63,6 +63,16 @@ attrib_gatttool_SOURCES =3D attrib/gatttool.c attrib/a=
tt.c attrib/gatt.c \
>  attrib_gatttool_LDADD =3D lib/libbluetooth-private.la @GLIB_LIBS@ @READL=
INE_LIBS@
>  endif
> =20
> +if SIXPAIR
> +noinst_PROGRAMS +=3D input/sixpair
> +
> +input_sixpair_CFLAGS =3D $(AM_CFLAGS) @USB10_CFLAGS@
> +input_sixpair_SOURCES =3D input/sixpair.c src/storage.c src/storage.h \
> +			src/textfile.c src/textfile.h src/glib-helper.c \
> +			src/glib-helper.h
> +input_sixpair_LDADD =3D lib/libbluetooth-private.la @GLIB_LIBS@ @USB10_L=
IBS@
> +endif
> +
>  dist_man_MANS +=3D tools/rfcomm.1 tools/l2ping.8 \
>  			tools/hciattach.8 tools/hciconfig.8 \
>  			tools/hcitool.1 tools/sdptool.1 tools/ciptool.1
> diff --git a/acinclude.m4 b/acinclude.m4
> index 4c72fee..f2a4845 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -141,6 +141,10 @@ AC_DEFUN([AC_PATH_USB], [
>  	AC_CHECK_LIB(usb, usb_interrupt_read, dummy=3Dyes,
>  		AC_DEFINE(NEED_USB_INTERRUPT_READ, 1,
>  			[Define to 1 if you need the usb_interrupt_read() function.]))
> +
> +	PKG_CHECK_MODULES(USB10, libusb-1.0, usb10_found=3Dyes, usb10_found=3Dn=
o)
> +	AC_SUBST(USB10_CFLAGS)
> +	AC_SUBST(USB10_LIBS)
>  ])
> =20
>  AC_DEFUN([AC_PATH_UDEV], [
> @@ -427,6 +431,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
>  	AM_CONDITIONAL(PCMCIA, test "${pcmcia_enable}" =3D "yes")
>  	AM_CONDITIONAL(HID2HCI, test "${hid2hci_enable}" =3D "yes" && test "${u=
sb_found}" =3D "yes" && test "${udev_found}" =3D "yes")
>  	AM_CONDITIONAL(DFUTOOL, test "${dfutool_enable}" =3D "yes" && test "${u=
sb_found}" =3D "yes")
> +	AM_CONDITIONAL(SIXPAIR, test "${usb10_found}" =3D "yes")
>  	AM_CONDITIONAL(DATAFILES, test "${datafiles_enable}" =3D "yes")
>  	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" =3D "yes")
>  	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" =3D "yes")
> --=20

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__30_Dec_2011_22_47_53_+0100_LXzz=.5rexbq5LTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7+MYkACgkQ5xr2akVTsAGWVQCfQLaMHLlqHqme/9dqhKGS4suL
X0cAnjaNL1LegCKKJtEmqxdSCh9Entw8
=LyQB
-----END PGP SIGNATURE-----

--Signature=_Fri__30_Dec_2011_22_47_53_+0100_LXzz=.5rexbq5LTb--
