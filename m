Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ] shared/gatt-client: Allow populating without discovery.
Date: Wed, 19 Nov 2014 19:07:08 -0800
Message-Id: <1416452828-25825-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need the ability to construct a shared/gatt-client from storage if
we're bonded with a remote device, so that we can reduce the number of
ATT requests by avoiding service discovery. This patch provides an API
to construct a bt_gatt_client using a pre-populated service list
structure.

A new argument has been added to bt_gatt_client_new which is
a pointer to a new opaque list structure "struct bt_gatt_service_list".
If NULL is passed, then bt_gatt_client will perform service discovery.
Otherwise, it will take ownership of the contents of the list and skip
discovery entirely.
---
 src/shared/gatt-client.c | 155 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/gatt-client.h |  30 +++++++--
 tools/btgatt-client.c    |   2 +-
 unit/test-gatt.c         |   2 +-
 4 files changed, 178 insertions(+), 11 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index cf93d4b..35b36e7 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -122,6 +122,13 @@ struct bt_gatt_client {
 	bool in_svc_chngd;
 };
 
+struct bt_gatt_service_list {
+	struct service_list *head, *tail;
+	uint16_t gatt_svc_handle;
+	uint16_t svc_chngd_val_handle;
+	uint16_t svc_chngd_ccc_handle;
+};
+
 struct notify_data {
 	struct bt_gatt_client *client;
 	bool removed;
@@ -917,6 +924,12 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 					"MTU exchange complete, with MTU: %u",
 					bt_att_get_mtu(client->att));
 
+	/* Don't discover services if they were pre-populated */
+	if (op->result_head) {
+		op->complete_func(op, true, 0);
+		return;
+	}
+
 	if (bt_gatt_discover_all_primary_services(client->att, NULL,
 							discover_primary_cb,
 							discovery_op_ref(op),
@@ -929,7 +942,7 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 	client->in_init = false;
 
 	if (client->ready_callback)
-		client->ready_callback(success, att_ecode, client->ready_data);
+		client->ready_callback(false, att_ecode, client->ready_data);
 
 	discovery_op_unref(op);
 }
@@ -1197,7 +1210,8 @@ done:
 		client->ready_callback(success, att_ecode, client->ready_data);
 }
 
-static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
+static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
+					struct bt_gatt_service_list *services)
 {
 	struct discovery_op *op;
 
@@ -1210,6 +1224,19 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 
 	op->client = client;
 	op->complete_func = init_complete;
+
+	if (services) {
+		/* Take ownership of services */
+		op->result_head = services->head;
+		op->result_tail = services->tail;
+		services->head = NULL;
+		services->tail = NULL;
+
+		client->gatt_svc_handle = services->gatt_svc_handle;
+		client->svc_chngd_val_handle = services->svc_chngd_val_handle;
+		client->svc_chngd_ccc_handle = services->svc_chngd_ccc_handle;
+	}
+
 	op->start = 0x0001;
 	op->end = 0xffff;
 
@@ -1468,7 +1495,8 @@ static void att_disconnect_cb(void *user_data)
 		client->ready_callback(false, 0, client->ready_data);
 }
 
-struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
+struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu,
+					struct bt_gatt_service_list *services)
 {
 	struct bt_gatt_client *client;
 
@@ -1508,7 +1536,7 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 
 	client->att = bt_att_ref(att);
 
-	if (!gatt_client_init(client, mtu))
+	if (!gatt_client_init(client, mtu, services))
 		goto fail;
 
 	return bt_gatt_client_ref(client);
@@ -1597,6 +1625,125 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 	return true;
 }
 
