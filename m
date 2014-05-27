Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] android/gatt: Initialize crypto first
Date: Tue, 27 May 2014 22:51:56 +0200
Message-ID: <7658749.JgPr7YaV1P@leonov>
In-Reply-To: <1401185734-23672-5-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com> <1401185734-23672-5-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 27 of May 2014 12:15:33 Jakub Tyszkowski wrote:
> This fixes the missleading error on crypto setup failure:
> 
> 02-17 20:19:44.639 I/bluetoothd( 1705): bluetoothd[1706]: gatt: Failed
> to allocate memory for queues
> ---
>  android/gatt.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index dab9781..a8f072f 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5491,15 +5491,20 @@ bool bt_gatt_register(struct ipc *ipc, const
> bdaddr_t *addr) if (!start_listening_io())
>  		return false;
> 
> +	crypto = bt_crypto_new();
> +	if (!crypto) {
> +		error("gatt: Failed to setup crypto.");

listening_io should be cleaned up here.
Also no need for dot at the end of error message.

> +		return false;
> +	}
> +
>  	gatt_devices = queue_new();
>  	gatt_apps = queue_new();
>  	app_connections = queue_new();
>  	listen_apps = queue_new();
>  	gatt_db = gatt_db_new();
> -	crypto = bt_crypto_new();
> 
> -	if (!gatt_devices || !gatt_apps || !listen_apps ||
> -				!app_connections || !gatt_db || !crypto) {
> +	if (!gatt_devices || !gatt_apps || !listen_apps || !app_connections ||
> +								!gatt_db) {
>  		error("gatt: Failed to allocate memory for queues");
> 
>  		queue_destroy(gatt_apps, NULL);

-- 
BR
Szymon Janc
