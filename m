Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Fix possible memory leak
Date: Mon, 26 May 2014 10:47:45 +0200
Message-ID: <4752905.d9AFggy7r0@uw000953>
In-Reply-To: <1401089563-9932-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401089563-9932-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Monday 26 of May 2014 09:32:42 Jakub Tyszkowski wrote:
> ---
>  android/gatt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index c8af09c..e7f7c86 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4440,6 +4440,7 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
>  		if (!queue_push_tail(device->pending_requests, entry)) {
>  			queue_remove_all(device->pending_requests, NULL, NULL,
>  						destroy_pending_request);
> +			free(entry);
>  			queue_destroy(q, NULL);
>  			return ATT_ECODE_UNLIKELY;
>  		}
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
