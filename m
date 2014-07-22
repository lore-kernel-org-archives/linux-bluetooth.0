Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 03/11] shared/gatt: Implement "Discover All Primary Services" procedure.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405718037-15401-4-git-send-email-armansito@chromium.org>
Date: Wed, 23 Jul 2014 01:23:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <63491528-A612-40A9-BB08-2C0983555865@holtmann.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org> <1405718037-15401-4-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch implements bt_gatt_discover_primary_services for the case when no
> UUID is provided.
> ---
> src/shared/gatt-helpers.c | 197 +++++++++++++++++++++++++++++++++++++++++++++-
> src/shared/gatt-helpers.h |   1 +
> 2 files changed, 196 insertions(+), 2 deletions(-)
> 
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index 9cf05cf..4fbf2eb 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -36,6 +36,11 @@
> #define MIN(a, b) ((a) < (b) ? (a) : (b))
> #endif
> 
> +static uint8_t bt_base_uuid[16] = {
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
> +	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
> +};
> +

as a general rule, make these const as well.

> struct mtu_op {
> 	struct bt_att *att;
> 	uint16_t client_rx_mtu;
> @@ -123,14 +128,202 @@ bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
> 	return true;
> }
> 
> +struct discovery_op {
> +	struct bt_att *att;
> +	int ref_count;
> +	bt_uuid_t uuid;
> +	struct queue *results;
> +	bt_gatt_discovery_callback_t callback;
> +	void *user_data;
> +	bt_gatt_destroy_func_t destroy;
> +};
> +
> +static struct discovery_op* discovery_op_ref(struct discovery_op *op)
> +{
> +	__sync_fetch_and_add(&op->ref_count, 1);
> +
> +	return op;
> +}
> +
> +static void discovery_op_unref(void *data)
> +{
> +	struct discovery_op *op = data;
> +
> +	if (__sync_sub_and_fetch(&op->ref_count, 1))
> +		return;
> +
> +	if (op->destroy)
> +		op->destroy(op->user_data);
> +
> +	queue_destroy(op->results, free);
> +
> +	free(op);
> +}
> +
> +static void put_uuid_le(const bt_uuid_t *src, void *dst)
> +{
> +	if (src->type == BT_UUID16)
> +		put_le16(src->value.u16, dst);
> +	else
> +		bswap_128(&src->value.u128, dst);
> +}

Actually 32-bit UUIDs are defined for GATT internally. It just for the wire protocol, the 32-bit UUID always needs to be converted to 128-bit. So you might want to take care of this detail here as well.

