Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hidhost: Fix adding hidhost device on devices list
Date: Tue, 24 Jun 2014 11:51:03 +0200
Message-ID: <1639276.t3HNkxrDWO@uw000953>
In-Reply-To: <1403533097-23511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1403533097-23511-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 23 of June 2014 16:18:17 Grzegorz Kolodziejczyk wrote:
> Create hog connection cb functionality tried to operate on stored on
> list hidhost device. Adding hidhost device to list should be done
> before operating on it.
> 
> It caused sending bogus connecting state change.
> ---
>  android/hidhost.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 846dd57..fdbe885 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -846,9 +846,12 @@ static void bt_hid_connect(const void *buf, uint16_t len)
>  	ba2str(&dev->dst, addr);
>  	DBG("connecting to %s", addr);
>  
> +	devices = g_slist_append(devices, dev);
> +
>  	if (bt_is_device_le(&dst)) {
>  		if (!hog_connect(dev)) {
>  			status = HAL_STATUS_FAILED;
> +			hid_device_remove(dev);
>  			goto failed;
>  		}
>  		goto done;
> @@ -864,8 +867,6 @@ static void bt_hid_connect(const void *buf, uint16_t len)
>  	}
>  
>  done:
> -	devices = g_slist_append(devices, dev);
> -
>  	if (dev->state == HAL_HIDHOST_STATE_DISCONNECTED)
>  		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
>  
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
