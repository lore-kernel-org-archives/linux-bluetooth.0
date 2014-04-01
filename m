Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] android/gatt: Remove redundant hal cmd check
Date: Tue, 01 Apr 2014 15:56:49 +0200
Message-ID: <26858286.n3DPGo1T2v@uw000953>
In-Reply-To: <1396356869-21053-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396356869-21053-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 01 of April 2014 14:54:27 Grzegorz Kolodziejczyk wrote:
> This removes redundant hal cmd check (is received in cmd UUID == NULL).
> ---
>  android/gatt.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 941582a..ee77a4e 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -350,12 +350,6 @@ static void handle_client_register(const void *buf, uint16_t len)
>  
>  	DBG("");
>  
> -	if (!cmd->uuid) {
> -		error("gatt: no uuid received");
> -		status = HAL_STATUS_FAILED;
> -		goto failed;
> -	}
> -
>  	if (queue_find(gatt_clients, match_client_by_uuid, &cmd->uuid)) {
>  		error("gatt: client uuid is already on list");
>  		status = HAL_STATUS_FAILED;
> 

All patches pushed (with some fixes applied), thanks.

-- 
Best regards, 
Szymon Janc
