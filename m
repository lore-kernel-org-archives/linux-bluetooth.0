Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix handling advertising state
Date: Wed, 14 May 2014 15:19:11 +0200
Message-ID: <5603621.8izkkfudE9@uw000953>
In-Reply-To: <1400066794-12621-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400066794-12621-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 14 of May 2014 13:26:34 Lukasz Rymanowski wrote:
> This patch fixes enabling advertising.
> It was not possible to enable it if we had server registered
> which is on listen_apps list but does not trigger advertising.
> 
> This patch introduces static counter to track number of clients
> requested advertising.
> ---
>  android/gatt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 157ebe6..ad89233 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -167,6 +167,7 @@ struct app_connection {
>  static struct ipc *hal_ipc = NULL;
>  static bdaddr_t adapter_addr;
>  static bool scanning = false;
> +static unsigned int advertising_cnt = 0;
>  
>  static struct queue *gatt_apps = NULL;
>  static struct queue *gatt_devices = NULL;
> @@ -1374,6 +1375,10 @@ static void set_advertising_cb(uint8_t status, void *user_data)
>  
>  	send_client_listen_notify(l->client_id, status);
>  
> +	/* In case of success update advertising state*/
> +	if (!status)
> +		advertising_cnt = l->start ? 1 : 0;
> +
>  	/*
>  	 * Let's remove client from the list in two cases
>  	 * 1. Start failed
> @@ -1418,7 +1423,8 @@ static void handle_client_listen(const void *buf, uint16_t len)
>  		}
>  
>  		/* If listen is already on just return success*/
> -		if (queue_length(listen_apps) > 1) {
> +		if (advertising_cnt > 0) {
> +			advertising_cnt++;
>  			status = HAL_STATUS_SUCCESS;
>  			goto reply;
>  		}
> @@ -1435,7 +1441,8 @@ static void handle_client_listen(const void *buf, uint16_t len)
>  		 * In case there is more listening clients don't stop
>  		 * advertising
>  		 */
> -		if (queue_length(listen_apps) > 1) {
> +		if (advertising_cnt > 1) {
> +			advertising_cnt--;
>  			queue_remove(listen_apps,
>  						INT_TO_PTR(cmd->client_if));
>  			status = HAL_STATUS_SUCCESS;
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
