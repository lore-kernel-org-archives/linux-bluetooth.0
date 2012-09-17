Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50549F3C.8050406@butterbrot.org>
References: <5050F5A9.5090401@butterbrot.org>
	<CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com>
	<ed6fbaf1-1410-4539-a36e-1d6d6f6220b5@email.android.com>
	<CANq1E4RmacRAkTVtRt2JH_+V=qn1AH3iJWZZS_LCqmj_yt4DoQ@mail.gmail.com>
	<CANq1E4S70tqhTG7PTMj5cHp45NLO9g4n1eLVaHJMuDZx1KMYjg@mail.gmail.com>
	<5052519F.30803@butterbrot.org>
	<CANq1E4TRWGTdpiXsrR3uUp+n1jtptRnSaOp++LBKqyiRM0=eGg@mail.gmail.com>
	<50549F3C.8050406@butterbrot.org>
Date: Mon, 17 Sep 2012 11:47:38 +0200
Message-ID: <CANq1E4RE4ZhfvxhO=MdbMdwUZYrsdYnw=Yn7uLJE4gTAbHhOEw@mail.gmail.com>
Subject: Re: Wii Balance Board vs. bluez
From: David Herrmann <dh.herrmann@googlemail.com>
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian

On Sat, Sep 15, 2012 at 5:31 PM, Florian Echtler <floe@butterbrot.org> wrote:
> Hello David,
>
>
> On 14.09.2012 11:02, David Herrmann wrote:
>>
>> On Thu, Sep 13, 2012 at 2:35 PM, Florian Echtler <floe@butterbrot.org>
>> wrote:
>>>
>>> I've attached an additional patch on top of yours to also read the
>>> calibration data (24 bytes at address 0xa40024). Calibration data is
>>> applied
>>> in handler_balance_board, resulting values are in units of 10 grams.
>>> Although this looks correct to me, I'm not getting any events with my
>>> patch
>>> applied - I suspect some connection to the min/max input values. Do you
>>> have
>>> any ideas what's wrong?
>>
>> Ah, yeah I forgot to change the min/max values of ABS_HAT**. I will
>> fix that. The calibration data looks also nice. I have no idea what
>> went wrong, but you should definitely initialize it to some sane value
>> and fallback to this if you cannot read the data from the device. I
>> would also like to split this into two patches. The first one without
>> calibration and the second one applies the calibration data.
>> I will try to resend these this afternoon, otherwise, I will not have
>> time until Sunday afternoon. Sorry.
>
> never mind - I tested my patch again and noticed that the driver wasn't able
> to read all 24 calibration bytes in one go, which was the root cause for not
> getting any data (I am simply disabling the extension when not getting
> proper calibration data).
>
> I fixed this by doing two reads of 12 bytes each instead. I've also fixed
> some signedness issues with the data calculation - I've attached the updated
> version, which I think should now be ready for integration.
>
> Can you submit both patches to the list when you get around to it (and have
> tested it yourself)?

Thanks! I have both patches ready for submission. However, could you
actually tell me in what range data is submitted? As I said, I cannot
test these patches. But looking at the code, you get 16bit per value
raw input. You then calculate the per-kg value and multiply it by
17kg. So I guess you fill up the whole 16bit?

Your second patch does not adjust the MIN/MAX values for the ABS_HATXY
values and I am just looking for good values here.

Thanks
David
