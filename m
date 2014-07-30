Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] shared/gatt: Use iterator based discovery result structure.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406664949-25196-1-git-send-email-armansito@chromium.org>
Date: Wed, 30 Jul 2014 09:42:27 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B1DE8040-EA3D-4B9B-9649-033A8FB49F46@holtmann.org>
References: <1406664949-25196-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch changes the GATT specific linked list structure in gatt-helpers to
> bt_gatt_result and bt_gatt_iter. bt_gatt_result internally stores a linked list
> of ATT response PDUs, which get decoded on-demand by the iterator functions.
> Each iterator function operates on a specific ATT response PDU.
> ---
> src/shared/gatt-helpers.c | 577 +++++++++++++++++++++++-----------------------
> src/shared/gatt-helpers.h |  21 +-
> 2 files changed, 309 insertions(+), 289 deletions(-)
> 
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index 489b8c4..c237b00 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -36,69 +36,207 @@
> #define MIN(a, b) ((a) < (b) ? (a) : (b))
> #endif
> 
> -struct bt_gatt_list {
> -	struct bt_gatt_list *next;
> -	void *data;
> -};
> +struct bt_gatt_result {
> +	uint8_t opcode;
> +	void *pdu;
> +	uint16_t pdu_len;
> +	uint16_t data_len;
> +
> +	void *op;  /* Discovery operation data */
> 
> -struct list_ptrs {
> -	struct bt_gatt_list *head;
> -	struct bt_gatt_list *tail;
> +	struct bt_gatt_result *next;
> };
> 
> -struct bt_gatt_list *bt_gatt_list_get_next(struct bt_gatt_list *list)
> +static struct bt_gatt_result *result_create(uint8_t opcode, const void *pdu,
> +							uint16_t pdu_len,
> +							uint16_t data_len,
> +							void *op)
> {
> -	return list->next;
> +	struct bt_gatt_result *result = new0(struct bt_gatt_result, 1);
> +
> +	if (!result)
> +		return NULL;

I now that this saves a few lines of code, but I prefer that assignment of variables is only done with "static" value.

	result = new0(...
	if (!result)
		return NULL;

It has the visual advantage of having the NULL check right where you did the allocation.

> +
> +	result->pdu = malloc(pdu_len);
> +	if (!result->pdu) {
> +		free(result);
> +		return NULL;
> +	}
> +
> +	result->opcode = opcode;
> +	result->pdu_len = pdu_len;
> +	result->data_len = data_len;
> +	result->op = op;
> +
> +	memcpy(result->pdu, pdu, pdu_len);
> +
> +	return result;
> }
> 
> -void *bt_gatt_list_get_data(struct bt_gatt_list *list)
> +static void result_destroy(struct bt_gatt_result *result)
> {
> -	return list->data;
> +	struct bt_gatt_result *next;
> +
> +	while (result) {
> +		next = result->next;
> +
> +		free(result->pdu);
> +		free(result);
> +
> +		result = next;
> +	}
> }
> 
> -static inline bool list_isempty(struct list_ptrs *list)
> +bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct bt_gatt_result *result)
> {
> -	return !list->head && !list->tail;
> +	if (!iter || !result)
> +		return false;
> +
> +	iter->result = result;
> +	iter->pos = 0;
> +
> +	return true;
> }
> 
> -static bool list_add(struct list_ptrs *list, void *data)
> +static const uint8_t bt_base_uuid[16] = {
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
> +	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
> +};
> +
> +static bool convert_uuid_le(const uint8_t *src, size_t len, uint8_t dst[16])
> {
> -	struct bt_gatt_list *item = new0(struct bt_gatt_list, 1);
> -	if (!item)
> +	if (len == 16) {
> +		bswap_128(src, dst);
> +		return true;
> +	}
> +
> +	if (len != 2)
> 		return false;
> 
> -	item->data = data;
> +	memcpy(dst, bt_base_uuid, sizeof(bt_base_uuid));
> +	dst[2] = src[1];
> +	dst[3] = src[0];
> 
> -	if (list_isempty(list)) {
> -		list->head = list->tail = item;
> -		return true;
> +	return true;
> +}
> +
> +struct result_ptrs {
> +	struct bt_gatt_result *head;
> +	struct bt_gatt_result *tail;
> +};
> +
> +struct discovery_op {
> +	struct bt_att *att;
> +	uint16_t end_handle;
> +	int ref_count;
> +	bt_uuid_t uuid;
> +	struct result_ptrs result;

Does this nested struct give you any benefit. Why not just include head and tail pointers directly.

I was actually thinking that struct bt_gatt_result will keep the tail pointer all by itself. That way it is self-contained.

Regards

Marcel

