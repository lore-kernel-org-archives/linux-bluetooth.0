Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Fix service changed indication
Date: Thu, 11 Dec 2014 18:55:16 +0100
Message-ID: <3935797.Wmi3EvObn2@leonov>
In-Reply-To: <1418316834-26886-1-git-send-email-mariusz.skamra@tieto.com>
References: <1418316834-26886-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Thursday 11 of December 2014 17:53:53 Mariusz Skamra wrote:
> This patch fixes the service changed indication issue.
> Without confirmation callback indications were not sent.
> Dummy ignore_confirmation_cb is used for this purpose.
> ---
>  android/gatt.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 58bc22d..c4e3497 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1017,6 +1017,12 @@ static void send_exchange_mtu_request(struct
> gatt_device *device) device_unref(device);
>  }
> 
> +static void ignore_confirmation_cb(guint8 status, const guint8 *pdu,
> +					guint16 len, gpointer user_data)
> +{
> +	/* Ignored. */
> +}
> +
>  static void notify_att_range_change(struct gatt_device *dev,
>  							struct att_range *range)
>  {
> @@ -1025,6 +1031,7 @@ static void notify_att_range_change(struct gatt_device
> *dev, uint16_t ccc;
>  	uint8_t *pdu;
>  	size_t mtu;
> +	GAttribResultFunc confirmation_cb = NULL;
> 
>  	handle = gatt_db_attribute_get_handle(service_changed_attrib);
>  	if (!handle)
> @@ -1044,6 +1051,7 @@ static void notify_att_range_change(struct gatt_device
> *dev, case 0x0002:
>  		length = enc_indication(handle, (uint8_t *) range,
>  						sizeof(*range), pdu, mtu);
> +		confirmation_cb = ignore_confirmation_cb;
>  		break;
>  	default:
>  		/* 0xfff4 reserved for future use */
> @@ -1051,7 +1059,8 @@ static void notify_att_range_change(struct gatt_device
> *dev, }
> 
>  	if (length)
> -		g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
> +		g_attrib_send(dev->attrib, 0, pdu, length,
> +						confirmation_cb, NULL, NULL);
>  }
> 
>  static struct app_connection *create_connection(struct gatt_device *device,
> @@ -5432,12 +5441,6 @@ failed:
>  				HAL_OP_GATT_SERVER_DELETE_SERVICE, status);
>  }
> 
> -static void ignore_confirmation_cb(guint8 status, const guint8 *pdu,
> -						guint16 len, gpointer user_data)
> -{
> -	/* Ignored. */
> -}
> -
>  static void handle_server_send_indication(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_gatt_server_send_indication *cmd = buf;

Both patches applied, thanks.

-- 
BR
Szymon Janc
