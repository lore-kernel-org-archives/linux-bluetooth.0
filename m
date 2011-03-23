Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>
Date: Wed, 23 Mar 2011 17:08:42 +0100
Subject: RE: [PATCH 2/2] mach-ux500: Add CG2900 devices
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C4DE937@EXDCVYMBSTM005.EQ1STM.local>
References: <1300888803-26474-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <201103231542.28311.arnd@arndb.de>
In-Reply-To: <201103231542.28311.arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,
=20
> > diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-
> ux500/Makefile
> > index b549a8f..47c92fa 100644
> > --- a/arch/arm/mach-ux500/Makefile
> > +++ b/arch/arm/mach-ux500/Makefile
> > @@ -2,6 +2,9 @@
> >  # Makefile for the linux kernel, U8500 machine.
> >  #
> >
> > +ccflags-y :=3D					\
> > +	-Idrivers/staging/cg2900/include
> > +
> >  obj-y				:=3D clock.o cpu.o devices.o
> devices-common.o \
> >  				   id.o usb.o
>=20
> Could we keep this more self-contained? Just register a
> single device with the necessary resources and let the
> staging driver figure out how to initialize it, rather
> than splitting it between mach-ux500 and drivers/staging.
>=20

I will see what I can do.

> > +#ifdef CONFIG_CG2900
> > +#define CG2900_BT_ENABLE_GPIO		170
> > +#define CG2900_GBF_ENA_RESET_GPIO	171
> > +#define CG2900_BT_CTS_GPIO		0
>=20
> Don't make hardware definitions depending on Kconfig symbols.
> Just describe what the hardware looks like if present, and
> let the board code figure out if it's actually there.
>=20

Will fix.

> > +static struct platform_device ux500_cg2900_device =3D {
> > +	.name =3D "cg2900",
> > +};
> > +
> > +#ifdef CONFIG_CG2900_CHIP
> > +static struct platform_device ux500_cg2900_chip_device =3D {
> > +	.name =3D "cg2900-chip",
> > +	.dev =3D {
> > +		.parent =3D &ux500_cg2900_device.dev,
> > +	},
> > +};
> > +#endif /* CONFIG_CG2900_CHIP */
> > +
> > +#ifdef CONFIG_STLC2690_CHIP
> > +static struct platform_device ux500_stlc2690_chip_device =3D {
> > +	.name =3D "stlc2690-chip",
> > +	.dev =3D {
> > +		.parent =3D &ux500_cg2900_device.dev,
> > +	},
> > +};
> > +#endif /* CONFIG_STLC2690_CHIP */
> > +
> > +#ifdef CONFIG_CG2900_TEST
> > +static struct cg2900_platform_data cg2900_test_platform_data =3D {
> > +	.bus =3D HCI_VIRTUAL,
> > +	.gpio_sleep =3D cg2900_sleep_gpio,
> > +};
>=20
> Also, don't make the device registration dependent on the Kconfig.
> Make sure that the hardware is there by asking the hardware, then
> register it, even if we don't compile the driver using it.
>=20
> I assume that this would get much simpler if you register everything
> from the .probe function of the main "cg2900" device.
>=20

I will see how I can fix this. I'm not 100% how I will solve the
"asking the hardware" part, but as you say we might be able to do
this in a better way by doing it from the main staging driver instead.

> > diff --git a/arch/arm/mach-ux500/devices-cg2900.c b/arch/arm/mach-
> ux500/devices-cg2900.c
> > new file mode 100644
> > index 0000000..525c871
> > --- /dev/null
> > +++ b/arch/arm/mach-ux500/devices-cg2900.c
>=20
> As far as I can tell, everything in this file can simply become part of
> the
> staging driver. I'm fine with basically anything that compiles going
> into
> drivers/staging, but we should keep the platform code outside of
> staging
> clean of stuff that might have to change as part of the staging
> process.
>=20
> 	Arnd

I agree that we can probably move at least most of the code, maybe all.
I will check and update.

Thanks,
/P-G
