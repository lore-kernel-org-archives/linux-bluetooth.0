Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 11:15:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 29/36] android/gatt: Add support for write request
Message-ID: <20140429081503.GI21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1398734107-4793-31-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398734107-4793-31-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> +static uint8_t write_request(const uint8_t *cmd, uint16_t cmd_len,
> +						struct gatt_device *dev)
> +{
> +	uint16_t handle;
> +	uint16_t offset = 0;
> +	uint16_t len;
> +	uint8_t value[ATT_DEFAULT_LE_MTU];
> +	size_t vlen;
> +	struct req_data *req_data;
> +
> +	req_data = new0(struct req_data, 1);
> +	if (!req_data)
> +		return ATT_ECODE_UNLIKELY;
> +
> +	switch (cmd[0]) {
> +	case ATT_OP_WRITE_CMD:
> +		len = dec_write_cmd(cmd, cmd_len, &handle, value, &vlen);
> +		if (!len) {
> +			free(req_data);
> +			return ATT_ECODE_INVALID_PDU;
> +		}
> +		break;
> +	case ATT_OP_WRITE_REQ:
> +		len = dec_write_req(cmd, cmd_len, &handle, value, &vlen);
> +		if (!len) {
> +			free(req_data);
> +			return ATT_ECODE_INVALID_PDU;
> +		}
> +		break;
> +	case ATT_OP_PREP_WRITE_REQ:
> +		len = dec_prep_write_req(cmd, cmd_len, &handle, &offset,
> +							value, &vlen);
> +		if (!len) {
> +			free(req_data);
> +			return ATT_ECODE_INVALID_PDU;
> +		}
> +		break;
> +	default:
> +		error("gatt: Unexpected write type 0x02%x", cmd[0]);
> +		free(req_data);
> +		return ATT_ECODE_REQ_NOT_SUPP;
> +	}
> +
> +	req_data->dev = dev;
> +	req_data->opcode = cmd[0];
> +
> +	if (!gatt_db_write(gatt_db, handle, offset, value, vlen, &req_data)) {
> +		free(req_data);
> +		return ATT_ECODE_UNLIKELY;
> +	}
> +
> +	return 0;
> +}

Same question here: where is req_data freed if gatt_db_read succeeds?

Johan
