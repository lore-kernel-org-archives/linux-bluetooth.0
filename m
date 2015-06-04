Return-Path: <cyrus@holtmann.org>
Message-ID: <55700F53.8030700@linux.intel.com>
Date: Thu, 04 Jun 2015 10:41:55 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] Broadcom Bluetooth UART Platform Driver
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com> <1433365304-16707-4-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1433365304-16707-4-git-send-email-ifaenson@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Ilya,

On 03/06/2015 23:01, Ilya Faenson wrote:
> Introduce the device tree enumerated Broadcom Bluetooth UART driver.
>
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
>   drivers/bluetooth/Kconfig      |   9 +
>   drivers/bluetooth/Makefile     |   1 +
>   drivers/bluetooth/btbcm_uart.c | 673 +++++++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btbcm_uart.h |  89 ++++++
>   4 files changed, 772 insertions(+)
>   create mode 100644 drivers/bluetooth/btbcm_uart.c
>   create mode 100644 drivers/bluetooth/btbcm_uart.h
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 2e77707..5eee3ed 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -143,6 +143,7 @@ config BT_HCIUART_BCM
>   	bool "Broadcom protocol support"
>   	depends on BT_HCIUART
>   	select BT_HCIUART_H4
> +	select BT_UART_BCM
>   	select BT_BCM
>   	help
>   	  The Broadcom protocol support enables Bluetooth HCI over serial
> @@ -150,6 +151,14 @@ config BT_HCIUART_BCM
>
>   	  Say Y here to compile support for Broadcom protocol.
>
> +config BT_UART_BCM
> +	tristate "Broadcom BT UART driver"
> +	depends on BT_HCIUART_H4 && TTY
> +	help
> +	  This driver supports the HCI_UART_BT protocol.
> +
> +	  It manages Bluetooth UART device properties and GPIOs.
> +
>   config BT_HCIBCM203X
>   	tristate "HCI BCM203x USB driver"
>   	depends on USB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index f40e194..e908a88 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
>   obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
>   obj-$(CONFIG_BT_WILINK)		+= btwilink.o
>   obj-$(CONFIG_BT_BCM)		+= btbcm.o
> +obj-$(CONFIG_BT_UART_BCM)	+= btbcm_uart.o
>   obj-$(CONFIG_BT_RTL)		+= btrtl.o
>
>   btmrvl-y			:= btmrvl_main.o
> diff --git a/drivers/bluetooth/btbcm_uart.c b/drivers/bluetooth/btbcm_uart.c
> new file mode 100644
> index 0000000..ccd02a9
> --- /dev/null
> +++ b/drivers/bluetooth/btbcm_uart.c
> @@ -0,0 +1,673 @@
> +/*
> + *  Bluetooth BCM UART Driver
> + *
> + *  Copyright (c) 2015 Broadcom Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/fcntl.h>
> +#include <linux/interrupt.h>
> +#include <linux/ptrace.h>
> +#include <linux/poll.h>
> +
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/signal.h>
> +#include <linux/ioctl.h>
> +#include <linux/skbuff.h>
> +#include <linux/list.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_platform.h>
> +
> +#include "btbcm_uart.h"
> +
> +static int idle_timeout = 5;
> +module_param(idle_timeout, int, 0);
> +MODULE_PARM_DESC(idle_timeout, "Bluetooth idle timeout in seconds");
> +
> +/* Device context */
> +struct bcm_device {
> +	struct list_head list;
> +
> +	struct platform_device *pdev;
> +	struct gpio_desc *bt_wake_gpio;
> +	struct gpio_desc *dev_wake_gpio;
> +	struct gpio_desc *reg_on_gpio;
> +	int bt_wake_irq;
> +	int dev_wake_active_low;
> +	int reg_on_active_low;
> +	int bt_wake_active_low;
> +	bool configure_sleep;
> +	u32 manual_fc;
> +	u32 oper_speed;
> +	bool configure_audio;
> +	u32 pcm_clockmode;
> +	u32 pcm_fillmethod;
> +	u32 pcm_fillnum;
> +	u32 pcm_fillvalue;
> +	u32 pcm_incallbitclock;
> +	u32 pcm_lsbfirst;
> +	u32 pcm_rightjustify;
> +	u32 pcm_routing;
> +	u32 pcm_shortframesync;
> +	u32 pcm_syncmode;
> +
> +	char tty_name[64];
> +
> +	struct btbcm_uart_callbacks protocol_callbacks;
> +	struct work_struct wakeup_work;
> +};
> +
> +/* List of BCM BT UART devices */
> +static DEFINE_SPINLOCK(device_list_lock);
> +static LIST_HEAD(device_list);
> +
> +/*
> + * Calling the BCM protocol at lower execution priority
> + */
> +static void bcm_bt_wakeup_task(struct work_struct *ws)
> +{
> +	int gpio_value;
> +	struct bcm_device *p_bcm_device =
> +		container_of(ws, struct bcm_device, wakeup_work);
> +
> +	if (!p_bcm_device) {
> +		BT_DBG("%s - failing, no device", __func__);

You do not need to include the function name in BT_DBG, this is managed 
by dynamic debug feature +f flag when enabling debug traces.

Regards

Fred
