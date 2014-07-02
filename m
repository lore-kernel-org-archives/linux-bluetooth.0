Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/health: Handle incoming streaming data channel request
Date: Wed, 02 Jul 2014 12:26:56 +0200
Message-ID: <1873266.EFIL8yoYrB@uw000953>
In-Reply-To: <1404293522-7220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404293522-7220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wednesday 02 of July 2014 12:32:00 Ravi kumar Veeramally wrote:
> First data channel should be reliable data channel when remote device
> in sink role request data channel with option any.
> ---
>  android/health.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 1943ced..2d80365 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1423,7 +1423,8 @@ static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
>  	struct health_app *app;
>  	struct mdep_cfg *mdep;
>  
> -	DBG("Data channel request: mdepid %u mdlid %u", mdepid, mdlid);
> +	DBG("Data channel request: mdepid %u mdlid %u conf %u",
> +							mdepid, mdlid, *conf);
>  
>  	if (mdepid == MDEP_ECHO)
>  		/* For echo service take last app */
> @@ -1478,10 +1479,14 @@ static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
>  
>  	switch (*conf) {
>  	case CHANNEL_TYPE_ANY:
> -		if (mdep->role == HAL_HEALTH_MDEP_ROLE_SINK)
> +		if (mdep->role == HAL_HEALTH_MDEP_ROLE_SINK) {
>  			return MCAP_CONFIGURATION_REJECTED;
> -		else
> -			*conf = CHANNEL_TYPE_RELIABLE;
> +		} else {
> +			if (queue_length(channel->dev->channels) <= 1)
> +				*conf = CHANNEL_TYPE_RELIABLE;
> +			else
> +				*conf = CHANNEL_TYPE_STREAM;
> +		}
>  		break;
>  	case CHANNEL_TYPE_STREAM:
>  		if (mdep->role == HAL_HEALTH_MDEP_ROLE_SOURCE)
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
