Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/gatt: Handle Androids read/write responses in response queue
Date: Sun, 18 May 2014 14:01:56 +0200
Message-ID: <1550819.rfaVXmX3eV@leonov>
In-Reply-To: <1400238042-16015-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400238042-16015-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 16 of May 2014 13:00:39 Jakub Tyszkowski wrote:
> This is needed for reads like "read by type" to support Android
> responses, callback reads and direct db reads in a single request.
> ---
>  android/gatt.c | 88
> ++++++++++++++++++++++++++++++++++++++-------------------- 1 file changed,
> 58 insertions(+), 30 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 9bbcc48..20850af 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3610,6 +3610,37 @@ static void send_dev_pending_response(struct
> gatt_device *device,
> 
>  		break;
>  	}
> +	case ATT_OP_EXEC_WRITE_REQ:
> +		val = queue_pop_head(device->pending_requests);
> +		if (!val) {
> +			error = ATT_ECODE_ATTR_NOT_FOUND;
> +			break;
> +		}
> +
> +		len = enc_exec_write_resp(rsp);
> +		destroy_pending_request(val);
> +		break;
> +	case ATT_OP_WRITE_REQ:
> +		val = queue_pop_head(device->pending_requests);
> +		if (!val) {
> +			error = ATT_ECODE_ATTR_NOT_FOUND;
> +			break;
> +		}
> +
> +		len = enc_write_resp(rsp);
> +		destroy_pending_request(val);
> +		break;
> +	case ATT_OP_PREP_WRITE_REQ:
> +		val = queue_pop_head(device->pending_requests);
> +		if (!val) {
> +			error = ATT_ECODE_ATTR_NOT_FOUND;
> +			break;
> +		}
> +
> +		len = enc_prep_write_resp(val->handle, val->offset, val->value,
> +						val->length, rsp, sizeof(rsp));
> +		destroy_pending_request(val);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -3698,48 +3729,45 @@ static void send_gatt_response(uint8_t opcode,
> uint16_t handle, bdaddr_t *bdaddr)
>  {
>  	struct gatt_device *dev;
> -	uint16_t length;
> -	uint8_t pdu[ATT_DEFAULT_LE_MTU];
> -
> -	DBG("");
> +	struct pending_request *entry;
> 
>  	dev = find_device_by_addr(bdaddr);
>  	if (!dev) {
>  		error("gatt: send_gatt_response, could not find dev");
> -		return;
> +		goto done;
>  	}
> 
> -	if (!status) {
> -		length = enc_error_resp(opcode, handle, status, pdu,
> -								sizeof(pdu));
> +	if (status)
>  		goto done;
> -	}
> 
> -	switch (opcode) {
> -	case ATT_OP_EXEC_WRITE_REQ:
> -		length = enc_exec_write_resp(pdu);
> -		break;
> -	case ATT_OP_WRITE_REQ:
> -		length = enc_write_resp(pdu);
> -		break;
> -	case ATT_OP_PREP_WRITE_REQ:
> -		length = enc_prep_write_resp(handle, offset, data, len, pdu,
> -								sizeof(pdu));
> -		break;
> -	case ATT_OP_READ_BLOB_REQ:
> -		length = enc_read_blob_resp((uint8_t *)data, len, offset, pdu,
> -								sizeof(pdu));
> -		break;
> -	case ATT_OP_READ_REQ:
> -		length = enc_read_resp((uint8_t *)data, len, pdu, sizeof(pdu));
> -		break;
> -	default:
> -		error("gatt: Unexpected opcode");
> +	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> +							UINT_TO_PTR(handle));
> +	if (!entry) {
> +		DBG("No pending response found! Bogus android response?");
>  		return;
>  	}
> 
> +	entry->handle = handle;
> +	entry->offset = offset;
> +	entry->length = len;
> +
> +	if (!len)
> +		goto done;
> +
> +	entry->value = malloc0(len);
> +	if (!entry->value) {
> +		/* send_dev_pending_request on empty queue sends error resp. */
> +		queue_remove(dev->pending_requests, entry);
> +		destroy_pending_request(entry);
> +
> +		goto done;
> +	}
> +
> +	memcpy(entry->value, data, len);
> +
>  done:
> -	g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
> +	if (!queue_find(dev->pending_requests, match_pending_dev_request, NULL))
> +		send_dev_pending_response(dev, opcode);
>  }
> 
>  static void set_trans_id(struct gatt_app *app, unsigned int id, int8_t
> opcode)

All patches are now applied, thanks.

-- 
BR
Szymon Janc
