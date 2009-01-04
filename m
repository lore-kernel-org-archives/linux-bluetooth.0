Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Sun, 4 Jan 2009 19:56:11 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812311803.45279.siarhei.siamashka@nokia.com> <200901021833.13342.siarhei.siamashka@nokia.com> <2d5a2c100901021140w7211d8e5r8e59316592951497@mail.gmail.com>
In-Reply-To: <2d5a2c100901021140w7211d8e5r8e59316592951497@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901041956.12084.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 02 January 2009 21:40:48 ext Luiz Augusto von Dentz wrote:
> Hi Siarhei,
>
> On Fri, Jan 2, 2009 at 1:33 PM, Siarhei Siamashka
>
> <siarhei.siamashka@nokia.com> wrote:
> > On Wednesday 31 December 2008 22:55:24 ext Luiz Augusto von Dentz wrote:
> >> I wonder why don't we use liboil
> >> (http://liboil.freedesktop.org/wiki/).
> >
> > Can you clarify your proposal a bit? Which functions/implementations from
> > liboil do you suggest for use in bluez sbc?
>
> Liboil stands to optimized inner loops, that exactly what we need,
> transforming the whole code will, already is, depend on each simd
> extention to be implemented. 
>
> What we basically do is multiply and 
> accumulate arrays, what could be done with:
> http://liboil.freedesktop.org/documentation/liboil-liboilfuncs-math.html#oi
>l-multsum-f32

Right now from what I see, we need SIMD optimized versions of:
- analysis filter
- channels deinterleaving with optional endian conversion
- scalefactors processing
- joining channels
- maybe quantization

Liboil does not seem to directly provide any of these (I really looked through
all of it, but could of course miss something). Your example is not very good
and does not clarify anything, because it is even a floating point function.

Let's take the SBC analysis filter as an example. It's a function, which reads
data from the samples buffer, constants buffer and writes some results in the
output buffer. We want all the operations inside of it to be done with
registers only, avoiding any intermediate stores to memory. The arrays t1[8]
and t2[8] are supposed to be mapped directly on the registers. If you try to
implement analysis function using liboil 'inner loop' functions, the resulting
performance would be simply horrible. If you don't trust me, just have a look
at some more stuff from liboil such as DCT functions. The analysis filter from
SBC falls exactly into the same category.

The other functions that need to be done and that I have mentioned above are
also the same.

Moreover, the arrays which SBC operates on are rather small. That's why
special care needs to be taken about proper loops unrolling, alignment and
the other stuff in order not to have any unneeded overhead.

> > Or do you suggest to submit the sbc analysis filter function to liboil,
> > add it as sbc dependency and hope that somebody would translate the code
> > to the instruction sets of other architectures? Will it turn out to be
> > beneficial? IMHO It may easily become just an unnecessary burden and
> > wasted effort too.
>
> What about if there is any other codec that might benefit from the
> code we are producing, Im not talking about the whole sbc analysis
> filter but the inner loops.

Than it is good for these other codecs :) They will be able to take some
code from SBC (either directly, or via liboil library if it gets to suck in
the stuff from bluez like it did with some other samples of optimized code).

> Also read careful what liboil does,  there is a whole instruction set 
> detection/benchmark system very similar to what you have proposed for
> choosing implementation in runtime.

The detection of MMX needs only a dozen of lines of trivial code (checking
EFLAGS and CPUID). Adding a  big library as a dependency just for a few lines
of code is kind of overkill.

In addition, by spending 15 minutes on writing and testing this trivial code
using just an Architecture Software Developer's Manual from Intel, I avoid
all the hassle of making sure that I don't violate the licenses or copyrights
of somebody else :)

By the way, I had a look and didn't quite like the way liboil does this CPU
capability check. Instead of checking EFLAGS first, it tries to execute CPUID
directly and has the code to catch SIGILL. I'm not sure if it is a good idea
to mess with the signals from a *library*.

-- 
Best regards,
Siarhei Siamashka
