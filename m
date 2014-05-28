Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] android/gatt: Fix not checking for read errors in read by type
Date: Wed, 28 May 2014 11:27:37 +0200
Message-ID: <25481012.KzKCjSqATe@uw000953>
In-Reply-To: <1401268680-21765-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401268680-21765-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 28 of May 2014 11:17:59 Jakub Tyszkowski wrote:
> ---
>  android/gatt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 9234b46..6189407 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3643,9 +3643,15 @@ static void send_dev_pending_response(struct gatt_device *device,
>  			goto done;
>  		}
>  
> +		if (val->error) {
> +			queue_destroy(temp, NULL);
> +			error = val->error;
> +			goto done;
> +		}
> +
>  		length = val->length;
>  
> -		while (val && val->length == length) {
> +		while (val && val->length == length && val->error == 0) {
>  			queue_push_tail(temp, val);
>  			val = queue_pop_head(device->pending_requests);
>  		}

This patch is now pushed, thanks.

-- 
Best regards, 
Szymon Janc
