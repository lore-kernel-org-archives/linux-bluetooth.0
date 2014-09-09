Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ v1 3/7] shared/gatt-client: Implement bt_gatt_client_unregister_notify.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410282249-22004-4-git-send-email-armansito@chromium.org>
Date: Tue, 9 Sep 2014 15:54:48 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E36C3BAA-4294-4A20-95C8-91BF3A05E866@holtmann.org>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org> <1410282249-22004-4-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch implements bt_gatt_client_unregister_notify, which is used to remove
> a previous registered notification/indication handler. This function decreases
> the per-characteristic count of handlers, and if the count drops to 0, a write
> request is sent to the CCC descriptor to disable notifications/indications.
> ---
> src/shared/gatt-client.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 974fa1d..d68c8aa 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -604,6 +604,14 @@ static void notify_data_unref(void *data)
> 	free(notify_data);
> }
> 
> +static bool match_notify_data_id(const void *a, const void *b)
> +{
> +	const struct notify_data *notify_data = a;
> +	unsigned int id = PTR_TO_UINT(b);
> +
> +	return notify_data->id == id;
> +}
> +
> static void complete_notify_request(void *data)
> {
> 	struct notify_data *notify_data = data;
> @@ -706,7 +714,23 @@ static void enable_ccc_callback(uint8_t opcode, const void *pdu,
> static void disable_ccc_callback(uint8_t opcode, const void *pdu,
> 					uint16_t length, void *user_data)
> {
> -	/* TODO */
> +	struct notify_data *notify_data = user_data;
> +	struct notify_data *next_data;
> +
> +	assert(!notify_data->chrc->not_ref_count);
> +	assert(notify_data->chrc->ccc_write_id);
> +
> +	notify_data->chrc->ccc_write_id = 0;
> +
> +	/* This is a best effort procedure, so ignore errors and process any
> +	 * queued requests.
> +	 */
> +	while (1) {
> +		next_data = queue_pop_head(notify_data->chrc->reg_notify_queue);
> +		if (!next_data || notify_data_write_ccc(notify_data, true,
> +							enable_ccc_callback))
> +			return;
> +	}
> }
> 
> struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
> @@ -1667,6 +1691,30 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
> bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
> 							unsigned int id)
> {
> -	/* TODO */
> -	return false;
> +	struct notify_data *notify_data;
> +
> +	if (!client || !id)
> +		return false;
> +
> +	notify_data = queue_find(client->notify_list, match_notify_data_id,
> +							UINT_TO_PTR(id));
> +	if (!notify_data)
> +		return false;
> +
> +	assert(notify_data->chrc->not_ref_count > 0);
> +	assert(!notify_data->chrc->ccc_write_id);

do we really need the asserts. I think we should just fall gracefully and cleanup. After all this is an exposed API. I rather have it not assert. Same applies to the case above, really only assert if this is something that should not happen ever and if it did something really horrible went wrong.

> +
> +	/* TODO: Delay destruction/removal if we're in the middle of processing
> +	 * a notification.
> +	 */
> +	queue_remove(client->notify_list, notify_data);
> +
> +	if (__sync_sub_and_fetch(&notify_data->chrc->not_ref_count, 1)) {

I read "this is not a reference count" when I see this variable name. That is not good. We need clear and short variable names. Not some that will confuse the reader of the code.

> +		notify_data_unref(notify_data);
> +		return true;
> +	}
> +
> +	notify_data_write_ccc(notify_data, false, disable_ccc_callback);
> +
> +	return true;
> }

Regards

Marcel

