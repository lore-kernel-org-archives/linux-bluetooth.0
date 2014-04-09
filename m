Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-gatt: Fix typo in struct name
Date: Wed, 09 Apr 2014 20:50:14 +0200
Message-ID: <2678232.oX8hbluooB@athlon>
In-Reply-To: <1397035613-980-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397035613-980-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 09 April 2014 11:26:53 Marcin Kraglak wrote:
> It causes ipc error due to incorrect message length.
> ---
>  android/hal-gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/hal-gatt.c b/android/hal-gatt.c
> index 5e7443c..d8c0d54 100644
> --- a/android/hal-gatt.c
> +++ b/android/hal-gatt.c
> @@ -536,7 +536,7 @@ static const struct hal_ipc_handler ev_handlers[] = {
>  		sizeof(struct hal_ev_gatt_server_service_added) },
>  	/* HAL_EV_GATT_SERVER_INC_SRVC_ADDED */
>  	{ handle_included_service_added, false,
> -		sizeof(struct hal_ev_gatt_server_service_added) },
> +		sizeof(struct hal_ev_gatt_server_inc_srvc_added) },
>  	/* HAL_EV_GATT_SERVER_CHAR_ADDED */
>  	{ handle_characteristic_added, false,
>  		sizeof(struct hal_ev_gatt_server_characteristic_added) },

Pushed, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
