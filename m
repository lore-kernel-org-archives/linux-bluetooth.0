Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] android/gatt: Unify destroy functions
Date: Thu, 27 Mar 2014 16:23:48 +0100
Message-ID: <5415794.WkJGC9P26L@uw000953>
In-Reply-To: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 26 of March 2014 18:00:53 Jakub Tyszkowski wrote:
> This patch unifies destroy function names. We should also keep destroy
> functions convention as it is in /src/shared/hci.c for example, and
> check passed pointer before dereferencing it.
> ---
>  android/gatt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 04e9729..aeb0585 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -96,10 +96,13 @@ static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
>  
>  static void bt_le_discovery_stop_cb(void);
>  
> -static void free_gatt_service(void *data)
> +static void destroy_service(void *data)
>  {
>  	struct service *srvc = data;
>  
> +	if (!srvc)
> +		return;
> +
>  	queue_destroy(srvc->chars, free);
>  	free(srvc);
>  }
> @@ -175,8 +178,11 @@ static void destroy_device(void *data)
>  {
>  	struct gatt_device *dev = data;
>  
> +	if (!dev)
> +		return;
> +
>  	queue_destroy(dev->clients, NULL);
> -	queue_destroy(dev->services, free_gatt_service);
> +	queue_destroy(dev->services, destroy_service);
>  	free(dev);
>  }
>  
> 

Patches 1-5 are now applied. Thanks.

-- 
Best regards, 
Szymon Janc
