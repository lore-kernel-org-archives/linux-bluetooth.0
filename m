Return-Path: <cyrus@holtmann.org>
Date: Sun, 28 Oct 2012 02:29:42 +0300
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: =?UTF-8?B?RnLDqWTDqXJpYw==?= Dalleau
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 06/10] sbc: Add mmx primitive for 1b 8s analyse
Message-ID: <20121028022942.3bcd1bd7@i7>
In-Reply-To: <20121028020621.3653ac8e@i7>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351272036-4875-7-git-send-email-frederic.dalleau@linux.intel.com>
	<20121028020621.3653ac8e@i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 28 Oct 2012 02:06:21 +0300
Siarhei Siamashka <siarhei.siamashka@gmail.com> wrote:

> On Fri, 26 Oct 2012 19:20:32 +0200
> Frédéric Dalleau  <frederic.dalleau@linux.intel.com> wrote:
> 
> > ---
> >  sbc/sbc_primitives_mmx.c |   18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> In the previous patches you are changing the behaviour of C
> implementation to support mSBC configuration. By still allowing
> assembly optimized implementations to override C functions, mSBC
> does not work correctly for the architectures which support these
> optimizations.
> 
> With this particular patch you are fixing MMX. The other
> implementations (ARM NEON) are still broken.
> 
> It would be better if we could shape out this patch series so that
> the code is always correct after every commit, preferably as:
> 1. SBC still works and uses assembly optimizations after
>    every commit
> 2. mSBC works correctly after the commit where SBC_MSBC feature
>    is advertised in the public header "sbc.h"
> 3. mSBC gets assembly optimizations enabled. Unsupported architectures
>    use C implementation.

Just to make this work, your "[PATCH v3 04/10] sbc: Add msbc flag and
generic C primitive" patch could update "sbc_init_primitives" in a
bit different way.

You changed it as:

>  void sbc_init_primitives(struct sbc_encoder_state *state)
>  {
> +	state->pending = -1;
> +	state->odd = 1;
> +
>  	/* Default implementation for analyze functions */
>  	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_simd;
> -	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;
> +
> +	if (state->increment == 1)
> +		state->sbc_analyze_4b_8s = sbc_analyze_1b_8s_simd;
> +	else
> +		state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_simd;

But it might be better to move "if (state->increment == 1)" check to
the very end of the function after

	/* X86/AMD64 optimizations */
#ifdef SBC_BUILD_WITH_MMX_SUPPORT
	sbc_init_primitives_mmx(state);
#endif

	/* ARM optimizations */
#ifdef SBC_BUILD_WITH_ARMV6_SUPPORT
	sbc_init_primitives_armv6(state);
#endif
#ifdef SBC_BUILD_WITH_IWMMXT_SUPPORT
	sbc_init_primitives_iwmmxt(state);
#endif
#ifdef SBC_BUILD_WITH_NEON_SUPPORT
	sbc_init_primitives_neon(state);
#endif


So that the C implementation overrides the function pointers for
mSBC configuration after the initialization of mSBC-unaware assembly
implementations.

As soon as some assembly implementation gets mSBC support (MMX for
example), the initialization order in "sbc_init_primitives" can be
changed appropriately.

-- 
Best regards,
Siarhei Siamashka
