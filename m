Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org, bluez-devel@lists.sf.net
In-Reply-To: <1137540084.4543.15.camel@localhost>
References: <1137540084.4543.15.camel@localhost>
Content-Type: text/plain
Message-Id: <1137589998.27515.8.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH] hci_usb: implement suspend/resume
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 18 Jan 2006 14:13:18 +0100

Hi Johannes,

> The attached patch implements suspend/resume for the hci_usb bluetooth
> driver by simply killing all outstanding urbs on suspend, and re-issuing
> them on resume.
> 
> This allows me to actually use the internal bluetooth "dongle" in my
> powerbook after suspend-to-ram without taking down all userland programs
> (sdpd, ...) and the hci device and reloading the module.

thanks for the patch. Due to the removed owner field it won't apply
cleanly to 2.6.16-rc1, but I can fix this easily by myself.

> +static int hci_usb_resume(struct usb_interface *intf)
> +{
> +	struct hci_usb *husb = usb_get_intfdata(intf);
> +	int i, err;
> +	unsigned long flags;
> +	if (!husb || intf == husb->isoc_iface)
> +		return 0;
> +	
> +	for (i = 0; i < 4; i++) {
> +		struct _urb_queue *q = &husb->pending_q[i];
> +		struct _urb *_urb;
> +		spin_lock_irqsave(&q->lock, flags);
> +		list_for_each_entry(_urb, &q->head, list) {
> +			err = usb_submit_urb(&_urb->urb, GFP_ATOMIC);
> +			if (err) break;
> +		}
> +		spin_unlock_irqrestore(&q->lock, flags);
> +		if (err)
> +			return -EIO;
> +	}
> +	return 0;
> +}

What happens if hci_usb_resume() really returns -EIO? Do we have to kill
the URBs again or does the USB subsystems disconnect the device in this
case?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
