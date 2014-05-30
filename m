Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Support find request in permission check
Date: Fri, 30 May 2014 16:47:33 +0200
Message-ID: <23756045.JH0hgDSIYx@leonov>
In-Reply-To: <1401455982-31339-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401455982-31339-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 30 of May 2014 15:19:41 Jakub Tyszkowski wrote:
> Permissions check was failing on those requests.
> ---
>  android/gatt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index fcc91ff..a61d702 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4007,6 +4007,8 @@ static uint8_t check_device_permissions(struct
> gatt_device *device, case ATT_OP_READ_BLOB_REQ:
>  	case ATT_OP_READ_MULTI_REQ:
>  	case ATT_OP_READ_BY_GROUP_REQ:
> +	case ATT_OP_FIND_BY_TYPE_REQ:
> +	case ATT_OP_FIND_INFO_REQ:
>  		if (!(permissions & GATT_PERM_READ))
>  			return ATT_ECODE_READ_NOT_PERM;

Both patches applied, thanks.

-- 
BR
Szymon Janc
