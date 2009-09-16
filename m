Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB12F11.5060305@dell.com>
Date: Wed, 16 Sep 2009 13:31:45 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluez: correct udev rule for Dell mouse
References: <20090916072858.GA22262@yangyi-dev.bj.intel.com>
In-Reply-To: <20090916072858.GA22262@yangyi-dev.bj.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB239CC956F296C0A85EAE9D9"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB239CC956F296C0A85EAE9D9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



Yi Yang wrote:
> From dbcfcf5dfbdef2377f64c7cd737886e31ae17615 Mon Sep 17 00:00:00 2001
> From: root <root@yangyi-dev.localdomain>
> Date: Wed, 16 Sep 2009 15:19:13 +0800
> Subject: [PATCH] Correct rule for Dell mouse
>
> Note: this rule should just for Dell bluetooth mouse, but it
> does function for Dell general USB mouse, such as this one:
>
>     ID 413c:3010 Dell Computer Corp. Optical Wheel Mouse
>
> We should let it just function for Dell bluetooth mouse, udev
> 144 and later has included rules for hid2hci
> extras/hid2hci/70-hid2hci.rules which has correct one, so we
> should use that one
> ---
>  scripts/bluetooth-hid2hci.rules |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/scripts/bluetooth-hid2hci.rules b/scripts/bluetooth-hid2hc=
i.rules
> index 1b231d1..eb63292 100644
> --- a/scripts/bluetooth-hid2hci.rules
> +++ b/scripts/bluetooth-hid2hci.rules
> @@ -8,7 +8,8 @@
>  #   413c:8154
>  #   413c:8158
>  #   413c:8162
> -ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"413c", ENV{ID_CLASS}=3D=3D"mou=
se", ATTRS{bmAttributes}=3D=3D"e0", KERNEL=3D=3D"mouse*", RUN+=3D"/usr/sb=
in/hid2hci --method dell -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"=

> +ATTR{bInterfaceClass}=3D=3D"03", ATTR{bInterfaceSubClass}=3D=3D"01", A=
TTR{bInterfaceProtocol}=3D=3D"02", ATTRS{bDeviceClass}=3D=3D"00", ATTRS{i=
dVendor}=3D=3D"413c", ATTRS{bmAttributes}=3D=3D"e0", \
> +    RUN+=3D"hid2hci --method dell -v $attr{idVendor} -p $attr{idProduc=
t} --mode hci"
> =20
>  # Logitech devices
>  ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70=
3" RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env=
{ID_MODEL} --mode hci"
>  =20
I think hid2hci should just be dropped, or hid2hci AND rules should be
synced from the udev source.  Everything is done right in the udev
source tree.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigB239CC956F296C0A85EAE9D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqxLxEACgkQ2CrZjkA73Ys9GACcDrh4//SL92L1YzF07AkTf1U3
QvkAn1RJqZ92VttsssxYBbt4rChn6Moo
=yM82
-----END PGP SIGNATURE-----

--------------enigB239CC956F296C0A85EAE9D9--
