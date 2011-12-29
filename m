Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1325180937.1965.294.camel@aeonflux>
References: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
	<1325173242-12264-2-git-send-email-dh.herrmann@googlemail.com>
	<1325180937.1965.294.camel@aeonflux>
Date: Thu, 29 Dec 2011 19:04:06 +0100
Message-ID: <CANq1E4Qc+DixjbUwDqH696mR6r3nNYLPq6tZEPmO=HxaRLtv4Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] Bluetooth: Remove obsolete hci-destruct callback
From: David Herrmann <dh.herrmann@googlemail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 29, 2011 at 6:48 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi David,
>
>> The destruct-callback is used by *all* drivers to remove their platform
>> data only. However, all drivers call hci_unregister_dev() before this
>> callback is executed. Therefore, there is no reason to keep platform
>> data alive after the driver was unregistered. Hence, we can free platform data
>> directly and then remove the hci-destruct callback entirely.
>>
>> Some drivers already depend on this behaviour, since they erroneously
>> already free the data after calling hci_free_dev(). This patch makes all
>> drivers behave that way and removes the callback entirely.
>
> it is important to not end up with a race condition between sysfs and
> hci_dev here. For example a cat /sys/class/bluetooth/hci0/name could
> still have sysfs file open and we need to keep the memory around until
> it gets destructed.

Ok, I am a bit confused. The destruct callback I am talking about here
is about driver state, not hci_dev state.
Also, this does not remove the hci_dev device-destruct callback. This
only removes the driver-state destruct callback.
Driver-data should be accessed by drivers only! Therefore, I don't
understand why we keep this driver-data alive until hci_dev is
destroyed.

I haven't found any other subsystem which behaves like this. I think
it's a bit confusing what this destruct callback actually does. It is
used as if it has something to do with hci_dev but it doesn't. I don't
understand why we use it and I think it's some left-over from some old
interface. However, look into the drivers/bluetooth/* files and see
what all these callbacks do. They only remove *driver-internal* state.
They do not remove any hci internal state. And driver-internal state
can be removed when the driver is unregistered like every other
bus-system does.
As an example, look at the kfree() calls I moved. The data which is
freed by them is never accessed outside of the
drivers/bluetooth/<driver>.c file so I don't think there is any
race-condition here.

> Regards
>
> Marcel

Thanks for reviewing
David
