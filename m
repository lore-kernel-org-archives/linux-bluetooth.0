Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 4/4] core: Remove dead code
Date: Mon, 19 Oct 2015 23:42:52 +0200
Message-Id: <1445290972-18383-3-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1445290972-18383-1-git-send-email-szymon.janc@codecoup.pl>
References: <1445290972-18383-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes dead code due to memory allocation with new0 not being
able to fail.
---
 src/advertising.c   |   6 ----
 src/gatt-client.c   |  67 -----------------------------------
 src/gatt-database.c | 100 ----------------------------------------------------
 3 files changed, 173 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index a148625..59c8c3d 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -591,9 +591,6 @@ static struct advertisement *advertisement_create(DBusConnection *conn,
 		return NULL;
 
 	ad = new0(struct advertisement, 1);
-	if (!ad)
-		return NULL;
-
 	ad->client = g_dbus_client_new_full(conn, sender, path, path);
 	if (!ad->client)
 		goto fail;
@@ -765,9 +762,6 @@ advertising_manager_create(struct btd_adapter *adapter)
 	struct btd_advertising *manager;
 
 	manager = new0(struct btd_advertising, 1);
-	if (!manager)
-		return NULL;
-
 	manager->adapter = adapter;
 
 	manager->mgmt = mgmt_new_default();
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 4e52c5d..20a5ae6 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -407,9 +407,6 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
 		return btd_error_in_progress(msg);
 
 	op = new0(struct async_dbus_op, 1);
-	if (!op)
-		return btd_error_failed(msg, "Failed to initialize request");
-
 	op->msg = dbus_message_ref(msg);
 	op->data = desc;
 
@@ -472,9 +469,6 @@ static unsigned int start_long_write(DBusMessage *msg, uint16_t handle,
 	unsigned int id;
 
 	op = new0(struct async_dbus_op, 1);
-	if (!op)
-		return false;
-
 	op->msg = dbus_message_ref(msg);
 	op->data = data;
 	op->complete = complete;
@@ -500,9 +494,6 @@ static unsigned int start_write_request(DBusMessage *msg, uint16_t handle,
 	unsigned int id;
 
 	op = new0(struct async_dbus_op, 1);
-	if (!op)
-		return false;
-
 	op->msg = dbus_message_ref(msg);
 	op->data = data;
 	op->complete = complete;
@@ -610,9 +601,6 @@ static struct descriptor *descriptor_create(struct gatt_db_attribute *attr,
 	struct descriptor *desc;
 
 	desc = new0(struct descriptor, 1);
-	if (!desc)
-		return NULL;
-
 	desc->chrc = chrc;
 	desc->attr = attr;
 	desc->handle = gatt_db_attribute_get_handle(attr);
@@ -852,9 +840,6 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 		return btd_error_in_progress(msg);
 
 	op = new0(struct async_dbus_op, 1);
-	if (!op)
-		return btd_error_failed(msg, "Failed to initialize request");
-
 	op->msg = dbus_message_ref(msg);
 	op->data = chrc;
 
@@ -1045,9 +1030,6 @@ static struct notify_client *notify_client_create(struct characteristic *chrc,
 	struct notify_client *client;
 
 	client = new0(struct notify_client, 1);
-	if (!client)
-		return NULL;
-
 	client->chrc = chrc;
 	client->owner = strdup(owner);
 	if (!client->owner) {
@@ -1193,9 +1175,6 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	}
 
 	op = new0(struct async_dbus_op, 1);
-	if (!op)
-		goto fail;
-
 	op->data = client;
 	op->msg = dbus_message_ref(msg);
 
@@ -1320,22 +1299,8 @@ static struct characteristic *characteristic_create(
 	bt_uuid_t uuid;
 
 	chrc = new0(struct characteristic, 1);
-	if (!chrc)
-		return NULL;
-
 	chrc->descs = queue_new();
-	if (!chrc->descs) {
-		free(chrc);
-		return NULL;
-	}
-
 	chrc->notify_clients = queue_new();
-	if (!chrc->notify_clients) {
-		queue_destroy(chrc->descs, NULL);
-		free(chrc);
-		return NULL;
-	}
-
 	chrc->service = service;
 
 	gatt_db_attribute_get_char_data(attr, &chrc->handle,
@@ -1494,22 +1459,8 @@ static struct service *service_create(struct gatt_db_attribute *attr,
 	bt_uuid_t uuid;
 
 	service = new0(struct service, 1);
-	if (!service)
-		return NULL;
-
 	service->chrcs = queue_new();
-	if (!service->chrcs) {
-		free(service);
-		return NULL;
-	}
-
 	service->pending_ext_props = queue_new();
-	if (!service->pending_ext_props) {
-		queue_destroy(service->chrcs, NULL);
-		free(service);
-		return NULL;
-	}
-
 	service->client = client;
 
 	gatt_db_attribute_get_service_data(attr, &service->start_handle,
@@ -1757,22 +1708,8 @@ struct btd_gatt_client *btd_gatt_client_new(struct btd_device *device)
 		return NULL;
 
 	client = new0(struct btd_gatt_client, 1);
-	if (!client)
-		return NULL;
-
 	client->services = queue_new();
-	if (!client->services) {
-		free(client);
-		return NULL;
-	}
-
 	client->all_notify_clients = queue_new();
-	if (!client->all_notify_clients) {
-		queue_destroy(client->services, NULL);
-		free(client);
-		return NULL;
-	}
-
 	client->device = device;
 	ba2str(device_get_address(device), client->devaddr);
 
@@ -1802,9 +1739,6 @@ static void register_notify(void *data, void *user_data)
 	DBG("Re-register subscribed notification client");
 
 	op = new0(struct async_dbus_op, 1);
-	if (!op)
-		goto fail;
-
 	op->data = notify_client;
 
 	notify_client->notify_id = bt_gatt_client_register_notify(client->gatt,
@@ -1816,7 +1750,6 @@ static void register_notify(void *data, void *user_data)
 
 	async_dbus_op_free(op);
 
-fail:
 	DBG("Failed to re-register notification client");
 
 	queue_remove(notify_client->chrc->notify_clients, client);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 774b19e..e8ce7d5 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -231,15 +231,7 @@ static struct device_state *device_state_create(bdaddr_t *bdaddr,
 	struct device_state *dev_state;
 
 	dev_state = new0(struct device_state, 1);
-	if (!dev_state)
-		return NULL;
-
 	dev_state->ccc_states = queue_new();
-	if (!dev_state->ccc_states) {
-		free(dev_state);
-		return NULL;
-	}
-
 	bacpy(&dev_state->bdaddr, bdaddr);
 	dev_state->bdaddr_type = bdaddr_type;
 
@@ -261,8 +253,6 @@ static struct device_state *get_device_state(struct btd_gatt_database *database,
 		return dev_state;
 
 	dev_state = device_state_create(bdaddr, bdaddr_type);
-	if (!dev_state)
-		return NULL;
 
 	queue_push_tail(database->device_states, dev_state);
 
@@ -278,17 +268,12 @@ static struct ccc_state *get_ccc_state(struct btd_gatt_database *database,
 	struct ccc_state *ccc;
 
 	dev_state = get_device_state(database, bdaddr, bdaddr_type);
-	if (!dev_state)
-		return NULL;
 
 	ccc = find_ccc_state(dev_state, handle);
 	if (ccc)
 		return ccc;
 
 	ccc = new0(struct ccc_state, 1);
-	if (!ccc)
-		return NULL;
-
 	ccc->handle = handle;
 	queue_push_tail(dev_state->ccc_states, ccc);
 
@@ -727,10 +712,6 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 	}
 
 	ccc = get_ccc_state(database, &bdaddr, bdaddr_type, handle);
-	if (!ccc) {
-		ecode = BT_ATT_ERROR_UNLIKELY;
-		goto done;
-	}
 
 	len = 2 - offset;
 	value = len ? &ccc->value[offset] : NULL;
@@ -773,10 +754,6 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 	}
 
 	ccc = get_ccc_state(database, &bdaddr, bdaddr_type, handle);
-	if (!ccc) {
-		ecode = BT_ATT_ERROR_UNLIKELY;
-		goto done;
-	}
 
 	ccc_cb = queue_find(database->ccc_callbacks, ccc_cb_match_handle,
 			UINT_TO_PTR(gatt_db_attribute_get_handle(attrib)));
@@ -813,10 +790,6 @@ service_add_ccc(struct gatt_db_attribute *service,
 	bt_uuid_t uuid;
 
 	ccc_cb = new0(struct ccc_cb_data, 1);
-	if (!ccc_cb) {
-		error("Could not allocate memory for callback data");
-		return NULL;
-	}
 
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	ccc = gatt_db_service_add_descriptor(service, &uuid,
@@ -1102,21 +1075,8 @@ static struct external_chrc *chrc_create(struct external_service *service,
 	struct external_chrc *chrc;
 
 	chrc = new0(struct external_chrc, 1);
-	if (!chrc)
-		return NULL;
-
 	chrc->pending_reads = queue_new();
-	if (!chrc->pending_reads) {
-		free(chrc);
-		return NULL;
-	}
-
 	chrc->pending_writes = queue_new();
-	if (!chrc->pending_writes) {
-		queue_destroy(chrc->pending_reads, NULL);
-		free(chrc);
-		return NULL;
-	}
 
 	chrc->path = g_strdup(path);
 	if (!chrc->path) {
@@ -1139,21 +1099,8 @@ static struct external_desc *desc_create(struct external_service *service,
 	struct external_desc *desc;
 
 	desc = new0(struct external_desc, 1);
-	if (!desc)
-		return NULL;
-
 	desc->pending_reads = queue_new();
-	if (!desc->pending_reads) {
-		free(desc);
-		return NULL;
-	}
-
 	desc->pending_writes = queue_new();
-	if (!desc->pending_writes) {
-		queue_destroy(desc->pending_reads, NULL);
-		free(desc);
-		return NULL;
-	}
 
 	desc->chrc_path = g_strdup(chrc_path);
 	if (!desc->chrc_path) {
@@ -1600,8 +1547,6 @@ static struct pending_op *pending_read_new(struct queue *owner_queue,
 	struct pending_op *op;
 
 	op = new0(struct pending_op, 1);
-	if (!op)
-		return NULL;
 
 	op->owner_queue = owner_queue;
 	op->attrib = attrib;
@@ -1619,11 +1564,6 @@ static void send_read(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 
 	op = pending_read_new(owner_queue, attrib, id);
-	if (!op) {
-		error("Failed to allocate memory for pending read call");
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
 
 	if (g_dbus_proxy_method_call(proxy, "ReadValue", NULL, read_reply_cb,
 						op, pending_op_free) == TRUE)
@@ -1631,7 +1571,6 @@ static void send_read(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
 
 	pending_op_free(op);
 
-error:
 	gatt_db_attribute_read_result(attrib, id, ecode, NULL, 0);
 }
 
@@ -1691,8 +1630,6 @@ static struct pending_op *pending_write_new(struct queue *owner_queue,
 	struct pending_op *op;
 
 	op = new0(struct pending_op, 1);
-	if (!op)
-		return NULL;
 
 	op->data.iov_base = (uint8_t *) value;
 	op->data.iov_len = len;
@@ -1714,11 +1651,6 @@ static void send_write(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 
 	op = pending_write_new(owner_queue, attrib, id, value, len);
-	if (!op) {
-		error("Failed to allocate memory for pending read call");
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
 
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
 						write_reply_cb, op,
@@ -1727,7 +1659,6 @@ static void send_write(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
 
 	pending_op_free(op);
 
-error:
 	gatt_db_attribute_write_result(attrib, id, ecode);
 }
 
@@ -2156,8 +2087,6 @@ static struct external_service *create_service(DBusConnection *conn,
 		return NULL;
 
 	service = new0(struct external_service, 1);
-	if (!service)
-		return NULL;
 
 	service->client = g_dbus_client_new_full(conn, sender, path, path);
 	if (!service->client)
@@ -2172,12 +2101,7 @@ static struct external_service *create_service(DBusConnection *conn,
 		goto fail;
 
 	service->chrcs = queue_new();
-	if (!service->chrcs)
-		goto fail;
-
 	service->descs = queue_new();
-	if (!service->descs)
-		goto fail;
 
 	service->reg = dbus_message_ref(msg);
 
@@ -2301,8 +2225,6 @@ static int profile_add(struct external_profile *profile, const char *uuid)
 	struct btd_profile *p;
 
 	p = new0(struct btd_profile, 1);
-	if (!p)
-		return -ENOMEM;
 
 	/* Assign directly to avoid having extra fields */
 	p->name = (const void *) g_strdup_printf("%s%s/%s", profile->owner,
@@ -2351,8 +2273,6 @@ static int profile_create(DBusConnection *conn,
 		return -EINVAL;
 
 	profile = new0(struct external_profile, 1);
-	if (!profile)
-		return -ENOMEM;
 
 	profile->owner = g_strdup(sender);
 	if (!profile->owner)
@@ -2363,9 +2283,6 @@ static int profile_create(DBusConnection *conn,
 		goto fail;
 
 	profile->profiles = queue_new();
-	if (!profile->profiles)
-		goto fail;
-
 	profile->database = database;
 	profile->id = g_dbus_add_disconnect_watch(conn, sender, profile_exited,
 								profile, NULL);
@@ -2498,29 +2415,12 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 		return NULL;
 
 	database = new0(struct btd_gatt_database, 1);
-	if (!database)
-		return NULL;
-
 	database->adapter = btd_adapter_ref(adapter);
 	database->db = gatt_db_new();
-	if (!database->db)
-		goto fail;
-
 	database->device_states = queue_new();
-	if (!database->device_states)
-		goto fail;
-
 	database->services = queue_new();
-	if (!database->services)
-		goto fail;
-
 	database->profiles = queue_new();
-	if (!database->profiles)
-		goto fail;
-
 	database->ccc_callbacks = queue_new();
-	if (!database->ccc_callbacks)
-		goto fail;
 
 	database->db_id = gatt_db_register(database->db, gatt_db_service_added,
 							gatt_db_service_removed,
-- 
2.5.0

