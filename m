Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Simplify find_device helper
Date: Mon, 31 Mar 2014 14:44:37 +0200
Message-ID: <1669405.qm1PI0d5hl@uw000953>
In-Reply-To: <1396258005-30573-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396258005-30573-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Monday 31 of March 2014 11:26:45 Marcin Kraglak wrote:
> We don't need to use dev pointer in second search attempt.
> ---
>  android/gatt.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index e361506..1bddbcf 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -805,11 +805,7 @@ static struct gatt_device *find_device(bdaddr_t *addr)
>  	if (dev)
>  		return dev;
>  
> -	dev = queue_find(conn_wait_queue, match_dev_by_bdaddr, addr);
> -	if (dev)
> -		return dev;
> -
> -	return NULL;
> +	return queue_find(conn_wait_queue, match_dev_by_bdaddr, addr);
>  }
>  
>  static struct gatt_device *find_device_by_conn_id(int32_t conn_id)
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
