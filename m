Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Olivier Bornet <Olivier.Bornet@smartdata.ch>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Developers List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
Message-ID: <20031209224217.GE26896@smartdata.ch>
References: <1070201531.8187.20.camel@bluez.bueche.ch> <1070218289.8534.30.camel@bluez.bueche.ch> <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag> <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch> <1070483755.24159.114.camel@pegasus> <20031204085314.GA1780@smartdata.ch> <1071001915.13464.33.camel@bluez.bueche.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
In-Reply-To: <1071001915.13464.33.camel@bluez.bueche.ch>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 9 Dec 2003 23:42:17 +0100


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Charles,

> 1. XFree patch
>=20
> I patched my XFree (gentoo xfree-4.3.99.16) with this patch
> (http://www.yhbt.net/normalperson/files/linux/LogitechMX_kernel_and_X_pat=
ch/4.3.0-XFree86_logitech_ps2.patch),
> to make it understand PS/2+ protocol. Do I need this for the MX900 ?

I don't have applied this patch, so I think this is not needed. (but I
don't know anything about this patch.

> 2. bthid patches
>=20
> - started with the bthid 0.8 stock source
> - applied Edd Dumbill's uinput patch
> - applied Olivier Bornet's patch-bthid-0.6-for-lt.txt
> - modified out.c to use /dev/misc/uinput (Marcel says devfs produce
> this, I don't see exactly what I do wrong or what I should do to get
> /dev/input/uinput).

OK. Almost the same for me, with a 2.6.0-test11 kernel.

> 3. XF86Config-4
>=20
> --------
> Section "InputDevice"
>         Identifier              "LogitechUSBMouse"
>         Driver                  "mouse"
>         Option "Protocol"       "ExplorerPS/2"
>         Option "Device"         "/dev/input/mice"
>         Option "ZAxisMapping"   "7 8"
>         Option "Resolution"     "800"
>         Option "SmartScroll"    "1"
>         Option "Buttons"        "8"
>         Option "Emulate3Buttons" "false"
> EndSection
> ----------------

Usualy, the ZAxisMapping in on the buttons 4 and 5. Here is my
XF86Config-4 related section:

----------
Section "InputDevice"
        Identifier      "USB Mouse"
        Driver          "mouse"
        Option          "SendCoreEvents"        "true"
        Option          "Device"                "/dev/input/mice"
        Option          "Protocol"              "ImPS/2"
        Option          "Buttons"               "5"
        Option          "Emulate3Buttons"       "true"
        Option          "ZAxisMapping"          "4 5"
EndSection
----------

With this config, the mouse wheel is working ok.

Hope this help.

		Olivier
--=20
Olivier Bornet                      http://www.smartdata.ch/
Olivier.Bornet@smartdata.ch         SMARTDATA SA
GPG key ID: C53D9218                CH Martigny/Lausanne

--72k7VsmfIboquFwl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/1k/Jdj3R/MU9khgRArnZAJsF6L0zVlllkREJQpMTSO1gXasBjQCg2iEe
KXItAP3SKFHgQwTDxNeGK9M=
=XtB4
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
