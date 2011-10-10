Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
Date: Mon, 10 Oct 2011 17:54:19 +0300
Message-ID: <CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
Subject: Re: A2DP quality (bluetooth-alsa)
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: "qduaty@gmail.com" <qduaty@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 10, 2011 at 1:40 PM, qduaty@gmail.com <qduaty@gmail.com> wrote:
> Hi people,
>
> I found that I cannot set A2DP bitpool to anything more than 53 in my
> ~/.asoundrc file. The bluetooth driver reports an error and keeps
> reporting it (becomes useless) until it is restarted.
>
> Bitpool values as high as 128 are possible on Windows Mobile devices
> (including mine), which means they are possible in A2DP.

The SBC codec itself supports bitpool values higher 53, and
sbcenc/sbcdec command line tools can be used to experiment with
encoding/decoding audio data.

> Such a high value is necessary for some genres of current music, which are highly
> compressed (the problem was once discussed in one of Xiph Foundation's
> articles). SBC is unable to encode such material properly if it
> doesn't have enough bandwidth.

Could you please provide a link to the Xiph Foundation's article you
have mentioned? Also what does "SBC is unable to encode such material
properly" mean?

My understanding is that the highly compressed sources are mostly a
problem not for SBC encoder, but actually for decoder:
    http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=3df7c3e66042f266dadace88488e532de92d4da9
When the original audio signal is using full range, then going to the
frequency domain, doing lossy compression, and going back to the time
domain may easily result in some sample values exceeding the valid
range. The reference binary SBC decoder seems to be simply clamping
the out-of-range values to bring them into valid range (based on the
output it produces). And since some time ago, bluez SBC decoder also
does the same. This not a perfect solution, because the shape of the
decoded signal abruptly changes to "flat" part at the top or bottom.
But not doing any clamping is a lot worse and letting the samples
overflow results in really bad audible clicks. However it's hard to
say how each particular A2DP headset deals with the out-of-range
samples. Most of them are apparently also doing clamping and the audio
sounds ok. But unfortunately sometimes this is not the case. I happen
to be an owner of Logitech FreePulse A2DP headset, and the
out-of-range samples can be clearly heard as clicking artifacts (in
the worst cases resembling 'frying pan' type of sound). I myself used
a hack by patching bluez SBC to also reduce audio volume as the part
of the encoding process so that the badly compressed audio sources are
less likely to have any out of range samples in the SBC encoded data
stream.

I guess that increasing bitpool would result in a less lossy encoding
with a better approximation of the original audio data. Hence less
likely to differ from the original data too much and go out of range.
But I don't think that it's a "proper" solution for the problem.
Normally, even low bitpool values should be still quite usable.

What kind of A2DP headset are you using yourself?

-- 
Best regards,
Siarhei Siamashka
