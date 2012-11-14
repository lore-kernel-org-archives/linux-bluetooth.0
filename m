Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Nov 2012 22:23:06 +0200
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: frederic.dalleau@linux.intel.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 05/16] sbc: Add mmx primitive for 1b 8s analysis
Message-ID: <20121114222306.6770b074@i7>
In-Reply-To: <50A3BC30.8060209@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351589975-22640-6-git-send-email-frederic.dalleau@linux.intel.com>
	<50A3BC30.8060209@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 14 Nov 2012 16:43:44 +0100
Frédéric Dalleau  <frederic.dalleau@linux.intel.com> wrote:

> Hi,
> 
> Since I'm gonna resend a new series, I'll comment myself ;)
> 
> On 10/30/2012 10:39 AM, Frédéric Dalleau wrote:
> > +static inline void sbc_analyze_1b_8s_mmx(struct sbc_encoder_state *state,
> > +		int16_t *x, int32_t *out, int out_stride)
> > +{
> > +	if (state->odd)
> > +		sbc_analyze_eight_mmx(x, out, analysis_consts_fixed8_simd_odd);
> > +	else
> > +		sbc_analyze_eight_mmx(x, out, analysis_consts_fixed8_simd_even);
> > +
> > +	state->odd = !state->odd;
> > +
> > +	__asm__ volatile ("emms\n");
> > +}
> > +
> 
> One thing bother me about this patch : the emms instruction is called
> after every block, instead of every four blocks until now. I have very
> little knowledge about this, but I read that emms instruction is
> somewhat expensive.
> Some quick tests haven't shown differences, but it is possible to add a
> post analyze callback to overcome this. In this case, emms instruction
> could be run every 15 blocks or whatever is defined.

The EMMS instruction must be used after the use of MMX instructions,
otherwise the subsequent floating point calculations are broken.

As part of calling conventions, FPU state must be clear after returning
from any function:
    http://www.agner.org/optimize/calling_conventions.pdf
It means that normally every MMX function needs to execute EMMS
instruction before returning. We were already cutting the corners a bit
by putting MMX code into static inline functions which don't have
EMMS themselves. But using the post analyze callback would be really
wrong as that's going to explicitly cross function boundaries with
inconsistent FPU state.

> 
> Is it worth it?

If benchmarks do not show a significant performance drop, then it does
not really matter. A minor performance regression is fine, as long as
the MMX code is still significantly faster than C.

Nowadays using SSE2 is a much better idea. And SSE2 does not suffer
from EMMS-alike warts.

-- 
Best regards,
Siarhei Siamashka
