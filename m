Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Keith Mok <ek9852@gmail.com>
Subject: Re: [PATCH] Add iwmmxt optimization for sbc for pxa series cpu
Date: Thu, 11 Nov 2010 13:46:57 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <AANLkTikPiwr+OtsDVbgoya281Zncg0P5Joq_v0UCzZDi@mail.gmail.com>
In-Reply-To: <AANLkTikPiwr+OtsDVbgoya281Zncg0P5Joq_v0UCzZDi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201011111346.58906.siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 11 November 2010 10:05:46 Keith Mok wrote:
> This patch add iwmmxt (Intel wireless mmx, pxa platform) optimzation
> for sbc, based on the mmx code.
> Have verified the encoded result against the mmx generated one.

Nice, I guess it should provide a noticeable performance improvement on this
hardware.

Did you run some benchmarks with these optimizations to measure how much they
are helping? The most interesting numbers are for the "44100kHz audio
with bitpool set to 53, 8 subbands, joint stereo" case, which is typically
used for A2DP. This can be done by running:
    $ time ./sbcenc -b53 -s8 -j test.au > /dev/null

In my opinion, commit messages for the performance patches are more descriptive
in the following format: 
http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=e80454d08b4ec098024ddfbdffbd71e9d2f81bd0

And splitting the patch into parts, adding one optimization at a time may be a
good idea (for bisecting purposes).

A few other comments below.

I don't have any IWMMXT capable hardware to test/benchmark, but I checked the
following manuals:
http://download.intel.com/design/intelxscale/31451001.pdf
http://download.intel.com/design/intelxscale/27347302.pdf 

> +static inline void sbc_analyze_four_iwmmxt(const int16_t *in, int32_t
> *out, +					const FIXED_T *consts)
> +{
> +	asm volatile (
> +		"tbcstw       wr4, %2\n"
> +		"wldrd        wr0, [%0]\n"
> +		"wldrd        wr1, [%0, #8]\n"
> +		"wldrd        wr2, [%1]\n"
> +		"wldrd        wr3, [%1, #8]\n"

Using back-to-back WLDRD instructions has some performance penalty 

"D.3.2.3 Memory Control Pipeline

There is also an additional stall introduced by the core when 2 double word (64 
bits) are issued back to back such as:
WLDRD or WSTRD
WLDR[B,H,W,D] or WSTR[B,H,W,D] <- 1 cycle stall.
Critical inner loop sequences can use non memory related instructions following 
a WLDRD or WSTRD."

It's better to try rearranging the code so that load instructions are 
interleaved with the others whenever it is possible.

> +		"wmadds       wr0, wr2, wr0\n"
> +		"wmadds       wr1, wr3, wr1\n"
> +		"waddwss      wr0, wr0, wr4\n"
> +		"waddwss      wr1, wr1, wr4\n"
> +		"\n"
> +		"wldrd        wr2, [%0, #16]\n"
> +		"wldrd        wr3, [%0, #24]\n"
> +		"wldrd        wr4, [%1, #16]\n"
                ^^^^^^ (1)
> +		"wldrd        wr5, [%1, #24]\n"
> +		"wmadds       wr2, wr4, wr2\n"
                ^^^^^^^ (2)

It also makes sense to pay attention to instruction latencies. Here you use wr4
register (2) after loading (1) with only one unrelated instruction in between. 

And according to "Table D-1. Issue Cycle and Result Latency of the Intel® 
Wireless MMX™ 2 Coprocessor Instructions", WLDRD has result latency 3, so that 
it works best if you insert 2 unrelated instruction in between.

> +		"wmadds       wr3, wr5, wr3\n"
> +		"waddwss      wr0, wr2, wr0\n"
> +		"waddwss      wr1, wr3, wr1\n"
> +		"\n"
> +		"wldrd        wr2, [%0, #32]\n"
> +		"wldrd        wr3, [%0, #40]\n"
> +		"wldrd        wr4, [%1, #32]\n"
> +		"wldrd        wr5, [%1, #40]\n"
> +		"wmadds       wr2, wr4, wr2\n"
> +		"wmadds       wr3, wr5, wr3\n"

According to "Table D-3. Resource Availability Delay for the Multiplier 
Pipeline", back-to-back WMADD instructions may have a performance penalty. 

> +		"waddwss      wr0, wr2, wr0\n"
> +		"waddwss      wr1, wr3, wr1\n"
> +		"\n"
> +		"wldrd        wr2, [%0, #48]\n"
> +		"wldrd        wr3, [%0, #56]\n"
> +		"wldrd        wr4, [%1, #48]\n"
> +		"wldrd        wr5, [%1, #56]\n"
> +		"wmadds       wr2, wr4, wr2\n"
> +		"wmadds       wr3, wr5, wr3\n"
> +		"waddwss      wr0, wr2, wr0\n"
> +		"waddwss      wr1, wr3, wr1\n"
> +		"\n"
> +		"wldrd        wr2, [%0, #64]\n"
> +		"wldrd        wr3, [%0, #72]\n"
> +		"wldrd        wr4, [%1, #64]\n"
> +		"wldrd        wr5, [%1, #72]\n"
> +		"wmadds       wr2, wr4, wr2\n"
> +		"wmadds       wr3, wr5, wr3\n"
> +		"waddwss      wr0, wr2, wr0\n"
> +		"waddwss      wr1, wr3, wr1\n"
> +		"\n"
> +		"tmcr       wcgr0, %4\n"
> +		"wsrawg       wr0, wr0, wcgr0\n"
> +		"wsrawg       wr1, wr1, wcgr0\n"
> +		"wpackwss     wr0, wr0, wr0\n"
> +		"wpackwss     wr1, wr1, wr1\n"
> +		"\n"
> +		"wldrd        wr4, [%1, #80]\n"
> +		"wldrd        wr5, [%1, #88]\n"
> +		"wldrd        wr6, [%1, #96]\n"
> +		"wldrd        wr7, [%1, #104]\n"
> +		"wmadds       wr2, wr5, wr0\n"
> +		"wmadds       wr0, wr4, wr0\n"
> +		"\n"
> +		"wmadds       wr3, wr7, wr1\n"
> +		"wmadds       wr1, wr6, wr1\n"
> +		"waddwss      wr0, wr1, wr0\n"
> +		"waddwss      wr2, wr3, wr2\n"
> +		"\n"
> +		"wstrd        wr0, [%3]\n"
> +		"wstrd        wr2, [%3, #8]\n"
> +		:
> +		: "r" (in), "r" (consts),
> +			"r" (1 << (SBC_PROTO_FIXED4_SCALE - 1)), "r" (out),
> +			"r" (SBC_PROTO_FIXED4_SCALE)
> +		: "memory");
> +}


