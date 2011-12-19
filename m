Return-Path: <cyrus@holtmann.org>
Message-ID: <1324258083.1965.96.camel@aeonflux>
Subject: Re: Bluetooth: btusb: urb->interval speed check in
 btusb_submit_isoc_urb()
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 18 Dec 2011 17:28:03 -0800
In-Reply-To: <477F20668A386D41ADCC57781B1F704308185E345D@SC-VEXCH1.marvell.com>
References: <1321504842-11199-1-git-send-email-bzhao@marvell.com>
	 <20111121155255.GD2552@joana>
	 <477F20668A386D41ADCC57781B1F704308185E345D@SC-VEXCH1.marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> In drivers/Bluetooth/btusb.c, function btusb_send_frame(), we call
> 
>         usb_fill_int_urb(urb, data->udev, pipe,
>                         skb->data, skb->len, btusb_isoc_tx_complete,
>                         skb, data->isoc_tx_ep->bInterval);
> 
> in case HCI_SCODATA_PKT. The inline function usb_fill_int_urb will check USB_SPEED_HIGH or USB_SPEED_SUPER to assign different value to urb->interval.
> 
>         if (dev->speed == USB_SPEED_HIGH || dev->speed == USB_SPEED_SUPER)
>                 urb->interval = 1 << (interval - 1);
>         else
>                 urb->interval = interval;
> 
> Shall we do the same check for btusb_submit_isoc_urb()?

I honestly do not know. Maybe just using usb_fill_int_urb here might be
a good idea. One is the TX and one is the RX URB. You need to go into
the USB subsystem and see if it actually makes a different.

However we should not handcode anything from the USB subsystem. We made
that mistake before with hci_usb.c from the 2.4.x times and it was a
valuable lesson learned on things not to do.

Regards

Marcel


