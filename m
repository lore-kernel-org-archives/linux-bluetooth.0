Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] android/gatt: Fix autoconnect
Date: Fri, 08 May 2015 14:46:22 +0200
Message-ID: <5915398.yFWW3tx09O@leonov>
In-Reply-To: <1430393178-29983-4-git-send-email-mariusz.skamra@gmail.com>
References: <1430393178-29983-1-git-send-email-mariusz.skamra@gmail.com> <1430393178-29983-4-git-send-email-mariusz.skamra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Thursday 30 of April 2015 13:26:18 Mariusz Skamra wrote:
> This patch fixes autoconnect issue, however there is also race hazard in
> Android Gatt framework. If app uses autoconnect while connecting,
> direct flag is set to false. Then bt_gatt_add_autoconnect should be called
> to add this app's id to autoconnect_apps queue.
> ---
>  android/gatt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 4da959f..72a27ab 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1972,6 +1972,7 @@ static bool trigger_connection(struct app_connection
> *conn, bool direct) if (direct)
>  			return connect_le(conn->device) == 0;
> 
> +		bt_gatt_add_autoconnect(conn->app->id, &conn->device->bdaddr);
>  		return auto_connect_le(conn->device);
>  	case DEVICE_CONNECTED:
>  		notify_app_connect_status(conn, GATT_SUCCESS);

This patch is now applied. Thanks.

-- 
BR
Szymon Janc
