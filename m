Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH net-next] iwmc3200bt: Add iwmc3200 bluetooth driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: linux-bluetooth@vger.kernel.org, guy.cohen@intel.com,
	ron.rindjunsky@intel.com
In-Reply-To: <1257204990-18669-1-git-send-email-tomas.winkler@intel.com>
References: <1257204990-18669-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain
Date: Tue, 03 Nov 2009 10:55:10 +0900
Message-Id: <1257213310.3420.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

so I removed all the unneeded parties from this thread since there is no
point in spamming everybody with this.

> Add Intel Wireless MultiCom 3200 SDIO BT driver
> IWMC3200 is 4Wireless Com CHIP (GPS/BT/WiFi/WiMAX).
> wmc3200bt is derived from btsdio driver
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/bluetooth/Kconfig      |   16 ++
>  drivers/bluetooth/Makefile     |    2 +
>  drivers/bluetooth/iwmc3200bt.c |  553 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 571 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/bluetooth/iwmc3200bt.c
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 652367a..e520889 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -195,5 +195,21 @@ config BT_MRVL_SDIO
>  	  Say Y here to compile support for Marvell BT-over-SDIO driver
>  	  into the kernel or say M to compile it as module.
>  
> +config BT_IWMC3200
> +        tristate "Intel Wireless MultiCom 3200 SDIO BT driver"
> +        depends on IWMC3200TOP && EXPERIMENTAL
> +        help
> +          Intel Wireless MultiCom 3200 SDIO Bluetooth driver
> +
> +	  Say Y here to compile support for IWMC3200 SDIO BT driver
> +	  into the kernel or say M to compile it as module.
> +
> +config BT_IWMC3200_DEBUG
> +        bool "Enable verbose debugging for iwmc3200bt"
> +        depends on BT_IWMC3200
> +        help
> +	  Say Y here to enable IWMC3200 SDIO BT driver
> +	  verbose debugging
> +
>  endmenu
>  
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index b3f57d2..975036e 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -21,6 +21,8 @@ obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
>  btmrvl-y			:= btmrvl_main.o
>  btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
>  
> +obj-$(CONFIG_BT_IWMC3200)	+= iwmc3200bt.o
> +

sort this one before the Marvell driver since it is a one file only
driver.

>  hci_uart-y				:= hci_ldisc.o
>  hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
>  hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
> diff --git a/drivers/bluetooth/iwmc3200bt.c b/drivers/bluetooth/iwmc3200bt.c
> new file mode 100644
> index 0000000..5aed7a3
> --- /dev/null
> +++ b/drivers/bluetooth/iwmc3200bt.c
> @@ -0,0 +1,553 @@
> +/*
> + *  ibtsdio - Intel Wireless MultiCom 3200 Bluetooth SDIO Driver
> + *  drivers/bluetooth/ibtsdio.c
> + *
> + *  Copyright (C) 2009 Intel Corporation. All rights reserved.
> + *
> + *  Based on  drivers/bluetooth/btsdio.c
> + *  Copyright (C) 2007  Cambridge Silicon Radio Ltd.
> + *  Copyright (C) 2007  Marcel Holtmann <marcel@holtmann.org>

You mean "based on" or "90% copied" ;)

> +#ifdef CONFIG_BT_IWMC3200_DEBUG
> +#define IBT_DBG(func, fmt, arg...) \
> +	dev_dbg(&((func)->dev), "%s: " fmt "\n" , __func__ , ## arg)
> +#define IBT_ERR(func, fmt, arg...) \
> +	dev_err(&((func)->dev), "%s: " fmt "\n" , __func__ , ## arg)
> +#define IBT_DUMP(func, buf, size) do {					\
> +	char prefix_str[30 + 1];					\
> +	scnprintf(prefix_str, 30, "%s %s",				\
> +		dev_driver_string(&((func)->dev)),			\
> +		dev_name(&((func)->dev)));				\
> +	print_hex_dump(KERN_DEBUG, prefix_str, DUMP_PREFIX_OFFSET,	\
> +			16, 1, buf, size, false);			\
> +} while (0)
> +
> +#define VD "-d"
> +#else
> +#define IBT_DBG(func, fmt, arg...)
> +#define IBT_ERR(func, fmt, arg...)
> +#define IBT_DUMP(func, buf, size)
> +#define VD
> +#endif /* CONFIG_BT_IWMC3200_DEBUG */
> +
> +#ifdef REPOSITORY_LABEL
> +#define RL REPOSITORY_LABEL
> +#else
> +#define RL local
> +#endif

