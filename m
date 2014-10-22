Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 03/14] shared/gatt: Discover included services 128 bit UUIDS
Date: Wed, 22 Oct 2014 20:43:42 +0200
Message-ID: <3896657.u0WVNEEou6@athlon>
In-Reply-To: <1413454646-23076-4-git-send-email-marcin.kraglak@tieto.com>
References: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com> <1413454646-23076-4-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 16 October 2014 12:17:15 Marcin Kraglak wrote:
> If included services has 128 bit UUID, it won't be returned in
> READ_BY_TYPE_RSP. To get UUID READ_REQUEST is used.
> This procedure is described in CORE SPEC 4.5.1 "Find Included Services".
> ---
>  src/shared/gatt-helpers.c | 170
> +++++++++++++++++++++++++++++++++++++++++++++- 1 file changed, 169
> insertions(+), 1 deletion(-)
> 
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index dcb2a2f..c18f738 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -692,6 +692,160 @@ bool bt_gatt_discover_secondary_services(struct bt_att
> *att, bt_uuid_t *uuid, destroy, false);
>  }
> 
> +struct read_incl_data {
> +	struct discovery_op *op;
> +	struct bt_gatt_result *result;
> +	int pos;
> +	int ref_count;
> +};
> +
> +static struct read_incl_data *new_read_included(struct bt_gatt_result *res)
> +{
> +	struct read_incl_data *data;
> +
> +	data = new0(struct read_incl_data, 1);
> +	if (!data)
> +		return NULL;
> +
> +	data->op = discovery_op_ref(res->op);
> +	data->result = res;
> +
> +	return data;
> +};
> +
> +static struct read_incl_data *read_included_ref(struct read_incl_data
> *data) +{
> +	__sync_fetch_and_add(&data->ref_count, 1);
> +
> +	return data;
> +}
> +
> +static void read_included_unref(void *data)
> +{
> +	struct read_incl_data *read_data = data;
> +
> +	if (__sync_sub_and_fetch(&read_data->ref_count, 1))
> +		return;
> +
> +	discovery_op_unref(read_data->op);
> +
> +	free(read_data);
> +}
> +
> +static void discover_included_cb(uint8_t opcode, const void *pdu,
> +					uint16_t length, void *user_data);
> +
> +static void read_included_cb(uint8_t opcode, const void *pdu,
> +					uint16_t length, void *user_data)
> +{
> +	struct read_incl_data *data = user_data;
> +	struct bt_gatt_result *final_result = NULL;
> +	struct discovery_op *op = data->op;
> +	struct bt_gatt_result *cur_result;
> +	uint8_t att_ecode = 0;
> +	uint16_t handle;
> +	uint8_t read_pdu[2];
> +	bool success;
> +
> +	if (opcode == BT_ATT_OP_ERROR_RSP) {
> +		success = false;
> +		att_ecode = process_error(pdu, length);
> +		goto done;
> +	}
> +
> +	if (opcode != BT_ATT_OP_READ_RSP || (!pdu && length)) {
> +		success = false;
> +		goto done;
> +	}
> +
> +	if (length != 16) {

I think we should have those magic numbers defined (this is more general 
comment since more code here uses magic values). It might be clear for you now 
why this must be 16 but won't be in 2 months :)

> +		success = false;
> +		goto done;
> +	}



Empty line here.

> +	cur_result = result_create(opcode, pdu, length, length, op);
> +	if (!cur_result) {
> +		success = false;
> +		goto done;
> +	}
> +
> +	if (!op->result_head)
> +		op->result_head = op->result_tail = cur_result;

Braces on both branches.

> +	else {
> +		op->result_tail->next = cur_result;
> +		op->result_tail = cur_result;
> +	}
> +
> +	if (data->pos == data->result->pdu_len) {
> +		uint16_t last_handle, data_len;
> +		uint8_t pdu[6];
> +
> +		data_len = data->result->data_len;
> +		last_handle = get_le16(data->result->pdu + data->pos -
> +								data_len);

This data_len variable doesn't make code clearer.

> +		if (last_handle == op->end_handle) {
> +			final_result = op->result_head;
> +			success = true;
> +			goto done;
> +		}
> +
> +		put_le16(last_handle + 1, pdu);
> +		put_le16(op->end_handle, pdu + 2);
> +		put_le16(GATT_INCLUDE_UUID, pdu + 4);
> +
> +		if (bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
> +						pdu, sizeof(pdu),
> +						discover_included_cb,
> +						discovery_op_ref(op),
> +						discovery_op_unref))

This should fit just in 2 lines, instead of 4.

> +			return;
> +
> +		discovery_op_unref(op);
> +		success = false;
> +		goto done;
> +	}
> +
> +	handle = get_le16(data->result->pdu + data->pos + 2);
> +	put_le16(handle, read_pdu);

So if both are LE value why not just memcpy() here?

> +
> +	data->pos += data->result->data_len;
> +
> +	if (bt_att_send(op->att, BT_ATT_OP_READ_REQ, read_pdu, sizeof(read_pdu),
> +							read_included_cb,
> +							read_included_ref(data),
> +							read_included_unref))

Ditto.

> +		return;
> +
> +	read_included_unref(data);
> +	success = false;
> +
> +done:
> +	if (op->callback)
> +		op->callback(success, att_ecode, final_result, op->user_data);
> +}
> +
> +static void read_included(struct read_incl_data *data)
> +{
> +	struct discovery_op *op = data->op;
> +	uint16_t handle;
> +	uint8_t pdu[2];
> +
> +	handle = get_le16(data->result->pdu + 2);
> +	put_le16(handle, pdu);

memcpy

> +
> +	data->pos += data->result->data_len;
> +
> +	if (bt_att_send(op->att, BT_ATT_OP_READ_REQ, pdu, sizeof(pdu),
> +							read_included_cb,
> +							read_included_ref(data),
> +							read_included_unref))
> +		return;
> +
> +	read_included_unref(data);
> +
> +	if (op->callback)
> +		op->callback(false, 0, NULL, data->op->user_data);
> +}
> +
>  static void discover_included_cb(uint8_t opcode, const void *pdu,
>  					uint16_t length, void *user_data)
>  {
> @@ -721,7 +875,8 @@ static void discover_included_cb(uint8_t opcode, const
> void *pdu,
> 
>  	data_length = ((uint8_t *) pdu)[0];
> 
> -	if ((length - 1) % data_length || data_length != 8) {
> +	if (((length - 1) % data_length) ||
> +				(data_length != 8 && data_length != 6)) {
>  		success = false;
>  		goto done;
>  	}
> @@ -740,6 +895,19 @@ static void discover_included_cb(uint8_t opcode, const
> void *pdu, op->result_tail = cur_result;
>  	}
> 
> +	if (data_length == 6) {
> +		struct read_incl_data *data;
> +
> +		data = new_read_included(cur_result);
> +		if (!data) {
> +			success = false;
> +			goto done;
> +		}
> +
> +		read_included(data);
> +		return;
> +	}
> +
>  	last_handle = get_le16(pdu + length - data_length);
>  	if (last_handle != op->end_handle) {
>  		uint8_t pdu[6];

-- 
Szymon K. Janc
szymon.janc@gmail.com
