Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/gatt: Check for connection state on connection search
Date: Thu, 22 May 2014 14:12:19 +0200
Message-ID: <1981859.VIDaj1bQ3U@uw000953>
In-Reply-To: <1400682882-11341-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400682882-11341-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 21 of May 2014 16:34:40 Jakub Tyszkowski wrote:
> This search was used with the assumption that connection is in
> "connected" state. This could result in attrib pointer being
> dereferenced while it's still NULL (pending connection).
> ---
>  android/gatt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 89da60d..1b000c4 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -364,8 +364,14 @@ static bool match_connection_by_device_and_app(const void *data,
>  
>  static struct app_connection *find_connection_by_id(int32_t conn_id)
>  {
> -	return queue_find(app_connections, match_connection_by_id,
> +	struct app_connection *conn;
> +
> +	conn = queue_find(app_connections, match_connection_by_id,
>  							INT_TO_PTR(conn_id));
> +	if (conn && conn->device->state == DEVICE_CONNECTED)
> +		return conn;
> +
> +	return NULL;
>  }
>  
>  static bool match_connection_by_device(const void *data, const void *user_data)

Patch 1/3 is now applied, thanks.

-- 
Best regards, 
Szymon Janc
