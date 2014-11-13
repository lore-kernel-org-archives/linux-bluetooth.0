Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/handsfree: Send indicator notif to all connected devices
Date: Thu, 13 Nov 2014 18:14:46 +0100
Message-ID: <2101011.n5l4rYIcFz@uw000953>
In-Reply-To: <1415893972-18656-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415893972-18656-1-git-send-email-lukasz.rymanowski@tieto.com> <1415893972-18656-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 13 of November 2014 16:52:50 Lukasz Rymanowski wrote:
> ---
>  android/handsfree.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index 9a2fdd0..0001eb6 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -2038,24 +2038,31 @@ static void update_indicator(struct hf_device *dev, int ind, uint8_t val)
>  	hfp_gw_send_info(dev->gw, "+CIEV: %u,%u", ind + 1, val);
>  }
>  
> +static void device_status_notif(void *data, void *user_data)
> +{
> +	struct hf_device *dev = data;
> +	struct hal_cmd_handsfree_device_status_notif *cmd = user_data;

I think we should send this only to devices with SLC established.

> +
> +	update_indicator(dev, IND_SERVICE, cmd->state);
> +	update_indicator(dev, IND_ROAM, cmd->type);
> +	update_indicator(dev, IND_SIGNAL, cmd->signal);
> +	update_indicator(dev, IND_BATTCHG, cmd->battery);
> +}
> +
>  static void handle_device_status_notif(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_handsfree_device_status_notif *cmd = buf;
> -	struct hf_device *dev;
>  	uint8_t status;
>  
>  	DBG("");
>  
> -	dev = find_default_device();
> -	if (!dev) {
> +	if (queue_isempty(devices)) {
>  		status = HAL_STATUS_FAILED;
>  		goto done;
>  	}
>  
> -	update_indicator(dev, IND_SERVICE, cmd->state);
> -	update_indicator(dev, IND_ROAM, cmd->type);
> -	update_indicator(dev, IND_SIGNAL, cmd->signal);
> -	update_indicator(dev, IND_BATTCHG, cmd->battery);
> +	/* Cast cmd to void as queue api needs that */
> +	queue_foreach(devices, device_status_notif, (void *) cmd);
>  
>  	status = HAL_STATUS_SUCCESS;
>  
> 

-- 
Best regards, 
Szymon Janc
