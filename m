Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B9D9D1.4020200@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>  <1119374946.26772.119.camel@pegasus>  <42B8563E.9040008@xmission.com>  <1119378538.26772.127.camel@pegasus>  <42B86FD5.8020204@xmission.com>  <1119387838.26772.134.camel@pegasus>  <42B8ADC8.6010802@xmission.com> <1119399984.26772.145.camel@pegasus> <42B919BB.6000107@xmission.com> <Pine.LNX.4.62.0506222203110.4779@server1.ploetzli.ch>
In-Reply-To: <Pine.LNX.4.62.0506222203110.4779@server1.ploetzli.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Jun 2005 15:36:17 -0600

Henryk

> So now you're going to bigger-than-32-bit integers anyways?

We don't need the full 32 bits. I want to get this working and then play 
around with slimming it down.

> Some time ago I already stated that using 32 bit for the floating point 
> presentation with 16 bits before the decimal point and 16 bits after 
> should be enough. (PCM and reconstructed subband samples should not exceed 
> 16 bits and all intermediary values should only be fractions of these 
> samples. I might have forgotten one bit for the sign, though.)

yes, i remember your suggestion. the libmad guys took an interesting 
approach... they only use 3 bits for the decimal and 28 for the 
fractional part. i will look at the range of our computation but it may 
be possible to similarly dedicate most of the range to the fractional part.

libmad produces 24-bit audio, another indication it is overkill for us 
to have 32-bit numbers.

> But then intermediate results during multiplication need an additional 16 
> bits and your platform therefore needs to be able to handle (at least) 48 
> bit integers without falling back to floating-point emulation speeds.

multiplying two n-bit numbers results in a 2n-bit product. if we have 
16-bit numbers, then the multiply/divide intermediate result would fit 
in a tidy 32 bits.

> If it can do that, then of course doing fixed point should be easy: 
> Addition, multiplication and shift work unchanged. Each multiplication 
> must be followed by a shift right 16 bits. Conversion integer -> fixed 
> point or fixed point -> integer is shift left 16 bits or shift right 16 
> bits respectively.

yes, exactly. I put inline functions in sbc.h to do the multiply and 
divide and add/sub "just work."

Brad


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