> +static void sbc_calc_scalefactors_iwmmxt(
> +	int32_t sb_sample_f[16][2][8],
> +	uint32_t scale_factor[2][8],
> +	int blocks, int channels, int subbands)
> +{
> +	int ch, sb;
> +	intptr_t blk;
> +	for (ch = 0; ch < channels; ch++) {
> +		for (sb = 0; sb < subbands; sb += 2) {
> +			int b;
> +			blk = &sb_sample_f[0][ch][sb];
> +			b = blocks;
> +			asm volatile (
> +				"tbcstw       wr0, %4\n"
> +			"1:\n"
> +				"wldrd        wr1, [%0], %2\n"
> +				"wxor         wr2, wr2, wr2\n"
> +				"wcmpgtsw     wr3, wr1, wr2\n"

The MMX code was using PCMPGTD and the other instructions just because MMX 
instruction set is very limited and did not have the needed instructions. But 
you can use WABS and WMAX instructions to do this job better. You can refer to
the original C code and also to ARM NEON optimizations to get some ideas about
how to do this operation faster.  

> +				"waddwss      wr1, wr1, wr3\n"
> +				"wcmpgtsw     wr2, wr2, wr1\n"
> +				"wxor         wr1, wr1, wr2\n"
> +
> +				"wor          wr0, wr0, wr1\n"
> +
> +				"subs         %1, %1, #1\n"
> +				"bne          1b\n"
> +
> +				"tmrrc        %0, %1, wr0\n"
> +				"clz          %0, %0\n"
> +				"rsb          %0, %0, %5\n"
> +				"str          %0, [%3]\n"
> +
> +				"clz          %1, %1\n"
> +				"rsb          %1, %1, %5\n"
> +				"str          %1, [%3, #4]\n"
> +			: "+&r" (blk), "+&r" (b)
> +			: "i" ((char *) &sb_sample_f[1][0][0] -
> +				(char *) &sb_sample_f[0][0][0]),
> +				"r" (&scale_factor[ch][sb]),
> +				"r" (1 << SCALE_OUT_BITS),
> +				"i" (SCALE_OUT_BITS+1)
> +			: "memory");

And this is actually a bug, which exists in the original MMX code too (my
fault). In order to fix it, "cc" needs to be added to the clobber list. I have
just sent a patch for MMX code here:
http://marc.info/?l=linux-bluetooth&m=128946780706187&w=2

Such bug is more dangerous on ARM, because it is up to the developer whether to
update flags in each particular instruction or not. So while almost every
arithmetic x86 instruction updates flags unconditionally, on ARM the flags can
easily survive long enough. That makes it possible for the compiler to
implement more clever optimizations related to setting and checking flags, and
fail if the clobber list does not contain correct information.

> +		}
> +	}
> +}

-- 
Best regards,
Siarhei Siamashka
