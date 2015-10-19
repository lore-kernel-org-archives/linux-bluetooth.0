Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 2/4] shared: Remove dead code
Date: Mon, 19 Oct 2015 23:42:50 +0200
Message-Id: <1445290972-18383-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes dead code due to memory allocation with new0 not being
able to fail.
---
 src/shared/ad.c               | 31 -----------------------
 src/shared/att.c              | 34 +------------------------
 src/shared/crypto.c           |  2 --
 src/shared/gap.c              |  7 -----
 src/shared/gatt-client.c      | 59 -------------------------------------------
 src/shared/gatt-db.c          | 37 ---------------------------
 src/shared/gatt-helpers.c     | 24 ------------------
 src/shared/gatt-server.c      | 47 ----------------------------------
 src/shared/hci-crypto.c       |  6 -----
 src/shared/hci.c              | 29 ---------------------
 src/shared/hfp.c              | 40 -----------------------------
 src/shared/io-mainloop.c      |  3 ---
 src/shared/mgmt.c             | 42 ------------------------------
 src/shared/queue.c            | 12 ---------
 src/shared/ringbuf.c          |  3 ---
 src/shared/tester.c           |  9 -------
 src/shared/timeout-mainloop.c |  3 ---
 src/shared/uhid.c             |  8 ------
 18 files changed, 1 insertion(+), 395 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 6259eb9..1bf013d 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -42,36 +42,12 @@ struct bt_ad *bt_ad_new(void)
 	struct bt_ad *ad;
 
 	ad = new0(struct bt_ad, 1);
-	if (!ad)
-		return NULL;
-
 	ad->service_uuids = queue_new();
-	if (!ad->service_uuids)
-		goto fail;
-
 	ad->manufacturer_data = queue_new();
-	if (!ad->manufacturer_data)
-		goto fail;
-
 	ad->solicit_uuids = queue_new();
-	if (!ad->solicit_uuids)
-		goto fail;
-
 	ad->service_data = queue_new();
-	if (!ad->service_data)
-		goto fail;
 
 	return bt_ad_ref(ad);
-
-fail:
-	queue_destroy(ad->service_uuids, NULL);
-	queue_destroy(ad->manufacturer_data, NULL);
-	queue_destroy(ad->solicit_uuids, NULL);
-	queue_destroy(ad->service_data, NULL);
-
-	free(ad);
-
-	return NULL;
 }
 
 struct bt_ad *bt_ad_ref(struct bt_ad *ad)
@@ -373,8 +349,6 @@ static bool queue_add_uuid(struct queue *queue, const bt_uuid_t *uuid)
 		return false;
 
 	new_uuid = new0(bt_uuid_t, 1);
-	if (!new_uuid)
-		return false;
 
 	*new_uuid = *uuid;
 
@@ -466,9 +440,6 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 	}
 
 	new_data = new0(struct bt_ad_manufacturer_data, 1);
-	if (!new_data)
-		return false;
-
 	new_data->manufacturer_id = manufacturer_id;
 
 	new_data->data = malloc(len);
@@ -605,8 +576,6 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 	}
 
 	new_data = new0(struct bt_ad_service_data, 1);
-	if (!new_data)
-		return false;
 
 	new_data->uuid = *uuid;
 
diff --git a/src/shared/att.c b/src/shared/att.c
index d88169e..0edc941 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -343,9 +343,6 @@ static struct att_send_op *create_att_send_op(struct bt_att *att,
 		return NULL;
 
 	op = new0(struct att_send_op, 1);
-	if (!op)
-		return NULL;
-
 	op->type = op_type;
 	op->opcode = opcode;
 	op->callback = callback;
@@ -496,9 +493,6 @@ static bool can_write_data(struct io *io, void *user_data)
 	}
 
 	timeout = new0(struct timeout_data, 1);