> +
> +static bool convert_uuid_le(const uint8_t *src, size_t len, uint8_t dst[16])
> +{
> +	if (len == 16) {
> +		bswap_128(src, dst);
> +		return true;
> +	}
> +
> +	if (len != 2)
> +		return false;
> +
> +	memcpy(dst, bt_base_uuid, sizeof(bt_base_uuid));
> +	dst[2] = src[1];
> +	dst[3] = src[0];
> +
> +	return true;
> +}
> +
> +static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
> +					uint16_t length, void *user_data)
> +{
> +	struct discovery_op *op = user_data;
> +	uint16_t status;
> +	struct queue *results = NULL;
> +	size_t data_length;
> +	size_t list_length;
> +	uint16_t last_end;
> +	int i;
> +
> +	if (opcode == BT_ATT_OP_ERROR_RSP) {
> +		status = process_error(pdu, length);
> +
> +		if (status == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
> +						!queue_isempty(op->results))
> +			goto success;
> +
> +		goto done;
> +	}
> +
> +	/* PDU must contain at least the following (sans opcode):
> +	 * - Attr Data Length (1 octet)
> +	 * - Attr Data List (at least 6 octets):
> +	 *   -- 2 octets: Attribute handle
> +	 *   -- 2 octets: End group handle
> +	 *   -- 2 or 16 octets: service UUID
> +	 */
> +	if (opcode != BT_ATT_OP_READ_BY_GRP_TYPE_RSP || !pdu || length < 7) {
> +		status = BT_GATT_ERROR_INVALID_RSP;
> +		goto done;
> +	}
> +
> +	data_length = ((uint8_t *) pdu)[0];
> +	list_length = length - 1;
> +
> +	if ((list_length % data_length) ||
> +				(data_length != 6 && data_length != 20)) {
> +		status = BT_GATT_ERROR_INVALID_RSP;
> +		goto done;
> +	}
> +
> +	for (i = 1; i < length; i += data_length) {
> +		struct bt_gatt_service *service;
> +
> +		service = new0(struct bt_gatt_service, 1);
> +		if (!service) {
> +			status = BT_GATT_ERROR_FAILED_ALLOC;
> +			goto done;
> +		}
> +
> +		service->start = get_le16(pdu + i);
> +		last_end = get_le16(pdu + i + 2);
> +		service->end = last_end;
> +		convert_uuid_le(pdu + i + 4, data_length - 4, service->uuid);
> +
> +		queue_push_tail(op->results, service);
> +	}
> +
> +	if (last_end != 0xFFFF) {

Generally we do 0xffff in lower-case. There might cases in the code that do not follow this as strictly, but we should not introduce new code doing the same thing.

> +		uint8_t pdu[6];
> +
> +		put_le16(last_end + 1, pdu);
> +		put_le16(0xFFFF, pdu + 2);
> +		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);

So I have no problem in doing initially manual PDU building this way, but I thing latest in follow up patches we need to introduce packed structs (where it makes sense since the data is static). If we don't, then this get easily out of control and the code becomes really hard to read later on since it is not obvious what PDU you are building.

> +
> +		if (bt_att_send(op->att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
> +							pdu, sizeof(pdu),
> +							read_by_grp_type_cb,
> +							discovery_op_ref(op),
> +							discovery_op_unref))
> +			return;
> +
> +		discovery_op_unref(op);
> +		status = BT_GATT_ERROR_UNKNOWN;
> +		goto done;
> +	}
> +
> +success:
> +	/* End of procedure */
> +	results = op->results;
> +	status = 0;
> +
> +done:
> +	if (op->callback)
> +		op->callback(status, results, op->user_data);
> +}
> +
> bool bt_gatt_discover_primary_services(struct bt_att *att,
> 					bt_uuid_t *uuid,
> 					bt_gatt_discovery_callback_t callback,
> 					void *user_data,
> 					bt_gatt_destroy_func_t destroy)
> {
> -	/* TODO */
> -	return false;
> +	struct discovery_op *op;
> +	bool result;
> +
> +	if (!att)
> +		return false;
> +
> +	op = new0(struct discovery_op, 1);
> +	if (!op)
> +		return false;
> +
> +	op->results = queue_new();
> +	if (!op->results) {
> +		free(op);
> +		return false;
> +	}
> +
> +	op->att = att;
> +	op->callback = callback;
> +	op->user_data = user_data;
> +	op->destroy = destroy;
> +
> +	/* If UUID is NULL, then discover all primary services */
> +	if (!uuid) {
> +		uint8_t pdu[6];
> +
> +		put_le16(0x0001, pdu);
> +		put_le16(0xFFFF, pdu + 2);
> +		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
> +
> +		result = bt_att_send(att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
> +							pdu, sizeof(pdu),
> +							read_by_grp_type_cb,
> +							discovery_op_ref(op),
> +							discovery_op_unref);
> +	} else {
> +		free(op);
> +		return false;
> +	}
> +
> +	if (!result) {
> +		queue_destroy(op->results, free);
> +		free(op);
> +	}
> +
> +	return result;
> }
> 
> bool bt_gatt_discover_included_services(struct bt_att *att,
> diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
> index b711324..068c4bb 100644
> --- a/src/shared/gatt-helpers.h
> +++ b/src/shared/gatt-helpers.h
> @@ -62,6 +62,7 @@ struct bt_gatt_descriptor {
>  */
> #define BT_GATT_ERROR_UNKNOWN		0x0100
> #define BT_GATT_ERROR_INVALID_RSP	0x0101
> +#define BT_GATT_ERROR_FAILED_ALLOC	0x0102
> 
> typedef void (*bt_gatt_destroy_func_t)(void *user_data);

Regards

Marcel

