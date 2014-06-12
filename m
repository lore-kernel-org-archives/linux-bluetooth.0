Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/gatt: Change check permissions order
Date: Thu, 12 Jun 2014 13:39:33 +0200
Message-ID: <1893660.GnYVkntkUv@uw000953>
In-Reply-To: <1402564106-27044-1-git-send-email-marcin.kraglak@tieto.com>
References: <1402564106-27044-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 12 of June 2014 11:08:23 Marcin Kraglak wrote:
> Firstly we should check if characteristic needs MITM permissions,
> and next check for ENCRYPTION permissions. Now remote device can
> increase security to MITM immediatelly (i.e. from sec LOW to HIGH).
> ---
>  android/gatt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 558b203..cfcfd9b 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4063,14 +4063,14 @@ static uint8_t check_device_permissions(struct gatt_device *device,
>  		if (!(permissions & GATT_PERM_READ))
>  			return ATT_ECODE_READ_NOT_PERM;
>  
> -		if ((permissions & GATT_PERM_READ_ENCRYPTED) &&
> -						sec_level < BT_SECURITY_MEDIUM)
> -			return ATT_ECODE_INSUFF_ENC;
> -
>  		if ((permissions & GATT_PERM_READ_MITM) &&
>  						sec_level < BT_SECURITY_HIGH)
>  			return ATT_ECODE_AUTHENTICATION;
>  
> +		if ((permissions & GATT_PERM_READ_ENCRYPTED) &&
> +						sec_level < BT_SECURITY_MEDIUM)
> +			return ATT_ECODE_INSUFF_ENC;
> +
>  		if (permissions & GATT_PERM_READ_AUTHORIZATION)
>  			return ATT_ECODE_AUTHORIZATION;
>  		break;
> @@ -4081,14 +4081,14 @@ static uint8_t check_device_permissions(struct gatt_device *device,
>  		if (!(permissions & GATT_PERM_WRITE))
>  			return ATT_ECODE_WRITE_NOT_PERM;
>  
> -		if ((permissions & GATT_PERM_WRITE_ENCRYPTED) &&
> -						sec_level < BT_SECURITY_MEDIUM)
> -			return ATT_ECODE_INSUFF_ENC;
> -
>  		if ((permissions & GATT_PERM_WRITE_MITM) &&
>  						sec_level < BT_SECURITY_HIGH)
>  			return ATT_ECODE_AUTHENTICATION;
>  
> +		if ((permissions & GATT_PERM_WRITE_ENCRYPTED) &&
> +						sec_level < BT_SECURITY_MEDIUM)
> +			return ATT_ECODE_INSUFF_ENC;
> +
>  		if (permissions & GATT_PERM_WRITE_AUTHORIZATION)
>  			return ATT_ECODE_AUTHORIZATION;
>  		break;
> 

All patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
