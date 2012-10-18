Return-Path: <cyrus@holtmann.org>
Message-ID: <1350578607.2026.1.camel@aeonflux>
Subject: Re: [PATCH 05/11] Add simd primitive for 1b 8s analyse
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 18 Oct 2012 09:43:27 -0700
In-Reply-To: <1350576911-14678-6-git-send-email-frederic.dalleau@linux.intel.com>
References: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1350576911-14678-6-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> ---
>  sbc/sbc.c            |   12 +++++++---
>  sbc/sbc_primitives.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  sbc/sbc_primitives.h |    2 ++
>  3 files changed, 73 insertions(+), 4 deletions(-)
> 
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index c40aa15..fa90e07 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -708,6 +708,10 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
>  		for (ch = 0; ch < frame->channels; ch++) {
>  			x = &state->X[ch][state->position - 8 * state->inc +
>  							frame->blocks * 8];
> +
> +			if (state->pending == state->position)
> +				x += 8;
> +
>  			for (blk = 0; blk < frame->blocks; blk += state->inc) {
>  				state->sbc_analyze_4b_8s(
>  					state, x,
> @@ -904,13 +908,14 @@ static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len
>  	}
>  }
>  
> -static void sbc_encoder_init(struct sbc_encoder_state *state,
> +static void sbc_encoder_init(int msbc, struct sbc_encoder_state *state,
>  					const struct sbc_frame *frame)
>  {

why not just unsigned long flags here instead of int msbc.

Regards

Marcel


