Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] android/gatt: Send app uuid also for failure response
Date: Mon, 28 Apr 2014 18:00:01 +0200
Message-ID: <1646919.8iKBmNv117@uw000953>
In-Reply-To: <1398691070-25530-3-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691070-25530-1-git-send-email-jakub.tyszkowski@tieto.com> <1398691070-25530-3-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Monday 28 of April 2014 15:17:50 Jakub Tyszkowski wrote:
> Framework should know which request failed.
> ---
>  android/gatt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 7c59e12..a7b8659 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3105,7 +3105,6 @@ static void handle_server_register(const void *buf, uint16_t len)
>  
>  	ev.status = GATT_SUCCESS;
>  	ev.server_if = server->id;
> -	memcpy(ev.uuid, server->uuid, sizeof(server->uuid));
>  
>  	status = HAL_STATUS_SUCCESS;
>  
> @@ -3113,6 +3112,8 @@ failed:
>  	if (status != HAL_STATUS_SUCCESS)
>  		ev.status = GATT_FAILURE;
>  
> +	memcpy(ev.uuid, cmd->uuid, sizeof(ev.uuid));
> +
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>  				HAL_EV_GATT_SERVER_REGISTER, sizeof(ev), &ev);
>  
This patch is now pushed, thanks.

-- 
Best regards, 
Szymon Janc
