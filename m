Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix not unregistering last profile
Date: Fri, 18 Apr 2014 09:08:11 +0200
Message-ID: <5421608.OuFghJksDq@uw000953>
In-Reply-To: <1397717063-1442-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397717063-1442-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 17 of April 2014 08:44:23 Jakub Tyszkowski wrote:
> ---
>  android/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/main.c b/android/main.c
> index e229a6d..99ab376 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -377,7 +377,7 @@ static void cleanup_services(void)
>  
>  	DBG("");
>  
> -	for (i = HAL_SERVICE_ID_BLUETOOTH; i < HAL_SERVICE_ID_MAX; i++) {
> +	for (i = HAL_SERVICE_ID_BLUETOOTH; i < HAL_SERVICE_ID_MAX + 1; i++) {
>  		if (!services[i])
>  			continue;
>  

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
