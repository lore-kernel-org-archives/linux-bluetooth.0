Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Set Descriptor handle and Include Service handle
Date: Tue, 18 Nov 2014 23:20:18 +0100
Message-ID: <19950456.7PV9tDReLT@leonov>
In-Reply-To: <1416220254-9349-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416220254-9349-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Monday 17 of November 2014 11:30:54 Marcin Kraglak wrote:
> Set newly created attribute's handle in notification data.
> ---
>  android/gatt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 086bb94..199243d 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4322,6 +4322,7 @@ static void handle_server_add_included_service(const
> void *buf, uint16_t len) goto failed;
>  	}
> 
> +	ev.incl_srvc_handle = gatt_db_attribute_get_handle(service);
>  	status = HAL_STATUS_SUCCESS;
>  failed:
>  	ev.srvc_handle = cmd->service_handle;
> @@ -5056,10 +5057,13 @@ static void handle_server_add_descriptor(const void
> *buf, uint16_t len) attrib = gatt_db_service_add_descriptor(attrib, &uuid,
> permissions, read_cb, write_cb,
>  							INT_TO_PTR(app_id));
> -	if (!attrib)
> +	if (!attrib) {
>  		status = HAL_STATUS_FAILED;
> -	else
> -		status = HAL_STATUS_SUCCESS;
> +		goto failed;
> +	}
> +
> +	ev.descr_handle = gatt_db_attribute_get_handle(attrib);
> +	status = HAL_STATUS_SUCCESS;
> 
>  failed:
>  	ev.server_if = app_id;

Applied, thanks.

-- 
BR
Szymon Janc
