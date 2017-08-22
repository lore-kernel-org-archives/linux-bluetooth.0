Return-Path: <maxime.ripard@free-electrons.com>
Date: Tue, 22 Aug 2017 09:47:26 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Loic Poulain <loic.poulain@gmail.com>
Cc: robh+dt@kernel.org, rjui@broadcom.com, sbranden@broadcom.com,
	f.fainelli@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
	stefan.wahren@i2se.com, linux-rpi-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add
 broadcom-bluetooth
Message-ID: <20170822074726.e424lflqxn6mb4xd@flea.lan>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bwwwc46oaqnuttbv"
In-Reply-To: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--bwwwc46oaqnuttbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Loic,

On Tue, Aug 01, 2017 at 10:38:22AM +0200, Loic Poulain wrote:
> Add binding document for serial bluetooth chips using
> Broadcom protocol.
>=20
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
> v2: dt-bindings as separate patch
>     rebase on upcoming pi3 dts changes
>=20
>  .../devicetree/bindings/net/broadcom-bluetooth.txt | 29 ++++++++++++++++=
++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/broadcom-blueto=
oth.txt
>=20
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt=
 b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> new file mode 100644
> index 0000000..c51ea1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> @@ -0,0 +1,29 @@
> +Broadcom Bluetooth Chips
> +---------------------
> +
> +This documents the binding structure and common properties for serial
> +attached Broadcom devices.
> +
> +Serial attached Broadcom devices shall be a child node of the host UART
> +device the slave device is attached to.
> +
> +Required properties:
> +
> + - compatible: should contain one of the following:
> +   * "brcm,bcm43438-bt"
> +
> +Optional properties:
> +
> + - max-speed: see Documentation/devicetree/bindings/serial/slave-device.=
txt
> +
> +Example:
> +
> +&uart2 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&uart2_pins>;
> +
> +       bluetooth {
> +               compatible =3D "brcm,bcm43438-bt";
> +               max-speed =3D <921600>;
> +       };
> +};

Thanks a lot for working on that, I've made a similar attempt a few
weeks ago but didn't manage to get it to work.

The way it's hooked in our boards is a bit more complex though, even
if it could be because we're using a different part.

In order to get it running we need:
  - two clocks, called in the broadcom datasheets lpo and tcxo.
  - three GPIOs, device wakeup, host wakeup and a shutdown GPIO (which
    might be the BT_ON you were discussing about)
  - two regulators called vbat and reg-en for us (I guess they're
    meant to power the chip, and its registers)

Do you know if you're also using those? Or could it be that it's just
hardwired to some non-gatable crystal / regulator on the RPI?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--bwwwc46oaqnuttbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZm+GOAAoJEBx+YmzsjxAgHqQP/3Ai2xt5IDslv+iKP4hnevbe
T1WcBnZo57O4UiUDoUgnWlB5875aT5z5EpvKTKnOfrAVZ8NFsioz8KuM8pTeN3Gv
fsy+S3wGijzTgECE7+05g4Rurt/ee6H+IQPzeUpkO6kRmh7A3MpQe6eSeNz6xECq
Rf83+DmlQXaxeas26OjCOEAycKDwAKSfqLs92BF94OrxdDIf9pRU1rUIftrk0B4S
YUz/UeDY3diG5DS+2tQ+ldzA7WBMyLWCpYyxYOJcdnBkPnczSS36kUZztblO7GHN
3EXDBOdI0WiWuFJAc//ym3VreKYavWgOuxqGpZ+YQJ5Y7SEeo5sZfdZk8wz23F/Q
6Y6yxeD74DZdddOLZaMFxdqA2nHMNrJxtdONS9GGXmIWhAazlOt2+yssRiO2hfaW
e2Exv36xLj93CRS4wU5XT9bnHIM9zZ293tnMInsOW1aZ4m7Gp2hUDgxfnwSTUWwp
49JACaw4HkToJ3Ua2ElSFyFD589laVZ11CL27k1Y9GuYKRz5FPdWsHLdymRx3AyA
8wcc/S3drGKRdUJbrH1alx9po9EVyPOZ5081co5zR6INbbsv4gWxsrqWUWGXDfho
epz2oFFBjOzbjoZkDl9Sx50akmBZDyJxGnM2rx1XbwP9fQtoLrOuagT2NNxrwHCH
8Ct7ZrT3ad7Qg1uwacw3
=XgNC
-----END PGP SIGNATURE-----

--bwwwc46oaqnuttbv--
