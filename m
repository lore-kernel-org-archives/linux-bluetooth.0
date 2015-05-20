Return-Path: <cyrus@holtmann.org>
Message-ID: <555C3577.3080102@broadcom.com>
Date: Wed, 20 May 2015 09:19:19 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Ilya Faenson <ifaenson@broadcom.com>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC v3 4/4] BlueZ Broadcom UART Protocol
References: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com> <1431553823-25670-5-git-send-email-ifaenson@broadcom.com> <555B30F2.7020605@broadcom.com> <96107116-846B-44A2-94BB-628AF77D2A23@holtmann.org>
In-Reply-To: <96107116-846B-44A2-94BB-628AF77D2A23@holtmann.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/19/15 17:20, Marcel Holtmann wrote:
> Hi Arend,
>
>>> Enhance Broadcom protocol with the UART setup, firmware download
>>> and power management.
>>>
>>> Signed-off-by: Ilya Faenson<ifaenson@broadcom.com>
>>> ---
>>>   drivers/bluetooth/hci_bcm.c | 528 ++++++++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 513 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>> index 1ec0b4a..ccd92ed 100644
>>> --- a/drivers/bluetooth/hci_bcm.c
>>> +++ b/drivers/bluetooth/hci_bcm.c
>>> @@ -1,8 +1,9 @@
>>>   /*
>>>    *
>>> - *  Bluetooth HCI UART driver for Broadcom devices
>>> + *  Bluetooth UART H4 protocol for Broadcom devices
>>>    *
>>>    *  Copyright (C) 2015  Intel Corporation
>>> + *  Copyright (C) 2015  Broadcom Corporation
>>>    *
>>>    *
>>>    *  This program is free software; you can redistribute it and/or modify
>>> @@ -21,48 +22,413 @@
>>>    *
>>>    */
>>>
>>> +#include<linux/module.h>
>>>   #include<linux/kernel.h>
>>> +#include<linux/init.h>
>>> +#include<linux/types.h>
>>> +#include<linux/fcntl.h>
>>> +#include<linux/interrupt.h>
>>> +#include<linux/ptrace.h>
>>> +#include<linux/poll.h>
>>> +#include<linux/slab.h>
>>> +#include<linux/tty.h>
>>>   #include<linux/errno.h>
>>> +#include<linux/string.h>
>>> +#include<linux/signal.h>
>>> +#include<linux/ioctl.h>
>>>   #include<linux/skbuff.h>
>>> +#include<linux/gpio/consumer.h>
>>> +#include<linux/of_gpio.h>
>>> +#include<linux/of_platform.h>
>>>
>>>   #include<net/bluetooth/bluetooth.h>
>>>   #include<net/bluetooth/hci_core.h>
>>>
>>> -#include "btbcm.h"
>>>   #include "hci_uart.h"
>>> +#include "btbcm.h"
>>> +#include "btbcm_uart.h"
>>>
>>>   struct bcm_data {
>>>   	struct sk_buff *rx_skb;
>>>   	struct sk_buff_head txq;
>>> +	struct hci_uart *hu;
>>> +
>>> +	bool is_suspended; /* suspend/resume flag */
>>> +
>>> +	struct timer_list timer; /* idle timer */
>>> +
>>> +	struct btbcm_uart_parameters pars; /* device parameters */
>>> +	void *device_context; /* ACPI/DT device context */
>>>   };
>>>
>>> +/* Suspend/resume synchronization mutex */
>>> +static DEFINE_MUTEX(plock);
>>> +
>>> +/*
>>> + * Callbacks from the BCMBT_UART device
>>> + */
>>> +
>>> +/*
>>> + * The platform is suspending. Stop UART activity
>>> + */
>>> +static void suspend_notification(void *context)
>>> +{
>>> +	struct ktermios ktermios;
>>> +	struct hci_uart *hu = (struct hci_uart *)context;
>>> +	struct bcm_data *h4 = hu->priv;
>>> +	struct tty_struct *tty = hu->tty;
>>> +	int status;
>>> +	unsigned int set = 0;
>>> +	unsigned int clear = 0;
>>> +
>>> +	BT_DBG("suspend_notification with is_suspended %d", h4->is_suspended);
>>> +
>>> +	if (!h4->pars.configure_sleep)
>>> +		return;
>>> +
>>> +	if (!h4->is_suspended) {
>>> +		if (h4->pars.manual_fc) {
>>> +			/* Disable hardware flow control */
>>> +			ktermios = tty->termios;
>>> +			ktermios.c_cflag&= ~CRTSCTS;
>>> +			status = tty_set_termios(tty,&ktermios);
>>> +			if (status)
>>> +				BT_DBG("suspend_notification dis fc fail %d",
>>> +				       status);
>>> +			else
>>> +				BT_DBG("suspend_notification hw fc disabled");
>>> +
>>> +			/* Clear RTS to prevent the device from sending */
>>> +			/* (most PCs need OUT2 to enable interrupts)    */
>>> +			status = tty->driver->ops->tiocmget(tty);
>>> +			BT_DBG("suspend_notification cur tiocm 0x%x", status);
>>> +			set&= ~(TIOCM_OUT2 | TIOCM_RTS);
>>> +			clear = ~set;
>>> +			set&= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
>>> +				TIOCM_OUT2 | TIOCM_LOOP;
>>> +			clear&= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
>>> +				TIOCM_OUT2 | TIOCM_LOOP;
>>> +			status = tty->driver->ops->tiocmset(tty, set, clear);
>>> +			if (status)
>>> +				BT_DBG("suspend_notification clr RTS fail %d",
>>> +				       status);
>>> +			else
>>> +				BT_DBG("suspend_notification RTS cleared");
>>> +			status = tty->driver->ops->tiocmget(tty);
>>> +			BT_DBG("suspend_notification end tiocm 0x%x", status);
>>> +		}
>>> +
>>> +		/* Once this callback returns, driver suspends BT via GPIO */
>>> +		h4->is_suspended = true;
>>> +	}
>>> +}
>>> +
>>> +/*
>>> + * The platform is resuming. Resume UART activity.
>>> + */
>>> +static void resume_notification(void *context)
>>> +{
>>> +	struct ktermios ktermios;
>>> +	struct hci_uart *hu = (struct hci_uart *)context;
>>> +	struct bcm_data *h4 = hu->priv;
>>> +	struct tty_struct *tty = hu->tty;
>>> +	int status;
>>> +	unsigned int set = 0;
>>> +	unsigned int clear = 0;
>>> +
>>> +	BT_DBG("resume_notification with is_suspended %d", h4->is_suspended);
>>> +
>>> +	if (!h4->pars.configure_sleep)
>>> +		return;
>>> +
>>> +	/* When this callback executes, the device has woken up already */
>>> +	if (h4->is_suspended) {
>>> +		h4->is_suspended = false;
>>> +
>>> +		if (h4->pars.manual_fc) {
>>> +			status = tty->driver->ops->tiocmget(tty);
>>> +			BT_DBG("resume_notification cur tiocm 0x%x", status);
>>> +			set |= (TIOCM_OUT2 | TIOCM_RTS);
>>> +			clear = ~set;
>>> +			set&= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
>>> +				TIOCM_OUT2 | TIOCM_LOOP;
>>> +			clear&= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
>>> +				TIOCM_OUT2 | TIOCM_LOOP;
>>> +			status = tty->driver->ops->tiocmset(tty, set, clear);
>>> +			if (status)
>>> +				BT_DBG("resume_notification set RTS fail %d",
>>> +				       status);
>>> +			else
>>> +				BT_DBG("resume_notification RTS set");
>>> +
>>> +			/* Re-enable hardware flow control */
>>> +			ktermios = tty->termios;
>>> +			ktermios.c_cflag |= CRTSCTS;
>>> +			status = tty_set_termios(tty,&ktermios);
>>> +			if (status)
>>> +				BT_DBG("resume_notification enable fc fail %d",
>>> +				       status);
>>> +			else
>>> +				BT_DBG("resume_notification hw fc re-enabled");
>>> +		}
>>> +	}
>>> +
>>> +	/* If we're resumed, the idle timer must be running */
>>> +	status = mod_timer(&h4->timer, jiffies +
>>> +	    msecs_to_jiffies(h4->pars.idle_timeout_in_secs * 1000));
>>> +}
>>> +
>>> +/*
>>> + * The BT device is resuming. Resume UART activity if suspended
>>> + */
>>> +static void wakeup_notification(void *context)
>>> +{
>>> +	struct ktermios ktermios;
>>> +	struct hci_uart *hu = (struct hci_uart *)context;
>>> +	struct bcm_data *h4 = hu->priv;
>>> +	struct tty_struct *tty = hu->tty;
>>> +	int status;
>>> +	unsigned int set = 0;
>>> +	unsigned int clear = 0;
>>> +
>>> +	if (!h4->pars.configure_sleep)
>>> +		return;
>>> +
>>> +	status = tty->driver->ops->tiocmget(tty);
>>> +	BT_DBG("wakeup_notification hu %p current tiocm 0x%x", hu, status);
>>> +	if (h4->is_suspended) {
>>> +		if (h4->pars.manual_fc) {
>>> +			set |= (TIOCM_OUT2 | TIOCM_RTS);
>>> +			clear = ~set;
>>> +			set&= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
>>> +				TIOCM_OUT2 | TIOCM_LOOP;
>>> +			clear&= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
>>> +				TIOCM_OUT2 | TIOCM_LOOP;
>>> +			status = tty->driver->ops->tiocmset(tty, set, clear);
>>> +			if (status)
>>> +				BT_DBG("wakeup_notification set RTS fail %d",
>>> +				       status);
>>> +			else
>>> +				BT_DBG("wakeup_notification RTS set");
>>> +
>>> +			/* Re-enable hardware flow control */
>>> +			ktermios = tty->termios;
>>> +			ktermios.c_cflag |= CRTSCTS;
>>> +			status = tty_set_termios(tty,&ktermios);
>>> +			if (status)
>>> +				BT_DBG("wakeup_notification fc-en failure %d",
>>> +				       status);
>>> +			else
>>> +				BT_DBG("wakeup_notification hw fc re-enabled");
>>> +		}
>>> +
>>> +		h4->is_suspended = false;
>>> +	}
>>> +
>>> +	/* If we're resumed, the idle timer must be running */
>>> +	status = mod_timer(&h4->timer, jiffies + msecs_to_jiffies(
>>> +			   h4->pars.idle_timeout_in_secs * 1000));
>>> +}
>>> +
>>> +/*
>>> + * Make sure we're awake
>>> + * (called when the resumed state is required)
>>> + */
>>> +static void bcm_ensure_wakeup(struct hci_uart *hu)
>>> +{
>>> +	struct bcm_data *h4 = hu->priv;
>>> +	int status;
>>> +
>>> +	if (!h4->pars.configure_sleep)
>>> +		return;
>>> +
>>> +	/* Suspend/resume operations are serialized */
>>> +	mutex_lock(&plock);
>>> +
>>> +	/* Nothing to do if resumed already */
>>> +	if (!h4->is_suspended) {
>>> +		mutex_unlock(&plock);
>>> +
>>> +		/* Just reset the timer */
>>> +		status = mod_timer(&h4->timer, jiffies + msecs_to_jiffies(
>>> +				   h4->pars.idle_timeout_in_secs * 1000));
>>> +		return;
>>> +	}
>>> +
>>> +	/* Wakeup the device */
>>> +	status = btbcm_uart_control(BTBCM_UART_ACTION_RESUME,
>>> +				    h4->device_context, NULL, NULL);
>>> +	if (status)
>>> +		BT_DBG("bcm_ensure_wakeup failed to resume driver %d", status);
>>> +
>>> +	/* Unflow control the port if configured */
>>> +	resume_notification(hu);
>>> +
>>> +	mutex_unlock(&plock);
>>> +}
>>> +
>>> +/*
>>> + * Idle timer callback
>>> + */
>>> +static void bcm_idle_timeout(unsigned long arg)
>>> +{
>>> +	struct hci_uart *hu = (struct hci_uart *)arg;
>>> +	struct bcm_data *h4 = hu->priv;
>>> +	int status;
>>> +
>>> +	BT_DBG("bcm_idle_timeout hu %p", hu);
>>> +
>>> +	/* Suspend/resume operations are serialized */
>>> +	mutex_lock(&plock);
>>> +
>>> +	if (!h4->is_suspended) {
>>> +		/* Flow control the port if configured */
>>> +		suspend_notification(hu);
>>> +
>>> +		/* Suspend the device */
>>> +		status = btbcm_uart_control(BTBCM_UART_ACTION_SUSPEND,
>>> +					    h4->device_context, NULL, NULL);
>>> +		if (status)
>>> +			BT_DBG("bcm_idle_timeout failed to suspend device %d",
>>> +			       status);
>>> +	}
>>> +
>>> +	mutex_unlock(&plock);
>>> +}
>>> +
>>>   static int bcm_open(struct hci_uart *hu)
>>>   {
>>> -	struct bcm_data *bcm;
>>> +	struct btbcm_uart_callbacks callbacks;
>>> +	unsigned long callbacks_size = sizeof(callbacks);
>>> +	int status;
>>> +	struct bcm_data *h4;
>>> +	struct tty_struct *tty = hu->tty;
>>>
>>> -	BT_DBG("hu %p", hu);
>>> +	BT_DBG("bcm_h4_open hu %p", hu);
>>>
>>> -	bcm = kzalloc(sizeof(*bcm), GFP_KERNEL);
>>> -	if (!bcm)
>>> +	h4 = kzalloc(sizeof(*h4), GFP_KERNEL);
>>> +	if (!h4)
>>>   		return -ENOMEM;
>>>
>>> -	skb_queue_head_init(&bcm->txq);
>>> +	skb_queue_head_init(&h4->txq);
>>> +	hu->priv = h4;
>>> +	h4->hu = hu;
>>> +	h4->is_suspended = false;
>>> +
>>> +	/* Configure callbacks on the driver */
>>> +	callbacks.interface_version = BTBCM_UART_INTERFACE_VERSION;
>>> +	callbacks.context = hu;
>>> +	strcpy(callbacks.name, tty->name);
>>> +	callbacks.p_suspend = suspend_notification;
>>> +	callbacks.p_resume = resume_notification;
>>> +	callbacks.p_wakeup = wakeup_notification;
>>> +	status = btbcm_uart_control(BTBCM_UART_ACTION_CONFIGURE_CALLBACKS,
>>> +				    NULL,&callbacks,&callbacks_size);
>>> +	if (status) {
>>> +		BT_DBG("bcm_h4_open failed to set driver callbacks %d", status);
>>> +		return status;
>>> +	}
>>> +	if (callbacks_size != sizeof(void *)) {
>>> +		BT_DBG("bcm_h4_open got back %d bytes from callbacks?!",
>>> +		       (int)callbacks_size);
>>> +		return -EMSGSIZE;
>>> +	}
>>> +	memcpy(&h4->device_context,&callbacks, sizeof(void *));
>>> +	BT_DBG("bcm_h4_open callbacks context %p", h4->device_context);
>>> +
>>> +	/* Retrieve device parameters */
>>> +	callbacks_size = sizeof(h4->pars);
>>> +	status = btbcm_uart_control(BTBCM_UART_ACTION_GET_PARAMETERS,
>>> +				    h4->device_context,&h4->pars,
>>> +				&callbacks_size);
>>> +	if (status) {
>>> +		BT_DBG("bcm_h4_open failed to get dev parameters %d", status);
>>> +		return status;
>>> +	}
>>> +	BT_DBG("Pars ver %d csleep %d dalow %d balow %d idle %d",
>>> +	       h4->pars.interface_version, h4->pars.configure_sleep,
>>> +	       h4->pars.dev_wake_active_low, h4->pars.bt_wake_active_low,
>>> +	       h4->pars.idle_timeout_in_secs);
>>> +
>>> +	/* Cycle power to make sure the device is in the known state */
>>> +	status = btbcm_uart_control(BTBCM_UART_ACTION_POWER_OFF,
>>> +				    h4->device_context, NULL, NULL);
>>> +	if (status) {
>>> +		BT_DBG("bcm_h4_open failed to power off %d", status);
>>> +	} else {
>>> +		status = btbcm_uart_control(BTBCM_UART_ACTION_POWER_ON,
>>> +					    h4->device_context, NULL, NULL);
>>> +		if (status)
>>> +			BT_DBG("bcm_h4_open failed to power on %d", status);
>>> +	}
>>> +
>>> +	/* Start the idle timer */
>>> +	if (h4->pars.configure_sleep) {
>>> +		setup_timer(&h4->timer, bcm_idle_timeout, (unsigned long)hu);
>>> +		if (h4->pars.configure_sleep)
>>> +			mod_timer(&h4->timer, jiffies + msecs_to_jiffies(
>>> +				  h4->pars.idle_timeout_in_secs * 1000));
>>> +	}
>>>
>>> -	hu->priv = bcm;
>>>   	return 0;
>>>   }
>>>
>>>   static int bcm_close(struct hci_uart *hu)
>>>   {
>>> -	struct bcm_data *bcm = hu->priv;
>>> +	struct btbcm_uart_callbacks callbacks;
>>> +	unsigned long callbacks_size = sizeof(callbacks);
>>> +	struct bcm_data *h4 = hu->priv;
>>> +	int status;
>>>
>>> -	BT_DBG("hu %p", hu);
>>> +	hu->priv = NULL;
>>>
>>> -	skb_queue_purge(&bcm->txq);
>>> -	kfree_skb(bcm->rx_skb);
>>> -	kfree(bcm);
>>> +	BT_DBG("bcm_h4_close hu %p", hu);
>>> +
>>> +	/* If we're being closed, we must suspend */
>>> +	if (h4->pars.configure_sleep) {
>>> +		mutex_lock(&plock);
>>> +
>>> +		if (!h4->is_suspended) {
>>> +			/* Flow control the port */
>>> +			suspend_notification(hu);
>>> +
>>> +			/* Suspend the device */
>>> +			status = btbcm_uart_control(BTBCM_UART_ACTION_SUSPEND,
>>> +						    h4->device_context, NULL,
>>> +						    NULL);
>>> +			if (status) {
>>> +				BT_DBG("bcm_h4_close suspend driver fail %d",
>>> +				       status);
>>> +			}
>>> +		}
>>> +
>>> +	mutex_unlock(&plock);
>>> +
>>> +	del_timer_sync(&h4->timer);
>>> +	}
>>> +
>>> +	/* Power off the device if possible */
>>> +	status = btbcm_uart_control(BTBCM_UART_ACTION_POWER_OFF,
>>> +				    h4->device_context, NULL, NULL);
>>> +	if (status)
>>> +		BT_DBG("bcm_h4_close failed to power off %d", status);
>>> +
>>> +	/* de-configure callbacks on the driver */
>>> +	callbacks.interface_version = BTBCM_UART_INTERFACE_VERSION;
>>> +	callbacks.context = hu;
>>> +	callbacks.p_suspend = NULL;
>>> +	callbacks.p_resume = NULL;
>>> +	callbacks.p_wakeup = NULL;
>>> +	status = btbcm_uart_control(BTBCM_UART_ACTION_CONFIGURE_CALLBACKS,
>>> +				    h4->device_context,&callbacks,
>>> +				&callbacks_size);
>>> +	if (status)
>>> +		BT_DBG("bcm_h4_close failed to reset drv callbacks %d", status);
>>> +	skb_queue_purge(&h4->txq);
>>>
>>>   	hu->priv = NULL;
>>> +	kfree(h4);
>>> +
>>>   	return 0;
>>>   }
>>>
>>> @@ -79,11 +445,137 @@ static int bcm_flush(struct hci_uart *hu)
>>>
>>>   static int bcm_setup(struct hci_uart *hu)
>>>   {
>>> -	BT_DBG("hu %p", hu);
>>> +	struct bcm_data *h4 = hu->priv;
>>> +	int status;
>>> +	struct sk_buff *skb;
>>> +	unsigned char sleep_pars[] = {
>>> +	0x01,       /* sleep mode 1=UART */
>>> +	0x02,       /* idle threshold HOST (value * 300ms) */
>>> +	0x02,       /* idle threshold HC   (value * 300ms) */
>>> +	0x01,       /* BT_WAKE active mode - 1=active high, 0 = active low */
>>> +	0x00,       /* HOST_WAKE active mode - 1=active high, 0 = active low */
>>> +	0x01,       /* Allow host sleep during SCO - FALSE */
>>> +	0x01,       /* combine sleep mode and LPM - 1 == TRUE */
>>> +	0x00,       /* enable tristate control of UART TX line - FALSE */
>>> +	0x00,       /* USB auto-sleep on USB SUSPEND */
>>> +	0x00,       /* USB USB RESUME timeout (seconds) */
>>> +	0x00,       /* Pulsed Host Wake */
>>> +	0x00        /* Enable Break To Host */
>>> +	};
>>> +	unsigned char pcm_int_pars[] = {
>>> +	0x00,       /* 0=PCM routing, 1=SCO over HCI */
>>> +	0x02,       /* 0=128Kbps,1=256Kbps,2=512Kbps,3=1024Kbps,4=2048Kbps */
>>> +	0x00,       /* short frame sync  0=short, 1=long */
>>> +	0x00,       /* sync mode         0=slave, 1=master */
>>> +	0x00        /* clock mode        0=slave, 1=master */
>>> +	};
>>> +	unsigned char pcm_format_pars[] = {
>>> +	0x00,       /* LSB_First 1=TRUE, 0=FALSE */
>>> +	0x00,       /* Fill_Value (use 0-7 for fill bits value) */
>>> +	0x02,       /* Fill_Method   (2=sign extended) */
>>> +	0x03,       /* Fill_Num      # of fill bits 0-3) */
>>> +	0x01        /* Right_Justify 1=TRUE, 0=FALSE */
>>> +	};
>>> +	unsigned char time_slot_number = 0;
>>> +
>>> +	BT_DBG("bcm_h4_setup hu %p", hu);
>>> +
>>> +	/* Bring the UART into known default state */
>>> +	status = btbcm_init_uart(hu);
>>> +	if (status) {
>>> +		BT_DBG("bcm_h4_setup failed to init BT device %d", status);
>>> +		return status;
>>> +	}
>>> +
>>> +	/* Basic sanity check */
>>> +	skb = __hci_cmd_sync(hu->hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
>>> +	if (IS_ERR(skb)) {
>>> +		status = PTR_ERR(skb);
>>> +		BT_ERR("bcm_h4_setup HCI Reset failed (%d)", status);
>>> +		return status;
>>> +	}
>>> +	kfree_skb(skb);
>>> +	BT_DBG("bcm_h4_setup HCI Reset succeeded");
>>> +
>>> +	/* Set the new baud rate */
>>> +	status = btbcm_set_baud_rate(hu,
>>> +				     h4->pars.baud_rate_before_config_download);
>>> +	if (status) {
>>> +		BT_ERR("bcm_h4_setup set_baud_rate faiilure %d", status);
>>> +		return status;
>>> +	}
>>>
>>>   	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
>>>
>>> -	return btbcm_setup_patchram(hu->hdev);
>>> +	/* Download the firmware and reconfigure the UART afterwards */
>>> +	status = btbcm_setup_patchram(hu->hdev);
>>> +	if (status) {
>>> +		BT_ERR("bcm_h4_setup setup_patchram faiilure %d", status);
>>> +		return status;
>>> +	}
>>> +
>>> +	/* Configure SCO PCM parameters */
>>> +	if (h4->pars.configure_audio) {
>>> +		pcm_int_pars[0] = h4->pars.PCMRouting;
>>> +		pcm_int_pars[1] = h4->pars.PCMInCallBitclock;
>>> +		pcm_int_pars[2] = h4->pars.PCMShortFrameSync;
>>> +		pcm_int_pars[3] = h4->pars.PCMSyncMode;
>>> +		pcm_int_pars[4] = h4->pars.PCMClockMode;
>>> +		skb = __hci_cmd_sync(hu->hdev, 0xfc1c, sizeof(pcm_int_pars),
>>
>> Guess 0xfc1c is the hci command. Can you create a define for them?
>
> in a lot of cases we kept the hex number and just included a proper comment above the command to explain what this command does. That is at least how we have done it inside the Intel vendor support. I am fine with also creating a define for it. However sometimes they got heavily complicated and long.

Ok. As there is already a comment at the if statement above I suppose it 
is clear and my remark can be ignored. Fine by me.

Thanks,
Arend
