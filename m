Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>, Zhaoyang Liu <liuzy@marvell.com>
Subject: RE: [PATCH 2/2] Bluetooth: btmrvl: add sd8997 chipset support
Date: Mon, 21 Sep 2015 10:06:18 +0000
Message-ID: <9a8b43c98ff5401cba0403372d6bd0dd@SC-EXCH04.marvell.com>
References: <1442583641-3182-1-git-send-email-akarwar@marvell.com>
 <1442583641-3182-2-git-send-email-akarwar@marvell.com>
 <E128FA2E-8B51-4205-92C6-B317F91FDE0F@holtmann.org>
In-Reply-To: <E128FA2E-8B51-4205-92C6-B317F91FDE0F@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Friday, September 18, 2015 9:16 PM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; Cathy Luo; Zhaoyang Liu
> Subject: Re: [PATCH 2/2] Bluetooth: btmrvl: add sd8997 chipset support
>=20
> Hi Amitkumar,
>=20
> > This patch adds support for Marvell's new chipset SD8997.
> > Register offsets and supported feature flags are updated.
> >
> > Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
> > Signed-off-by: Cathy Luo <cluo@marvell.com>
> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > ---
> > drivers/bluetooth/Kconfig       |  4 ++--
> > drivers/bluetooth/btmrvl_sdio.c | 36
> > ++++++++++++++++++++++++++++++++++++
> > 2 files changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > index 0bd88c9..3d480d8 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -275,7 +275,7 @@ config BT_MRVL
> > 	  The core driver to support Marvell Bluetooth devices.
> >
> > 	  This driver is required if you want to support
> > -	  Marvell Bluetooth devices, such as 8688/8787/8797/8887/8897.
> > +	  Marvell Bluetooth devices, such as
> 8688/8787/8797/8887/8897/8997.
> >
> > 	  Say Y here to compile Marvell Bluetooth driver
> > 	  into the kernel or say M to compile it as module.
> > @@ -289,7 +289,7 @@ config BT_MRVL_SDIO
> > 	  The driver for Marvell Bluetooth chipsets with SDIO interface.
> >
> > 	  This driver is required if you want to use Marvell Bluetooth
> > -	  devices with SDIO interface. Currently
> SD8688/SD8787/SD8797/SD8887/SD8897
> > +	  devices with SDIO interface. Currently
> > +SD8688/SD8787/SD8797/SD8887/SD8897/SD8997
> > 	  chipsets are supported.
> >
> > 	  Say Y here to compile support for Marvell BT-over-SDIO driver
> diff
> > --git a/drivers/bluetooth/btmrvl_sdio.c
> > b/drivers/bluetooth/btmrvl_sdio.c index 5f7c9be..6e2c6d5 100644
> > --- a/drivers/bluetooth/btmrvl_sdio.c
> > +++ b/drivers/bluetooth/btmrvl_sdio.c
> > @@ -146,6 +146,29 @@ static const struct btmrvl_sdio_card_reg
> btmrvl_reg_8897 =3D {
> > 	.fw_dump_end =3D 0xea,
> > };
> >
> > +static const struct btmrvl_sdio_card_reg btmrvl_reg_8997 =3D {
> > +	.cfg =3D 0x00,
> > +	.host_int_mask =3D 0x08,
> > +	.host_intstatus =3D 0x0c,
> > +	.card_status =3D 0x5c,
> > +	.sq_read_base_addr_a0 =3D 0xf8,
> > +	.sq_read_base_addr_a1 =3D 0xf9,
> > +	.card_revision =3D 0xc8,
> > +	.card_fw_status0 =3D 0xe8,
> > +	.card_fw_status1 =3D 0xe9,
> > +	.card_rx_len =3D 0xea,
> > +	.card_rx_unit =3D 0xeb,
> > +	.io_port_0 =3D 0xe4,
> > +	.io_port_1 =3D 0xe5,
> > +	.io_port_2 =3D 0xe6,
> > +	.int_read_to_clear =3D true,
> > +	.host_int_rsr =3D 0x04,
> > +	.card_misc_cfg =3D 0xD8,
> > +	.fw_dump_ctrl =3D 0xf0,
> > +	.fw_dump_start =3D 0xf1,
> > +	.fw_dump_end =3D 0xf8,
> > +};
> > +
> > static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 =3D {
> > 	.helper		=3D "mrvl/sd8688_helper.bin",
> > 	.firmware	=3D "mrvl/sd8688.bin",
> > @@ -191,6 +214,15 @@ static const struct btmrvl_sdio_device
> btmrvl_sdio_sd8897 =3D {
> > 	.supports_fw_dump =3D true,
> > };
> >
> > +static const struct btmrvl_sdio_device btmrvl_sdio_sd8997 =3D {
> > +	.helper         =3D NULL,
> > +	.firmware       =3D "mrvl/sdsd8997_combo.bin",
> > +	.reg            =3D &btmrvl_reg_8997,
> > +	.support_pscan_win_report =3D true,
> > +	.sd_blksz_fw_dl =3D 256,
> > +	.supports_fw_dump =3D true,
> > +};
> > +
> > static const struct sdio_device_id btmrvl_sdio_ids[] =3D {
> > 	/* Marvell SD8688 Bluetooth device */
> > 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9105), @@ -210,6 +242,9 @@
> > static const struct sdio_device_id btmrvl_sdio_ids[] =3D {
> > 	/* Marvell SD8897 Bluetooth device */
> > 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912E),
> > 			.driver_data =3D (unsigned long) &btmrvl_sdio_sd8897 },
>=20
> please send a patch to fix the coding style for the extra space in the
> cast first. Lets make it all unique.

Sure. I will send separate patch for this change.

> > +	/* Marvell SD8997 Bluetooth device */
> > +	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9142),
> > +			.driver_data =3D (unsigned long)&btmrvl_sdio_sd8997 },
> >
> > 	{ }	/* Terminating entry */
> > };
> > @@ -1622,3 +1657,4 @@ MODULE_FIRMWARE("mrvl/sd8787_uapsta.bin");
> > MODULE_FIRMWARE("mrvl/sd8797_uapsta.bin");
> > MODULE_FIRMWARE("mrvl/sd8887_uapsta.bin");
> > MODULE_FIRMWARE("mrvl/sd8897_uapsta.bin");
> > +MODULE_FIRMWARE("mrvl/sdsd8997_combo.bin");
>=20
> Is the "sdsd" intentionally here. For me this looks like a typo.
>=20

Thanks for pointing this out. I will correct this typo in updated version.

Regards,
Amitkumar
