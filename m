Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] sbc: powerpc altivec optimizations for 4 subbands
 encoding
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200903162159.49487.siarhei.siamashka@nokia.com>
References: <200903162159.49487.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Sat, 14 Mar 2009 07:17:13 +0100
Message-Id: <1237011433.24751.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> On the last weekend I tried to get familiar with powerpc altivec assembly  and
> added some optimization for sbc encoder. Experimental patch is attached. It
> handles 4 subbands case only, so is not that much useful in practice. There
> are no problems supporting 8 subbands too, but I was just running out of
> time. The patch merges processing of 4 blocks into the single block of code.
> It's something that is also in my todo list for ARM NEON. But while this merge
> is mostly "nice to have" optimization for ARM, it is much more important for
> PowerPC because of a huge multiply-accumulate latency.
> 
> And bluez a2dp seems to work fine on ppc64 linux (playstation3).
> 
> In order to activate altivec code, -maltivec option needs to be added to
> gcc compilation flags.
> 
> Benchmark result:
> 
> time ./sbcenc -s4 somefile.au > /dev/null
> 
> before:
> real	0m13.999s
> user	0m13.468s
> sys	0m0.523s
> 
> after:
> real	0m5.714s
> user	0m5.199s
> sys	0m0.519s
> 
> 3.2GHz CPU in playstation3 uses roughly 1.5% of cpu resources on sbc encoding
> without any optimizations. cpu usage is down to something like 0.6% after this
> optimization is applied.

please redo the patch and include a proper commit message. For example
the details from the email would be perfect for a commit message. It
doesn't need to be that verbose, but a little bit more would be nice.

Regards

Marcel


