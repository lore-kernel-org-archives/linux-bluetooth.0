Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 3/4] android/gatt: dummy callback for indications
Date: Wed, 12 Nov 2014 21:56:57 +0100
Message-ID: <2667261.3GKfMOmS1K@leonov>
In-Reply-To: <1415823779-346-4-git-send-email-jamuraa@chromium.org>
References: <1415823779-346-1-git-send-email-jamuraa@chromium.org> <1415823779-346-4-git-send-email-jamuraa@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Wednesday 12 of November 2014 12:22:58 Michael Janssen wrote:
> Indications require a confirmation reply, and newer APIs require that a
> callback is provided.  Add a dummy callback which ignores this
> confirmation to ensure future compatability.
> ---

There are some coding style issues in this patch.

>  android/gatt.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 086bb94..9c48f97 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5414,6 +5414,11 @@ failed:
>  				HAL_OP_GATT_SERVER_DELETE_SERVICE, status);
>  }
> 
> +static void ignore_confirmation_cb(guint8 status, const guint8 *pdu,
> +					      guint16 len, gpointer user_data) {
> +	// Ignored.
> +}

Please use C-style /* foo */ comments.
Also function braces should be open in new line.


> +
>  static void handle_server_send_indication(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_gatt_server_send_indication *cmd = buf;
> @@ -5422,6 +5427,7 @@ static void handle_server_send_indication(const void
> *buf, uint16_t len) uint16_t length;
>  	uint8_t *pdu;
>  	size_t mtu;
> +	GAttribResultFunc confirmation_cb = NULL;
> 
>  	DBG("");
> 
> @@ -5434,12 +5440,13 @@ static void handle_server_send_indication(const void
> *buf, uint16_t len)
> 
>  	pdu = g_attrib_get_buffer(conn->device->attrib, &mtu);
> 
> -	if (cmd->confirm)
> +	if (cmd->confirm) {
>  		/* TODO: Add data to track confirmation for this request */
>  		length = enc_indication(cmd->attribute_handle,
>  					(uint8_t *)cmd->value, cmd->len, pdu,
>  					mtu);
> -	else
> +		confirmation_cb = ignore_confirmation_cb;
> +	} else
>  		length = enc_notification(cmd->attribute_handle,
>  						(uint8_t *)cmd->value, cmd->len,
>  						pdu, mtu);

If single branch has braces every branch should have those.


> @@ -5448,8 +5455,8 @@ static void handle_server_send_indication(const void
> *buf, uint16_t len) error("gatt: Failed to encode indication");
>  		status = HAL_STATUS_FAILED;
>  	} else {
> -		g_attrib_send(conn->device->attrib, 0, pdu, length, NULL, NULL,
> -									NULL);
> +		g_attrib_send(conn->device->attrib, 0, pdu, length,
> +						   confirmation_cb, NULL, NULL);
>  		status = HAL_STATUS_SUCCESS;
>  	}

Other than code style issues this looks fine for me.

-- 
BR
Szymon Janc
