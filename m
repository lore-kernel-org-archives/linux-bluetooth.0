Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: bcm203x: Fix race condition on disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Wed, 26 Oct 2011 11:04:43 +0200
In-Reply-To: <CANq1E4S0iK_DoX=kkk0hfmnj2MzyyXL-b9Z-wcLJu5YdVq9bag@mail.gmail.com>
References: <1319570016-7439-1-git-send-email-dh.herrmann@googlemail.com>
	 <1319619427.15441.254.camel@aeonflux>
	 <CANq1E4S0iK_DoX=kkk0hfmnj2MzyyXL-b9Z-wcLJu5YdVq9bag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319619883.15441.256.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> >> When disconnecting a bcm203x device we kill and destroy the usb-urb, however,
> >> there might still be a pending work-structure which resubmits the now invalid
> >> urb. To avoid this race condition, we simply set a shutdown-flag and
> >> synchronously kill the worker first.
> >>
> >> This also adds a comment to all schedule_work()s, as it is really not clear
> >> that they are used as replacement for short timers (which can be seen in the git
> >> history).
> >>
> >> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> >> ---
> >>  drivers/bluetooth/bcm203x.c |   12 ++++++++++++
> >>  1 files changed, 12 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
> >> index 8b1b643..6b42732 100644
> >> --- a/drivers/bluetooth/bcm203x.c
> >> +++ b/drivers/bluetooth/bcm203x.c
> >> @@ -24,6 +24,7 @@
> >>
> >>  #include <linux/module.h>
> >>
> >> +#include <linux/atomic.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/init.h>
> >>  #include <linux/slab.h>
> >> @@ -65,6 +66,7 @@ struct bcm203x_data {
> >>       unsigned long           state;
> >>
> >>       struct work_struct      work;
> >> +     atomic_t                shutdown;
> >>
> >>       struct urb              *urb;
> >>       unsigned char           *buffer;
> >> @@ -97,6 +99,7 @@ static void bcm203x_complete(struct urb *urb)
> >>
> >>               data->state = BCM203X_SELECT_MEMORY;
> >>
> >> +             /* use workqueue to have a small delay */
> >>               schedule_work(&data->work);
> >>               break;
> >>
> >> @@ -155,6 +158,10 @@ static void bcm203x_work(struct work_struct *work)
> >>       struct bcm203x_data *data =
> >>               container_of(work, struct bcm203x_data, work);
> >>
> >> +     smp_rmb();
> >> +     if (atomic_read(&data->shutdown))
> >> +             return;
> >> +
> >>       if (usb_submit_urb(data->urb, GFP_ATOMIC) < 0)
> >>               BT_ERR("Can't submit URB");
> >>  }
> >> @@ -243,6 +250,7 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
> >>
> >>       usb_set_intfdata(intf, data);
> >>
> >> +     /* use workqueue to have a small delay */
> >>       schedule_work(&data->work);
> >>
> >>       return 0;
> >> @@ -254,6 +262,10 @@ static void bcm203x_disconnect(struct usb_interface *intf)
> >>
> >>       BT_DBG("intf %p", intf);
> >>
> >> +     atomic_inc(&data->shutdown);
> >> +     smp_wmb();
> >> +     cancel_work_sync(&data->work);
> >> +
> >
> > can you quickly explain to me why we need the memory barrier here.
> 
> atomic_inc() and atomic_read() do not imply memory barriers, hence,
> cancel_work_sync() may finish before atomic_inc() is visible to the
> worker. Then the worker could restart and resend the urb without
> seeing the shutdown-flag and we still have the same race.
> However, I think cancel_work_sync() uses spinlocks or some other kind
> of lock and implies a memory barrier so both smp_wmb() and smp_rmb()
> may be dropped.
> I am not sure whether it is valid to rely on cancel_work_sync() to
> behave that way.

I think that we can rely on the behavior of cancel_work_sync. So lets
drop the memory barriers and then the patch looks good.

Regards

Marcel


