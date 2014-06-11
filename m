Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v3 4/4] src/shared/att: Handle incoming response PDUs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402364040-11502-5-git-send-email-armansito@chromium.org>
Date: Wed, 11 Jun 2014 14:03:19 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7FD20345-0246-4986-991C-DA9C24E6BFD1@holtmann.org>
References: <1402364040-11502-1-git-send-email-armansito@chromium.org> <1402364040-11502-5-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch adds handling for incoming ATT protocol response PDUs. Basic
> incoming PDU handling logic added to the io read handler.
> ---
> src/shared/att.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/src/shared/att.c b/src/shared/att.c
> index f3ece02..e967273 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -370,6 +370,109 @@ set_handler:
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
> +		/* There is no pending request so the response is unexpected.
> +		 * TODO: In such a case, the connection should be dropped
> +		 * entirely. For now, simply ignore the PDU.
> +		 */

is this what the specification say?

> +		wakeup_writer(att);
> +		return false;
> +	}
> +
> +	if (op->opcode != req_opcode)
> +		/* The request opcode corresponding to the received response
> +		 * opcode does not match the currently pending request.
> +		 * TODO: The connection should be dropped in this case, since
> +		 * an invalid response PDU has been received. For now, keep
> +		 * waiting for the correct response.
> +		 */
> +		return false;

In these case { } are a bit of sugar to make it easier on the eyes. The compiler knows what it is, but my brain gets confused too easy ;)

> +
> +	if (op->callback)
> +		op->callback(rsp_opcode, param, len, op->user_data);
> +
> +	destroy_att_send_op(op);
> +	att->pending_req = NULL;
> +
> +	if (!att->destroyed)
> +		wakeup_writer(att);

I would have done this:

	if (att->destroyed)
		return true;

	wakeup_writer(att);

I prefer it this way since it is easier to read when you go through the function. Especially with the att->destroyed cases for the reentrant support. We want to make it clear that we expect that object to be gone.

> +
> +	return true;
> +}
> +
> +static bool handle_error_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> +								ssize_t pdu_len)
> +{
> +	struct bt_att_error_rsp_param p;
> +	bool result;
> +
> +	if (pdu_len != 5)
> +		return false;
> +
> +	memset(&p, 0, sizeof(p));
> +	p.request_opcode = pdu[1];
> +	p.handle = get_le16(pdu + 2);
> +	p.error_code = pdu[4];
> +
> +	/* Note: avoid a tail call */

I do not get this comment. Explain please.

> +	result = request_complete(att, p.request_opcode, opcode, &p, sizeof(p));
> +	return result;

	return request_complete(..

> +}
> +
> +static bool handle_mtu_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> +								ssize_t pdu_len)
> +{
> +	struct bt_att_mtu_rsp_param p;
> +	bool result;
> +
> +	if (pdu_len != 3)
> +		return false;
> +
> +	memset(&p, 0, sizeof(p));
> +	p.server_rx_mtu = get_le16(pdu + 1);
> +
> +	/* Note: avoid a tail call */
> +	result = request_complete(att, BT_ATT_OP_MTU_REQ, opcode,
> +								&p, sizeof(p));
> +	return result;

See above.

> +}
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
> static void read_watch_destroy(void *user_data)
> {
> 	struct bt_att *att = user_data;
> @@ -389,6 +492,7 @@ static void read_watch_destroy(void *user_data)
> static bool can_read_data(struct io *io, void *user_data)
> {
> 	struct bt_att *att = user_data;
> +	uint8_t opcode;
> 	uint8_t *pdu;
> 	ssize_t bytes_read;
> 
> @@ -402,7 +506,19 @@ static bool can_read_data(struct io *io, void *user_data)
> 	if (bytes_read < ATT_MIN_PDU_LEN)
> 		goto done;
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
> 
> done:
> 	if (att->destroyed)

Regards

Marcel

