Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: [PATCH] sbc: fix for overflow bug in quantization code
Date: Mon, 22 Dec 2008 13:37:53 +0200
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, jaska.uimonen@nokia.com,
        "ext Marcel Holtmann" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200812172243.27442.siarhei.siamashka@nokia.com> <2d5a2c100812191423g301a6aebr103d3602e8ec984c@mail.gmail.com> <d89ddf300812191451q5a94a6b7n91423f1ce5a91a9f@mail.gmail.com>
In-Reply-To: <d89ddf300812191451q5a94a6b7n91423f1ce5a91a9f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812221337.53781.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Saturday 20 December 2008 00:51:52 ext Brad Midgley wrote:
> Luiz,
>
> > So what about the subband filters fixes and 16 bit fixed point, do you
> > thing it can be done? I left this out since the last patch was only
> > dealing with 8 subband and was 32 bit.
>
> FYI, I made some testing changes some time ago from 32-bit to 16-bit
> integers that didn't improve performance on arm at all...

There are a few things to note:
1. Subband filter, while using a noticeable amount of CPU, is not the only
bottleneck in SBC encoder. Other parts of code also need to be improved in
order to see a major overall performance improvement as a result of
subband filter optimization
2. If you want to benefit from 16-bit math on ARM, you need to compile the
code with right -mcpu/-march settings. Fast single cycle 16-bit multiplication
instructions were introduced on ARM with armv5te instruction set and ARM9E
core. If you compile the code for armv4, you will hardly see any improvements
at all. Also current code explicitly uses 32-bit multiply-accumulate
instruction in inline assembly macro, preventing the compiler from using
16-bit instructions even for the cases where it could.

Performance improvement of using 16-bit multiplication instructions on ARM for
the subband filter function should be really high, if done right.

> we shouldn't sacrifice quality for no real improvement in performance.

With the patch from http://marc.info/?l=linux-bluetooth&m=122972547004294&w=2
anyone can already estimate the quality difference between using 16-bit fixed
point and 32-bit fixed point.

If we take http://media.xiph.org/BBB/BigBuckBunny-stereo.flac , convert it to
au format and use in testing, we get the following results (encoding was done
with bluez sbc encoder, decoding was done with some conformant reference
win32 decoder binary, original file was compared with the decoded result using
tiny_psnr tool).

First we can try to crank up bitrate to the very maximum and encode the file
with the following command line:
./sbcenc -j -S -b 255 BigBuckBunny-stereo.au >BigBuckBunny-stereo.sbc

bluez 16-bit fixed point:
stddev:    2.55 PSNR: 88.16 bytes:114491016/114491308

bluez 32-bit fixed point:
stddev:    1.09 PSNR: 95.56 bytes:114491016/114491308

reference encoder:
stddev:    1.09 PSNR: 95.56 bytes:114491016/114491308

Looks like a major difference and 16-bit fixed point looks bad in comparison,
right? But this is the artificial case when the compressed file is even bigger
than the original.

If we try to use more realistic settings similar to the recommended high
quality settings from SBC specification (Table 4.7):
./sbcenc -j -S -b 51 BigBuckBunny-stereo.au >BigBuckBunny-stereo.sbc

bluez 16-bit fixed point:
stddev:   43.82 PSNR: 63.48 bytes:114491016/114491308

bluez 32-bit fixed point:
stddev:   43.78 PSNR: 63.49 bytes:114491016/114491308

reference encoder:
stddev:   43.37 PSNR: 63.57 bytes:114491016/114491308

Now as you see, effects of having not very precise calculations are completely
eclipsed by the quantization and compression artefacts. I think that the 
difference is really negligible.

If anybody wants to help, results of blind ABX tests with a real A2DP headset
are very much welcome. But I suspect that nobody will be able to tell the
difference between 16-bit and 32-bit version.

PS. I still wonder why there is a loss when compared to reference encoder.
32-bit fixed point version should be even more precise than single precision
floating point. Maybe there could be another minor bug in the code, or it is
just a random deviation and there could be a win for other audio files.

> The story may be different on a mips etc core, but I think we should
> realize real performance improvements in order to justify lowering
> fidelity.

I don't know anything about mips at all.

-- 
Best regards,
Siarhei Siamashka
