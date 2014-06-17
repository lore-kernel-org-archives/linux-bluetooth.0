Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 2/4] anrdoid/health: Fix wrong channel type defines
Date: Tue, 17 Jun 2014 11:29:54 +0200
Message-ID: <1976668.iXxFPmJhy5@uw000953>
In-Reply-To: <1402956170-18356-3-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402956170-18356-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1402956170-18356-3-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tuesday 17 of June 2014 01:02:48 Ravi kumar Veeramally wrote:
> Enums in bt_hl.h are defined in this order BTHL_CHANNEL_TYPE_RELIABLE,
> BTHL_CHANNEL_TYPE_STREAMING, BTHL_CHANNEL_TYPE_ANY. But HDP_SPEC_V11(3.4)
> has no-preference(any)-0, reliable-1, stream-2, reserved(0x03-0xff).
> Providing utility to solve this.
> ---
>  android/health.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 7e2c5d6..5a87089 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -52,6 +52,10 @@
>  #define HDP_VERSION			0x0101
>  #define DATA_EXCHANGE_SPEC_11073	0x01
>  
> +#define CHANNEL_TYPE_ANY       0x00
> +#define CHANNEL_TYPE_RELIABLE  0x01
> +#define CHANNEL_TYPE_STREAM    0x02
> +

Isn't that already defined in hdp_types.h ?

>  static bdaddr_t adapter_addr;
>  static struct ipc *hal_ipc = NULL;
>  static struct queue *apps = NULL;
> @@ -639,6 +643,18 @@ fail:
>  							HAL_STATUS_FAILED);
>  }
>  
> +static uint8_t android2channel_type(uint8_t type)
> +{
> +	switch (type) {
> +	case HAL_HEALTH_CHANNEL_TYPE_RELIABLE:
> +		return CHANNEL_TYPE_RELIABLE;
> +	case HAL_HEALTH_CHANNEL_TYPE_STREAMING:
> +		return CHANNEL_TYPE_STREAM;
> +	}
> +
> +	return CHANNEL_TYPE_ANY;

Move this under default case.

> +}
> +
>  static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_health_mdep *cmd = buf;
> @@ -662,7 +678,7 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
>  
>  	mdep->role = cmd->role;
>  	mdep->data_type = cmd->data_type;
> -	mdep->channel_type = cmd->channel_type;
> +	mdep->channel_type = android2channel_type(cmd->channel_type);
>  	mdep->id = queue_length(app->mdeps) + 1;
>  
>  	if (cmd->descr_len > 0) {
> 

-- 
Best regards, 
Szymon Janc
