Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ 04/11] shared/att: Support multiple disconnect handlers.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408565737-8187-5-git-send-email-armansito@chromium.org>
Date: Thu, 21 Aug 2014 13:28:38 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4782A56B-01A3-40AA-82F2-D7933E982FA4@holtmann.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org> <1408565737-8187-5-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch adds support for registering multiple disconnect handlers with an
> instance of struct bt_att. Unregistering is achieved via a new function AND
> through bt_att_unregister_all and all disconnect callbacks get automatically
> unregistered after a single disconnect event.
> ---
> src/shared/att.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++---------
> src/shared/att.h |   9 ++--
> 2 files changed, 137 insertions(+), 27 deletions(-)
> 
> diff --git a/src/shared/att.c b/src/shared/att.c
> index b5ab742..68a57f9 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -60,6 +60,10 @@ struct bt_att {
> 	bool in_notify;
> 	bool need_notify_cleanup;
> 
> +	struct queue *disconn_list;	/* List of disconnect handlers */
> +	bool in_disconn;
> +	bool need_disconn_cleanup;
> +
> 	uint8_t *buf;
> 	uint16_t mtu;
> 
> @@ -73,10 +77,6 @@ struct bt_att {
> 	bt_att_debug_func_t debug_callback;
> 	bt_att_destroy_func_t debug_destroy;
> 	void *debug_data;
> -
> -	bt_att_disconnect_func_t disconn_callback;
> -	bt_att_destroy_func_t disconn_destroy;
> -	void *disconn_data;
> };
> 
> enum att_op_type {
> @@ -233,6 +233,46 @@ static void mark_notify_removed(void *data, void *user_data)
> 	notify->removed = true;
> }
> 
> +struct att_disconn {
> +	unsigned int id;
> +	bool removed;
> +	bt_att_disconnect_func_t callback;
> +	bt_att_destroy_func_t destroy;
> +	void *user_data;
> +};
> +
> +static void destroy_att_disconn(void *data)
> +{
> +	struct att_disconn *disconn = data;
> +
> +	if (disconn->destroy)
> +		disconn->destroy(disconn->user_data);
> +
> +	free(disconn);
> +}
> +
> +static bool match_disconn_id(const void *a, const void *b)
> +{
> +	const struct att_disconn *disconn = a;
> +	unsigned int id = PTR_TO_UINT(b);
> +
> +	return disconn->id == id;
> +}
> +
> +static bool match_disconn_removed(const void *a, const void *b)
> +{
> +	const struct att_disconn *disconn = a;
> +
> +	return disconn->removed;
> +}
> +
> +static void mark_disconn_removed(void *data, void *user_data)
> +{
> +	struct att_disconn *disconn = data;
> +
> +	disconn->removed = true;
> +}
> +
> static bool encode_pdu(struct att_send_op *op, const void *pdu,
> 						uint16_t length, uint16_t mtu)
> {
> @@ -605,21 +645,42 @@ static bool can_read_data(struct io *io, void *user_data)
> 	return true;
> }
> 
> +static void disconn_handler(void *data, void *user_data)
> +{
> +	struct att_disconn *disconn = data;
> +
> +	if (disconn->removed)
> +		return;
> +
> +	if (disconn->callback)
> +		disconn->callback(disconn->user_data);
> +}
> +
> static bool disconnect_cb(struct io *io, void *user_data)
> {
> 	struct bt_att *att = user_data;
> 
> -	bt_att_cancel_all(att);
> -	bt_att_unregister_all(att);
> -
> 	io_destroy(att->io);
> 	att->io = NULL;
> 
> 	util_debug(att->debug_callback, att->debug_data,
> 						"Physical link disconnected");
> 
> -	if (att->disconn_callback)
> -		att->disconn_callback(att->disconn_data);
> +	bt_att_ref(att);
> +	att->in_disconn = true;
> +	queue_foreach(att->disconn_list, disconn_handler, NULL);
> +	att->in_disconn = false;
> +
> +	if (att->need_disconn_cleanup) {
> +		queue_remove_all(att->disconn_list, match_disconn_removed, NULL,
> +							destroy_att_disconn);
> +		att->need_disconn_cleanup = false;
> +	}
> +
> +	bt_att_cancel_all(att);
> +	bt_att_unregister_all(att);
> +
> +	bt_att_unref(att);
> 
> 	return false;
> }
> @@ -662,6 +723,10 @@ struct bt_att *bt_att_new(int fd)
> 	if (!att->notify_list)
> 		goto fail;
> 
> +	att->disconn_list = queue_new();
> +	if (!att->disconn_list)
> +		goto fail;
> +
> 	if (!io_set_read_handler(att->io, can_read_data, att, NULL))
> 		goto fail;
> 
> @@ -674,6 +739,8 @@ fail:
> 	queue_destroy(att->req_queue, NULL);
> 	queue_destroy(att->ind_queue, NULL);
> 	queue_destroy(att->write_queue, NULL);
> +	queue_destroy(att->notify_list, NULL);
> +	queue_destroy(att->disconn_list, NULL);
> 	io_destroy(att->io);
> 	free(att->buf);
> 	free(att);
> @@ -709,6 +776,7 @@ void bt_att_unref(struct bt_att *att)
> 	queue_destroy(att->ind_queue, NULL);
> 	queue_destroy(att->write_queue, NULL);
> 	queue_destroy(att->notify_list, NULL);
> +	queue_destroy(att->disconn_list, NULL);
> 	att->req_queue = NULL;
> 	att->ind_queue = NULL;
> 	att->write_queue = NULL;
> @@ -720,9 +788,6 @@ void bt_att_unref(struct bt_att *att)
> 	if (att->debug_destroy)
> 		att->debug_destroy(att->debug_data);
> 
> -	if (att->disconn_destroy)
> -		att->disconn_destroy(att->disconn_data);
> -
> 	free(att->buf);
> 	att->buf = NULL;
> 
> @@ -800,20 +865,57 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
> 	return true;
> }
> 
> -bool bt_att_set_disconnect_cb(struct bt_att *att,
> +unsigned int bt_att_register_disconnect_handler(struct bt_att *att,
> 					bt_att_disconnect_func_t callback,
> 					void *user_data,
> 					bt_att_destroy_func_t destroy)
> {
> -	if (!att)
> +	struct att_disconn *disconn;
> +
> +	if (!att || !att->io)
> +		return 0;
> +
> +	disconn = new0(struct att_disconn, 1);
> +	if (!disconn)
> +		return 0;
> +
> +	disconn->callback = callback;
> +	disconn->destroy = destroy;
> +	disconn->user_data = user_data;
> +
> +	if (att->next_reg_id < 1)
> +		att->next_reg_id = 1;
> +
> +	disconn->id = att->next_reg_id++;
> +
> +	if (!queue_push_tail(att->disconn_list, disconn)) {
> +		free(disconn);
> +		return 0;
> +	}
> +
> +	return disconn->id;
> +}
> +
> +bool bt_att_unregister_disconnect_handler(struct bt_att *att, unsigned int id)
> +{
> +	struct att_disconn *disconn;
> +
> +	if (!att || !id)
> 		return false;
> 
> -	if (att->disconn_destroy)
> -		att->disconn_destroy(att->disconn_data);
> +	disconn = queue_find(att->disconn_list, match_disconn_id,
> +							UINT_TO_PTR(id));
> +	if (!disconn)
> +		return false;
> +
> +	if (!att->in_disconn) {
> +		queue_remove(att->disconn_list, disconn);
> +		destroy_att_disconn(disconn);
> +		return true;
> +	}
> 
> -	att->disconn_callback = callback;
> -	att->disconn_destroy = destroy;
> -	att->disconn_data = user_data;
> +	disconn->removed = true;
> +	att->need_disconn_cleanup = true;
> 
> 	return true;
> }
> @@ -996,14 +1098,21 @@ bool bt_att_unregister_all(struct bt_att *att)
> 	if (!att)
> 		return false;
> 
> -	if (!att->in_notify) {
> +	if (att->in_notify) {
> +		queue_foreach(att->notify_list, mark_notify_removed, NULL);
> +		att->need_notify_cleanup = true;
> +	} else {
> 		queue_remove_all(att->notify_list, NULL, NULL,
> 							destroy_att_notify);
> -		return true;
> 	}
> 
> -	queue_foreach(att->notify_list, mark_notify_removed, NULL);
> -	att->need_notify_cleanup = true;
> +	if (att->in_disconn) {
> +		queue_foreach(att->disconn_list, mark_disconn_removed, NULL);
> +		att->need_disconn_cleanup = true;
> +	} else {
> +		queue_remove_all(att->disconn_list, NULL, NULL,
> +							destroy_att_disconn);
> +	}
> 
> 	return true;
> }
> diff --git a/src/shared/att.h b/src/shared/att.h
> index cf44704..3180d2c 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -54,10 +54,6 @@ bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu);
> bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
> 						void *user_data,
> 						bt_att_destroy_func_t destroy);
> -bool bt_att_set_disconnect_cb(struct bt_att *att,
> -					bt_att_disconnect_func_t callback,
> -					void *user_data,
> -					bt_att_destroy_func_t destroy);
> 
> unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
> 					const void *pdu, uint16_t length,
> @@ -72,4 +68,9 @@ unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
> 						void *user_data,
> 						bt_att_destroy_func_t destroy);
> bool bt_att_unregister(struct bt_att *att, unsigned int id);
> +unsigned int bt_att_register_disconnect_handler(struct bt_att *att,
> +					bt_att_disconnect_func_t callback,
> +					void *user_data,
> +					bt_att_destroy_func_t destroy);
> +bool bt_att_unregister_disconnect_handler(struct bt_att *att, unsigned int id);

lets just make it bt_att_{register,unregister}_disconnect here. At some point we need to try to avoid super long function names.

Regards

Marcel

