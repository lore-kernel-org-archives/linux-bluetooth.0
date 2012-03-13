Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
	<CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
Date: Tue, 13 Mar 2012 02:48:50 +0100
Message-ID: <CABax29U8N2nOge34tr=G2f-fZvowCHPf3V=N2an-vC+x=UBdiQ@mail.gmail.com>
Subject: Re: A2DP quality (bluetooth-alsa)
From: qduaty <qduaty@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/10/18 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
> Still I would suggest you to try the attached patch just for a test.
> It reduces audio volume as part of the sbc encoding process and should
> eliminate most of the possible clipping cases on the decoding side.

Sorry for responding after a half year :) but I finally tested your
encoder patch applied to libbluetooth version 4.96, using AIMP3 and
pulseaudio. Unpatched encoder produces a "digital" distortion (which
is rather annoying) and sounds much like BlueSoleil on Windows. After
patching, music is slightly quieter (which can be expected if you
decreased its volume) and has an "analog overdrive" like through a
cheap FM radio. Anyway, the annoying "digital" distortion that was
present in unpatched encoder, is now gone.

Some fluctuations can be heard in higher bands in classical music, and
(as expected) instruments are indistinguishable, but it's acceptable
given the low bitpool.

For the "analog overdrive" I hear, it may also come from the device
itself (its proper name is Nokia BH-503). Considering its glue sealed
case, it might have been designed as a budget solution and its price
was "adjusted" due to no competition.

> Using bitpool 128 is kind of weird for SBC codec, because the encoded
> data stream has about the same size as the the original data and this
> defeats the whole purpose of having any lossy compression at all.

Yes, but who needs a lossy compression in an endpoint? SBC and MP3
were introduced to overcome the low throughput problem of the
bluetooth link, which is no longer the case since 2.0+EDR has plenty
of unused bits.

> I still recommend you to try sbcenc/sbcdec tools for the experiments with audio quality.

I tried them some time ago, but I believe ALSA backend may serve for
the same purpose (and is much easier to use). 8 blocks seems to sound
slightly better than 16 for classical music, full stereo eliminates
the floating of virtual sound sources, 48 kHz also seems to increase
quality a bit when compared to 44.1.

Regards

--
Sebastian Olter
