Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Remove redundant find function parameter
Date: Wed, 30 Apr 2014 11:22:48 +0200
Message-ID: <5203543.5rAnQQMj8k@uw000953>
In-Reply-To: <1398767468-15966-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398767468-15966-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 29 of April 2014 12:31:08 Jakub Tyszkowski wrote:
> As client and server apps id is guaranteed to be unique, there is no
> need for this search function parameter.
> ---
>  android/gatt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 0e81e7d..b2c1a02 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1242,8 +1242,7 @@ static void handle_client_unregister(const void *buf, uint16_t len)
>  					HAL_OP_GATT_CLIENT_UNREGISTER, status);
>  }
>  
> -static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id,
> -							int32_t app_type)
> +static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id)
>  {
>  	struct app_connection conn_match;
>  	struct gatt_device *dev = NULL;
> @@ -2875,7 +2874,7 @@ static void handle_client_register_for_notification(const void *buf,
>  
>  	android2bdaddr(&cmd->bdaddr, &addr);
>  
> -	conn = find_conn(&addr, cmd->client_if, APP_CLIENT);
> +	conn = find_conn(&addr, cmd->client_if);
>  	if (!conn) {
>  		status = HAL_STATUS_FAILED;
>  		goto failed;
> @@ -2980,7 +2979,7 @@ static void handle_client_deregister_for_notification(const void *buf,
>  
>  	android2bdaddr(&cmd->bdaddr, &addr);
>  
> -	conn = find_conn(&addr, cmd->client_if, APP_CLIENT);
> +	conn = find_conn(&addr, cmd->client_if);
>  	if (!conn) {
>  		status = HAL_STATUS_FAILED;
>  		goto failed;
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
