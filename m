Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v4 4/4] src/shared/att: Handle incoming response PDUs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402958640-1132-5-git-send-email-armansito@chromium.org>
Date: Tue, 17 Jun 2014 11:32:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F0DE0097-7AD2-4C16-8A64-613495021AEB@holtmann.org>
References: <1402958640-1132-1-git-send-email-armansito@chromium.org> <1402958640-1132-5-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch adds handling for incoming ATT protocol response PDUs. Basic
> incoming PDU handling logic added to the io read handler.
> ---
> src/shared/att.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 116 insertions(+), 1 deletion(-)
> 
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 0c26811..df8461b 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -404,9 +404,111 @@ static void wakeup_writer(struct bt_att *att)
> 	att->writer_active = true;
> }
> 
> +static bool request_complete(struct bt_att *att, uint8_t req_opcode,
> +					uint8_t rsp_opcode, const void *param,
> +					uint16_t len)
> +{
> +	struct att_send_op *op = att->pending_req;
> +
> +	if (!op) {
> +		/* There is no pending request so the response is unexpected. */
> +		wakeup_writer(att);
> +		return false;
> +	}
> +
> +	if (op->opcode != req_opcode) {
> +		/* The request opcode corresponding to the received response
> +		 * opcode does not match the currently pending request.
> +		 */
> +		return false;
> +	}
> +
> +	if (op->callback)
> +		op->callback(rsp_opcode, param, len, op->user_data);
> +
> +	destroy_att_send_op(op);
> +	att->pending_req = NULL;
> +
> +	wakeup_writer(att);
> +	return true;
> +}
> +
> +static bool handle_error_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> +								ssize_t pdu_len)
> +{
> +	struct bt_att_error_rsp_param param;
> +	bool result;
> +
> +	if (pdu_len != 5)
> +		return false;
> +
> +	memset(&param, 0, sizeof(param));
> +	param.request_opcode = pdu[1];
> +	param.handle = get_le16(pdu + 2);
> +	param.error_code = pdu[4];
> +
> +	/* Note: avoid a tail call here, since "param" would go out of scope
> +	 * due to tail call optimization.
> +	 */
> +	result = request_complete(att, param.request_opcode, opcode,
> +							&param, sizeof(param));
> +	return result;
> +}
> +
> +static bool handle_mtu_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> +								ssize_t pdu_len)
> +{
> +	struct bt_att_mtu_rsp_param param;
> +	bool result;
> +
> +	if (pdu_len != 3)
> +		return false;
> +
> +	memset(&param, 0, sizeof(param));
> +	param.server_rx_mtu = get_le16(pdu + 1);
> +
> +	/* Note: avoid a tail call here, since "param" would go out of scope
> +	 * due to tail call optimization.
> +	 */
> +	result = request_complete(att, BT_ATT_OP_MTU_REQ, opcode,
> +							&param, sizeof(param));
> +	return result;
> +}

I am still not buying this tail call optimization. However we might need to thing about how we can make sure we do not need this. It feels bad to me every time I look at it. However this is not something that holds up merging this patchset. It is just something that I prefer to get somehow worked out. Especially since I am afraid we have then similar issues in the whole codebase if this holds true. Maybe we need a magic gcc option.

> +
> +static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> +								ssize_t pdu_len)
> +{
> +	bool success;
> +
> +	switch (opcode) {
> +	case BT_ATT_OP_ERROR_RSP:
> +		success = handle_error_rsp(att, opcode, pdu, pdu_len);
> +		break;
> +	case BT_ATT_OP_MTU_RSP:
> +		success = handle_mtu_rsp(att, opcode, pdu, pdu_len);
> +		break;
> +	default:
> +		success = false;
> +		util_debug(att->debug_callback, att->debug_data,
> +				"Unknown response opcode: 0x%02x", opcode);
> +		break;
> +	}
> +
> +	if (success)
> +		return;
> +
> +	util_debug(att->debug_callback, att->debug_data,
> +			"Failed to handle respone PDU; opcode: 0x%02x", opcode);
> +
> +	if (att->pending_req)
> +		request_complete(att, att->pending_req->opcode,
> +						BT_ATT_OP_ERROR_RSP, NULL, 0);
> +}
> +
> static bool can_read_data(struct io *io, void *user_data)
> {
> 	struct bt_att *att = user_data;
> +	uint8_t opcode;
> 	uint8_t *pdu;
> 	ssize_t bytes_read;
> 
> @@ -420,7 +522,20 @@ static bool can_read_data(struct io *io, void *user_data)
> 	if (bytes_read < ATT_MIN_PDU_LEN)
> 		return true;
> 
> -	/* TODO: Handle different types of PDUs here */
> +	pdu = att->buf;
> +	opcode = pdu[0];
> +
> +	/* Act on the received PDU based on the opcode type */
> +	switch (get_op_type(opcode)) {
> +	case ATT_OP_TYPE_RSP:
> +		handle_rsp(att, opcode, pdu, bytes_read);
> +		break;
> +	default:
> +		util_debug(att->debug_callback, att->debug_data,
> +				"ATT opcode cannot be handled: 0x%02x", opcode);
> +		break;
> +	}
> +
> 	return true;
> }

Regards

Marcel

