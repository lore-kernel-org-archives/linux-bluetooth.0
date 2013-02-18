Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361053591.1583.9.camel@aeonflux>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
	<1360970828-24004-2-git-send-email-andre.guedes@openbossa.org>
	<1361053591.1583.9.camel@aeonflux>
Date: Mon, 18 Feb 2013 19:07:32 -0300
Message-ID: <CACJA=fVD_0z5o6D0L-1roj19GTaOCYiroAXEWWhXMY4tC5+1Xw@mail.gmail.com>
Subject: Re: [RFC v2 1/8] Bluetooth: Setup LE scan with no timeout
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 16, 2013 at 8:26 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patch modifies hci_do_le_scan and hci_cancel_le_scan helpers so
>> we are able to start and stop LE scan with no timeout. This feature
>> will be used by the LE connection routine.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  net/bluetooth/hci_core.c | 17 +++++++++--------
>>  1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 22e77a7..3aa0345 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1618,26 +1618,27 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
>>       if (err < 0)
>>               return err;
>>
>> -     queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
>> -                        msecs_to_jiffies(timeout));
>> +     if (timeout > 0)
>> +             queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
>> +                                msecs_to_jiffies(timeout));
>>
>>       return 0;
>>  }
>
> I really do not like this magic handling of scan disable. Maybe you
> better remove the timeout handling completely and put it into the
> discovery functionality.
>
> Doing it like this seems pretty much hacked together. It no longer looks
> like the right place to do handle it.

The le_scan_disable work should be scheduled only if LE scanning was
started successfully.

So hci_do_le_scan seems to be a better place than discovery
functionality for the timeout handling. Besides, these LE scan helpers
were originally designed to provide a self-contained framework to
start and stop LE scanning.

The framework lacks support for starting LE scanning with no timeout.
This patch aims to address this issue.

Anyway, if you still think it is a good idea to remove this timeout
handling, I'll remove it in the next series.

Regards,

Andre
