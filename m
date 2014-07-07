Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 01/10] shared/att: Implement outgoing "Find Information" request/response.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403824457-22461-2-git-send-email-armansito@chromium.org>
Date: Mon, 7 Jul 2014 09:20:59 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3C1DD48A-E6D0-4F6C-BD38-3F8AB023663E@holtmann.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org> <1403824457-22461-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch add support for "Find Information" requests sent via
> bt_att_send and the corresponding response.
> ---
> src/shared/att.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 52 insertions(+)
> 
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 57f887e..22dd471 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -165,6 +165,30 @@ static bool encode_mtu_req(struct att_send_op *op, const void *param,
> 	return true;
> }
> 
> +static bool encode_find_info_req(struct att_send_op *op, const void *param,
> +						uint16_t length, uint16_t mtu)
> +{
> +	const struct bt_att_find_info_req_param *p = param;
> +	const uint16_t len = 5;
> +
> +	if (length != sizeof(*p))
> +		return false;
> +
> +	if (len > mtu)
> +		return false;
> +
> +	op->pdu = malloc(len);
> +	if (!op->pdu)
> +		return false;
> +
> +	((uint8_t *) op->pdu)[0] = op->opcode;
> +	put_le16(p->start_handle, ((uint8_t *) op->pdu) + 1);
> +	put_le16(p->end_handle, ((uint8_t *) op->pdu) + 3);

this ptr + x operation is actually defined on void pointers. At least with gcc. The casting should not be needed.

> +	op->len = len;
> +
> +	return true;
> +}

> +
> static bool encode_pdu(struct att_send_op *op, const void *param,
> 						uint16_t length, uint16_t mtu)
> {
> @@ -191,6 +215,8 @@ static bool encode_pdu(struct att_send_op *op, const void *param,
> 	switch (op->opcode) {
> 	case BT_ATT_OP_MTU_REQ:
> 		return encode_mtu_req(op, param, length, mtu);
> +	case BT_ATT_OP_FIND_INFO_REQ:
> +		return encode_find_info_req(op, param, length, mtu);
> 	default:
> 		break;
> 	}
> @@ -471,6 +497,29 @@ static bool handle_mtu_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> 							&param, sizeof(param));
> }
> 
> +static bool handle_find_info_rsp(struct bt_att *att, uint8_t opcode,
> +						uint8_t *pdu, ssize_t pdu_len)
> +{
> +	struct bt_att_find_info_rsp_param param;
> +
> +	/* PDU must have the following data:
> +	 * - 1 octet: ATT opcode
> +	 * - 1 octet: Format
> +	 * - 4 to MTU-2 octetsS; Information data
> +	 */
> +	if (pdu_len < 6)
> +		return false;
> +
> +	memset(&param, 0, sizeof(param));
> +
> +	param.format = pdu[1];
> +	param.length = pdu_len - 2;
> +	param.info_data = pdu + 2;
> +
> +	return request_complete(att, BT_ATT_OP_FIND_INFO_REQ, opcode,
> +							&param, sizeof(param));
> +}
> +
> static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> 								ssize_t pdu_len)
> {
> @@ -483,6 +532,9 @@ static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> 	case BT_ATT_OP_MTU_RSP:
> 		success = handle_mtu_rsp(att, opcode, pdu, pdu_len);
> 		break;
> +	case BT_ATT_OP_FIND_INFO_RSP:
> +		success = handle_find_info_rsp(att, opcode, pdu, pdu_len);
> +		break;

Help me out here on why are we doing this in this layer.

I am not really convinced that doing all the encoding and decoding in such a way is a good idea. The low-level bt_att_send should not really care about the PDU payload or anything. It should just now what are the expected result PDUs and nothing else. I think we should stick to the ATT low-level protocol.

If you want to add extra helpers for using the ATT procedures like Find Information, then we better add actually proper helpers on top of bt_att_send (compared to internally hacked into it). I am thinking along the lines of bt_add_find_info() and then have parameters that make sense.

However I am also fine in just making this part (the ATT procedures) part of our new GATT implementation. That is how I would have done it. When working on mgmt there was no need to try to add more logic than needed to it. Same as when we added QMI support to oFono. The biggest help was to have a simple asynchronous non-blocking implementation of the low-level transport. Everything else was easy to do in the higher layers.

Have you looked at the actually GATT defined procedure and just try to implement them using bt_att_send and PDU payload building and parsing in the higher layer.

Regards

Marcel

