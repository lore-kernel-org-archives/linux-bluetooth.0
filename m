Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/10] shared/gatt-client: Allow multiple ready callbacks
Date: Mon,  3 Jul 2017 15:11:40 +0300
Message-Id: <20170703121148.24299-3-luiz.dentz@gmail.com>
In-Reply-To: <20170703121148.24299-1-luiz.dentz@gmail.com>
References: <20170703121148.24299-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the ready callbacks much more convenient to track when the
client is ready since its is now possible to notify more than on client
at the same time.
---
 peripheral/gatt.c        |  4 ++--
 src/device.c             | 10 ++++----
 src/shared/gatt-client.c | 60 ++++++++++++++++++++++++++++++++++++------------
 src/shared/gatt-client.h |  4 +++-
 tools/btgatt-client.c    |  2 +-
 unit/test-gatt.c         |  4 ++--
 6 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index 4c5531d..5ae19a8 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -145,8 +145,8 @@ static struct gatt_conn *gatt_conn_new(int fd)
 		return NULL;
 	}
 
-	bt_gatt_client_set_ready_handler(conn->client,
-				client_ready_callback, conn, NULL);
+	bt_gatt_client_ready_register(conn->client, client_ready_callback,
+								conn, NULL);
 	bt_gatt_client_set_service_changed(conn->client,
 				client_service_changed_callback, conn, NULL);
 
diff --git a/src/device.c b/src/device.c
index def192f..8cb79df 100644
--- a/src/device.c
+++ b/src/device.c
@@ -226,6 +226,7 @@ struct btd_device {
 	struct gatt_db *db;			/* GATT db cache */
 	struct bt_gatt_client *client;		/* GATT client instance */
 	struct bt_gatt_server *server;		/* GATT server instance */
+	unsigned int gatt_ready_id;
 
 	struct btd_gatt_client *client_dbus;
 
@@ -550,7 +551,7 @@ static void gatt_client_cleanup(struct btd_device *device)
 
 	gatt_cache_cleanup(device);
 	bt_gatt_client_set_service_changed(device->client, NULL, NULL, NULL);
-	bt_gatt_client_set_ready_handler(device->client, NULL, NULL, NULL);
+	bt_gatt_client_ready_unregister(device->client, device->gatt_ready_id);
 	bt_gatt_client_unref(device->client);
 	device->client = NULL;
 }
@@ -4718,10 +4719,11 @@ static void gatt_client_init(struct btd_device *device)
 	 */
 	device_accept_gatt_profiles(device);
 
