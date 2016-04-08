Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 2/2] btmrvl: add platform specific wakeup interrupt support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1459344056-5234-2-git-send-email-akarwar@marvell.com>
Date: Fri, 8 Apr 2016 10:09:55 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	wnhuang@chromium.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xinming Hu <huxm@marvell.com>
Message-Id: <B99FD549-3D36-4A89-83F3-E4170ADE1336@holtmann.org>
References: <1459344056-5234-1-git-send-email-akarwar@marvell.com> <1459344056-5234-2-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> On some arm-based platforms, we need to configure platform specific
> parameters by device tree node and we need define our node as a child
> node of parent SDIO host controller.
> This patch parses these parameters from device tree. It includes
> calibration data download to firmware, wakeup pin configured to firmware,
> and soc specific wakeup interrupt pin.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_drv.h  | 11 ++++++
> drivers/bluetooth/btmrvl_main.c | 33 +++++++++--------
> drivers/bluetooth/btmrvl_sdio.c | 79 +++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btmrvl_sdio.h |  6 ++++
> 4 files changed, 115 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
> index 0590473..f742384 100644
> --- a/drivers/bluetooth/btmrvl_drv.h
> +++ b/drivers/bluetooth/btmrvl_drv.h
> @@ -23,6 +23,17 @@
> #include <linux/bitops.h>
> #include <linux/slab.h>
> #include <net/bluetooth/bluetooth.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/gfp.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/of_irq.h>
> 
> #define BTM_HEADER_LEN			4
> #define BTM_UPLD_SIZE			2312
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index f25a825..25343ef 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -510,34 +510,39 @@ static int btmrvl_download_cal_data(struct btmrvl_private *priv,
> static int btmrvl_check_device_tree(struct btmrvl_private *priv)
> {
> 	struct device_node *dt_node;
> +	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
> 	u8 cal_data[BT_CAL_HDR_LEN + BT_CAL_DATA_SIZE];
> -	int ret;
> -	u32 val;
> +	int ret = 0;
> +	u16 gpio, gap;
> +
> +	if (card->plt_of_node) {
> +		dt_node = card->plt_of_node;
> +		ret = of_property_read_u16(dt_node, "btmrvl,wakeup-pin",
> +					   &gpio);
> +		if (ret)
> +			gpio = (priv->btmrvl_dev.gpio_gap & 0xff00) >> 8;
> +
> +		ret = of_property_read_u16(dt_node, "btmrvl,wakeup-gap",
> +					   &gap);
> +		if (ret)
> +			gap = (u8)(priv->btmrvl_dev.gpio_gap & 0x00ff);
> 
> -	for_each_compatible_node(dt_node, NULL, "btmrvl,cfgdata") {
> -		ret = of_property_read_u32(dt_node, "btmrvl,gpio-gap", &val);
> -		if (!ret)
> -			priv->btmrvl_dev.gpio_gap = val;
> +		priv->btmrvl_dev.gpio_gap = (gpio << 8) + gap;
> 
> 		ret = of_property_read_u8_array(dt_node, "btmrvl,cal-data",
> 						cal_data + BT_CAL_HDR_LEN,
> 						BT_CAL_DATA_SIZE);
> -		if (ret) {
> -			of_node_put(dt_node);
> +		if (ret)
> 			return ret;
> -		}
> 
> 		BT_DBG("Use cal data from device tree");
> 		ret = btmrvl_download_cal_data(priv, cal_data,
> 					       BT_CAL_DATA_SIZE);
> -		if (ret) {
> +		if (ret)
> 			BT_ERR("Fail to download calibrate data");
> -			of_node_put(dt_node);
> -			return ret;
> -		}
> 	}
> 
> -	return 0;
> +	return ret;
> }
> 
> static int btmrvl_setup(struct hci_dev *hdev)
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 6ed8acf..c714040 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -52,6 +52,68 @@ static struct memory_type_mapping mem_type_mapping_tbl[] = {
> 	{"EXTLAST", NULL, 0, 0xFE},
> };
> 
> +static const struct of_device_id btmrvl_sdio_of_match_table[] = {
> +	{ .compatible = "marvell,sd8897-bt" },
> +	{ .compatible = "marvell,sd8997-bt" },
> +	{ }
> +};

is this agreed upon by the DT maintainer? I only want to merge this patch if we have agreement.

Regards

Marcel

