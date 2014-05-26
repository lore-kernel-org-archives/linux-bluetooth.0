Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Fix possible memory leak in write request
Date: Tue, 27 May 2014 00:14:21 +0200
Message-ID: <11034349.R0bk4YHB4h@athlon>
In-Reply-To: <1401113183-6617-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401113183-6617-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Monday 26 May 2014 16:06:22 Marcin Kraglak wrote:
> If write cannot be executed, remove data from queue and free
> allocated memory.
> ---
>  android/gatt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index e41a69e..721785a 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4969,8 +4969,11 @@ static uint8_t write_req_request(const uint8_t *cmd,
> uint16_t cmd_len, }
> 
>  	if (!gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
> -								&dev->bdaddr))
> +								&dev->bdaddr)) {
> +		queue_remove(dev->pending_requests, data);
> +		free(data);
>  		return ATT_ECODE_UNLIKELY;
> +	}
> 
>  	return 0;
>  }

Both patches applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
