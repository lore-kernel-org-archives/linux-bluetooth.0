Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319619427.15441.254.camel@aeonflux>
References: <1319570016-7439-1-git-send-email-dh.herrmann@googlemail.com>
	<1319619427.15441.254.camel@aeonflux>
Date: Wed, 26 Oct 2011 11:03:45 +0200
Message-ID: <CANq1E4S0iK_DoX=kkk0hfmnj2MzyyXL-b9Z-wcLJu5YdVq9bag@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: bcm203x: Fix race condition on disconnect
From: David Herrmann <dh.herrmann@googlemail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 26, 2011 at 10:57 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi David,
>
>> When disconnecting a bcm203x device we kill and destroy the usb-urb, how=
ever,
>> there might still be a pending work-structure which resubmits the now in=
valid
>> urb. To avoid this race condition, we simply set a shutdown-flag and
>> synchronously kill the worker first.
>>
>> This also adds a comment to all schedule_work()s, as it is really not cl=
ear
>> that they are used as replacement for short timers (which can be seen in=
 the git
>> history).
>>
>> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> ---
>> =A0drivers/bluetooth/bcm203x.c | =A0 12 ++++++++++++
>> =A01 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
>> index 8b1b643..6b42732 100644
>> --- a/drivers/bluetooth/bcm203x.c
>> +++ b/drivers/bluetooth/bcm203x.c
>> @@ -24,6 +24,7 @@
>>
>> =A0#include <linux/module.h>
>>
>> +#include <linux/atomic.h>
>> =A0#include <linux/kernel.h>
>> =A0#include <linux/init.h>
>> =A0#include <linux/slab.h>
>> @@ -65,6 +66,7 @@ struct bcm203x_data {
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 state;
>>
>> =A0 =A0 =A0 struct work_struct =A0 =A0 =A0work;
>> + =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0shutdown;
>>
>> =A0 =A0 =A0 struct urb =A0 =A0 =A0 =A0 =A0 =A0 =A0*urb;
>> =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 *buffer;
>> @@ -97,6 +99,7 @@ static void bcm203x_complete(struct urb *urb)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->state =3D BCM203X_SELECT_MEMORY;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* use workqueue to have a small delay */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_work(&data->work);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> @@ -155,6 +158,10 @@ static void bcm203x_work(struct work_struct *work)
>> =A0 =A0 =A0 struct bcm203x_data *data =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct bcm203x_data, work=
);
>>
>> + =A0 =A0 smp_rmb();
>> + =A0 =A0 if (atomic_read(&data->shutdown))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> =A0 =A0 =A0 if (usb_submit_urb(data->urb, GFP_ATOMIC) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("Can't submit URB");
>> =A0}
>> @@ -243,6 +250,7 @@ static int bcm203x_probe(struct usb_interface *intf,=
 const struct usb_device_id
>>
>> =A0 =A0 =A0 usb_set_intfdata(intf, data);
>>
>> + =A0 =A0 /* use workqueue to have a small delay */
>> =A0 =A0 =A0 schedule_work(&data->work);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -254,6 +262,10 @@ static void bcm203x_disconnect(struct usb_interface=
 *intf)
>>
>> =A0 =A0 =A0 BT_DBG("intf %p", intf);
>>
>> + =A0 =A0 atomic_inc(&data->shutdown);
>> + =A0 =A0 smp_wmb();
>> + =A0 =A0 cancel_work_sync(&data->work);
>> +
>
> can you quickly explain to me why we need the memory barrier here.

atomic_inc() and atomic_read() do not imply memory barriers, hence,
cancel_work_sync() may finish before atomic_inc() is visible to the
worker. Then the worker could restart and resend the urb without
seeing the shutdown-flag and we still have the same race.
However, I think cancel_work_sync() uses spinlocks or some other kind
of lock and implies a memory barrier so both smp_wmb() and smp_rmb()
may be dropped.
I am not sure whether it is valid to rely on cancel_work_sync() to
behave that way.

> Regards
>
> Marcel

Regards
David
