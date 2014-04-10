Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix not sending confirmation while receiving indication
Date: Thu, 10 Apr 2014 11:29:46 +0200
Message-ID: <1556117.jmY3lOSIcj@uw000953>
In-Reply-To: <1397035360-32680-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397035360-32680-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 09 of April 2014 11:22:40 Marcin Kraglak wrote:
> Send confirmation after receiving indication.
> ---
>  android/gatt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index a33ce25..a4c5026 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -2355,6 +2355,18 @@ static void handle_notification(const uint8_t *pdu, uint16_t len,
>  	ev->len = len - data_offset;
>  	memcpy(ev->value, pdu + data_offset, len - data_offset);
>  
> +	if (!ev->is_notify) {
> +		uint8_t *res;
> +		uint16_t len;
> +		size_t plen;
> +
> +		res = g_attrib_get_buffer(notification->dev->attrib, &plen);
> +		len = enc_confirmation(res, plen);
> +		if (len > 0)
> +			g_attrib_send(notification->dev->attrib, 0, res, len,
> +							NULL, NULL, NULL);
> +	}
> +
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_NOTIFY,
>  						sizeof(*ev) + ev->len, ev);
>  }
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
