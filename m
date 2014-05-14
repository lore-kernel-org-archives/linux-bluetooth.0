Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/bluetooth: Add function for getting bonded device list
Date: Wed, 14 May 2014 15:25:10 +0200
Message-ID: <1704510.lWAUPKPsXh@uw000953>
In-Reply-To: <1399905493-10699-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399905493-10699-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 12 of May 2014 16:38:12 Grzegorz Kolodziejczyk wrote:
> This will be used by GATT HAL.
> ---
>  android/bluetooth.c | 8 ++++++++
>  android/bluetooth.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index be7b47c..ecdbeac 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1218,6 +1218,14 @@ const char *bt_get_adapter_name(void)
>  	return adapter.name;
>  }
>  
> +bool bt_device_is_bonded(const bdaddr_t *bdaddr)
> +{
> +	if (g_slist_find_custom(bonded_devices, bdaddr, device_match))
> +		return true;
> +
> +	return false;
> +}
> +
>  static bool rssi_above_threshold(int old, int new)
>  {
>  	/* only 8 dBm or more */
> diff --git a/android/bluetooth.h b/android/bluetooth.h
> index dddbf20..3eef7a4 100644
> --- a/android/bluetooth.h
> +++ b/android/bluetooth.h
> @@ -49,3 +49,4 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
>  
>  uint8_t bt_get_device_android_type(const bdaddr_t *addr);
>  const char *bt_get_adapter_name(void);
> +bool bt_device_is_bonded(const bdaddr_t *bdaddr);
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
