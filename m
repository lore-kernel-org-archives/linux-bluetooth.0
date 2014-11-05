Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Print number on query current calls in hf-client
Date: Wed, 05 Nov 2014 21:55:35 +0100
Message-ID: <1750368.bag9xc8uWn@leonov>
In-Reply-To: <1415198354-3470-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415198354-3470-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 05 of November 2014 15:39:14 Lukasz Rymanowski wrote:
> ---
>  android/client/if-hf-client.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
> index c383cab..3f6f7c2 100644
> --- a/android/client/if-hf-client.c
> +++ b/android/client/if-hf-client.c
> @@ -312,6 +312,9 @@ static void hf_client_current_calls_callback(int index,
>  					bthf_client_call_direction_t2str(dir),
>  					bthf_client_call_state_t2str(state),
>  					bthf_client_call_mpty_type_t2str(mpty));
> +
> +	if (number)
> +		haltest_info("%s: number=%s\n", __func__, number);
>  }
> 
>  /* Callback for audio volume change */

Applied, thanks.

-- 
BR
Szymon Janc
