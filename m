Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/gatt: Fix reading attribute value
Date: Fri, 16 May 2014 10:45:35 +0200
Message-ID: <18188176.R3cMoBMcFL@uw000953>
In-Reply-To: <1400229459-21617-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400229459-21617-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 16 of May 2014 10:37:37 Marcin Kraglak wrote:
> If value and length was set by callback while gatt_db_read(), don't set
> length to READ_PENDING. We have to set it only for async callbacks, then
> length is still READ_INIT.
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index b367eef..2a2e649 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3670,7 +3670,7 @@ static void read_requested_attributes(void *data, void *user_data)
>  
>  		memcpy(resp_data->value, value, value_len);
>  		resp_data->length = value_len;
> -	} else {
> +	} else if (resp_data->length == READ_INIT) {
>  		resp_data->length = READ_PENDING;
>  	}
>  }
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
