Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 05/10] src/shared/att: Add "Find Information" request and response.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400271298-29769-6-git-send-email-armansito@chromium.org>
Date: Sat, 24 May 2014 23:20:51 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <75E7F181-3C42-4674-922B-C52EDEBEE575@holtmann.org>
References: <1400271298-29769-1-git-send-email-armansito@chromium.org> <1400271298-29769-6-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch adds support for the "Find Information" request and response
> with their corresponding parameter structures.
> ---
> src/shared/att.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
> src/shared/att.h | 14 +++++++++
> 2 files changed, 99 insertions(+), 8 deletions(-)
> 
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 8b10c30..f124731 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -192,6 +192,8 @@ static bool handle_exchange_mtu_rsp(struct bt_att *att, const uint8_t *pdu,
> 	if (pdu_length != 3)
> 		return false;
> 
> +	memset(&param, 0, sizeof(param));
> +

skip the empty line here.

> 	param.server_rx_mtu = get_le16(pdu + 1);
> 
> 	request_complete(att, BT_ATT_OP_EXCHANGE_MTU_REQ, pdu[0],
> @@ -200,16 +202,67 @@ static bool handle_exchange_mtu_rsp(struct bt_att *att, const uint8_t *pdu,
> 	return true;
> }
> 
> +static bool handle_find_info_rsp(struct bt_att *att, const uint8_t *pdu,
> +							uint16_t pdu_length)
> +{
> +	struct bt_att_find_information_rsp_param param;
> +	uint8_t *information_data;

Use info_data please. Spelling out information in code makes my brain hurt ;)

> +
> +	if (pdu_length < 6)
> +		return false;
> +
> +	memset(&param, 0, sizeof(param));
> +
> +	param.format = pdu[1];
> +	param.length = pdu_length - 2;
> +
> +	/* param.length is at least 4, as checked above */
> +	information_data = malloc(param.length);
> +	if (!information_data)
> +		return false;
> +
> +	memcpy(information_data, pdu + 2, param.length);
> +
> +	param.information_data = information_data;
> +
> +	request_complete(att, BT_ATT_OP_FIND_INFORMATION_REQ, pdu[0],
> +							&param, sizeof(param));

On a side note, INFO_REQ is always better. Check monitor/bt.h for some ideas on when to shortcut and when not. I tried to be consistent as much I can be when I re-did all the constants. Sometimes it is a taste thing, but the long names really get in your way in the long run. I learned that the hard way.

> +
> +	free(information_data);
> +
> +	return true;
> +}
> +
> static bool handle_response(struct bt_att *att, const uint8_t *pdu,
> 							uint16_t pdu_length)
> {
> 	uint8_t opcode = pdu[0];
> +	uint8_t req_opcode;
> 
> -	if (opcode == BT_ATT_OP_ERROR_RESP)
> +	switch (opcode) {
> +	case BT_ATT_OP_ERROR_RESP:
> 		return handle_error_rsp(att, pdu, pdu_length);
> 
> -	if (opcode == BT_ATT_OP_EXCHANGE_MTU_RESP)
> -		return handle_exchange_mtu_rsp(att, pdu, pdu_length);
> +	case BT_ATT_OP_EXCHANGE_MTU_RESP:
> +		if (!handle_exchange_mtu_rsp(att, pdu, pdu_length)) {
> +			req_opcode = BT_ATT_OP_EXCHANGE_MTU_REQ;
> +			goto fail;
> +		}
> +		return true;
> +
> +	case BT_ATT_OP_FIND_INFORMATION_RESP:
> +		if (!handle_find_info_rsp(att, pdu, pdu_length)) {
> +			req_opcode = BT_ATT_OP_FIND_INFORMATION_REQ;
> +			goto fail;
> +		}
> +		return true;
> +
> +	default:
> +		break;
> +	}
> +
> +fail:
> +	request_complete(att, req_opcode, BT_ATT_OP_ERROR_RESP, NULL, 0);
> 
> 	return false;
> }
> @@ -405,14 +458,36 @@ static bool encode_mtu_req(const void *param, uint16_t length, void *buf,
> {
> 	const struct bt_att_exchange_mtu_req_param *cp = param;
> 	const uint16_t len = 3;
> +	uint8_t *bytes = buf;
> 
> -	if (length != sizeof(struct bt_att_exchange_mtu_req_param))
> +	if (length != sizeof(*cp))
> 		return false;
> 
> 	if (len > mtu)
> 		return false;
> 
> -	put_le16(cp->client_rx_mtu, buf);
> +	put_le16(cp->client_rx_mtu, bytes + 1);
> +	*pdu_length = len;
> +
> +	return true;
> +}
> +
> +static bool encode_find_info_req(const void *param, uint16_t length, void *buf,
> +						uint16_t mtu, uint16_t *pdu_length)
> +{
> +	const struct bt_att_find_information_req_param *cp = param;
> +	const uint16_t len = 5;
> +	uint8_t *bytes = buf;
> +
> +	if (length != sizeof(*cp))
> +		return false;
> +
> +	if (len > mtu)
> +		return false;
> +
> +	put_le16(cp->start_handle, bytes + 1);
> +	put_le16(cp->end_handle, bytes + 3);
> +
> 	*pdu_length = len;
> 
> 	return true;
> @@ -439,10 +514,12 @@ static bool encode_pdu(uint8_t opcode, const void *param, uint16_t length,
> 	if (!param)
> 		return false;
> 
> -	if (opcode == BT_ATT_OP_EXCHANGE_MTU_REQ) {
> -		return encode_mtu_req(param, length, bytes + 1,
> +	if (opcode == BT_ATT_OP_EXCHANGE_MTU_REQ)
> +		return encode_mtu_req(param, length, bytes, mtu, pdu_length);
> +
> +	if (opcode == BT_ATT_OP_FIND_INFORMATION_REQ)
> +		return encode_find_info_req(param, length, bytes,
> 							mtu, pdu_length);
> -	}
> 
> 	return false;
> }
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 8fe8805..16d852d 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -43,6 +43,20 @@ struct bt_att_exchange_mtu_rsp_param {
> 	uint16_t server_rx_mtu;
> };
> 
> +/* Find Information */
> +#define BT_ATT_OP_FIND_INFORMATION_REQ		0x04
> +struct bt_att_find_information_req_param {
> +	uint16_t start_handle;
> +	uint16_t end_handle;
> +};
> +
> +#define BT_ATT_OP_FIND_INFORMATION_RESP		0x05
> +struct bt_att_find_information_rsp_param {
> +	uint8_t format;
> +	const uint8_t *information_data;
> +	uint16_t length;
> +};

When you have wire format structs, use attribute packed with the struct. See monitor/bt.h.

I also think that is where these should go anyway.

> +
> /* Error codes for Error response PDU */
> #define BT_ATT_ERROR_INVALID_HANDLE			0x01
> #define BT_ATT_ERROR_READ_NOT_PERMITTED			0x02

Regards

Marcel

