Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 21:20:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v2 29/40] android/gatt: Add support to read request
Message-ID: <20140429182025.GA21895@t440s.P-661HNU-F1>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1398790049-30303-30-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398790049-30303-30-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> +static void gatt_request_complete(void *data, const uint8_t *pdu, uint16_t len)
> +{
> +	struct req_data *d = data;
> +
> +	if (pdu)
> +		g_attrib_send(d->dev->attrib, 0, pdu, len, NULL, NULL, NULL);
> +	else
> +		error("gatt: gatt_request_complete: pdu not present ?!");
> +
> +	free(d);
> +}
> +
> +static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
> +					struct gatt_device *dev)
> +{
> +	uint16_t handle;
> +	uint16_t len;
> +	uint16_t offset = 0;
> +	struct req_data *req_data;
> +
> +	DBG("");
> +
> +	req_data = new0(struct req_data, 1);
> +	if (!req_data)
> +		return ATT_ECODE_INSUFF_RESOURCES;
> +
> +	switch (cmd[0]) {
> +	case ATT_OP_READ_BLOB_REQ:
> +		len = dec_read_blob_req(cmd, cmd_len, &handle, &offset);
> +		if (!len) {
> +			free(req_data);
> +			return ATT_ECODE_INVALID_PDU;
> +		}
> +		req_data->long_read = true;
> +		break;
> +	case ATT_OP_READ_REQ:
> +		len = dec_read_req(cmd, cmd_len, &handle);
> +		if (!len) {
> +			free(req_data);
> +			return ATT_ECODE_INVALID_PDU;
> +		}
> +		break;
> +	default:
> +		error("gatt: Unexpected read type 0x%02x", cmd[0]);
> +		free(req_data);
> +		return ATT_ECODE_REQ_NOT_SUPP;
> +	}
> +
> +	req_data->dev = dev;
> +	req_data->opcode = cmd[0];
> +
> +	if (!gatt_db_read(gatt_db, handle, offset, req_data, gatt_request_complete)) {
> +		free(req_data);
> +		return ATT_ECODE_UNLIKELY;
> +	}

I don't understand the need to have so many levels of callback passing
instead of having simple direct calls, especially since all functions
are in the same c-file anyway. I.e. why can't the characteristic
read/write callbacks be responsible themselves for sending the response
PDU (if that's all your gatt_request_complete function is needed for).

This passing a callback (gatt_request_complete in this case) as a
parameter to another callback (the read/write callback) doesn't really
help in keeping things simple and understandable.

Johan
