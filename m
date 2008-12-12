Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] sbc: bitstream packing optimization for encoder.
Date: Fri, 12 Dec 2008 18:01:01 +0200
Cc: Christian Hoene <hoene@uni-tuebingen.de>, linux-bluetooth@vger.kernel.org
References: <200812112227.07170.siarhei.siamashka@nokia.com> <00c801c95c6d$9953dad0$cbfb9070$@de> <1229095847.22285.93.camel@violet.holtmann.net>
In-Reply-To: <1229095847.22285.93.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812121801.02083.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 12 December 2008 17:30:47 ext Marcel Holtmann wrote:
> Hi Christian,
>
> can we please keep this mailing a top-posting free zone. I know it is
> hard for Outlock to get this right, but it is possible.
>
> > next week I will discuss the bug fixing of SBC with Jaska Uimonen, who is
> > ill this week.
> >
> > The sound quality of the fix point implementation still remains below of
> > the quality of the floating point version.
> >
> > Maybe, we shall support both depending on the performance requirements?

Well, it is quite natural that sound quality for 16 bit fixed point version
can't be better than the quality of the floating point one. But when
dealing with lossy compression, it is not always strictly necessary to
precisely match the output of the reference implementation, carefully
reproducing all the compression artefacts :)

More important is whether this implementation passes a standard SBC
conformance test. If it does, it would be good to have 16 bit fixed point
implementation.

Sound quality of Jaska's patch can be probably tweaked a bit by trying
different bias for coefficient values (not just clip values to 16 bit, but
also try different directions for rounding).

> I think we should focus a fixed point version. There should be no need
> for floating point at all. If fixed point isn't good enough, then we
> screwed it up.
>
> And in case of embedded devices we are seriously limited with floating
> point and doing that in software just doesn't work out. And this is
> mostly not directly a performance problem. It is more a power
> consumption problem. We don't wanna have A2DP drain the battery.

At least for ARM, performance of the possible polyphase filter implementations
can be approximately ranged in the following way (from fastest to slowest):
1. 16-bit*16-bit->32-bit integer multiplications (the best for any 
ARM cores >=armv5te)
2. single precision floating point multiplications (if floating point math is 
supported by hardware)
3. 32-bit*32-bit->32-bit  integer multiplications
4. double precision floating point multiplications (if floating point math is 
supported by hardware and FPU is pipelined for this kind of operation - not 
the case for Cortex-A8 unfortunately)
5. 32-bit*32-bit->64-bit integer multiplications

Currently SBC contains ARM inline assembly macros to utilize 
32-bit*32-bit->32-bit multiplication (multiply-accumulate variant) which
is not the fastest option. It is only good for armv4 cores which do not
support anything better. Even quite an old Nokia 770 internet tablet 
has support for armv5te instructions.

For x86 platform, 16-bit integer multiplications can be done quite efficiently
using MMX or SSE2.

To sum up, the 16-bit fixed point version will be the fastest and is the best
variant if it can provide the required precision. Otherwise single precision
floating point version is the next natural choice.

Surely there are also other factors to consider and raw multiplications
throughput performance is not the only thing. The need of scaling values for
fixed point versions and int->float/float->int conversions for the floating
point ones also plays some role.

-- 
Best regards,
Siarhei Siamashka
