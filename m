Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH, RFC] Bluetooth: btusb, hci_intel: Fix
 wait_on_bit_timeout() return value checks
To: Johan Hedberg <johan.hedberg@gmail.com>
References: <fae0be30-bd77-e5ce-37c6-58591916d28c@sandisk.com>
 <20160812091237.GA31871@t440s.P-661HNU-F1>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <1f29b9e3-5c2f-be23-f591-34e43a67d0d1@sandisk.com>
Date: Fri, 12 Aug 2016 09:17:54 -0700
MIME-Version: 1.0
In-Reply-To: <20160812091237.GA31871@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/12/2016 02:12 AM, Johan Hedberg wrote:
> On Thu, Aug 11, 2016, Bart Van Assche wrote:
>> wait_on_bit_timeout() returns one of the following three values:
>> * 0 to indicate success.
>> * -EINTR to indicate that a signal has been received;
>> * -EAGAIN to indicate timeout;
>> Make the wait_on_bit_timeout() callers check for these values.
>> This patch has not yet been tested.
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Cc: Gustavo Padovan <gustavo@padovan.org>
>> Cc: Johan Hedberg <johan.hedberg@gmail.com>
>> ---
>>  drivers/bluetooth/btusb.c     | 5 ++---
>>  drivers/bluetooth/hci_intel.c | 6 +++---
>>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> Good catch. It seems the API was changed not to return 1 by this commit
> (which failed to update any users of of it):
>
>   commit 68985633bccb6066bf1803e316fbc6c1f5b796d6
>   Author: Peter Zijlstra <peterz@infradead.org>
>   Date:   Tue Dec 1 14:04:04 2015 +0100
>
>       sched/wait: Fix signal handling in bit wait helpers
>
> Do you have some doubts about your fix? You put "RFC" in the subject
> which usually means the author isn't completely sure about it.

Hello Johan,

The reason I put "RFC" in the subject is because I wouldn't like this 
patch to be accepted upstream without having been tested first. 
Mentioning "RFC" makes people think twice before applying a patch. 
That's the only reason.

Bart.
