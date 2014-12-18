Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Fix embeded services not responsing to some requests
Date: Thu, 18 Dec 2014 11:02:36 +0100
Message-ID: <10592153.5tJcofLVcF@uw000953>
In-Reply-To: <1418731357-8531-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418731357-8531-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 16 of December 2014 13:02:36 Jakub Tyszkowski wrote:
> For application attributes this is triggered when application sends response but
> for embeded ones we need to trigger this manually. As in prepare and execute
> write requests handlers we don't know if its embeded or application attribute,
> we should try sending processed request responses if there are any.
> ---
>  android/gatt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 2aa52b0..1e2627b 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4414,6 +4414,9 @@ static void send_dev_complete_response(struct gatt_device *device,
>  	uint16_t len = 0;
>  	uint8_t error = 0;
>  
> +	if (queue_isempty(device->pending_requests))
> +		return;
> +
>  	if (queue_find(device->pending_requests, match_pending_dev_request,
>  									NULL)) {
>  		DBG("Still pending requests");
> @@ -6513,6 +6516,8 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
>  		return ATT_ECODE_UNLIKELY;
>  	}
>  
> +	send_dev_complete_response(dev, cmd[0]);
> +
>  	return 0;
>  }
>  
> @@ -6572,6 +6577,7 @@ static uint8_t write_execute_request(const uint8_t *cmd, uint16_t cmd_len,
>  	}
>  
>  	queue_foreach(app_connections, send_server_write_execute_notify, &ev);
> +	send_dev_complete_response(dev, cmd[0]);
>  
>  	return 0;
>  }
> 

This patch is now applied, thanks.

-- 
Best regards, 
Szymon Janc
