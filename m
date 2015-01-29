Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Change device information service handle number
Date: Thu, 29 Jan 2015 16:49:55 +0100
Message-ID: <7691265.5utIoNFrWh@leonov>
In-Reply-To: <1421938912-17448-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1421938912-17448-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 22 of January 2015 16:01:51 Grzegorz Kolodziejczyk wrote:
> This patch corrects number of handles which are reserved for DIS service
> while adding to gatt db. Sufficient amount for all DIS characteristics
> instances is 17.
> 
> This is related to PTS test case:
> TC_DEC_BV_09_C - while all characteristics are registered, 15 handles in
> service wasn't sufficient to register PNP ID.
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 1d65c2a..3b690f9 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6898,7 +6898,7 @@ static void register_device_info_service(void)
> 
>  	/* Device Information Service */
>  	bt_uuid16_create(&uuid, 0x180a);
> -	service = gatt_db_add_service(gatt_db, &uuid, true, 15);
> +	service = gatt_db_add_service(gatt_db, &uuid, true, 17);
> 
>  	/* User data are not const hence (void *) cast is used */
>  	data = bt_config_get_name();

Both patches applied, thanks.

-- 
BR
Szymon Janc
