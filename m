Return-Path: <cyrus@holtmann.org>
Message-ID: <55702513.4020804@linux.intel.com>
Date: Thu, 04 Jun 2015 12:14:43 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5] BlueZ Broadcom UART Protocol
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com> <1433365304-16707-6-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1433365304-16707-6-git-send-email-ifaenson@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/06/2015 23:01, Ilya Faenson wrote:
> Merge Broadcom protocol with the Intel implementation, providing
> for UART setup, firmware download and power management.
>
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
>   drivers/bluetooth/hci_bcm.c | 481 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 466 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 1ec0b4a..2894253 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -3,6 +3,7 @@
>    *  Bluetooth HCI UART driver for Broadcom devices
>    *
>    *  Copyright (C) 2015  Intel Corporation
> + *  Copyright (C) 2015  Broadcom Corporation
>    *
>    *
>    *  This program is free software; you can redistribute it and/or modify
> @@ -24,45 +25,355 @@
>   #include <linux/kernel.h>
>   #include <linux/errno.h>
>   #include <linux/skbuff.h>
> +#include <linux/tty.h>
>
>   #include <net/bluetooth/bluetooth.h>
>   #include <net/bluetooth/hci_core.h>
>
>   #include "btbcm.h"
>   #include "hci_uart.h"
> +#include "btbcm_uart.h"
> +
> +#define BCM43XX_CLOCK_48 1
> +#define BCM43XX_CLOCK_24 2
>
>   struct bcm_data {
>   	struct sk_buff *rx_skb;
>   	struct sk_buff_head txq;
> +	struct hci_uart *hu;
> +
> +	bool is_suspended; /* suspend/resume flag */
> +
> +	struct timer_list timer; /* idle timer */
> +
> +	struct btbcm_uart_parameters pars; /* device parameters */
> +	void *device_context; /* ACPI/DT device context */
>   };
>
> +/* Suspend/resume synchronization mutex */
> +static DEFINE_MUTEX(plock);
> +
> +/* Forward reference */
> +static struct hci_uart_proto bcm_proto;
> +
> +/*
> + * Callbacks from the BCMBT_UART device
> + */
> +
> +/*
> + * The platform is suspending. Stop UART activity
> + */
> +static void suspend_notification(void *context)
> +{
> +	struct hci_uart *hu = (struct hci_uart *)context;
> +	struct bcm_data *h4 = hu->priv;
> +
> +	BT_DBG("%s: is_suspended %d", __func__, h4->is_suspended);

You do not need to include the function name in BT_DBG, this is managed 
by dynamic debug feature +f flag when enabling debug traces.

Regards

Fred
