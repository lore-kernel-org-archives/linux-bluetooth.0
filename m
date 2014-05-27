Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/6] android/gatt: Exchange mtu on connect if acting as client
Date: Tue, 27 May 2014 22:41:57 +0200
Message-ID: <58386092.pIfScf94rH@leonov>
In-Reply-To: <1401185734-23672-6-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com> <1401185734-23672-6-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 27 of May 2014 12:15:34 Jakub Tyszkowski wrote:
> When no client apps are registered we basically act as server only and
> mtu exchange request handling is enough. When acting as client we send
> request.
> ---
>  android/gatt.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index a8f072f..b120834 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -320,11 +320,24 @@ static bool match_app_by_id(const void *data, const
> void *user_data) return client->id == exp_id;
>  }
> 
> +static bool match_app_by_type(const void *data, const void *user_data)
> +{
> +	gatt_app_type_t app_type = PTR_TO_INT(user_data);
> +	const struct gatt_app *app = data;
> +
> +	return app->type == app_type;
> +}
> +
>  static struct gatt_app *find_app_by_id(int32_t id)
>  {
>  	return queue_find(gatt_apps, match_app_by_id, INT_TO_PTR(id));
>  }
> 
> +static struct gatt_app *find_app_by_type(gatt_app_type_t type)
> +{
> +	return queue_find(gatt_apps, match_app_by_type, INT_TO_PTR(type));
> +}
> +
>  static bool match_by_value(const void *data, const void *user_data)
>  {
>  	return data == user_data;
> @@ -1116,9 +1129,9 @@ static void connect_cb(GIOChannel *io, GError *gerr,
> gpointer user_data)
> 
>  	device_set_state(dev, DEVICE_CONNECTED);
> 
> -	/* Send exchange mtu request as we assume being client and server */
> -	/* TODO: Dont exchange mtu if no client apps */
> -	send_exchange_mtu_request(dev);
> +	/* Send exchange mtu request if any client app was registered */
> +	if (find_app_by_type(APP_CLIENT))
> +		send_exchange_mtu_request(dev);
> 
>  	status = GATT_SUCCESS;

I think we should also exchange MTU if first client app (since connection) is 
registered and exchange MTU was not performed by remote client.

-- 
BR
Szymon Janc