All of this debug stuff has to go away. It is really not needed and
BT_DBG with dynamic_printk support seems more than enough.

> +#define IWMCBT_VERSION "0.1.6"
> +
> +#define DRIVER_VERSION IWMCBT_VERSION "-"  __stringify(RL) VD

This one needs to be removed too. I don't care about the repository
label in upstream.

> +#define IWMC_BT_SDIO_DEVID (0x1406)
> +
> +static const struct sdio_device_id btsdio_table[] = {
> +	/* IWMC3200BT (0x1406) */
> +	{ SDIO_DEVICE(SDIO_VENDOR_ID_INTEL, 0x1406)},
> +	{ }	/* Terminating entry */
> +};

This is pointless. Just use the numbers directly. and put a proper
comment above SDIO_DEVICE with hardware this is. Also no need to repeat
the number in that comment.

> +
> +MODULE_DEVICE_TABLE(sdio, btsdio_table);
> +
> +struct btsdio_data {
> +	struct hci_dev   *hdev;
> +	struct sdio_func *func;
> +
> +	struct work_struct work;
> +
> +	struct sk_buff_head txq;
> +	unsigned char tx_buf[2048];
> +	unsigned char rx_buf[2048];
> +};

I know that you guys copied btsdio driver, but if you change the name,
then also change the internal structure names. So this these should be
called iwmc3200_data and etc.

Also I prefer that we allocate tx_buf and rx_buf so that they are
ensured to be aligned and we don't have to play alignment tricks during
the packet sending and receiving.

> +#define REG_RDAT     0x00	/* Receiver Data */
> +#define REG_TDAT     0x00	/* Transmitter Data */
> +#define REG_PC_RRT   0x10	/* Read Packet Control */
> +#define REG_PC_WRT   0x11	/* Write Packet Control */
> +#define REG_RTC_STAT 0x12	/* Retry Control Status */
> +#define REG_RTC_SET  0x12	/* Retry Control Set */
> +#define REG_INTRD    0x13	/* Interrupt Indication */
> +#define REG_CL_INTRD 0x13	/* Interrupt Clear */
> +#define REG_EN_INTRD 0x14	/* Interrupt Enable */
> +#define REG_MD_STAT  0x20	/* Bluetooth Mode Status */
> +#define REG_H2D_COUNT_L  0x2C
> +#define REG_H2D_COUNT_H  0x2D
> +
> +#ifdef CONFIG_BT_IWMC3200_DEBUG
> +static char *type_names[] = {
> +	"Illegal",
> +	"HCI_COMMAND_PKT",
> +	"HCI_ACLDATA_PKT",
> +	"HCI_SCODATA_PKT",
> +	"HCI_EVENT_PKT"
> +};
> +#endif /* CONFIG_BT_IWMC3200_DEBUG  */

No unneeded debug extras please. This is a Bluetooth HCI driver. It is
really not that complicated.

<snip>

I need the debug cleanup first, before continuing looking at the rest of
the driver.

> +
> +module_init(btsdio_init);
> +module_exit(btsdio_exit);
> +
> +MODULE_AUTHOR("Gregory Paskar <gregory.paskar@intel.com>");
> +MODULE_DESCRIPTION("IWMC Bluetooth SDIO driver ver " DRIVER_VERSION);
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("ibtsdio");

We are not using module aliases here. So that can be removed.

Regards

Marcel


