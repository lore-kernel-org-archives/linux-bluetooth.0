Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6 04/17] sbc: add odd member variable to sbc_encoder_state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362565163-3567-5-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 26 Mar 2013 19:17:35 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <52E3E55C-7E50-4702-9F37-94399097B485@holtmann.org>
References: <1362565163-3567-1-git-send-email-frederic.dalleau@linux.intel.com> <1362565163-3567-5-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> sbc/sbc_primitives.c |    2 ++
> sbc/sbc_primitives.h |    1 +
> 2 files changed, 3 insertions(+)
> 
> diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
> index dce0ed2..0b48ddb 100644
> --- a/sbc/sbc_primitives.c
> +++ b/sbc/sbc_primitives.c
> @@ -521,6 +521,8 @@ static int sbc_calc_scalefactors_j(
>  */
> void sbc_init_primitives(struct sbc_encoder_state *state)
> {
> +	state->odd = 1;
> +
> 	/* Default implementation for analyze functions */
> 	state->sbc_analyze_4s = sbc_analyze_4b_4s_simd;
> 	state->sbc_analyze_8s = sbc_analyze_4b_8s_simd;
> diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
> index 267c277..ffee339 100644
> --- a/sbc/sbc_primitives.h
> +++ b/sbc/sbc_primitives.h
> @@ -40,6 +40,7 @@ struct sbc_encoder_state {
> 	int position;
> 	/* Number of consecutive blocks handled by the encoder */
> 	int increment;
> +	int odd;

lets start using bool here. We should keep the memory footprint as small as possible.

We could also discuss using uint8_t instead of int in some cases. Or go with unsigned int in some cases.

Regards

Marcel

