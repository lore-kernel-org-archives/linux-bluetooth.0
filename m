Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: Fix wrong parameter passing to android2bdaddr
Date: Tue, 17 Jun 2014 15:10:09 +0200
Message-ID: <11409985.TI9k9sRMRi@uw000953>
In-Reply-To: <1403009607-6232-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403009607-6232-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tuesday 17 of June 2014 15:53:27 Ravi kumar Veeramally wrote:
> ---
>  android/health.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 585d8a4..58323d9 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1102,7 +1102,7 @@ static struct health_device *create_device(uint16_t app_id,
>  	if (!dev)
>  		return NULL;
>  
> -	android2bdaddr(&addr, &dev->dst);
> +	android2bdaddr(addr, &dev->dst);
>  	dev->app_id = app_id;
>  
>  	return dev;
> 

Pushed. Thanks.

-- 
Best regards, 
Szymon Janc