-	if (!timeout)
-		return true;
-
 	timeout->att = att;
 	timeout->id = op->id;
 	op->timeout_id = timeout_add(ATT_TIMEOUT_INTERVAL, timeout_cb,
@@ -957,9 +951,6 @@ struct bt_att *bt_att_new(int fd, bool ext_signed)
 		return NULL;
 
 	att = new0(struct bt_att, 1);
-	if (!att)
-		return NULL;
-
 	att->fd = fd;
 	att->mtu = BT_ATT_DEFAULT_LE_MTU;
 	att->buf = malloc(att->mtu);
@@ -975,24 +966,10 @@ struct bt_att *bt_att_new(int fd, bool ext_signed)
 		att->crypto = bt_crypto_new();
 
 	att->req_queue = queue_new();
-	if (!att->req_queue)
-		goto fail;
-
 	att->ind_queue = queue_new();
-	if (!att->ind_queue)
-		goto fail;
-
 	att->write_queue = queue_new();
-	if (!att->write_queue)
-		goto fail;
-
 	att->notify_list = queue_new();
-	if (!att->notify_list)
-		goto fail;
-
 	att->disconn_list = queue_new();
-	if (!att->disconn_list)
-		goto fail;
 
 	if (!io_set_read_handler(att->io, can_read_data, att, NULL))
 		goto fail;
@@ -1126,9 +1103,6 @@ unsigned int bt_att_register_disconnect(struct bt_att *att,
 		return 0;
 
 	disconn = new0(struct att_disconn, 1);
-	if (!disconn)
-		return 0;
-
 	disconn->callback = callback;
 	disconn->destroy = destroy;
 	disconn->user_data = user_data;
@@ -1342,9 +1316,6 @@ unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
 		return 0;
 
 	notify = new0(struct att_notify, 1);
-	if (!notify)
-		return 0;
-
 	notify->opcode = opcode;
 	notify->callback = callback;
 	notify->destroy = destroy;
@@ -1435,11 +1406,8 @@ bool bt_att_set_security(struct bt_att *att, int level)
 static bool sign_set_key(struct sign_info **sign, uint8_t key[16],
 				bt_att_counter_func_t func, void *user_data)
 {
-	if (!(*sign)) {
+	if (!(*sign))
 		*sign = new0(struct sign_info, 1);
-		if (!(*sign))
-			return false;
-	}
 
 	(*sign)->counter = func;
 	(*sign)->user_data = user_data;
diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index d5cd915..aa66dac 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -142,8 +142,6 @@ struct bt_crypto *bt_crypto_new(void)
 	struct bt_crypto *crypto;
 
 	crypto = new0(struct bt_crypto, 1);
-	if (!crypto)
-		return NULL;
 
 	crypto->ecb_aes = ecb_aes_setup();
 	if (crypto->ecb_aes < 0) {
diff --git a/src/shared/gap.c b/src/shared/gap.c
index cc48a02..4a21e5d 100644
--- a/src/shared/gap.c
+++ b/src/shared/gap.c
@@ -162,9 +162,6 @@ struct bt_gap *bt_gap_new_index(uint16_t index)
 		return NULL;
 
 	gap = new0(struct bt_gap, 1);
-	if (!gap)
-		return NULL;
-
 	gap->index = index;
 
 	gap->mgmt = mgmt_new_default();
@@ -174,7 +171,6 @@ struct bt_gap *bt_gap_new_index(uint16_t index)
 	}
 
 	gap->irk_list = queue_new();
-
 	gap->mgmt_ready = false;
 
 	if (!mgmt_send(gap->mgmt, MGMT_OP_READ_VERSION,
@@ -269,9 +265,6 @@ bool bt_gap_add_peer_irk(struct bt_gap *gap, uint8_t addr_type,
 		return false;
 
 	irk = new0(struct irk_entry, 1);
-	if (!irk)
-		return false;
-
 	irk->addr_type = addr_type;
 	memcpy(irk->addr, addr, 6);
 	memcpy(irk->key, key, 16);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d3e17e1..fd306ac 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -131,8 +131,6 @@ static struct request *request_create(struct bt_gatt_client *client)
 	struct request *req;
 
 	req = new0(struct request, 1);
-	if (!req)
-		return NULL;
 
 	if (client->next_request_id < 1)
 		client->next_request_id = 1;
@@ -243,8 +241,6 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 			return NULL;
 
 	chrc = new0(struct notify_chrc, 1);
-	if (!chrc)
-		return NULL;
 
 	chrc->reg_notify_queue = queue_new();
 	if (!chrc->reg_notify_queue) {
@@ -373,21 +369,9 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	struct discovery_op *op;
 
 	op = new0(struct discovery_op, 1);
-	if (!op)
-		return NULL;
-
 	op->pending_svcs = queue_new();
-	if (!op->pending_svcs)
-		goto fail;
-
 	op->pending_chrcs = queue_new();
-	if (!op->pending_chrcs)
-		goto fail;
-
 	op->tmp_queue = queue_new();
-	if (!op->tmp_queue)
-		goto fail;
-
 	op->client = client;
 	op->complete_func = complete_func;
 	op->failure_func = failure_func;
@@ -395,10 +379,6 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	op->end = end;
 
 	return op;
-
-fail:
-	discovery_op_free(op);
-	return NULL;
 }
 
 static struct discovery_op *discovery_op_ref(struct discovery_op *op)
@@ -787,8 +767,6 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 				start, end, value, properties, uuid_str);
 
 		chrc_data = new0(struct chrc, 1);
-		if (!chrc_data)
-			goto failed;
 
 		chrc_data->start_handle = start;
 		chrc_data->end_handle = end;
@@ -1255,9 +1233,6 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 		return 0;
 
 	notify_data = new0(struct notify_data, 1);
-	if (!notify_data)
-		return 0;
-
 	notify_data->client = client;
 	notify_data->ref_count = 1;
 	notify_data->chrc = chrc;
@@ -1481,8 +1456,6 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 	}
 
 	op = new0(struct service_changed_op, 1);
-	if (!op)
-		return;
 
 	op->start_handle = start;
 	op->end_handle = end;
@@ -1713,33 +1686,16 @@ struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 		return NULL;
 
 	client = new0(struct bt_gatt_client, 1);
-	if (!client)
-		return NULL;
-
 	client->disc_id = bt_att_register_disconnect(att, att_disconnect_cb,
 								client, NULL);
 	if (!client->disc_id)
 		goto fail;
 
 	client->long_write_queue = queue_new();
-	if (!client->long_write_queue)
-		goto fail;
-
 	client->svc_chngd_queue = queue_new();
-	if (!client->svc_chngd_queue)
-		goto fail;
-
 	client->notify_list = queue_new();
-	if (!client->notify_list)
-		goto fail;
-
 	client->notify_chrcs = queue_new();
-	if (!client->notify_chrcs)
-		goto fail;
-
 	client->pending_requests = queue_new();
-	if (!client->pending_requests)
-		goto fail;
 
 	client->notify_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_NOT,
 						notify_cb, client, NULL);
@@ -2025,8 +1981,6 @@ unsigned int bt_gatt_client_read_value(struct bt_gatt_client *client,
 		return 0;
 
 	op = new0(struct read_op, 1);
-	if (!op)
-		return 0;
 
 	req = request_create(client);
 	if (!req) {
@@ -2104,8 +2058,6 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 		return 0;
 
 	op = new0(struct read_op, 1);
-	if (!op)
-		return 0;
 
 	req = request_create(client);
 	if (!req) {
@@ -2254,8 +2206,6 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 		return 0;
 
 	op = new0(struct read_long_op, 1);
-	if (!op)
-		return 0;
 
 	req = request_create(client);
 	if (!req) {
@@ -2381,8 +2331,6 @@ unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 		return 0;
 
 	op = new0(struct write_op, 1);
-	if (!op)
-		return 0;
 
 	req = request_create(client);
 	if (!req) {
@@ -2656,9 +2604,6 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 		return 0;
 
 	op = new0(struct long_write_op, 1);
-	if (!op)
-		return 0;
-
 	op->value = malloc(length);
 	if (!op->value) {
 		free(op);
@@ -2787,8 +2732,6 @@ static struct request *get_reliable_request(struct bt_gatt_client *client,
 	struct prep_write_op *op;
 
 	op = new0(struct prep_write_op, 1);
-	if (!op)
-		return NULL;
 
 	/* Following prepare writes */
 	if (id != 0)
@@ -2947,8 +2890,6 @@ unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
 		return 0;
 
 	op = new0(struct write_op, 1);
-	if (!op)
-		return 0;
 
 	req = queue_find(client->pending_requests, match_req_id,
 							UINT_TO_PTR(id));
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 7f863ef..6ef708d 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -166,8 +166,6 @@ static struct gatt_db_attribute *new_attribute(struct gatt_db_service *service,
 	struct gatt_db_attribute *attribute;
 
 	attribute = new0(struct gatt_db_attribute, 1);
-	if (!attribute)
-		return NULL;
 
 	attribute->service = service;
 	attribute->handle = handle;
@@ -182,12 +180,7 @@ static struct gatt_db_attribute *new_attribute(struct gatt_db_service *service,
 	}
 
 	attribute->pending_reads = queue_new();
-	if (!attribute->pending_reads)
-		goto failed;
-
 	attribute->pending_writes = queue_new();
-	if (!attribute->pending_reads)
-		goto failed;
 
 	return attribute;
 
@@ -211,22 +204,8 @@ struct gatt_db *gatt_db_new(void)
 	struct gatt_db *db;
 
 	db = new0(struct gatt_db, 1);
-	if (!db)
-		return NULL;
-
 	db->services = queue_new();
-	if (!db->services) {
-		free(db);
-		return NULL;
-	}
-
 	db->notify_list = queue_new();
-	if (!db->notify_list) {
-		queue_destroy(db->services, NULL);
-		free(db);
-		return NULL;
-	}
-
 	db->next_handle = 0x0001;
 
 	return gatt_db_ref(db);
@@ -386,14 +365,7 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
 		return NULL;
 
 	service = new0(struct gatt_db_service, 1);
-	if (!service)
-		return NULL;
-
 	service->attributes = new0(struct gatt_db_attribute *, num_handles);
-	if (!service->attributes) {
-		free(service);
-		return NULL;
-	}
 
 	if (primary)
 		type = &primary_service_uuid;
@@ -605,9 +577,6 @@ unsigned int gatt_db_register(struct gatt_db *db,
 		return 0;
 
 	notify = new0(struct notify, 1);
-	if (!notify)
-		return 0;
-
 	notify->service_added = service_added;
 	notify->service_removed = service_removed;
 	notify->destroy = destroy;
@@ -1591,9 +1560,6 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 		struct pending_read *p;
 
 		p = new0(struct pending_read, 1);
-		if (!p)
-			return false;
-
 		p->attrib = attrib;
 		p->id = ++attrib->read_id;
 		p->timeout_id = timeout_add(ATTRIBUTE_TIMEOUT, read_timeout,
@@ -1675,9 +1641,6 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 		struct pending_write *p;
 
 		p = new0(struct pending_write, 1);
-		if (!p)
-			return false;
-
 		p->attrib = attrib;
 		p->id = ++attrib->write_id;
 		p->timeout_id = timeout_add(ATTRIBUTE_TIMEOUT, write_timeout,
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 008b8bc..b1dd38b 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -56,9 +56,6 @@ static struct bt_gatt_result *result_create(uint8_t opcode, const void *pdu,
 	struct bt_gatt_result *result;
 
 	result = new0(struct bt_gatt_result, 1);
-	if (!result)
-		return NULL;
-
 	result->pdu = malloc(pdu_len);
 	if (!result->pdu) {
 		free(result);
@@ -549,9 +546,6 @@ unsigned int bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 		return false;
 
 	op = new0(struct mtu_op, 1);
-	if (!op)
-		return false;
-
 	op->att = att;
 	op->client_rx_mtu = client_rx_mtu;
 	op->callback = callback;
@@ -823,9 +817,6 @@ static struct bt_gatt_request *discover_services(struct bt_att *att,
 		return NULL;
 
 	op = new0(struct bt_gatt_request, 1);
-	if (!op)
-		return NULL;
-
 	op->att = att;
 	op->start_handle = start;
 	op->end_handle = end;
@@ -924,9 +915,6 @@ static struct read_incl_data *new_read_included(struct bt_gatt_result *res)
 	struct read_incl_data *data;
 
 	data = new0(struct read_incl_data, 1);
-	if (!data)
-		return NULL;
-
 	data->op = bt_gatt_request_ref(res->op);
 	data->result = res;
 
@@ -1161,9 +1149,6 @@ struct bt_gatt_request *bt_gatt_discover_included_services(struct bt_att *att,
 		return false;
 
 	op = new0(struct bt_gatt_request, 1);
-	if (!op)
-		return false;
-
 	op->att = att;
 	op->callback = callback;
 	op->user_data = user_data;
@@ -1278,9 +1263,6 @@ struct bt_gatt_request *bt_gatt_discover_characteristics(struct bt_att *att,
 		return false;
 
 	op = new0(struct bt_gatt_request, 1);
-	if (!op)
-		return false;
-
 	op->att = att;
 	op->callback = callback;
 	op->user_data = user_data;
@@ -1388,9 +1370,6 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 		return false;
 
 	op = new0(struct bt_gatt_request, 1);
-	if (!op)
-		return false;
-
 	op->att = att;
 	op->callback = callback;
 	op->user_data = user_data;
@@ -1512,9 +1491,6 @@ struct bt_gatt_request *bt_gatt_discover_descriptors(struct bt_att *att,
 		return false;
 
 	op = new0(struct bt_gatt_request, 1);
-	if (!op)
-		return false;
-
 	op->att = att;
 	op->callback = callback;
 	op->user_data = user_data;
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 6167065..6dec3f3 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -248,10 +248,6 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	}
 
 	q = queue_new();
-	if (!q) {
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
 
 	start = get_le16(pdu);
 	end = get_le16(pdu + 2);
@@ -457,10 +453,6 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 	}
 
 	q = queue_new();
-	if (!q) {
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
 
 	start = get_le16(pdu);
 	end = get_le16(pdu + 2);
@@ -495,11 +487,6 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 	}
 
 	op = new0(struct async_read_op, 1);
-	if (!op) {
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
-
 	op->pdu = malloc(bt_att_get_mtu(server->att));
 	if (!op->pdu) {
 		free(op);
@@ -593,10 +580,6 @@ static void find_info_cb(uint8_t opcode, const void *pdu,
 	}
 
 	q = queue_new();
-	if (!q) {
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
 
 	start = get_le16(pdu);
 	end = get_le16(pdu + 2);
@@ -802,11 +785,6 @@ static void write_cb(uint8_t opcode, const void *pdu,
 	}
 
 	op = new0(struct async_write_op, 1);
-	if (!op) {
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
-
 	op->server = server;
 	op->opcode = opcode;
 	server->pending_write_op = op;
@@ -914,11 +892,6 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 	}
 
 	op = new0(struct async_read_op, 1);
-	if (!op) {
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
-
 	op->opcode = opcode;
 	op->server = server;
 	server->pending_read_op = op;
@@ -1088,9 +1061,6 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu,
 
 	data.handles = new0(uint16_t, data.num_handles);
 
-	if (!data.handles)
-		goto error;
-
 	for (i = 0; i < data.num_handles; i++)
 		data.handles[i] = get_le16(pdu + i * 2);
 
@@ -1153,11 +1123,6 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 		goto error;
 
 	prep_data = new0(struct prep_write_data, 1);
-	if (!prep_data) {
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
-
 	prep_data->length = length - 4;
 	if (prep_data->length) {
 		prep_data->value = malloc(prep_data->length);
@@ -1418,19 +1383,11 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 		return NULL;
 
 	server = new0(struct bt_gatt_server, 1);
-	if (!server)
-		return NULL;
-
 	server->db = gatt_db_ref(db);
 	server->att = bt_att_ref(att);
 	server->mtu = MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
 	server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
-
 	server->prep_queue = queue_new();
-	if (!server->prep_queue) {
-		bt_gatt_server_free(server);
-		return NULL;
-	}
 
 	if (!gatt_server_register_att_handlers(server)) {
 		bt_gatt_server_free(server);
@@ -1551,10 +1508,6 @@ bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 		return false;
 
 	data = new0(struct ind_data, 1);
-	if (!data) {
-		free(pdu);
-		return false;
-	}
 
 	data->callback = callback;
 	data->destroy = destroy;
diff --git a/src/shared/hci-crypto.c b/src/shared/hci-crypto.c
index 8a40aa5..f750747 100644
--- a/src/shared/hci-crypto.c
+++ b/src/shared/hci-crypto.c
@@ -66,9 +66,6 @@ static bool le_encrypt(struct bt_hci *hci, uint8_t size,
 	memcpy(cmd.plaintext, plaintext, 16);
 
 	data = new0(struct crypto_data, 1);
-	if (!data)
-		return false;
-
 	data->size = size;
 	data->callback = callback;
 	data->user_data = user_data;
@@ -110,9 +107,6 @@ bool bt_hci_crypto_prand(struct bt_hci *hci,
 		return false;
 
 	data = new0(struct crypto_data, 1);
-	if (!data)
-		return false;
-
 	data->callback = callback;
 	data->user_data = user_data;
 
diff --git a/src/shared/hci.c b/src/shared/hci.c
index 0db0146..bfee4ab 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -290,9 +290,6 @@ static struct bt_hci *create_hci(int fd)
 		return NULL;
 
 	hci = new0(struct bt_hci, 1);
-	if (!hci)
-		return NULL;
-
 	hci->io = io_new(fd);
 	if (!hci->io) {
 		free(hci);
@@ -306,28 +303,8 @@ static struct bt_hci *create_hci(int fd)
 	hci->next_evt_id = 1;
 
 	hci->cmd_queue = queue_new();
-	if (!hci->cmd_queue) {
-		io_destroy(hci->io);
-		free(hci);
-		return NULL;
-	}
-
 	hci->rsp_queue = queue_new();
-	if (!hci->rsp_queue) {
-		queue_destroy(hci->cmd_queue, NULL);
-		io_destroy(hci->io);
-		free(hci);
-		return NULL;
-	}
-
 	hci->evt_list = queue_new();
-	if (!hci->evt_list) {
-		queue_destroy(hci->rsp_queue, NULL);
-		queue_destroy(hci->cmd_queue, NULL);
-		io_destroy(hci->io);
-		free(hci);
-		return NULL;
-	}
 
 	if (!io_set_read_handler(hci->io, io_read_callback, hci, NULL)) {
 		queue_destroy(hci->evt_list, NULL);
@@ -476,9 +453,6 @@ unsigned int bt_hci_send(struct bt_hci *hci, uint16_t opcode,
 		return 0;
 
 	cmd = new0(struct cmd, 1);
-	if (!cmd)
-		return 0;
-
 	cmd->opcode = opcode;
 	cmd->size = size;
 
@@ -568,9 +542,6 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 		return 0;
 
 	evt = new0(struct evt, 1);
-	if (!evt)
-		return 0;
-
 	evt->event = event;
 
 	if (hci->next_evt_id < 1)
diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 74ee979..d9f7659 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -575,9 +575,6 @@ struct hfp_gw *hfp_gw_new(int fd)
 		return NULL;
 
 	hfp = new0(struct hfp_gw, 1);
-	if (!hfp)
-		return NULL;
-
 	hfp->fd = fd;
 	hfp->close_on_unref = false;
 
@@ -603,13 +600,6 @@ struct hfp_gw *hfp_gw_new(int fd)
 	}
 
 	hfp->cmd_handlers = queue_new();
-	if (!hfp->cmd_handlers) {
-		io_destroy(hfp->io);
-		ringbuf_free(hfp->write_buf);
-		ringbuf_free(hfp->read_buf);
-		free(hfp);
-		return NULL;
-	}
 
 	if (!io_set_read_handler(hfp->io, can_read_data, hfp,
 							read_watch_destroy)) {
@@ -844,9 +834,6 @@ bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
 	struct cmd_handler *handler;
 
 	handler = new0(struct cmd_handler, 1);
-	if (!handler)
-		return false;
-
 	handler->callback = callback;
 	handler->user_data = user_data;
 
@@ -1262,9 +1249,6 @@ struct hfp_hf *hfp_hf_new(int fd)
 		return NULL;
 
 	hfp = new0(struct hfp_hf, 1);
-	if (!hfp)
-		return NULL;
-
 	hfp->fd = fd;
 	hfp->close_on_unref = false;
 
@@ -1290,24 +1274,7 @@ struct hfp_hf *hfp_hf_new(int fd)
 	}
 
 	hfp->event_handlers = queue_new();
-	if (!hfp->event_handlers) {
-		io_destroy(hfp->io);
-		ringbuf_free(hfp->write_buf);
-		ringbuf_free(hfp->read_buf);
-		free(hfp);
-		return NULL;
-	}
-
 	hfp->cmd_queue = queue_new();
-	if (!hfp->cmd_queue) {
-		io_destroy(hfp->io);
-		ringbuf_free(hfp->write_buf);
-		ringbuf_free(hfp->read_buf);
-		queue_destroy(hfp->event_handlers, NULL);
-		free(hfp);
-		return NULL;
-	}
-
 	hfp->writer_active = false;
 
 	if (!io_set_read_handler(hfp->io, hf_can_read_data, hfp,
@@ -1440,10 +1407,6 @@ bool hfp_hf_send_command(struct hfp_hf *hfp, hfp_response_func_t resp_cb,
 		return false;
 
 	cmd = new0(struct cmd_response, 1);
-	if (!cmd) {
-		free(fmt);
-		return false;
-	}
 
 	va_start(ap, format);
 	len = ringbuf_vprintf(hfp->write_buf, fmt, ap);
@@ -1481,9 +1444,6 @@ bool hfp_hf_register(struct hfp_hf *hfp, hfp_hf_result_func_t callback,
 		return false;
 
 	handler = new0(struct event_handler, 1);
-	if (!handler)
-		return false;
-
 	handler->callback = callback;
 	handler->user_data = user_data;
 
diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index 4923710..2306c34 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -160,9 +160,6 @@ struct io *io_new(int fd)
 		return NULL;
 
 	io = new0(struct io, 1);
-	if (!io)
-		return NULL;
-
 	io->fd = fd;
 	io->events = 0;
 	io->close_on_destroy = false;
diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 1ed635d..5e03a51 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -353,9 +353,6 @@ struct mgmt *mgmt_new(int fd)
 		return NULL;
 
 	mgmt = new0(struct mgmt, 1);
-	if (!mgmt)
-		return NULL;
-
 	mgmt->fd = fd;
 	mgmt->close_on_unref = false;
 
@@ -374,42 +371,9 @@ struct mgmt *mgmt_new(int fd)
 	}
 
 	mgmt->request_queue = queue_new();
-	if (!mgmt->request_queue) {
-		io_destroy(mgmt->io);
-		free(mgmt->buf);
-		free(mgmt);
-		return NULL;
-	}
-
 	mgmt->reply_queue = queue_new();
-	if (!mgmt->reply_queue) {
-		queue_destroy(mgmt->request_queue, NULL);
-		io_destroy(mgmt->io);
-		free(mgmt->buf);
-		free(mgmt);
-		return NULL;
-	}
-
 	mgmt->pending_list = queue_new();
-	if (!mgmt->pending_list) {
-		queue_destroy(mgmt->reply_queue, NULL);
-		queue_destroy(mgmt->request_queue, NULL);
-		io_destroy(mgmt->io);
-		free(mgmt->buf);
-		free(mgmt);
-		return NULL;
-	}
-
 	mgmt->notify_list = queue_new();
-	if (!mgmt->notify_list) {
-		queue_destroy(mgmt->pending_list, NULL);
-		queue_destroy(mgmt->reply_queue, NULL);
-		queue_destroy(mgmt->request_queue, NULL);
-		io_destroy(mgmt->io);
-		free(mgmt->buf);
-		free(mgmt);
-		return NULL;
-	}
 
 	if (!io_set_read_handler(mgmt->io, can_read_data, mgmt, NULL)) {
 		queue_destroy(mgmt->notify_list, NULL);
@@ -549,9 +513,6 @@ static struct mgmt_request *create_request(uint16_t opcode, uint16_t index,
 		return NULL;
 
 	request = new0(struct mgmt_request, 1);
-	if (!request)
-		return NULL;
-
 	request->len = length + MGMT_HDR_SIZE;
 	request->buf = malloc(request->len);
 	if (!request->buf) {
@@ -732,9 +693,6 @@ unsigned int mgmt_register(struct mgmt *mgmt, uint16_t event, uint16_t index,
 		return 0;
 
 	notify = new0(struct mgmt_notify, 1);
-	if (!notify)
-		return 0;
-
 	notify->event = event;
 	notify->index = index;
 
diff --git a/src/shared/queue.c b/src/shared/queue.c
index 3507ed1..1a2ffc8 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -58,9 +58,6 @@ struct queue *queue_new(void)
 	struct queue *queue;
 
 	queue = new0(struct queue, 1);
-	if (!queue)
-		return NULL;
-
 	queue->head = NULL;
 	queue->tail = NULL;
 	queue->entries = 0;
@@ -101,9 +98,6 @@ static struct queue_entry *queue_entry_new(void *data)
 	struct queue_entry *entry;
 
 	entry = new0(struct queue_entry, 1);
-	if (!entry)
-		return NULL;
-
 	entry->data = data;
 
 	return queue_entry_ref(entry);
@@ -117,8 +111,6 @@ bool queue_push_tail(struct queue *queue, void *data)
 		return false;
 
 	entry = queue_entry_new(data);
-	if (!entry)
-		return false;
 
 	if (queue->tail)
 		queue->tail->next = entry;
@@ -141,8 +133,6 @@ bool queue_push_head(struct queue *queue, void *data)
 		return false;
 
 	entry = queue_entry_new(data);
-	if (!entry)
-		return false;
 
 	entry->next = queue->head;
 
@@ -176,8 +166,6 @@ bool queue_push_after(struct queue *queue, void *entry, void *data)
 		return false;
 
 	new_entry = queue_entry_new(data);
-	if (!new_entry)
-		return false;
 
 	new_entry->next = qentry->next;
 
diff --git a/src/shared/ringbuf.c b/src/shared/ringbuf.c
index a11d2dc..8e7c50e 100644
--- a/src/shared/ringbuf.c
+++ b/src/shared/ringbuf.c
@@ -72,9 +72,6 @@ struct ringbuf *ringbuf_new(size_t size)
 	real_size = align_power2(size);
 
 	ringbuf = new0(struct ringbuf, 1);
-	if (!ringbuf)
-		return NULL;
-
 	ringbuf->buffer = malloc(real_size);
 	if (!ringbuf->buffer) {
 		free(ringbuf);
diff --git a/src/shared/tester.c b/src/shared/tester.c
index c3120fb..80d6511 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -215,12 +215,6 @@ void tester_add_full(const char *name, const void *test_data,
 	}
 
 	test = new0(struct test_case, 1);
-	if (!test) {
-		if (destroy)
-			destroy(user_data);
-		return;
-	}
-
 	test->name = strdup(name);
 	test->result = TEST_RESULT_NOT_RUN;
 	test->stage = TEST_STAGE_INVALID;
@@ -684,9 +678,6 @@ void tester_wait(unsigned int seconds, tester_wait_func_t func,
 	test = test_current->data;
 
 	wait = new0(struct wait_data, 1);
-	if (!wait)
-		return;
-
 	wait->seconds = seconds;
 	wait->test = test;
 	wait->func = func;
diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.c
index f099312..971124a 100644
--- a/src/shared/timeout-mainloop.c
+++ b/src/shared/timeout-mainloop.c
@@ -58,9 +58,6 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
 	struct timeout_data *data;
 
 	data = new0(struct timeout_data, 1);
-	if (!data)
-		return 0;
-
 	data->func = func;
 	data->user_data = user_data;
 	data->timeout = timeout;
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index f7ad0cb..1c684cd 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -125,16 +125,11 @@ struct bt_uhid *bt_uhid_new(int fd)
 	struct bt_uhid *uhid;
 
 	uhid = new0(struct bt_uhid, 1);
-	if (!uhid)
-		return NULL;
-
 	uhid->io = io_new(fd);
 	if (!uhid->io)
 		goto failed;
 
 	uhid->notify_list = queue_new();
-	if (!uhid->notify_list)
-		goto failed;
 
 	if (!io_set_read_handler(uhid->io, uhid_read_handler, uhid, NULL))
 		goto failed;
@@ -186,9 +181,6 @@ unsigned int bt_uhid_register(struct bt_uhid *uhid, uint32_t event,
 		return 0;
 
 	notify = new0(struct uhid_notify, 1);
-	if (!notify)
-		return 0;
-
 	notify->id = uhid->notify_id++;
 	notify->event = event;
 	notify->func = func;
-- 
2.5.0

