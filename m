Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/gatt: Remove unneeded label from unregister_client
Date: Fri, 11 Apr 2014 15:54:55 +0200
Message-ID: <7987899.aG6gJZyyB9@uw000953>
In-Reply-To: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 10 of April 2014 20:40:35 Marcin Kraglak wrote:
> ---
>  android/gatt.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index a7a7204..4a720cc 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -506,13 +506,11 @@ static void handle_client_unregister(const void *buf, uint16_t len)
>  	if (!cl) {
>  		error("gatt: client_if=%d not found", cmd->client_if);
>  		status = HAL_STATUS_FAILED;
> -		goto failed;
> +	} else {
> +		destroy_gatt_client(cl);
> +		status = HAL_STATUS_SUCCESS;
>  	}
>  
> -	destroy_gatt_client(cl);
> -	status = HAL_STATUS_SUCCESS;
> -
> -failed:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
>  					HAL_OP_GATT_CLIENT_UNREGISTER, status);
>  }
> 

All patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
