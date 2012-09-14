Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5052519F.30803@butterbrot.org>
References: <5050F5A9.5090401@butterbrot.org>
	<CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com>
	<ed6fbaf1-1410-4539-a36e-1d6d6f6220b5@email.android.com>
	<CANq1E4RmacRAkTVtRt2JH_+V=qn1AH3iJWZZS_LCqmj_yt4DoQ@mail.gmail.com>
	<CANq1E4S70tqhTG7PTMj5cHp45NLO9g4n1eLVaHJMuDZx1KMYjg@mail.gmail.com>
	<5052519F.30803@butterbrot.org>
Date: Fri, 14 Sep 2012 02:02:21 -0700
Message-ID: <CANq1E4TRWGTdpiXsrR3uUp+n1jtptRnSaOp++LBKqyiRM0=eGg@mail.gmail.com>
Subject: Re: Wii Balance Board vs. bluez
From: David Herrmann <dh.herrmann@googlemail.com>
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian

On Thu, Sep 13, 2012 at 2:35 PM, Florian Echtler <floe@butterbrot.org> wrote:
> On 13.09.2012 16:39, David Herrmann wrote:
>>>
>>> Please see the appended patch. You have to apply it to your kernel
>>> tree and recompile the hid-wiimote driver. No other sources are
>>> changed so you don't need to reboot or install the new kernel. Just
>>> install the new hid-wiimote.ko module.
>>>
>>> One of the 5 input devices should then report the wiimote weight
>>> sensor data. (the input device with name "Wii Remote Balance Board").
>>
>> Forgot to attach the patch... Here it is.
>
> Awesome - works as expected, weight sensor data can be read from one of the
> event devices.

Good to hear. I hate writing drivers for devices I don't have...
Thanks for testing!

> I've attached an additional patch on top of yours to also read the
> calibration data (24 bytes at address 0xa40024). Calibration data is applied
> in handler_balance_board, resulting values are in units of 10 grams.
> Although this looks correct to me, I'm not getting any events with my patch
> applied - I suspect some connection to the min/max input values. Do you have
> any ideas what's wrong?

Ah, yeah I forgot to change the min/max values of ABS_HAT**. I will
fix that. The calibration data looks also nice. I have no idea what
went wrong, but you should definitely initialize it to some sane value
and fallback to this if you cannot read the data from the device. I
would also like to split this into two patches. The first one without
calibration and the second one applies the calibration data.

I will try to resend these this afternoon, otherwise, I will not have
time until Sunday afternoon. Sorry.

Thanks for the efforts!
David
