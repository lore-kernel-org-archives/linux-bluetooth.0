Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ v1 4/7] shared/gatt-client: Handle incoming not/ind PDUs.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410282249-22004-5-git-send-email-armansito@chromium.org>
Date: Tue, 9 Sep 2014 15:58:23 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B3B84C22-937B-4880-B59F-0CFA680192D1@holtmann.org>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org> <1410282249-22004-5-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> bt_gatt_client now registers an incoming PDU handler for notification and
> indication PDUs. The PDU is parsed and routed to the notify handler registered
> with bt_gatt_client_register_notify for the corresponding characteristic value
> handle. A confirmation PDU is sent automatically for received indications.
> 
> This patch removes the bt_gatt_register function from shared/gatt-helpers.
> ---
> src/shared/gatt-client.c  | 120 ++++++++++++++++++++++++++++++++++++++++++----
> src/shared/gatt-helpers.c |  67 --------------------------
> src/shared/gatt-helpers.h |   9 ----
> 3 files changed, 110 insertions(+), 86 deletions(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index d68c8aa..d3c9225 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -97,6 +97,9 @@ struct bt_gatt_client {
> 	/* List of registered notification/indication callbacks */
> 	struct queue *notify_list;
> 	int next_reg_id;
> +	unsigned int notify_id, indic_id;

I have never seen indication shorted into indic. I have to say that I do not like it that much. However I do not have any good suggestion either.

> +	bool in_notify;
> +	bool need_notify_cleanup;
> };
> 
> static bool gatt_client_add_service(struct bt_gatt_client *client,
> @@ -575,6 +578,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
> 
> struct notify_data {
> 	struct bt_gatt_client *client;
> +	bool removed;
> 	unsigned int id;
> 	int ref_count;
> 	struct chrc_data *chrc;
> @@ -612,6 +616,18 @@ static bool match_notify_data_id(const void *a, const void *b)
> 	return notify_data->id == id;
> }
> 
> +static bool match_notify_data_removed(const void *a, const void *b)
> +{
> +	const struct notify_data *notify_data = a;
> +
> +	return notify_data->removed;
> +}
> +
> +struct pdu_data {
> +	const void *pdu;
> +	uint16_t length;
> +};
> +
> static void complete_notify_request(void *data)
> {
> 	struct notify_data *notify_data = data;
> @@ -638,6 +654,7 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
> {
> 	uint8_t pdu[4];
> 
> +	assert(notify_data->chrc->ccc_handle);

You are going heavy on the asserts. I am not convinced that is always a good idea. If remote devices can exploit such an assert, we have a problem. Gracefully disconnect might be better in many cases.

Regards

Marcel

