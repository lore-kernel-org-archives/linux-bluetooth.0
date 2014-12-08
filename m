Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] android/handsfree-client: Trivial fix typo
Date: Mon, 08 Dec 2014 14:18:12 +0100
Message-ID: <2349425.bF4snaIfs3@leonov>
In-Reply-To: <1418035656-17285-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418035656-17285-1-git-send-email-lukasz.rymanowski@tieto.com> <1418035656-17285-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 08 of December 2014 11:47:36 Lukasz Rymanowski wrote:
> ---
>  android/hal-msg.h          | 2 +-
>  android/handsfree-client.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index d43cdbe..3cf2d85 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -2226,7 +2226,7 @@ struct hal_ev_hf_client_call_waiting {
>  } __attribute__((packed));
> 
>  #define HAL_HF_CLIENT_DIRECTION_OUTGOING	0x00
> -#define HAL_HF_CLIENT_DIRECTION_INCOMIGN	0x01
> +#define HAL_HF_CLIENT_DIRECTION_INCOMING	0x01
> 
>  #define HAL_HF_CLIENT_CALL_STATE_ACTIVE			0x00
>  #define HAL_HF_CLIENT_CALL_STATE_HELD			0x01
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index 3eb8517..007ac32 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -954,7 +954,7 @@ static void clcc_cb(struct hfp_context *context, void
> *user_data) ev->index = val;
> 
>  	if (!hfp_context_get_number(context, &val) ||
> -				val > HAL_HF_CLIENT_DIRECTION_INCOMIGN) {
> +				val > HAL_HF_CLIENT_DIRECTION_INCOMING) {
>  		error("hf-client: Could not get direction");
>  		return;
>  	}

This patch is now applied, thanks.

-- 
BR
Szymon Janc
