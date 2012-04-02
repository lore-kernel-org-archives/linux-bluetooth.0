Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABax29U=bsb0T2FQtzkQ2WGOkDTgJ8STshcu8fRmC4QvHEv=QQ@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
	<CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
	<CABax29U8N2nOge34tr=G2f-fZvowCHPf3V=N2an-vC+x=UBdiQ@mail.gmail.com>
	<CACY+gR2PkP76J2Dw9xobpeGsU2HKhsOYvU6Wcx8WCcq1opihiA@mail.gmail.com>
	<CABax29VadeA+6WZWRDiZZUhpRqk2Nk35__b0Cjfz8HO12Tq4vQ@mail.gmail.com>
	<CACY+gR0DJfbOgfSGHrsAj5vk00v4-_+KYwR+SF+0BRRs2oYBkw@mail.gmail.com>
	<CABax29X+ke_PO9obAxbEJjdx68g8JW4ZZn7vS7mYpE7+00iYng@mail.gmail.com>
	<CABax29WFvAXH9g8CnOtEDAqfmKmURnt4eYY58fi+P9zBa5Ji1A@mail.gmail.com>
	<CACY+gR3pqj6xoJ-G-pt5QTY6BjuyUNXTZRzsQmmutcSNBzY3qQ@mail.gmail.com>
	<CABax29Unh0AOhExp_FJwUr=edmPSDXy=_YJAXN81M5tp5+yUxw@mail.gmail.com>
	<CABax29XWLWcBT6hHgSQud6qzhQ-Y-WAMjQ8ytCT7Px09H1iQtg@mail.gmail.com>
	<CACY+gR3aPvvMRvNW+c3QdF8UkGR4ZGPChWt4MAoa+5fK=HSBNQ@mail.gmail.com>
	<CABax29U=bsb0T2FQtzkQ2WGOkDTgJ8STshcu8fRmC4QvHEv=QQ@mail.gmail.com>
Date: Mon, 2 Apr 2012 12:44:04 +0300
Message-ID: <CACY+gR326euT9fgXMZF_XLV28peJUJVWxOVZAA_xNEfHAsRRWA@mail.gmail.com>
Subject: Re: [PATCH] Re: A2DP quality (bluetooth-alsa)
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 28, 2012 at 2:28 AM, qduaty <qduaty@gmail.com> wrote:
> ALSA bitpool patch is attached.
>
> 2012/3/27 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>> The first patch adds debug prints to syslog from sbc encoder, just to
>> clearly confirm the real bitpool used by the encoder.
>
> It obviously worked:
>
> Mar 27 17:49:41 machina-turbo pulseaudio[2355]: sbc_encode: bitpool set to 138
>
>> The second patch removes default_bitpool() limitation, and this boosts
>> bitpool from 53 to 64 for me.
>
> I found it was my device that prevented Bluez from using higher
> bitpools. Bluez assumes that requesting a wider range of bitpools from
> a device will cause an error, and indeed, my device cannot be
> configured with a bitpool range wider than 2-53. So the only way to
> achieve higher bitrates is to force them.

I guess this depends on the headset. Your patch hacks around and
allows you to use higher bitpool with your Nokia BH-503 headset. With
my Logitech FreePulse headset, your patch does not seem to break audio
playback, but on the other hand such radical changes are not needed
(just removing default_bitpool() is enough to be able to set bitpool
to 128 via ./asoundrc). For somebody else your patch might possibly
even break audio playback if their headset does not like to be forced.

> There is (was) a rather serious problem in the ALSA module, when it
> tried to set bitpool exceding device capabilities, it ended with an
> error and next tries, even with a valid bitpool, resulted in "Invalid
> seid 0" in syslog and required bluetooth service to be restarted. With
> my patch, bluez only uses the configured bitpool for sbc, without
> sending it to the device. So, any bitpool value not exceeding true
> device and adapter capabilities will work (and these can be much
> higher than negotiated).

Apparently this works a bit different in my case and I don't get the
same "Invalid seid 0" error.

In any case, what we have here is that (some?) A2DP headsets can
support a lot higher SBC bitpool settings than they are normally
reporting. Now the big question is how to probe for this information
without violating negotiation protocol in any way and not causing any
regressions. The next question is how to decide which bitpool to use
by default, because in my case bitpool 128 occasionally causes some
skips in music playback which did not happen with lower bitpool
settings.

Could you provide a short summary for this whole discussion? The
discussion has been changing from bitpool negotiation to SBC codec
improvements back and forth. And now it's becoming hard to follow and
see which problems are still relevant and need to be solved. Also do
you want to work on some code yourself or mostly trying to escalate
the problems?

A2DP is in the list of ideas for BlueZ GSoC, so maybe that's a good
chance to get some improvements implemented:
http://www.bluez.org/development/gsoc/gsoc-ideas-list-2012/

-- 
Best regards,
Siarhei Siamashka
