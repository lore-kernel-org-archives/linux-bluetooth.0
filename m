Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix not sending confirmation for INDICATION
Date: Thu, 22 May 2014 13:15:06 +0200
Message-ID: <5289260.qhIs60D7SF@uw000953>
In-Reply-To: <1400669436-2252-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400669436-2252-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 21 of May 2014 12:50:36 Marcin Kraglak wrote:
> Send confirmation for ATT_OP_HANDLE_IND (opcode 0x1D). It is needed
> for flow control.
> ---
>  android/gatt.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 89da60d..59fdc07 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3007,20 +3007,6 @@ static void handle_notification(const uint8_t *pdu, uint16_t len,
>  	ev->len = len - data_offset;
>  	memcpy(ev->value, pdu + data_offset, len - data_offset);
>  
> -	if (!ev->is_notify) {
> -		uint8_t *res;
> -		uint16_t len;
> -		size_t plen;
> -
> -		res = g_attrib_get_buffer(
> -				notification->conn->device->attrib,
> -				&plen);
> -		len = enc_confirmation(res, plen);
> -		if (len > 0)
> -			g_attrib_send(notification->conn->device->attrib,
> -						0, res, len, NULL, NULL, NULL);
> -	}
> -
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_NOTIFY,
>  						sizeof(*ev) + ev->len, ev);
>  }
> @@ -4760,8 +4746,16 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
>  	case ATT_OP_FIND_BY_TYPE_REQ:
>  		status = find_by_type_request(ipdu, len, dev);
>  		break;
> -        case ATT_OP_HANDLE_IND:
> -        case ATT_OP_HANDLE_NOTIFY:
> +	case ATT_OP_HANDLE_IND:
> +		/*
> +		 * We have to send confirmation here. If some client is
> +		 * registered for this indication, event will be send in
> +		 * handle_notification
> +		 */
> +		length = enc_confirmation(opdu, sizeof(opdu));
> +		status = 0;
> +		break;
> +	case ATT_OP_HANDLE_NOTIFY:
>  		/* Client will handle this */
>  		return;
>  	case ATT_OP_EXEC_WRITE_REQ:

Applied, thanks.

-- 
Best regards, 
Szymon Janc
