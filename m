Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACY+gR3rjZ9_5zJ2yAf7Z+yfa7RsNWBRhNk5NJadpF5_V2TS7Q@mail.gmail.com>
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
	<CACY+gR326euT9fgXMZF_XLV28peJUJVWxOVZAA_xNEfHAsRRWA@mail.gmail.com>
	<CABax29XEJ5V5_cN9ieXfb1byDB7bQsuuwenJLOUDos7NNuepaQ@mail.gmail.com>
	<CACY+gR3rjZ9_5zJ2yAf7Z+yfa7RsNWBRhNk5NJadpF5_V2TS7Q@mail.gmail.com>
Date: Tue, 31 Jul 2012 13:09:19 +0300
Message-ID: <CABBYNZKzJCqnkManeGxtWuDsKF_hHK+Ucbb1SXzUuce5cLdmqw@mail.gmail.com>
Subject: Re: [PATCH] Re: A2DP quality (bluetooth-alsa)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Wed, Apr 4, 2012 at 11:12 AM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> On Tue, Apr 3, 2012 at 3:56 AM, qduaty <qduaty@gmail.com> wrote:
>> 2012/4/2 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>>> Could you provide a short summary for this whole discussion? The
>>> discussion has been changing from bitpool negotiation to SBC codec
>>> improvements back and forth. And now it's becoming hard to follow and
>>> see which problems are still relevant and need to be solved. Also do
>>> you want to work on some code yourself or mostly trying to escalate
>>> the problems?
>>>
>>> A2DP is in the list of ideas for BlueZ GSoC, so maybe that's a good
>>> chance to get some improvements implemented:
>>> http://www.bluez.org/development/gsoc/gsoc-ideas-list-2012/
>>
>> Ok. This is the summary.
>> 1. It was found that Bluez can occasionally limit available bitpool
>> because some devices report a narrow bitpool range that does not
>> reflect their real capabilities. A solution was proposed by means of
>> encoding at a higher bitpool than negotiated, and it was confirmed to
>> both work and not break compatibility, unless it is misused.
>> 2. It was found that Bluez audio sink has quality problems even on
>> high bitpools. An SBC encoder fix was proposed, which (re)enables
>> floating point processing. Tests are needed to confirm whether it
>> improves quality in all cases.
>> 3. It was (previously) found and now confirmed that reducing volume in
>> SBC encoder by a factor of 0.7-0.8 improves quality by eliminating
>> audible effects of clipping in the decoder.
>
> OK, thanks.
>
>> For myself, I'm likely to be done with it. I've already solved the
>> problems that prevented me from using A2DP on Linux. Further work
>> would require more time and I cannot benefit from it (but students
>> obviously can).
>
> Fair enough.
>
>> My proposals:
>> 1. Introduce a less restrictive input format for the audio sink, such
>> as float32. Currently it supports only S16LE, which is not suitable
>> for audio processing (ALSA softvol is a known example).
>> 2. Find out what quality problems the SBC decoder has and fix them.
>> Possibly introduce floating point output to eliminate clipping.
>> 3. Implement proper (adaptive?) clipping prevention in the SBC encoder.

Is there anyone working on this proposals? Specially the decoder seems
to need some optimization as it consumes quite a bit of CPU (6-8% on
my i7) and some people seems to notice some quality issues.


-- 
Luiz Augusto von Dentz
