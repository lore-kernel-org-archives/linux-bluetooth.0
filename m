Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2 5/5] BlueZ Broadcom UART Protocol
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433966720-17482-6-git-send-email-ifaenson@broadcom.com>
Date: Fri, 12 Jun 2015 11:31:23 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Arend van Spriel <arend@broadcom.com>
Message-Id: <10D46DDD-5B79-4D9C-92E8-0440A66CB45C@holtmann.org>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com> <1433966720-17482-6-git-send-email-ifaenson@broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> Merge Broadcom protocol with the existing implementation, providing
> for UART setup, firmware download and power management.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/hci_bcm.c | 400 ++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 384 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index e4d66b6..5ff35b7 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -3,6 +3,7 @@
>  *  Bluetooth HCI UART driver for Broadcom devices
>  *
>  *  Copyright (C) 2015  Intel Corporation
> + *  Copyright (C) 2015  Broadcom Corporation
>  *
>  *
>  *  This program is free software; you can redistribute it and/or modify
> @@ -24,6 +25,7 @@
> #include <linux/kernel.h>
> #include <linux/errno.h>
> #include <linux/skbuff.h>
> +#include <linux/tty.h>
> #include <linux/firmware.h>
> 
> #include <net/bluetooth/bluetooth.h>
> @@ -31,12 +33,170 @@
> 
> #include "btbcm.h"
> #include "hci_uart.h"
> +#include "btbcm_uart.h"
> 
> struct bcm_data {
> 	struct sk_buff *rx_skb;
> 	struct sk_buff_head txq;
> +	struct hci_uart *hu;
> +
> +	bool is_suspended; /* suspend/resume flag */
> +
> +	struct timer_list timer; /* idle timer */

I prefer not to use timers if we can use delayed work instead.

> +
> +	struct btbcm_uart_parameters pars; /* device parameters */

btbcm_uart_params and params please. No pars and not point in spelling out parameters in a struct name.

> +	void *device_context; /* ACPI/DT device context */
> };
> 
> +/* Suspend/resume synchronization mutex */
> +static DEFINE_MUTEX(plock);

Please use a more descriptive name than plock. That is too generic for a global variable.

> +
> +/* Forward reference */
> +static struct hci_uart_proto bcm_proto;

Why do we need this? I am generally not in favor of having forward reference until really really needed.

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

context is void * and so no need to cast.

> +	struct bcm_data *h4 = hu->priv;
> +
> +	BT_DBG("%s: is_suspended %d", __func__, h4->is_suspended);
> +
> +	if (!h4->pars.configure_sleep)
> +		return;
> +
> +	if (!h4->is_suspended) {
> +		if (h4->pars.manual_fc)
> +			hci_uart_set_flow_control(hu, true);
> +
> +		/* Once this callback returns, driver suspends BT via GPIO */
> +		h4->is_suspended = true;
> +	}
> +}
> +
> +/*
> + * The platform is resuming. Resume UART activity.
> + */
> +static void resume_notification(void *context)
> +{
> +	struct hci_uart *hu = (struct hci_uart *)context;
> +	struct bcm_data *h4 = hu->priv;
> +
> +	BT_DBG("%s: is_suspended %d", __func__, h4->is_suspended);
> +
> +	if (!h4->pars.configure_sleep)
> +		return;
> +
> +	/* When this callback executes, the device has woken up already */
> +	if (h4->is_suspended) {
> +		h4->is_suspended = false;
> +
> +		if (h4->pars.manual_fc)
> +			hci_uart_set_flow_control(hu, false);
> +	}
> +
> +	/* If we're resumed, the idle timer must be running */
> +	mod_timer(&h4->timer, jiffies +
> +	    msecs_to_jiffies(h4->pars.idle_timeout_in_secs * 1000));

Indention is violated here.

> +}
> +
> +/*
> + * The BT device is resuming. Resume UART activity if suspended
> + */
> +static void wakeup_notification(void *context)
> +{
> +	struct hci_uart *hu = (struct hci_uart *)context;
> +	struct bcm_data *h4 = hu->priv;
> +
> +	BT_DBG("%s: is_suspended %d", __func__, h4->is_suspended);
> +
> +	if (!h4->pars.configure_sleep)
> +		return;
> +
> +	if (h4->is_suspended) {
> +		if (h4->pars.manual_fc)
> +			hci_uart_set_flow_control(hu, false);
> +
> +		h4->is_suspended = false;
> +	}
> +
> +	/* If we're resumed, the idle timer must be running */
> +	mod_timer(&h4->timer, jiffies + msecs_to_jiffies(
> +			   h4->pars.idle_timeout_in_secs * 1000));

Same here actually and worse it is different from the other one.

Splitting the rearming into its own helper might help here.

> +}
> +
> +/*
> + * Make sure we're awake
> + * (called when the resumed state is required)
> + */
> +static void bcm_ensure_wakeup(struct hci_uart *hu)
> +{
> +	struct bcm_data *h4 = hu->priv;
> +	int status;
> +
> +	if (!h4->pars.configure_sleep)
> +		return;
> +
> +	/* Suspend/resume operations are serialized */
> +	mutex_lock(&plock);
> +
> +	/* Nothing to do if resumed already */
> +	if (!h4->is_suspended) {
> +		mutex_unlock(&plock);
> +
> +		/* Just reset the timer */
> +		status = mod_timer(&h4->timer, jiffies + msecs_to_jiffies(
> +				   h4->pars.idle_timeout_in_secs * 1000));

This indentation is still not correct and now we have a 3rd version ;)

> +		return;
> +	}
> +
> +	/* Wakeup the device */
> +	status = btbcm_uart_control(BTBCM_UART_ACTION_RESUME,
> +				    h4->device_context, NULL, NULL);
> +	if (status)
> +		BT_DBG("%s: failed to resume driver %d", __func__, status);

