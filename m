Return-Path: <cyrus@holtmann.org>
Message-ID: <50A3BC30.8060209@linux.intel.com>
Date: Wed, 14 Nov 2012 16:43:44 +0100
From: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
	<frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
	<frederic.dalleau@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 05/16] sbc: Add mmx primitive for 1b 8s analysis
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com> <1351589975-22640-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-6-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Since I'm gonna resend a new series, I'll comment myself ;)

On 10/30/2012 10:39 AM, Frédéric Dalleau wrote:
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

One thing bother me about this patch : the emms instruction is called
after every block, instead of every four blocks until now. I have very
little knowledge about this, but I read that emms instruction is
somewhat expensive.
Some quick tests haven't shown differences, but it is possible to add a
post analyze callback to overcome this. In this case, emms instruction
could be run every 15 blocks or whatever is defined.

Is it worth it?

Thanks,
Frédéric
