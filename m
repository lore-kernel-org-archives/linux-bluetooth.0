Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 01/11] shared/gatt: Introduce gatt-helpers.h skeleton.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406326123-10564-2-git-send-email-armansito@chromium.org>
Date: Sat, 26 Jul 2014 00:47:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <30A4ADE6-330B-451B-AF32-A32A6F17F2BF@holtmann.org>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org> <1406326123-10564-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces the skeleton for src/shared/gatt-helpers, which defines
> helper functions for over-the-air GATT client-side procedures that will be
> frequently used by clients. Most of these functions require several sequential
> ATT protocol requests and it is useful to abstract these details away from the
> upper layer.

<snip>

> 
> +struct bt_gatt_service {
> +	uint16_t start;
> +	uint16_t end;
> +	uint8_t uuid[16];
> +};
> +
> +struct bt_gatt_characteristic {
> +	uint16_t start;
> +	uint16_t end;
> +	uint16_t value;
> +	uint8_t properties;
> +	uint8_t uuid[16];
> +};
> +
> +struct bt_gatt_descriptor {
> +	uint16_t handle;
> +	uint8_t uuid[16];
> +};
> +
> +struct bt_gatt_list;
> +
> +struct bt_gatt_list *bt_gatt_list_get_next(struct bt_gatt_list *l);
> +void *bt_gatt_list_get_data(struct bt_gatt_list *l);
> +
> +typedef void (*bt_gatt_destroy_func_t)(void *user_data);
> +
> +typedef void (*bt_gatt_result_callback_t)(bool success, uint8_t att_ecode,
> +							void *user_data);
> +typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_ecode,
> +						struct bt_gatt_list *results,
> +						void *user_data);

what we have used a lot is the concept of an iterator in a lot of protocols that have complex return types. It makes it generic, flexible and most important it results in readable code.

	struct bt_gatt_result;
	struct bt_gatt_iter;

	bool bt_gatt_iter_init(struct bt_gatt_iter *iter,
				struct bt_gatt_result *result);

	bool bt_gatt_iter_next_uuid(struct bt_gatt_iter *iter,
					uint8_t *len, const uint8_t **uuid);


This means we could process the result of a list of UUIDs as simple as this:

	if (!bt_gatt_iter_init(&iter, result)
		return;

	while (bt_gatt_iter_next_uuid(&iter, &len, &uuid))
		printf("len %d uuid %p\n", len, uuid);

Possible other types could be _next_handle_range etc. If needed we could even allow one level nesting here.

One interesting advantage is that the bt_gatt_result could just store the result PDU as it is an we just return pointers to the next field. That would help us avoid having to copy data around.

For internal representation we might choose to allow linking multiple bt_gatt_result together and only return the head item. And then just let the bt_gatt_iter point to the next one when moved forward.

I went through the whole patchset and besides this detail, it looks pretty solid. I let others have a look at it as well. So we could start applying patches and then change to an iterator approach or you fix it up before applying. What do you think?

Regards

Marcel

