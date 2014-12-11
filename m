Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Add callback for test command
Date: Thu, 11 Dec 2014 15:14:33 +0100
Message-ID: <1670022.J8tim6EklZ@uw000953>
In-Reply-To: <1418306706-21479-1-git-send-email-mariusz.skamra@tieto.com>
References: <1418306706-21479-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Thursday 11 of December 2014 15:05:06 Mariusz Skamra wrote:
> It is needed in new gattrib. Without callback command won't be send.
> ---
>  android/gatt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 8a81852..1b38a51 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4053,6 +4053,12 @@ failed:
>  				HAL_OP_GATT_CLIENT_SET_ADV_DATA, status);
>  }
>  
> +static void test_command_result(guint8 status, const guint8 *pdu,
> +					guint16 len, gpointer user_data)
> +{
> +	DBG("status: %d", status);
> +}
> +
>  static uint8_t test_read_write(bdaddr_t *bdaddr, bt_uuid_t *uuid, uint16_t op,
>  						uint16_t u2,uint16_t u3,
>  						uint16_t u4, uint16_t u5)
> @@ -4114,7 +4120,8 @@ static uint8_t test_read_write(bdaddr_t *bdaddr, bt_uuid_t *uuid, uint16_t op,
>  	if (!length)
>  		return HAL_STATUS_FAILED;
>  
> -	g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
> +	g_attrib_send(dev->attrib, 0, pdu, length, test_command_result, NULL,
> +									NULL);
>  
>  	return HAL_STATUS_SUCCESS;
>  }

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
