Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Print peer and CHLD features only on connected event
Date: Mon, 06 Oct 2014 15:45:18 +0200
Message-ID: <2874517.49Oxin3lzP@uw000953>
In-Reply-To: <1412591654-10250-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412591654-10250-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 06 of October 2014 12:34:14 Lukasz Rymanowski wrote:
> We want to print peer and CHLD features are only when client gets
> connected event. Otherwise it might be confusing as those fields are not
> set.
> ---
>  android/client/if-hf-client.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
> index 07c09cd..0f4f3e9 100644
> --- a/android/client/if-hf-client.c
> +++ b/android/client/if-hf-client.c
> @@ -203,6 +203,10 @@ static void hf_client_connection_state_callback(
>  	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
>  				bthf_client_connection_state_t2str(state),
>  				bt_bdaddr_t2str(bd_addr, last_addr));
> +
> +	if ( state != BTHF_CLIENT_CONNECTION_STATE_CONNECTED)
> +		return;
> +
>  	haltest_info("\tpeer_features%s\n", pear_features_t2str(peer_feat));
>  	haltest_info("\tchld_feat=%s\n", chld_features_t2str(chld_feat));
>  }
> 

Applied (after fixing bogus space after '('), thanks.

-- 
Best regards, 
Szymon Janc
