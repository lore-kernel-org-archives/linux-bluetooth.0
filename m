Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix adding duplicate connection for server apps
Date: Fri, 03 Oct 2014 12:49:54 +0200
Message-ID: <2614039.CqHTy7gBEc@uw000953>
In-Reply-To: <1412332929-14595-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412332929-14595-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 03 of October 2014 12:42:09 Jakub Tyszkowski wrote:
> This replaces the usage of unsafe function for adding app connections
> with the one that is almost the same but first it checks if no
> duplicate entry is added to the list.
> 
> This fixes connection callback being sent twice for server app when it
> initiates the connection, and removes duplicated code.
> ---
>  android/gatt.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index b4a2554..dbe067f 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6193,17 +6193,6 @@ done:
>  									NULL);
>  }
>  
> -static void create_listen_connections(void *data, void *user_data)
> -{
> -	struct gatt_device *dev = user_data;
> -	int32_t id = PTR_TO_INT(data);
> -	struct gatt_app *app;
> -
> -	app = find_app_by_id(id);
> -	if (app)
> -		create_connection(dev, app);
> -}
> -
>  static void connect_confirm(GIOChannel *io, void *user_data)
>  {
>  	struct gatt_device *dev;
> @@ -6252,7 +6241,7 @@ static void connect_confirm(GIOChannel *io, void *user_data)
>  		goto drop;
>  	}
>  
> -	queue_foreach(listen_apps, create_listen_connections, dev);
> +	queue_foreach(listen_apps, create_app_connection, dev);
>  	device_set_state(dev, DEVICE_CONNECT_READY);
>  
>  	return;
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
