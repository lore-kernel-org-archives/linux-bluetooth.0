Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Nov 2012 21:27:03 +0200
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: =?UTF-8?B?RnLDqWTDqXJpYw==?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 09/16] sbc: Use simd primitive if doing msbc on neon
Message-ID: <20121114212703.0d8bf8cd@i7>
In-Reply-To: <1351589975-22640-10-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351589975-22640-10-git-send-email-frederic.dalleau@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 30 Oct 2012 10:39:28 +0100
Frédéric Dalleau  <frederic.dalleau@linux.intel.com> wrote:

> ---
>  sbc/sbc_primitives.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
> index a4767ef..9311848 100644
> --- a/sbc/sbc_primitives.c
> +++ b/sbc/sbc_primitives.c
> @@ -568,5 +568,8 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
>  #endif
>  #ifdef SBC_BUILD_WITH_NEON_SUPPORT
>  	sbc_init_primitives_neon(state);
> +
> +	if (state->increment == 1)
> +		state->sbc_analyze_8s = sbc_analyze_1b_8s_simd;
>  #endif
>  }

This is not enough. As I commented earlier in
    http://permalink.gmane.org/gmane.linux.bluez.kernel/31567

"neon code also provides optimized "sbc_enc_process_input_*" functions,
which are not going to work correctly for mSBC:

	state->sbc_enc_process_input_8s_le = sbc_enc_process_input_8s_le_neon;
	state->sbc_enc_process_input_8s_be = sbc_enc_process_input_8s_be_neon;"

And if we had, for example, an SSSE3 implementation of
"sbc_enc_process_input_*" functions for x86 (via PSHUFB instruction),
then it would also have the same problem.

-- 
Best regards,
Siarhei Siamashka
