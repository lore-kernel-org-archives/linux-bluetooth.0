Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/gatt: Remove redundant search
Date: Wed, 11 Feb 2015 12:27:42 +0100
Message-ID: <2356699.pYCfEUalJd@uw000953>
In-Reply-To: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 10 of February 2015 13:48:09 Jakub Tyszkowski wrote:
> Searching for device is not needed since we have reference counting and
> device is there as long as app connection exist.
> ---
>  android/gatt.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 4398194..425d3e8 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -914,14 +914,10 @@ static void destroy_connection(void *data)
>  	if (conn->timeout_id > 0)
>  		g_source_remove(conn->timeout_id);
>  
> -	if (!queue_find(gatt_devices, match_by_value, conn->device))
> -		goto cleanup;
> -
>  	conn->device->conn_cnt--;
>  	if (conn->device->conn_cnt == 0)
>  		connection_cleanup(conn->device);
>  
> -cleanup:
>  	queue_destroy(conn->transactions, free);
>  	device_unref(conn->device);
>  	free(conn);
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
