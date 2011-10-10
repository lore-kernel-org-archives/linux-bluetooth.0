Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
Date: Mon, 10 Oct 2011 21:10:40 +0200
Message-ID: <CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
Subject: Re: A2DP quality (bluetooth-alsa)
From: "qduaty@gmail.com" <qduaty@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/10/10 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> It can be 2 things, either a bug or the device maximum bitpool is
> actually 53 so we cannot negotiate it.

My headset indeed reports bitpool range up to 53. WinMo seems to
either override it, or present some features that cause the Nokia BT
chip to report a wider range. Unfortunately I don't know how to
disable encryption in Windows Mobile to capture its bluetooth session
(and how to capture it with Bluez). Can 'hcidump' do this?

> PulseAudio uses 64 as bitpool maximum and it seems to work fine

Yes, wIth movies, games etc. the quality is excellent.

2011/10/10 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
> On Mon, Oct 10, 2011 at 1:40 PM, qduaty@gmail.com <qduaty@gmail.com> wrote:
> Could you please provide a link to the Xiph Foundation's article you
> have mentioned? Also what does "SBC is unable to encode such material
> properly" mean?

I remember it was their "About" article, but it seems either they
shortened it (removing fragments irrelevant to their mission) or it
has never been there and I've seen it somewhere else. Anyway, the
whole phenomena is called "Loudness war". CD's are recorded with
dynamics compression, so their sound has distortions introduced in
production and high energy in all subbands at the same time. Thus, SBC
must encode distortions as well as higher energy in all subbands.

> The SBC decoder seems to be clamping the out-of-range values [...]
> not doing any clamping is a lot worse and letting the samples
> overflow results in really bad audible clicks.

Maybe sin() would help, who knows? Obviously in the decoder, which
usually cannot be reprogrammed, but future /bluez devices/ could
benefit from this.

> What kind of A2DP headset are you using yourself?

Nokia BT-503. Its quality is enough to notice an obvious difference
between 'computer' bitpool (<=53) and that coming from Windows Mobile
(128 does not cause skipping yet). In presence of dynamics
compression, even two guitars with a vocal can be distinguished only
with higher bitpool. Another example is a symphony - I can hear
individual instruments from WinMo, and a "movie soundtrack" from
Bluez. I don't know how the device deals with clicks, but I never
heard them. Usual (and also annoying) distortion is a 'chirp' in some
bands.


Regards
--
Sebastian Olter
