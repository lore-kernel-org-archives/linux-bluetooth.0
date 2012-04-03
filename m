Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACY+gR326euT9fgXMZF_XLV28peJUJVWxOVZAA_xNEfHAsRRWA@mail.gmail.com>
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
Date: Tue, 3 Apr 2012 02:56:49 +0200
Message-ID: <CABax29XEJ5V5_cN9ieXfb1byDB7bQsuuwenJLOUDos7NNuepaQ@mail.gmail.com>
Subject: Re: [PATCH] Re: A2DP quality (bluetooth-alsa)
From: qduaty <qduaty@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/4/2 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
> Your patch hacks around and
> allows you to use higher bitpool with your Nokia BH-503 headset. With
> my Logitech FreePulse headset, your patch does not seem to break audio
> playback, but on the other hand such radical changes are not needed
> (just removing default_bitpool() is enough to be able to set bitpool
> to 128 via ./asoundrc). For somebody else your patch might possibly
> even break audio playback if their headset does not like to be forced.

This means your headset is capable of decoding at higher bitpool than
it claims, as well as mine. So there is 50% probability that all A2DP
headsets support higher bitpools than they report.

My patch won't break anyone's playback unless they specify extremely
high bitpool values; most users won't do it due to the lack of
knowledge that it's possible (and has any purpose), and the rest will
know exactly what they're doing.

The solution works as well in pulseaudio (though, it is hard to
specify the bitpool and I have it currently hardcoded in
setup_a2dp()).

> In any case, what we have here is that (some?) A2DP headsets can
> support a lot higher SBC bitpool settings than they are normally
> reporting. Now the big question is how to probe for this information
> without violating negotiation protocol in any way and not causing any
> regressions. The next question is how to decide which bitpool to use
> by default

Just use default_bitpool(), but let users override it. I didn't post a
modified patch because it seemed obvious, but here it is (a
modification of bluetooth_a2dp_setup()):

	/* If the bitpool was not configured, use default */
	if(a2dp->sbc.bitpool <= MIN_BITPOOL)
	    a2dp->sbc.bitpool = MIN(default_bitpool(active_capabilities.frequency,
					active_capabilities.channel_mode),
					active_capabilities.max_bitpool);

With this change, Bluez will use default_bitpool() unless a user
specifies a bitpool in the config file.

Regarding the detection - I think any way of probing the maximum is
likely to be magic and can mysteriously fail with an unsupported
device.

>, because in my case bitpool 128 occasionally causes some
> skips in music playback which did not happen with lower bitpool
> settings.

L2CAP speed tests that I've seen, show that no 2.0+EDR device is
capable of transmitting even 2 Mb/s. In my case, a bitrate of 800kbps
(bitpool=138, 44100 Hz, 16 blocks) is achievable in A2DP.

> Could you provide a short summary for this whole discussion? The
> discussion has been changing from bitpool negotiation to SBC codec
> improvements back and forth. And now it's becoming hard to follow and
> see which problems are still relevant and need to be solved. Also do
> you want to work on some code yourself or mostly trying to escalate
> the problems?
>
> A2DP is in the list of ideas for BlueZ GSoC, so maybe that's a good
> chance to get some improvements implemented:
> http://www.bluez.org/development/gsoc/gsoc-ideas-list-2012/

Ok. This is the summary.
1. It was found that Bluez can occasionally limit available bitpool
because some devices report a narrow bitpool range that does not
reflect their real capabilities. A solution was proposed by means of
encoding at a higher bitpool than negotiated, and it was confirmed to
both work and not break compatibility, unless it is misused.
2. It was found that Bluez audio sink has quality problems even on
high bitpools. An SBC encoder fix was proposed, which (re)enables
floating point processing. Tests are needed to confirm whether it
improves quality in all cases.
3. It was (previously) found and now confirmed that reducing volume in
SBC encoder by a factor of 0.7-0.8 improves quality by eliminating
audible effects of clipping in the decoder.

For myself, I'm likely to be done with it. I've already solved the
problems that prevented me from using A2DP on Linux. Further work
would require more time and I cannot benefit from it (but students
obviously can).

My proposals:
1. Introduce a less restrictive input format for the audio sink, such
as float32. Currently it supports only S16LE, which is not suitable
for audio processing (ALSA softvol is a known example).
2. Find out what quality problems the SBC decoder has and fix them.
Possibly introduce floating point output to eliminate clipping.
3. Implement proper (adaptive?) clipping prevention in the SBC encoder.


Regards

--
Sebastian Olter
