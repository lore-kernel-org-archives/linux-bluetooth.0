Return-Path: <cyrus@holtmann.org>
To: Hendrik Sattler <post@hendrik-sattler.de>,
	Jaganath Kanakkassery <jaganath.k@samsung.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd 2/2] gobex: Fix ABORT request not processing
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Fri, 13 Jan 2012 14:36:54 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
In-Reply-To: <20120113130127.GA8173@x220>
References: <1326448613-8367-1-git-send-email-jaganath.k@samsung.com>
 <adc3f64ff0de3606125dfbdea3f6b2ac@mail.hendrik-sattler.de>
 <20120113105420.GA4490@x220>
 <8d043367426e37a570df29ff2f4b298b@mail.hendrik-sattler.de>
 <20120113112111.GA5880@x220>
 <82c765e00dbfd5c5b2adf4059f7205b7@mail.hendrik-sattler.de>
 <20120113130127.GA8173@x220>
Message-ID: <51b47fcb808c7f5a99274ed0c3008c44@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 13.01.2012 14:01, schrieb Johan Hedberg:
> Hi Hendrik,
>
> On Fri, Jan 13, 2012, Hendrik Sattler wrote:
>>Am 13.01.2012 12:21, schrieb Johan Hedberg:
>>>Hi Hendrik,
>>>
>>>On Fri, Jan 13, 2012, Hendrik Sattler wrote:
>>>>>>>		opcode = obex->rx_last_op;
>>>>>>>		/* Unexpected response -- fail silently */
>>>>>>> -		if (opcode > 0x1f && opcode < 0xff) {
>>>>>>> +		if (opcode > G_OBEX_OP_ABORT && opcode < 0xff) {
>>>>>>>			obex->rx_data = 0;
>>>>>>>			return TRUE;
>>>>>>>		}
>>>>>>
>>>>>> This one always evaluates to false because 0xff ==
>>>>>> G_OBEX_OP_ABORT |
>>>>>> FINAL_BIT.
>>>>>
>>>>> The value of obex->rx_last_op is stored with the final bit 
>>>>> cleared,
>>>>> so the < 0xff part could also be removed from the test. The value
>>>>> 0x1f has been picked because the IrDA OBEX specification defines
>>>>> 0x10 - 0x1f as a user-definable range, so anything between 0x1f 
>>>>> and
>>>>> 0x7f isn't actually valid. The correct test would then become:
>>>>>
>>>>>	if (opcode > 0x1f && opcode != G_OBEX_OP_ABORT)
>>>>>
>>>>> Jaganath, with the above change the patch should be ok, but the
>>>>> more surprising thing to me here is that this implies we're 
>>>>> missing
>>>>> one or more unit tests for Abort. Could you create a patch to add
>>>>> those too?  (if we're really strict those tests should go in 
>>>>> before
>>>>> this patch so that it's actually possible to see that the patch
>>>>> makes a difference).
>>>>
>>>> User-definable does not mean invalid. It only means that these can
>>>> be used for custom commands. These are still bound to the rules of
>>>> the OBEX protocol. I've never seen one using that, though.
>>>
>>> Exactly. You might want to re-read what I said and the test I
>>> proposed.
>>
>> I did.
>
> I interpreted your message as you thinking that I was wanting to 
> filter
> out or equate user-definable values as invalid. Seems I was wrong 
> then.
>
>>>> Else you'd also have to filter 0x04 and the range 0x08-0x0f 
>>>> because
>>>> these are marked as "reserved".
>>>
>>> With the test I proposed we filter neither reserved (since they 
>>> might
>>> get meaning in new spec versions) nor user-defined opcodes.
>>
>> Your propose if-line discards all packets with opcodes in the range
>> 0x20-0x1e.
>
> I suppose you mean 0x20-0x7f (since 0x1e is less than 0x20)?

Yes :-)

> Yes, and in addition to that it also discards 0x80-0xff.

No, that bit is filtered, the highest value _is_ 0x7F.

>> I would remove that if-line (and also the wrong comments that talks
>> about responses but means requests).
>
> No, it does mean responses. In the case that we've timed out waiting 
> for
> a response it is possible that we still receive it later (if we time 
> out
> while the packet is already on its way to us). This test is meant to
> discard such packets (i.e. any packet that isn't an obvious command).

The values we are talking about here are request values, not response 
values.
You cannot differ response or request by pure opcode values but only by 
the
role (client or server) that your are in.
This if-check looks like for the server-role. And a server only takes
requests, not responses.

>> OTOH, the reserved and user-defined packets will fail immediately
>> after that anyway due to the check of the length of non-header data
>> returning -1 for those cases.
>
> For this one possible solution is to add the capability for defining
> custom header offsets for user-defined opcodes. But we'll do that 
> only
> once someone has a real use-case for it and requests the feature.
>
>> Not only that but it immediately drops connection because of that? 
>> It
>> could at least get the packet and send a negative response.
>
> That's true, an error response could be added instead of discarding 
> the
> connection as unusable. One question to answer though is should we
> inform the application about this somehow.

I guess not unless you also add the ability to make the application 
handle
user-defined opcodes. It's ok to only add this ability on request.

Just imaging a client that tests a user-defined opcode for special 
devices
but can also go on without that for normal devices. Theoretically, of 
course.

HS