+struct bt_gatt_service_list *bt_gatt_service_list_new(void)
+{
+	struct bt_gatt_service_list *l;
+
+	l = new0(struct bt_gatt_service_list, 1);
+	if (!l)
+		return NULL;
+
+	return l;
+}
+
+bool bt_gatt_service_list_add_service(struct bt_gatt_service_list *l,
+					bt_gatt_service_t *service,
+					bt_gatt_characteristic_t *chrcs,
+					size_t num_chrcs,
+					bt_gatt_included_service_t *includes,
+					size_t num_includes)
+{
+	struct service_list *svc;
+	size_t i, j;
+	uint16_t gatt_svc_handle = 0;
+	uint16_t svc_chngd_val_handle = 0;
+	uint16_t svc_chngd_ccc_handle = 0;
+
+	if (!l || !service || (num_chrcs && !chrcs) ||
+						(num_includes && !includes))
+		return false;
+
+	if (uuid_cmp(service->uuid, GATT_SVC_UUID)) {
+		if (l->gatt_svc_handle)
+			return false;
+
+		gatt_svc_handle = service->start_handle;
+	}
+	if (!service_list_add_service(&l->head, &l->tail, service->primary,
+							service->start_handle,
+							service->end_handle,
+							service->uuid))
+		return false;
+
+	svc = l->tail;
+
+	if (!num_chrcs)
+		goto includes;
+
+	svc->chrcs = new0(struct chrc_data, num_chrcs);
+	if (!svc->chrcs)
+		goto fail;
+
+	for (i = 0; i < num_chrcs; i++) {
+		bool svc_chngd_chrc = false;
+
+		svc->num_chrcs++;
+		svc->chrcs[i].reg_notify_queue = queue_new();
+		if (!svc->chrcs[i].reg_notify_queue)
+			goto fail;
+
+		svc->chrcs[i].chrc_external = chrcs[i];
+		svc->chrcs[i].chrc_external.descs = new0(bt_gatt_descriptor_t,
+							chrcs[i].num_descs);
+		if (!svc->chrcs[i].chrc_external.descs && chrcs[i].num_descs)
+			goto fail;
+
+		memcpy((void *) svc->chrcs[i].chrc_external.descs,
+			chrcs[i].descs,
+			sizeof(bt_gatt_descriptor_t) * chrcs[i].num_descs);
+
+		if (!uuid_cmp(chrcs[i].uuid, SVC_CHNGD_UUID)) {
+			svc_chngd_val_handle = chrcs[i].value_handle;
+			svc_chngd_chrc = true;
+		}
+
+		for (j = 0; j < chrcs[i].num_descs; j++) {
+			const bt_gatt_descriptor_t *desc = chrcs[i].descs + j;
+
+			if (!uuid_cmp(desc->uuid,
+						GATT_CLIENT_CHARAC_CFG_UUID)) {
+				svc->chrcs[i].ccc_handle = desc->handle;
+
+				if (svc_chngd_chrc)
+					svc_chngd_ccc_handle = desc->handle;
+			}
+		}
+	}
+
+includes:
+	if (!num_includes)
+		goto done;
+
+	svc->includes = new0(bt_gatt_included_service_t, num_includes);
+	if (!svc->includes)
+		goto fail;
+
+	memcpy(svc->includes, includes,
+			sizeof(bt_gatt_included_service_t) * num_includes);
+	svc->num_includes = num_includes;
+
+done:
+	l->gatt_svc_handle = gatt_svc_handle;
+	l->svc_chngd_val_handle = svc_chngd_val_handle;
+	l->svc_chngd_ccc_handle = svc_chngd_ccc_handle;
+
+	return true;
+
+fail:
+	service_list_clear_range(&l->head, &l->tail, service->start_handle,
+							service->end_handle);
+	return false;
+}
+
+void bt_gatt_service_list_free(struct bt_gatt_service_list *l)
+{
+	if (!l)
+		return;
+
+	service_list_clear(&l->head, &l->tail);
+	free(l);
+}
+
 bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
 						struct bt_gatt_client *client)
 {
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index adccfc5..9a4a160 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -28,8 +28,16 @@
 #define BT_GATT_UUID_SIZE 16
 
 struct bt_gatt_client;
+struct bt_gatt_service_list;
 
-struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu);
+/*
+ * Creates a new bt_gatt_client. If "services" is not NULL and non-empty, then
+ * the in memory service cache of bt_gatt_client will be populated based on the
+ * given list, otherwise bt_gatt_client will perform GATT service discovery to
+ * populate its cache.
+ */
+struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu,
+					struct bt_gatt_service_list *services);
 
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client);
 void bt_gatt_client_unref(struct bt_gatt_client *client);
@@ -38,6 +46,9 @@ typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
 typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
 typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
 typedef void (*bt_gatt_client_write_long_callback_t)(bool success,
 					bool reliable_error, uint8_t att_ecode,
 					void *user_data);
@@ -65,6 +76,7 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
 
+/* Structures that represent GATT definitions */
 typedef struct {
 	bool primary;
 	uint16_t start_handle;
@@ -94,6 +106,17 @@ typedef struct {
 	uint8_t uuid[BT_GATT_UUID_SIZE];
 } bt_gatt_included_service_t;
 
+/* Function for manipulating a bt_gatt_service_list */
+struct bt_gatt_service_list *bt_gatt_service_list_new(void);
+bool bt_gatt_service_list_add_service(struct bt_gatt_service_list *l,
+					bt_gatt_service_t *service,
+					bt_gatt_characteristic_t *chrcs,
+					size_t num_chrcs,
+					bt_gatt_included_service_t *includes,
+					size_t num_includes);
+void bt_gatt_service_list_free(struct bt_gatt_service_list *l);
+
+/* Structures and functions for iterating through a bt_gatt_client's services */
 struct bt_gatt_service_iter {
 	struct bt_gatt_client *client;
 	void *ptr;
@@ -130,10 +153,7 @@ bool bt_gatt_include_service_iter_init(struct bt_gatt_incl_service_iter *iter,
 bool bt_gatt_include_service_iter_next(struct bt_gatt_incl_service_iter *iter,
 					const bt_gatt_included_service_t **inc);
 
-typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
-					void *user_data);
-
+/* Functions for GATT client-role procedures */
 bool bt_gatt_client_read_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bt_gatt_client_read_callback_t callback,
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 7a1204f..2d480bc 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -130,7 +130,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 	}
 
 	cli->fd = fd;
-	cli->gatt = bt_gatt_client_new(att, mtu);
+	cli->gatt = bt_gatt_client_new(att, mtu, NULL);
 	if (!cli->gatt) {
 		fprintf(stderr, "Failed to create GATT client\n");
 		bt_att_unref(att);
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 9ded1f0..900f5e3 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -448,7 +448,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 		bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
 		break;
 	case CLIENT:
-		context->client = bt_gatt_client_new(att, mtu);
+		context->client = bt_gatt_client_new(att, mtu, NULL);
 		g_assert(context->client);
 
 		if (g_test_verbose())
-- 
2.1.0.rc2.206.gedb03e5

