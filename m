Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808182326.48365.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
	 <200808181803.48778.oliver@neukum.org>
	 <1219079273.7591.62.camel@violet.holtmann.net>
	 <200808182326.48365.oliver@neukum.org>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 06:05:54 +0200
Message-Id: <1219118754.7591.70.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > > actually we can't move the URB killing for ACL into notify() since that
> > > > gives me a kernel panic (fatal exception in interrupt).
> > > > 
> > > > Your patch for the IRQ disabling doesn't make a difference.
> > > 
> > > Please send me the version that triggers it.
> > 
> > the attached version makes it oops. Just create a connection with rfcomm
> > or sdptool and you will see it when disconnecting.
> 
> This is a context you cannot sleep in:
> 
> @@ -504,8 +674,62 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
>  
>  	BT_DBG("%s evt %d", hdev->name, evt);
>  
> -	if (evt == HCI_NOTIFY_CONN_ADD || evt == HCI_NOTIFY_CONN_DEL)
> -		schedule_work(&data->work);
> +	if (hdev->conn_hash.acl_num > 0) {
> +		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
> +			if (btusb_submit_bulk_urb(hdev) < 0)
> +				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> +			else
> +				btusb_submit_bulk_urb(hdev);
> +		}
> +	} else {
> +		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> +		usb_kill_anchored_urbs(&data->bulk_anchor);
> 
> But you use usb_kill_anchored_urbs(). You should use usb_unlink_anchored_urbs()

good catch. That was starring me at the code and not realizing that all
usb_kill_* version need to sleep.

However when using the unlink version, this gives me spinlock lockup
(with and without your IRQ disable patch). From the backtrace it seems
that usb_unanchor_urb is calling spinlock_irq_save here.

Regards

Marcel


