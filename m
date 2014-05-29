Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix doing database reads on write
Date: Thu, 29 May 2014 09:32:54 +0200
Message-ID: <3076533.KcQ2SvJP53@uw000953>
In-Reply-To: <1401343151-25242-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401343151-25242-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 29 of May 2014 07:59:11 Jakub Tyszkowski wrote:
> Wrong function was called resulting in read responses being send along
> with write response. As it is now 'process_dev_pending_requests' is
> processing only read requests.
> ---
>  android/gatt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 89aca16..fd35442 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5043,7 +5043,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
>  		return ATT_ECODE_INSUFF_RESOURCES;
>  
>  	data->handle = handle;
> -	data->state = REQUEST_INIT;
> +	data->state = REQUEST_PENDING;
>  
>  	if (!queue_push_tail(dev->pending_requests, data)) {
>  		free(data);
> @@ -5057,7 +5057,8 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
>  		return ATT_ECODE_UNLIKELY;
>  	}
>  
> -	process_dev_pending_requests(dev, cmd[0]);
> +	if (!queue_find(dev->pending_requests, match_pending_dev_request, NULL))
> +		send_dev_pending_response(dev, cmd[0]);
>  
>  	return 0;
>  }

I've applied this patch, yet please prepare patches that will at least fix
names of those functions since this is becoming hard to follow. Thanks.

-- 
Best regards, 
Szymon Janc