Conditional BT_DBG on the status is pretty useless in my mind. Either BT_DBG the status or don't at all.

> +
> +	/* Unflow control the port if configured */
> +	resume_notification(hu);
> +
> +	mutex_unlock(&plock);
> +}
> +
> +/*
> + * Idle timer callback
> + */
> +static void bcm_idle_timeout(unsigned long arg)
> +{
> +	struct hci_uart *hu = (struct hci_uart *)arg;
> +	struct bcm_data *h4 = hu->priv;
> +	int status;
> +
> +	BT_DBG("%s: hu %p", __func__, hu);
> +
> +	/* Suspend/resume operations are serialized */
> +	mutex_lock(&plock);
> +
> +	if (!h4->is_suspended) {
> +		/* Flow control the port if configured */
> +		suspend_notification(hu);
> +
> +		/* Suspend the device */
> +		status = btbcm_uart_control(BTBCM_UART_ACTION_SUSPEND,
> +					    h4->device_context, NULL, NULL);
> +		if (status)
> +			BT_DBG("%s: failed to suspend device %d", __func__,
> +			       status);
> +	}
> +
> +	mutex_unlock(&plock);
> +}
> +
> static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
> {
> 	struct hci_dev *hdev = hu->hdev;
> @@ -88,31 +248,138 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
> 
> static int bcm_open(struct hci_uart *hu)
> {
> -	struct bcm_data *bcm;
> +	struct btbcm_uart_callbacks callbacks;
> +	unsigned long callbacks_size = sizeof(callbacks);

Not needed since it is all inside the kernel. And I think once this is split into individual exported functions, this will become a lot clearer.

> +	int status;
> +	struct bcm_data *h4;
> +	struct tty_struct *tty = hu->tty;
> 
> -	BT_DBG("hu %p", hu);
> +	BT_DBG("bcm_open hu %p", hu);
> 
> -	bcm = kzalloc(sizeof(*bcm), GFP_KERNEL);
> -	if (!bcm)
> +	h4 = kzalloc(sizeof(*h4), GFP_KERNEL);
> +	if (!h4)
> 		return -ENOMEM;

If we are doing renaming of variables, then I am expecting a cleanup patch first that does only that. If this is needed at all or just some left-over merge issue.

> 
> -	skb_queue_head_init(&bcm->txq);
> +	skb_queue_head_init(&h4->txq);
> +	hu->priv = h4;
> +	h4->hu = hu;
> +	h4->is_suspended = false;
> +
> +	/* Configure callbacks on the driver */
> +	callbacks.interface_version = BTBCM_UART_INTERFACE_VERSION;
> +	callbacks.context = hu;
> +	strcpy(callbacks.name, tty->name);
> +	callbacks.p_suspend = suspend_notification;
> +	callbacks.p_resume = resume_notification;
> +	callbacks.p_wakeup = wakeup_notification;
> +	status = btbcm_uart_control(BTBCM_UART_ACTION_CONFIGURE_CALLBACKS,
> +				    NULL, &callbacks, &callbacks_size);
> +	if (status) {
> +		BT_DBG("bcm_open failed to set driver callbacks %d", status);
> +		return status;
> +	}
> +	if (callbacks_size != sizeof(void *)) {
> +		BT_DBG("bcm_open got back %d bytes from callbacks?!",
> +		       (int)callbacks_size);
> +		return -EMSGSIZE;
> +	}
> +	memcpy(&h4->device_context, &callbacks, sizeof(void *));
> +	BT_DBG("bcm_open callbacks context %p", h4->device_context);
> +
> +	/* Retrieve device parameters */
> +	callbacks_size = sizeof(h4->pars);
> +	status = btbcm_uart_control(BTBCM_UART_ACTION_GET_PARAMETERS,
> +				    h4->device_context, &h4->pars,
> +				    &callbacks_size);
> +	if (status) {
> +		BT_DBG("bcm_open failed to get dev parameters %d", status);
> +		return status;
> +	}
> +	BT_DBG("Pars ver %d csleep %d dalow %d balow %d idle %d",
> +	       h4->pars.interface_version, h4->pars.configure_sleep,
> +	       h4->pars.dev_wake_active_low, h4->pars.bt_wake_active_low,
> +	       h4->pars.idle_timeout_in_secs);
> +	bcm_proto.oper_speed = h4->pars.oper_speed;
> +
> +	/* Cycle power to make sure the device is in the known state */
> +	status = btbcm_uart_control(BTBCM_UART_ACTION_POWER_OFF,
> +				    h4->device_context, NULL, NULL);
> +	if (status) {
> +		BT_DBG("bcm_open failed to power off %d", status);
> +	} else {
> +		status = btbcm_uart_control(BTBCM_UART_ACTION_POWER_ON,
> +					    h4->device_context, NULL, NULL);
> +		if (status)
> +			BT_DBG("bcm_open failed to power on %d", status);
> +	}
> +
> +	/* Start the idle timer */
> +	if (h4->pars.configure_sleep) {
> +		setup_timer(&h4->timer, bcm_idle_timeout, (unsigned long)hu);
> +		if (h4->pars.configure_sleep)
> +			mod_timer(&h4->timer, jiffies + msecs_to_jiffies(
> +				  h4->pars.idle_timeout_in_secs * 1000));
> +	}
> 
> -	hu->priv = bcm;
> 	return 0;
> }
> 
> static int bcm_close(struct hci_uart *hu)
> {
> -	struct bcm_data *bcm = hu->priv;
> +	struct btbcm_uart_callbacks callbacks;
> +	unsigned long callbacks_size = sizeof(callbacks);
> +	struct bcm_data *h4 = hu->priv;
> +	int status;
> 
> -	BT_DBG("hu %p", hu);
> +	hu->priv = NULL;
> 
> -	skb_queue_purge(&bcm->txq);
> -	kfree_skb(bcm->rx_skb);
> -	kfree(bcm);
> +	BT_DBG("bcm_close hu %p", hu);
> +
> +	/* If we're being closed, we must suspend */
> +	if (h4->pars.configure_sleep) {
> +		mutex_lock(&plock);
> +
> +		if (!h4->is_suspended) {
> +			/* Flow control the port */
> +			suspend_notification(hu);
> +
> +			/* Suspend the device */
> +			status = btbcm_uart_control(BTBCM_UART_ACTION_SUSPEND,
> +						    h4->device_context, NULL,
> +						    NULL);
> +			if (status) {
> +				BT_DBG("bcm_close suspend driver fail %d",
> +				       status);
> +			}
> +		}
> +
> +	mutex_unlock(&plock);
> +
> +	del_timer_sync(&h4->timer);
> +	}
> +
> +	/* Power off the device if possible */
> +	status = btbcm_uart_control(BTBCM_UART_ACTION_POWER_OFF,
> +				    h4->device_context, NULL, NULL);
> +	if (status)
> +		BT_DBG("bcm_close failed to power off %d", status);
> +
> +	/* de-configure callbacks on the driver */
> +	callbacks.interface_version = BTBCM_UART_INTERFACE_VERSION;
> +	callbacks.context = hu;
> +	callbacks.p_suspend = NULL;
> +	callbacks.p_resume = NULL;
> +	callbacks.p_wakeup = NULL;
> +	status = btbcm_uart_control(BTBCM_UART_ACTION_CONFIGURE_CALLBACKS,
> +				    h4->device_context, &callbacks,
> +				    &callbacks_size);
> +	if (status)
> +		BT_DBG("bcm_close failed to reset drv callbacks %d", status);
> +	skb_queue_purge(&h4->txq);
> 
> 	hu->priv = NULL;
> +	kfree(h4);
> +
> 	return 0;
> }
> 
> @@ -129,11 +396,42 @@ static int bcm_flush(struct hci_uart *hu)
> 
> static int bcm_setup(struct hci_uart *hu)
> {
> -	char fw_name[64];
> +	char fw_name[128];
> 	const struct firmware *fw;
> 	int err;
> -
> -	BT_DBG("hu %p", hu);
> +	struct sk_buff *skb;
> +	struct bcm_data *h4 = hu->priv;
> +	unsigned char sleep_pars[] = {
> +	0x01,       /* sleep mode 1=UART */
> +	0x02,       /* idle threshold HOST (value * 300ms) */
> +	0x02,       /* idle threshold HC   (value * 300ms) */
> +	0x01,       /* BT_WAKE active mode - 1=active high, 0 = active low */
> +	0x00,       /* HOST_WAKE active mode - 1=active high, 0 = active low */
> +	0x01,       /* Allow host sleep during SCO - FALSE */
> +	0x01,       /* combine sleep mode and LPM - 1 == TRUE */
> +	0x00,       /* enable tristate control of UART TX line - FALSE */
> +	0x00,       /* USB auto-sleep on USB SUSPEND */
> +	0x00,       /* USB USB RESUME timeout (seconds) */
> +	0x00,       /* Pulsed Host Wake */
> +	0x00        /* Enable Break To Host */
> +	};

Unless these are all single byte values, this is not endian safe. And it is horrible to read actually. Lets add the proper structs to btbcm.h like Fred did for the other commands.

And in addition it might be good to add these structs in a separate patch.

> +	unsigned char pcm_int_pars[] = {
> +	0x00,       /* 0=PCM routing, 1=SCO over HCI */
> +	0x02,       /* 0=128Kbps,1=256Kbps,2=512Kbps,3=1024Kbps,4=2048Kbps */
> +	0x00,       /* short frame sync  0=short, 1=long */
> +	0x00,       /* sync mode         0=slave, 1=master */
> +	0x00        /* clock mode        0=slave, 1=master */
> +	};
> +	unsigned char pcm_format_pars[] = {
> +	0x00,       /* LSB_First 1=TRUE, 0=FALSE */
> +	0x00,       /* Fill_Value (use 0-7 for fill bits value) */
> +	0x02,       /* Fill_Method   (2=sign extended) */
> +	0x03,       /* Fill_Num      # of fill bits 0-3) */
> +	0x01        /* Right_Justify 1=TRUE, 0=FALSE */
> +	};
> +	unsigned char time_slot_number = 0;
> +
> +	BT_DBG("bcm_setup hu %p", hu);
> 
> 	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
> 
> @@ -162,6 +460,67 @@ static int bcm_setup(struct hci_uart *hu)
> 			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
> 	}
> 
> +	/* Configure SCO PCM parameters */
> +	if (h4->pars.configure_audio) {
> +		pcm_int_pars[0] = h4->pars.pcm_routing;
> +		pcm_int_pars[1] = h4->pars.pcm_incallbitclock;
> +		pcm_int_pars[2] = h4->pars.pcm_shortframesync;
> +		pcm_int_pars[3] = h4->pars.pcm_syncmode;
> +		pcm_int_pars[4] = h4->pars.pcm_clockmode;

I prefer if vendor drivers add comments above their vendor commands explaining what they do and way. See the Intel driver on how far we went to help others understand what is going here.

> +		skb = __hci_cmd_sync(hu->hdev, 0xfc1c, sizeof(pcm_int_pars),
> +				     pcm_int_pars, HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			err = PTR_ERR(skb);
> +			BT_ERR("bcm_setup pcm_ INT VSC failed (%d)", err);
> +			goto finalize;
> +		}
> +		kfree_skb(skb);
> +		BT_DBG("bcm_setup pcm_ INT Parameters VSC succeeded");
> +
> +		pcm_format_pars[0] = h4->pars.pcm_lsbfirst;
> +		pcm_format_pars[1] = h4->pars.pcm_fillvalue;
> +		pcm_format_pars[2] = h4->pars.pcm_fillmethod;
> +		pcm_format_pars[3] = h4->pars.pcm_fillnum;
> +		pcm_format_pars[4] = h4->pars.pcm_rightjustify;
> +		skb = __hci_cmd_sync(hu->hdev, 0xfc1e, sizeof(pcm_format_pars),
> +				     pcm_format_pars, HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			err = PTR_ERR(skb);
> +			BT_ERR("bcm_setup pcm_ Format VSC failed (%d)",
> +			       err);
> +			goto finalize;
> +		}
> +		kfree_skb(skb);
> +		BT_DBG("bcm_setup pcm_ Format VSC succeeded");
> +
> +		skb = __hci_cmd_sync(hu->hdev, 0xfc22, sizeof(time_slot_number),
> +				     &time_slot_number, HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			err = PTR_ERR(skb);
> +			BT_ERR("bcm_setup SCO Time Slot VSC failed (%d)",
> +			       err);
> +			goto finalize;
> +		}
> +		kfree_skb(skb);
> +		BT_DBG("bcm_setup SCO Time Slot VSC succeeded");
> +	}
> +
> +	/* Configure device's suspend/resume operation */
> +	if (h4->pars.configure_sleep) {
> +		/* Override the default */
> +		sleep_pars[3] = (unsigned char)!h4->pars.bt_wake_active_low;
> +		sleep_pars[4] = (unsigned char)!h4->pars.dev_wake_active_low;
> +		skb = __hci_cmd_sync(hu->hdev, 0xfc27, sizeof(sleep_pars),
> +				     sleep_pars, HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			err = PTR_ERR(skb);
> +			BT_ERR("bcm_setup Sleep VSC failed (%d)", err);
> +			goto finalize;
> +		}
> +		kfree_skb(skb);
> +		BT_DBG("bcm_setup Set Sleep Parameters VSC succeeded");
> +	}
> +
> finalize:
> 	release_firmware(fw);
> 
> @@ -183,6 +542,11 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
> 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> 		return -EUNATCH;
> 
> +	BT_DBG("bcm_recv %d bytes", count);

I would prefer not to have this BT_DBG here. This function will be called a lot.

> +
> +	/* Make sure we're resumed */
> +	bcm_ensure_wakeup(hu);
> +
> 	bcm->rx_skb = h4_recv_buf(hu->hdev, bcm->rx_skb, data, count,
> 				  bcm_recv_pkts, ARRAY_SIZE(bcm_recv_pkts));
> 	if (IS_ERR(bcm->rx_skb)) {
> @@ -198,7 +562,10 @@ static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> {
> 	struct bcm_data *bcm = hu->priv;
> 
> -	BT_DBG("hu %p skb %p", hu, skb);
> +	BT_DBG("bcm_enqueue hu %p skb %p", hu, skb);

This is again that the function name is available with dynamic debug. So please do not change these or send separate patches with a commit message explaining why this change makes sense.

> +
> +	/* Make sure we're resumed */
> +	bcm_ensure_wakeup(hu);
> 
> 	/* Prepend skb with frame type */
> 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
> @@ -214,7 +581,8 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
> 	return skb_dequeue(&bcm->txq);
> }
> 
> -static const struct hci_uart_proto bcm_proto = {
> +/* This structure may not be const as speed may change at runtime */

No. This struct is const. These are the value that a protocol driver sets.

If values are dynamic and change based on DT, then left them zero here and provide a method for overwriting them internally in hci_uart. Please do not hack this in. There are simple UART drivers that we want to enable in a really simple way.

> +static struct hci_uart_proto bcm_proto = {
> 	.id		= HCI_UART_BCM,
> 	.name		= "BCM",
> 	.init_speed	= 115200,

Regards

Marcel

