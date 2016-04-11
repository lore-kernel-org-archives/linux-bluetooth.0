Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        "wnhuang@chromium.com"
	<wnhuang@chromium.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Xinming Hu <huxm@marvell.com>
Subject: RE: [PATCH v6 2/2] btmrvl: add platform specific wakeup interrupt
 support
Date: Mon, 11 Apr 2016 04:38:40 +0000
Message-ID: <171a54de45594926857b1bc3d76ea253@SC-EXCH04.marvell.com>
References: <1459344056-5234-1-git-send-email-akarwar@marvell.com>
 <1459344056-5234-2-git-send-email-akarwar@marvell.com>
 <B99FD549-3D36-4A89-83F3-E4170ADE1336@holtmann.org>
In-Reply-To: <B99FD549-3D36-4A89-83F3-E4170ADE1336@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Friday, April 08, 2016 10:40 PM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; Nishant Sarmukadam;
> wnhuang@chromium.com; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Xinming Hu
> Subject: Re: [PATCH v6 2/2] btmrvl: add platform specific wakeup
> interrupt support
>=20
> Hi Amitkumar,
>=20
> > On some arm-based platforms, we need to configure platform specific
> > parameters by device tree node and we need define our node as a child
> > node of parent SDIO host controller.
> > This patch parses these parameters from device tree. It includes
> > calibration data download to firmware, wakeup pin configured to
> > firmware, and soc specific wakeup interrupt pin.
> >
> > Signed-off-by: Xinming Hu <huxm@marvell.com>
> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > ---
> > drivers/bluetooth/btmrvl_drv.h  | 11 ++++++
> > drivers/bluetooth/btmrvl_main.c | 33 +++++++++--------
> > drivers/bluetooth/btmrvl_sdio.c | 79
> > +++++++++++++++++++++++++++++++++++++++++
> > drivers/bluetooth/btmrvl_sdio.h |  6 ++++
> > 4 files changed, 115 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btmrvl_drv.h
> > b/drivers/bluetooth/btmrvl_drv.h index 0590473..f742384 100644
> > --- a/drivers/bluetooth/btmrvl_drv.h
> > +++ b/drivers/bluetooth/btmrvl_drv.h
> > @@ -23,6 +23,17 @@
> > #include <linux/bitops.h>
> > #include <linux/slab.h>
> > #include <net/bluetooth/bluetooth.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio.h>
> > +#include <linux/gfp.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
> > +#include <linux/of_irq.h>
> >
> > #define BTM_HEADER_LEN			4
> > #define BTM_UPLD_SIZE			2312
> > diff --git a/drivers/bluetooth/btmrvl_main.c
> > b/drivers/bluetooth/btmrvl_main.c index f25a825..25343ef 100644
> > --- a/drivers/bluetooth/btmrvl_main.c
> > +++ b/drivers/bluetooth/btmrvl_main.c
> > @@ -510,34 +510,39 @@ static int btmrvl_download_cal_data(struct
> > btmrvl_private *priv, static int btmrvl_check_device_tree(struct
> > btmrvl_private *priv) {
> > 	struct device_node *dt_node;
> > +	struct btmrvl_sdio_card *card =3D priv->btmrvl_dev.card;
> > 	u8 cal_data[BT_CAL_HDR_LEN + BT_CAL_DATA_SIZE];
> > -	int ret;
> > -	u32 val;
> > +	int ret =3D 0;
> > +	u16 gpio, gap;
> > +
> > +	if (card->plt_of_node) {
> > +		dt_node =3D card->plt_of_node;
> > +		ret =3D of_property_read_u16(dt_node, "btmrvl,wakeup-pin",
> > +					   &gpio);
> > +		if (ret)
> > +			gpio =3D (priv->btmrvl_dev.gpio_gap & 0xff00) >> 8;
> > +
> > +		ret =3D of_property_read_u16(dt_node, "btmrvl,wakeup-gap",
> > +					   &gap);
> > +		if (ret)
> > +			gap =3D (u8)(priv->btmrvl_dev.gpio_gap & 0x00ff);
> >
> > -	for_each_compatible_node(dt_node, NULL, "btmrvl,cfgdata") {
> > -		ret =3D of_property_read_u32(dt_node, "btmrvl,gpio-gap",
> &val);
> > -		if (!ret)
> > -			priv->btmrvl_dev.gpio_gap =3D val;
> > +		priv->btmrvl_dev.gpio_gap =3D (gpio << 8) + gap;
> >
> > 		ret =3D of_property_read_u8_array(dt_node, "btmrvl,cal-data",
> > 						cal_data + BT_CAL_HDR_LEN,
> > 						BT_CAL_DATA_SIZE);
> > -		if (ret) {
> > -			of_node_put(dt_node);
> > +		if (ret)
> > 			return ret;
> > -		}
> >
> > 		BT_DBG("Use cal data from device tree");
> > 		ret =3D btmrvl_download_cal_data(priv, cal_data,
> > 					       BT_CAL_DATA_SIZE);
> > -		if (ret) {
> > +		if (ret)
> > 			BT_ERR("Fail to download calibrate data");
> > -			of_node_put(dt_node);
> > -			return ret;
> > -		}
> > 	}
> >
> > -	return 0;
> > +	return ret;
> > }
> >
> > static int btmrvl_setup(struct hci_dev *hdev) diff --git
> > a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> > index 6ed8acf..c714040 100644
> > --- a/drivers/bluetooth/btmrvl_sdio.c
> > +++ b/drivers/bluetooth/btmrvl_sdio.c
> > @@ -52,6 +52,68 @@ static struct memory_type_mapping
> mem_type_mapping_tbl[] =3D {
> > 	{"EXTLAST", NULL, 0, 0xFE},
> > };
> >
> > +static const struct of_device_id btmrvl_sdio_of_match_table[] =3D {
> > +	{ .compatible =3D "marvell,sd8897-bt" },
> > +	{ .compatible =3D "marvell,sd8997-bt" },
> > +	{ }
> > +};
>=20
> is this agreed upon by the DT maintainer? I only want to merge this
> patch if we have agreement.
>=20

Please hold on for this patch. Rob Herring had suggested to use Linux kerne=
l's generic wake irq handling. We found out it's not suitable for us. We wi=
ll discuss it with Rob.

Regards,
Amitkumar