-	if (!bt_gatt_client_set_ready_handler(device->client,
+	device->gatt_ready_id = bt_gatt_client_ready_register(device->client,
 							gatt_client_ready_cb,
-							device, NULL)) {
-		DBG("Failed to set ready handler");
+							device, NULL);
+	if (!device->gatt_ready_id) {
+		DBG("Failed to register GATT ready callback");
 		gatt_client_cleanup(device);
 		return;
 	}
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index fbf90ff..a34b001 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -51,6 +51,12 @@
 #define GATT_SVC_UUID	0x1801
 #define SVC_CHNGD_UUID	0x2a05
 
+struct ready_cb {
+	bt_gatt_client_callback_t callback;
+	bt_gatt_client_destroy_func_t destroy;
+	void *data;
+};
+
 struct bt_gatt_client {
 	struct bt_att *att;
 	int ref_count;
@@ -58,9 +64,7 @@ struct bt_gatt_client {
 	struct bt_gatt_client *parent;
 	struct queue *clones;
 
-	bt_gatt_client_callback_t ready_callback;
-	bt_gatt_client_destroy_func_t ready_destroy;
-	void *ready_data;
+	struct queue *ready_cbs;
 
 	bt_gatt_client_service_changed_callback_t svc_chngd_callback;
 	bt_gatt_client_destroy_func_t svc_chngd_destroy;
@@ -1097,17 +1101,35 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
+static void ready_destroy(void *data)
+{
+	struct ready_cb *ready = data;
+
+	if (ready->destroy)
+		ready->destroy(ready->data);
+
+	free(ready);
+}
+
 static void notify_client_ready(struct bt_gatt_client *client, bool success,
 							uint8_t att_ecode)
 {
 	const struct queue_entry *entry;
 
-	if (!client->ready_callback || client->ready)
+	if (client->ready)
 		return;
 
 	bt_gatt_client_ref(client);
 	client->ready = success;
-	client->ready_callback(success, att_ecode, client->ready_data);
+
+	for (entry = queue_get_entries(client->ready_cbs); entry;
+							entry = entry->next) {
+		struct ready_cb *ready = entry->data;
+
+		ready->callback(success, att_ecode, ready->data);
+	}
+
+	queue_remove_all(client->ready_cbs, NULL, NULL, ready_destroy);
 
 	/* Notify clones */
 	for (entry = queue_get_entries(client->clones); entry;
@@ -1731,8 +1753,7 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 
 	queue_destroy(client->notify_list, notify_data_cleanup);
 
-	if (client->ready_destroy)
-		client->ready_destroy(client->ready_data);
+	queue_destroy(client->ready_cbs, ready_destroy);
 
 	if (client->debug_destroy)
 		client->debug_destroy(client->debug_data);
@@ -1789,6 +1810,7 @@ static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 		goto fail;
 
 	client->clones = queue_new();
+	client->ready_cbs = queue_new();
 	client->long_write_queue = queue_new();
 	client->svc_chngd_queue = queue_new();
 	client->notify_list = queue_new();
@@ -1886,22 +1908,30 @@ bool bt_gatt_client_is_ready(struct bt_gatt_client *client)
 	return (client && client->ready);
 }
 
-bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_ready_register(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy)
 {
+	struct ready_cb *ready;
+
 	if (!client)
-		return false;
+		return 0;
 
-	if (client->ready_destroy)
-		client->ready_destroy(client->ready_data);
+	ready = new0(struct ready_cb, 1);
+	ready->callback = callback;
+	ready->destroy = destroy;
+	ready->data = user_data;
 
-	client->ready_callback = callback;
-	client->ready_destroy = destroy;
-	client->ready_data = user_data;
+	queue_push_tail(client->ready_cbs, ready);
 
-	return true;
+	return PTR_TO_UINT(ready);
+}
+
+bool bt_gatt_client_ready_unregister(struct bt_gatt_client *client,
+						unsigned int id)
+{
+	return queue_remove(client->ready_cbs, UINT_TO_PTR(id));
 }
 
 bool bt_gatt_client_set_service_changed(struct bt_gatt_client *client,
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index aceb570..6d8bf80 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -57,10 +57,12 @@ typedef void (*bt_gatt_client_service_changed_callback_t)(uint16_t start_handle,
 							void *user_data);
 
 bool bt_gatt_client_is_ready(struct bt_gatt_client *client);
-bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_ready_register(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
+bool bt_gatt_client_ready_unregister(struct bt_gatt_client *client,
+						unsigned int id);
 bool bt_gatt_client_set_service_changed(struct bt_gatt_client *client,
 			bt_gatt_client_service_changed_callback_t callback,
 			void *user_data,
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index f97963e..51bc362 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -235,7 +235,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 									NULL);
 	}
 
-	bt_gatt_client_set_ready_handler(cli->gatt, ready_cb, cli, NULL);
+	bt_gatt_client_ready_register(cli->gatt, ready_cb, cli, NULL);
 	bt_gatt_client_set_service_changed(cli->gatt, service_changed_cb, cli,
 									NULL);
 
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 15638dc..5d79e94 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -684,8 +684,8 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 		bt_gatt_client_set_debug(context->client, print_debug,
 						"bt_gatt_client:", NULL);
 
-		bt_gatt_client_set_ready_handler(context->client,
-						client_ready_cb, context, NULL);
+		bt_gatt_client_ready_register(context->client, client_ready_cb,
+								context, NULL);
 		break;
 	default:
 		break;
-- 
2.9.4

