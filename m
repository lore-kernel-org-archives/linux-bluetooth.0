Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8w1_mtsjmO4=Giz0+Q43Q3wpq0sSdtFnH--A3Ne-chAPQ@mail.gmail.com>
References: <1420636254-25626-1-git-send-email-jpawlowski@google.com>
	<1420636254-25626-2-git-send-email-jpawlowski@google.com>
	<20150109102628.GA19211@t440s.lan>
	<CAD0=r8w1_mtsjmO4=Giz0+Q43Q3wpq0sSdtFnH--A3Ne-chAPQ@mail.gmail.com>
Date: Fri, 9 Jan 2015 14:45:25 +0100
Message-ID: <CAD0=r8x+S66CBbRdv5K9EqX=8K9NqbidmtSbB1kp+s-h8DMNvw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] Bluetooth: Add le_scan_restart
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 9, 2015 at 12:22 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> Hi Johan,
>
> On Fri, Jan 9, 2015 at 11:26 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Jakub,
>>
>> On Wed, Jan 07, 2015, Jakub Pawlowski wrote:
>>> -             cancel_delayed_work(&hdev->le_scan_disable);
>>> +             if (!bt_cb(hdev->sent_cmd)->req.marker)
>>> +                     cancel_delayed_work(&hdev->le_scan_disable);
>>>
>>>               clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
>>
>> Modifying the generic HCI request framework for this single purpose
>> doesn't make much sense to me. Also, the details of the bt_cb(skb)->req
>> struct are considered an implementation detail of the HCI request
>> specific handling and should not be directly touched by other code.
>
> Description of cb field of skbuff says it can be used by every layer:
> " @cb: Control buffer. Free for use by every layer. Put private vars
> here" ( http://lxr.free-electrons.com/source/include/linux/skbuff.h#L445
> )
> I fought I can just add something there, and use it.
> I agree that this field doesn't fit struct hci_req_ctrl , but that was
> only place where there are free bits, otherwise the struct gets too
> big and don't fit cb field.
>
>>
>> It looks to me like this marker has the same purpose as the flag you had
>> in some earlier revision of this set? For such a use-case a flag would
>> still be the best option.
>
> Yes, it have same meaning as this eariler version flag. The problem
> with flag was that I can't set it when I create request, it need to be
> set when the request is being executed, otherwise I can get race
> condition. In case of this marker field, there is no option to have
> race condition.
>
>> However, I'm wondering whether we can remove
>> the need for this completely. Can't you just let the code cancel the
>> delayed work and the re-schedule it again once the scanning gets
>> re-enabled (with some extra code decrease the timeout some appropriate
>> amount for each time scanning gets restarted).
>
> 1. I can't get remaining time from workqueue, so I'll have to remember
> when it was started.
> 2. When I do restart I'll still need some flag to know wether it was
> my internal restart, or wether someone just stopped and then started
> the scan, so I'll still need some flag, and way to set it.
>
> I have one more idea on how to make it work, I'll send patch soon.
>

Ok I figured out how you wanted it, it's much simpler now, I'll send
patches now.
Thanks!
>>
>> Johan
