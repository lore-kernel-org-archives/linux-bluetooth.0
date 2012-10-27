Return-Path: <cyrus@holtmann.org>
Date: Sun, 28 Oct 2012 02:06:21 +0300
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: =?UTF-8?B?RnLDqWTDqXJpYw==?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 06/10] sbc: Add mmx primitive for 1b 8s analyse
Message-ID: <20121028020621.3653ac8e@i7>
In-Reply-To: <1351272036-4875-7-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351272036-4875-7-git-send-email-frederic.dalleau@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 26 Oct 2012 19:20:32 +0200
Frédéric Dalleau  <frederic.dalleau@linux.intel.com> wrote:

> ---
>  sbc/sbc_primitives_mmx.c |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

In the previous patches you are changing the behaviour of C
implementation to support mSBC configuration. By still allowing
assembly optimized implementations to override C functions, mSBC
does not work correctly for the architectures which support these
optimizations.

With this particular patch you are fixing MMX. The other
implementations (ARM NEON) are still broken.

It would be better if we could shape out this patch series so that
the code is always correct after every commit, preferably as:
1. SBC still works and uses assembly optimizations after
   every commit
2. mSBC works correctly after the commit where SBC_MSBC feature
   is advertised in the public header "sbc.h"
3. mSBC gets assembly optimizations enabled. Unsupported architectures
   use C implementation.

> diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
> index cbacb4e..17065e5 100644
> --- a/sbc/sbc_primitives_mmx.c
> +++ b/sbc/sbc_primitives_mmx.c
> @@ -276,6 +276,19 @@ static inline void sbc_analyze_4b_8s_mmx(struct sbc_encoder_state *state,
>  	__asm__ volatile ("emms\n");
>  }
>  
> +static inline void sbc_analyze_1b_8s_mmx(struct sbc_encoder_state *state,
> +		int16_t *x, int32_t *out, int out_stride)
> +{
> +	if (state->odd)
> +		sbc_analyze_eight_mmx(x, out, analysis_consts_fixed8_simd_odd);
> +	else
> +		sbc_analyze_eight_mmx(x, out, analysis_consts_fixed8_simd_even);
> +
> +	state->odd = !state->odd;
> +
> +	__asm__ volatile ("emms\n");
> +}
> +
>  static void sbc_calc_scalefactors_mmx(
>  	int32_t sb_sample_f[16][2][8],
>  	uint32_t scale_factor[2][8],
> @@ -366,7 +379,10 @@ void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
>  {
>  	if (check_mmx_support()) {
>  		state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_mmx;
> -		state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
> +		if (state->increment == 1)
> +			state->sbc_analyze_4b_8s = sbc_analyze_1b_8s_mmx;

Overriding the function with "_4b_" (4 blocks) in its name with "_1b_"
variant (1 block) looks wrong and is just asking for troubles.

Maybe we need a new function pointer? If not, then the function might
need to be at least renamed.

> +		else
> +			state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
>  		state->sbc_calc_scalefactors = sbc_calc_scalefactors_mmx;
>  		state->implementation_info = "MMX";
>  	}

-- 
Best regards,
Siarhei Siamashka
