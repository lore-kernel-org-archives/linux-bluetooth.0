Return-Path: <greg@kroah.com>
Date: Wed, 28 Apr 2004 10:43:25 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>, bluez-devel@lists.sourceforge.net
Cc: Marcel Holtmann <marcel@holtmann.org>,
   USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: PATCH: (as265) Fix bluetooth driver's wait_for_urb()
Message-ID: <20040428174325.GG32040@kroah.com>
References: <Pine.LNX.4.44L0.0404281321520.1238-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.0404281321520.1238-100000@ida.rowland.org>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Apr 28, 2004 at 01:25:08PM -0400, Alan Stern wrote:
> Greg:
> 
> Your recent change to struct urb broke this function in the bluetooth 
> driver.

I know.  I really hate what the Bluetooth driver does, and it's up to
them to keep up with the changes in urbs due to them statically
including a urb in their structures.  That is what they agreed to when
they did this a while ago.  They are on their own here...

> You know, I think usb_wait_for_urb() would make an excellent 
> addition to usbcore.

No, no one should do that.  Just use the proper usb_alloc_urb() and
usb_free_urb() and you will be fine.

> At some future time we could consider replacing 
> synchronous unlink_urb with asynchronous unlink plus wait_for_urb.

Why?  Does it cause undue hardship in the host controllers to have a
synchronous unlink_urb?

> ===== drivers/bluetooth/hci_usb.c 1.43 vs edited =====
> --- 1.43/drivers/bluetooth/hci_usb.c	Wed Apr 21 01:11:06 2004
> +++ edited/drivers/bluetooth/hci_usb.c	Wed Apr 28 13:20:22 2004
> @@ -342,7 +342,7 @@
>  
>  static inline void hci_usb_wait_for_urb(struct urb *urb)
>  {
> -	while (atomic_read(&urb->count) > 1) {
> +	while (atomic_read(&urb->kref.refcount) > 1) {
>  		current->state = TASK_UNINTERRUPTIBLE;
>  		schedule_timeout((5 * HZ + 999) / 1000);
>  	}

I really just hate that whole function, it's such a hack.

So, Bluetooth developers, have you reconsidered your "need" to put a
static urb in your structure?  Are you convinced yet of the wrongness of
your ways?  Do you want a patch to change your subsystem to follow the
rest of the kernel with regards to USB?

thanks,

greg k-h
