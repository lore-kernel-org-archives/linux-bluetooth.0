Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix missing android address to bdadr conversion
Date: Thu, 08 May 2014 10:36:47 +0200
Message-ID: <1623131.8qjDlFkzyy@uw000953>
In-Reply-To: <1399537137-8349-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399537137-8349-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 08 of May 2014 10:18:57 Grzegorz Kolodziejczyk wrote:
> This fix missing android to bd address conversion before handle
> connection.
> ---
>  android/gatt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 9b96dbf..9e466cf 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3102,6 +3102,8 @@ static void handle_server_connect(const void *buf, uint16_t len)
>  
>  	DBG("");
>  
> +	android2bdaddr(&cmd->bdaddr, &addr);
> +
>  	status = handle_connect(cmd->server_if, &addr);
>  
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_CONNECT,
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
