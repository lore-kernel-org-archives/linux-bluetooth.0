Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200912171653.42190.siarhei.siamashka@gmail.com>
References: <002301ca7dd1$cb5fa3c0$621eeb40$@uni-marburg.de>
	 <200912170841.14550.siarhei.siamashka@gmail.com>
	 <aa32413d0912170449m162ca572p9e42275cf7c18201@mail.gmail.com>
	 <200912171653.42190.siarhei.siamashka@gmail.com>
Date: Thu, 17 Dec 2009 14:35:40 -0200
Message-ID: <aa32413d0912170835m33e2a288hd853b2d947106cef@mail.gmail.com>
Subject: Re: gstreamer and sbcdec problem
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/12/17 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
> On Thursday 17 December 2009, João Paulo Rechi Vita wrote:
>> 2009/12/17 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>> > On Wednesday 16 December 2009, João Paulo Rechi Vita wrote:
>> >> On Tue, Dec 15, 2009 at 10:03 PM, Siarhei Siamashka
>> >>
>> >> <siarhei.siamashka@gmail.com> wrote:
>> >> > Also I don't have much trust in the current bluez SBC decoder
>> >> > implementation. Its quality may be not the very best. I was
>> >> > considering to eventually review its code, do some refactoring and
>> >> > merge some of its parts with the encoder (SBC encode and decode are
>> >> > quite symmetric), but did not find some spare time for this yet.
>> >> > Considering that bluez got SBC sink support now, improving the decoder
>> >> > may make sense.
>> >>
>> >> IMO it would make sense to export SBC codec in a library, since
>> >> encoding and decoding is done outside bluetoothd (ALSA, gstreamer or
>> >> PulseAudio). Also, the codec could be used for applications different
>> >> from A2DP streaming, and the more people using it, more tested (and
>> >> eventually improved) the code gets.
>> >
>> > I don't have first hand information regarding this matter myself, but
>> > according to SBC wikipedia page [1]:
>> > "The patent owners wrote that they allow the free usage of SBC in
>> > Bluetooth application, with the view to boost the use of this technology.
>> > All applications outside Bluetooth are however not free."
>>
>> And if you continue reading the same paragraph: "The patent will
>> expire June 2, 2010.".
>
> So should we wait for half a year before bringing this discussion up again,
> or something? ;-)
>

No, of course not, hehe. I've just brought that up because in a few
months non-bluetooth application can benefit of this re-factor too.

>> But anyway, gstreamer and pulseaudio uses SBC for bluetooth
>> application, so it's under the free usage terms (and also, there is a
>> copy of sbc.c in pulseaudio tree).
>
> In any case, everything can be categorized into
> 1. administrative part (splitting off SBC into a separate library, make a
> repository for it, make a formal release, promote it and start using it in
> different bluetooth related projects).
> 2. technical part (fixing bugs and improving the codec)
>

At least for now, I don't think SBC should be moved to a different
repository, but only be split in a separate library and have a
separated release tarball. But I would like to know what other devs
think about this separation.

And part 2 should be done independently of making SBC a lib or not.

> I'm not very much interested in the "administrative part" myself :-)
>
> For the "technical part", the first thing to do is to change SBC decoder
> to use Q31 fixed point arithmetics in the synthesis filter. Currently it
> uses lower precision calculations and is somewhat optimized (to the point
> of becoming a bit obfuscated). After this change, the output of SBC decoder
> should differ from from the output of the reference SBC decoder binary
> probably only in the least significant bit. More significant differences (if
> any) are caused by the bugs in the code, most likely overflows on
> calculations (I already fixed a bug with caused by missing clamping of output
> in the decoder, but who knows how many of them could be still there?). After
> all the bugs get ironed out, support for Q15 calculations can be added for
> better performance and SIMD optimizations. Precision loss of Q15 fixed point
> implementation should be carefully checked and minimized.
>
> Additionally, more SIMD optimizations can still improve performance for both
> encoder and decoder.
>
> As for the other changes, maybe handling of the initial samples in the encoder
> could be tweaked (for example not by using zero samples in the initial
> "history" buffer, but putting something like a mirror reflection of the input
> data there). Still I'm not sure if it's a really big problem, maybe Marian can
> provide a bit more information about what is the real impact in practice.
>

So from you comments it seems you are interested and have the
technical knowledge to work these improvements. Please do this when
you find the time and send patches to the ML.

-- 
João Paulo Rechi Vita
MSc Computer Science Student
Computer Engineer
IC / Unicamp
http://jprvita.wordpress.com/
