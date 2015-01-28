Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jan 2015 15:16:36 -0500
From: Adam Lee <adam.lee@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bluetooth: ath3k: workaround the compatibility issue
 with xHCI controller
Message-ID: <20150128201636.GA2659@adam-laptop>
References: <1422474752-26871-1-git-send-email-adam.lee@canonical.com>
 <0731CFAA-B45A-4DC2-8579-1A4E5E7707F3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0731CFAA-B45A-4DC2-8579-1A4E5E7707F3@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 28, 2015 at 12:10:21PM -0800, Marcel Holtmann wrote:
> Hi Adam,
> ...
> > --- a/drivers/bluetooth/ath3k.c
> > +++ b/drivers/bluetooth/ath3k.c
> > @@ -174,6 +174,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
> > #define USB_REQ_DFU_DNLOAD	1
> > #define BULK_SIZE		4096
> > #define FW_HDR_SIZE		20
> > +#define TIMEGAP_US		100
> > 
> > static int ath3k_load_firmware(struct usb_device *udev,
> > 				const struct firmware *firmware)
> > @@ -205,6 +206,9 @@ static int ath3k_load_firmware(struct usb_device *udev,
> > 	pipe = usb_sndbulkpipe(udev, 0x02);
> > 
> > 	while (count) {
> > +		/* workaround the compatibility issue with xHCI controller*/
> > +		usleep_range(TIMEGAP_US - 50, TIMEGAP_US);
> > +
> 
> why are you using a usleep_range() here. Why not just sleep for 100us.
> 
> Regards
> 
> Marcel

Yes, I intended to do that, but timer is not that simple, check this:

https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
	* Use usleep_range

	- Why not msleep for (1ms - 20ms)?
		Explained originally here:
			http://lkml.org/lkml/2007/8/3/250
		msleep(1~20) may not do what the caller intends, and
		will often sleep longer (~20 ms actual sleep for any
		value given in the 1~20ms range). In many cases this
		is not the desired behavior.

	- Why is there no "usleep" / What is a good range?
		Since usleep_range is built on top of hrtimers, the
		wakeup will be very precise (ish), thus a simple
		usleep function would likely introduce a large number
		of undesired interrupts.

		With the introduction of a range, the scheduler is
		free to coalesce your wakeup with any other wakeup
		that may have happened for other reasons, or at the
		worst case, fire an interrupt for your upper bound.

		The larger a range you supply, the greater a chance
		that you will not trigger an interrupt; this should
		be balanced with what is an acceptable upper bound on
		delay / performance for your specific code path. Exact
		tolerances here are very situation specific, thus it
		is left to the caller to determine a reasonable range.

-- 
Adam Lee
