Return-Path: <cyrus@holtmann.org>
Message-ID: <55265438.50008@gmail.com>
Date: Thu, 09 Apr 2015 12:28:08 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core/mgmt: Change adv inst to list.
References: <1428162231-17940-1-git-send-email-fgrandel@gmail.com> <1428258080-6275-1-git-send-email-fgrandel@gmail.com> <20150409094913.GB10676@t440s.lan>
In-Reply-To: <20150409094913.GB10676@t440s.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

thank you very much for your review.

On 04/09/2015 11:49 AM, Johan Hedberg wrote:
> Hi Florian,
>
> On Sun, Apr 05, 2015, Florian Grandel wrote:
>> As a preparatory step towards multi-instance advertising it is
>> necessary to introduce a data structure that supports storing
>> multiple advertising info data structures for a bluetooth device.
>>
>> This is introduced by refactoring the existing adv_instance member
>> of the hci_dev struct into a linked list and making the necessary
>> changes in the code to support this list.
>>
>> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
>> ---
>>
>> v1 -> v2: add missing braces in read_adv_features()
>>
>>   include/net/bluetooth/hci_core.h |  21 ++-
>>   net/bluetooth/hci_core.c         | 118 ++++++++++++-
>>   net/bluetooth/mgmt.c             | 345 +++++++++++++++++++++------------------
>>   3 files changed, 316 insertions(+), 168 deletions(-)
>
> It'd be really good if you could try to split this patch up a bit. It
> really is going over the limits of individual patch sizes that we're
> comfortable with. See if you can split this up logically into at least
> two, preferably more (3-4) patches while still keeping something that
> compiles during each step.

I fully agree. I admit that I thought hard about how to split this up 
before posting the patch but couldn't come up with a solution I felt 
comfortable with: :-(

1) I could leave the old data-structure temporarily in place and 
introduce the new one in parallel which would allow me to introduce the 
list management stuff in hci_core separately without breaking the build 
or any e2e tests. Removing parts of such a patch set would leave the 
code in an intermediate state, though, that wouldn't be acceptable as 
such. And I'd still have to introduce the bulk of the complexity in 
mgmt.* as a single patch to not break e2e tests.

2) If breaking functionality temporarily between commits is not an 
issue, then I could think of a much finer grained approach. I could 
provide e.g. one patch per mgmt API method or even one patch per method. 
Removing parts of such a patch set would still compile but leave the 
code in a buggy state that would not pass e2e tests.

Does any of these ideas sound like an acceptable solution to you? Or do 
you maybe have a better alternative?

>> +			if (err == 0)
>> +				advertising_removed(sk, hdev,
>> +						    adv_instance->instance);
>> +		}
>> +	} else {
>> +		err = hci_remove_adv_instance(hdev, instance);
>> +		if (err == 0)
>> +			advertising_removed(sk, hdev, instance);
>
> I think if (!err) is the more consistent convension.

Sure, will be fixed throughout.

>> +	err = hci_add_adv_instance(hdev, cp->instance, flags,
>> +					 cp->adv_data_len, cp->data,
>> +					 cp->scan_rsp_len,
>> +					 cp->data + cp->adv_data_len,
>> +					 adv_timeout_expired, timeout);
>
> The split lines don't look like they're correctly lined up. They should
> start from one column after the opening '(' on the first line.
>
>> +	// TODO: Trigger an advertising added event even when instance
>> +	// advertising is already switched on?
>
> Please stick to /* ... */ for comments.

Of course. My oversight.

Florian
