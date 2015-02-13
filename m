Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 05/10] android/gatt: Use g_attrib_send consistently
Date: Fri, 13 Feb 2015 12:31:11 +0100
Message-ID: <2715406.EyNz60MSyF@uw000953>
In-Reply-To: <1423665248-5121-5-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com> <1423665248-5121-5-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 11 of February 2015 15:34:03 Jakub Tyszkowski wrote:
> 'g_attrib_send' do checks the 'length' parameter so there is no need
> for us to do this (and in most cases we don't). We can test the
> returned value in case we want to report error.
> ---
>  android/gatt.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 7f95226..81b0283 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1068,9 +1068,7 @@ static void notify_att_range_change(struct gatt_device *dev,
>  		break;
>  	}
>  
> -	if (length)
> -		g_attrib_send(dev->attrib, 0, pdu, length,
> -						confirmation_cb, NULL, NULL);
> +	g_attrib_send(dev->attrib, 0, pdu, length, confirmation_cb, NULL, NULL);
>  }
>  
>  static struct app_connection *create_connection(struct gatt_device *device,
> @@ -1480,9 +1478,7 @@ static void ind_handler(const uint8_t *cmd, uint16_t cmd_len,
>  	 */
>  
>  	resp_length = enc_confirmation(opdu, length);
> -	if (resp_length)
> -		g_attrib_send(dev->attrib, 0, opdu, resp_length, NULL, NULL,
> -									NULL);
> +	g_attrib_send(dev->attrib, 0, opdu, resp_length, NULL, NULL, NULL);
>  }
>  
>  static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
> @@ -4157,12 +4153,10 @@ static uint8_t test_read_write(bdaddr_t *bdaddr, bt_uuid_t *uuid, uint16_t op,
>  		return HAL_STATUS_UNSUPPORTED;
>  	}
>  
> -	if (!length)
> +	if (!g_attrib_send(dev->attrib, 0, pdu, length, test_command_result,
> +								NULL, NULL))
>  		return HAL_STATUS_FAILED;
>  
> -	g_attrib_send(dev->attrib, 0, pdu, length, test_command_result, NULL,
> -									NULL);
> -
>  	return HAL_STATUS_SUCCESS;
>  }
>  
> @@ -5531,12 +5525,11 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
>  						cmd->len, pdu, mtu);
>  	}
>  
> -	if (length == 0) {
> -		error("gatt: Failed to encode indication");
> +	if (!g_attrib_send(conn->device->attrib, 0, pdu, length,
> +				confirmation_cb, UINT_TO_PTR(conn->id), NULL)) {
> +		error("gatt: Failed to send indication");
>  		status = HAL_STATUS_FAILED;
>  	} else {
> -		g_attrib_send(conn->device->attrib, 0, pdu, length,
> -				confirmation_cb, UINT_TO_PTR(conn->id), NULL);
>  		status = HAL_STATUS_SUCCESS;
>  	}
>  
> @@ -6143,13 +6136,13 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
>  
>  	rsp = g_attrib_get_buffer(dev->attrib, &length);
>  
> +		return ATT_ECODE_UNLIKELY;
> +

This looks strange, rebase artifact perhaps?

>  	/* Respond with our MTU */
>  	len = enc_mtu_resp(mtu, rsp, length);
> -	if (!len)
> +	if (!g_attrib_send(dev->attrib, 0, rsp, len, NULL, NULL, NULL))
>  		return ATT_ECODE_UNLIKELY;
>  
> -	g_attrib_send(dev->attrib, 0, rsp, len, NULL, NULL, NULL);
> -
>  	return 0;
>  }
>  
> @@ -6703,9 +6696,7 @@ done:
>  		resp_length = enc_error_resp(ipdu[0], 0x0000, status, opdu,
>  									length);
>  
> -	if (resp_length)
> -		g_attrib_send(dev->attrib, 0, opdu, resp_length, NULL, NULL,
> -									NULL);
> +	g_attrib_send(dev->attrib, 0, opdu, resp_length, NULL, NULL, NULL);
>  }
>  
>  static void connect_confirm(GIOChannel *io, void *user_data)
> 

-- 
Best regards, 
Szymon Janc
