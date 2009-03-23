Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] sbc: powerpc altivec optimizations for 4 subbands encoding
Date: Mon, 23 Mar 2009 08:51:53 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200903162159.49487.siarhei.siamashka@nokia.com> <1237011433.24751.6.camel@localhost.localdomain>
In-Reply-To: <1237011433.24751.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903230851.53472.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Saturday 14 March 2009 08:17:13 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > On the last weekend I tried to get familiar with powerpc altivec assembly
> >  and added some optimization for sbc encoder. Experimental patch is
> > attached. It handles 4 subbands case only, so is not that much useful in
> > practice. There are no problems supporting 8 subbands too, but I was just
> > running out of time. The patch merges processing of 4 blocks into the
> > single block of code. It's something that is also in my todo list for ARM
> > NEON. But while this merge is mostly "nice to have" optimization for ARM,
> > it is much more important for PowerPC because of a huge
> > multiply-accumulate latency.
> >
> > And bluez a2dp seems to work fine on ppc64 linux (playstation3).
> >
> > In order to activate altivec code, -maltivec option needs to be added to
> > gcc compilation flags.
> >
> > Benchmark result:
> >
> > time ./sbcenc -s4 somefile.au > /dev/null
> >
> > before:
> > real	0m13.999s
> > user	0m13.468s
> > sys	0m0.523s
> >
> > after:
> > real	0m5.714s
> > user	0m5.199s
> > sys	0m0.519s
> >
> > 3.2GHz CPU in playstation3 uses roughly 1.5% of cpu resources on sbc
> > encoding without any optimizations. cpu usage is down to something like
> > 0.6% after this optimization is applied.
>
> please redo the patch and include a proper commit message. For example
> the details from the email would be perfect for a commit message. It
> doesn't need to be that verbose, but a little bit more would be nice.

That patch was more like a preview targeted at the people interested in
powerpc optimizations (by the way, are there any low end or embedded
powerpc systems which could benefit the most from these in practice?).
For me it was more like a test if the code works correctly on more exotic
platform like big endian 64-bit system :) And also an exercise in powerpc
assembly and a check if the bluez sbc code can be easily accommodated
to different SIMD architectures.

For it to be ready to be appied, the following still needs to be done in my
opinion:
1. Add '/proc/self/auxv' based altivec instructions support detection at
runtime, this should work for all linux systems.
way the same binary will be usable on which are conservative about the debian
2. Add 8 subbands support, this is what is actually used for A2DP most of the
time

Additionally, I wonder about the copy of the table with coefficients. For
powerpc, some zero padding needs to be added. For ARM NEON, the
second part of the coefficients table can be reordered to make better use
of "vertical" simd instructions that it supports. For ARMv6, the second part
of the table can be also tweaked to exploit the fact that some coefficients
are the same and reduce the number of operations (it only can do 2
multiplicate&accumulate operations at once, so the straight "brute force"
which works fine for the other SIMD extensions is not the fastest here).
As an alternative to having copy-pasted and slightly modified tables in the
sources, reordering of coefficients can be done at runtime (and this
reordering code would also make it easier to see what kind of transformation
was applied).

-- 
Best regards,
Siarhei Siamashka
