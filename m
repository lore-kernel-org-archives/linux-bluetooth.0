Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANq1E4Qc+DixjbUwDqH696mR6r3nNYLPq6tZEPmO=HxaRLtv4Q@mail.gmail.com>
References: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
	<1325173242-12264-2-git-send-email-dh.herrmann@googlemail.com>
	<1325180937.1965.294.camel@aeonflux>
	<CANq1E4Qc+DixjbUwDqH696mR6r3nNYLPq6tZEPmO=HxaRLtv4Q@mail.gmail.com>
Date: Sat, 7 Jan 2012 15:13:09 +0100
Message-ID: <CANq1E4Qkdy+9HEcLzK2yx5bPBMX8DW2vyNP-KQ1MokANRDw9JQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] Bluetooth: Remove obsolete hci-destruct callback
From: David Herrmann <dh.herrmann@googlemail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

On Thu, Dec 29, 2011 at 7:04 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> On Thu, Dec 29, 2011 at 6:48 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi David,
>>
>>> The destruct-callback is used by *all* drivers to remove their platform
>>> data only. However, all drivers call hci_unregister_dev() before this
>>> callback is executed. Therefore, there is no reason to keep platform
>>> data alive after the driver was unregistered. Hence, we can free platform data
>>> directly and then remove the hci-destruct callback entirely.
>>>
>>> Some drivers already depend on this behaviour, since they erroneously
>>> already free the data after calling hci_free_dev(). This patch makes all
>>> drivers behave that way and removes the callback entirely.
>>
>> it is important to not end up with a race condition between sysfs and
>> hci_dev here. For example a cat /sys/class/bluetooth/hci0/name could
>> still have sysfs file open and we need to keep the memory around until
>> it gets destructed.

I will resend this as sequential patches which thorough explanations
so it might be more clear why this callback is obsolete.

Cheers
David
