Return-Path: <cyrus@holtmann.org>
Message-ID: <51E8079C.2030605@hurleysoftware.com>
Date: Thu, 18 Jul 2013 11:19:56 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org
Subject: Re: [PATCH 6/8] Fix the reference counting of tty_port
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it> <1373661649-1385-6-git-send-email-gianluca@sottospazio.it> <51E6A3F7.20202@hurleysoftware.com> <20130717170500.GA10640@sottospazio.it> <51E6DE1D.4020808@hurleysoftware.com> <51E7E377.2000108@hurleysoftware.com> <20130718141310.GA16537@sottospazio.it>
In-Reply-To: <20130718141310.GA16537@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/18/2013 10:13 AM, Gianluca Anzolin wrote:
> On Thu, Jul 18, 2013 at 08:45:43AM -0400, Peter Hurley wrote:
>> On 07/17/2013 02:10 PM, Peter Hurley wrote:
>>> That said, preventing rfcomm_dev destruction by holding the dlc lock
>>> is poor design (not that I'm suggesting you should be required to fix it though)
>>> and something that at least needs documenting.
>>>
>>> Regarding acquiring a snapshot of dev->id is fine, provided that the id
>>> cannot be reallocated in between dropping the dlc lock and subsequently
>>> scanning the rfcomm_dev_list for that id.
>>
>> Or at least a FIXME comment that the id could potentially be reallocated
>> between dropping the dlc lock and the subsequent rfcomm_dev_get().
>>
>> Regards,
>> Peter Hurley
>
> I must admit I don't know how to solve the issue you outlined. I cannot also
> understand why that code exists in first place: why should we release the
> device when RFCOMM_RELEASE_ONHUP is set but we didn't get a HUP?

Essentially a HUP did occur: the underlying device is gone/disconnected.
The rfcomm_dev_state_change(BT_CLOSED) is the notification that this has
happened. This event is similar to a usb disconnect or pci remove.

As far as why a user-space flag (RFCOMM_RELEASE_ONHUP) controls this
behavior, I have no idea. It pre-dates the original commit in
current mainline.

But regardless, rfcomm_dev teardown must be a supported behavior of lower-layer
device disconnects.

ISTM the central design flaw is the cross-linkage of dlc <-> rfcomm_dev.
Cross-linked structures are trivial to establish and *very* difficult
to dismantle. A solution I've used before is RCU from one direction and
spinlock from the other.

For this particular application though, it may be simpler to figure out
how to either reorder or separate the locks in rfcomm_dev_add(). If the
rfcomm_dev_lock can be dropped before acquiring the dlc lock, then
rfcomm_dev_state_change() could hold the dlc lock during rfcomm_dev
teardown. Unfortunately, it seems like that solution might allow
a not-completely-initialized rfcomm_dev to be found on the rfcomm_dev_list.

Maybe a better solution would be to completely initialize the rfcomm_dev
and dlc, and then just before registering the tty device, do the id
lookup and link in the rfcomm_dev into the rfcomm_dev_list last. The
main issue with this approach is that some means of preventing
rfcomm_dev_state_change() from acquiring a partially constructed
rfcomm_dev would need to exist. I don't see any serialization coming
from the lower-layer drivers, so the dlc->owner linkage would have
to be delayed until the rfcomm_dev was constructed and attached to
the rfcomm_dev_list. Or something like that :)

FWIW, your existing patches are a huge step forward for this code
so feel free to proceed with a v2 patchset that leaves this
problem unaddressed.

Regards,
Peter Hurley
