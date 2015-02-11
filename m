Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 08/13] core: Setup added/removed handlers in GATT server
Date: Tue, 10 Feb 2015 20:54:21 -0800
Message-Id: <1423630466-26327-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1423630466-26327-1-git-send-email-armansito@chromium.org>
References: <1423630466-26327-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Registered service added/removed handlers in btd_gatt_server.
---
 src/gatt-server.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/gatt-server.c b/src/gatt-server.c
index f9ff92d..22faece 100644
--- a/src/gatt-server.c
+++ b/src/gatt-server.c
@@ -47,6 +47,7 @@ static struct queue *servers = NULL;
 struct btd_gatt_server {
 	struct btd_adapter *adapter;
 	struct gatt_db *db;
+	unsigned int db_id;
 	GIOChannel *le_io;
 	struct queue *device_states;
 };
@@ -194,6 +195,7 @@ static void gatt_server_free(void *data)
 
 	/* TODO: Persistently store CCC states before freeing them */
 	queue_destroy(server->device_states, device_state_free);
+	gatt_db_unregister(server->db, server->db_id);
 	gatt_db_unref(server->db);
 	btd_adapter_unref(server->adapter);
 	free(server);
@@ -373,6 +375,43 @@ static void register_core_services(struct btd_gatt_server *server)
 	populate_gatt_service(server);
 }
 
+static void gatt_db_service_added(struct gatt_db_attribute *attrib,
+								void *user_data)
+{
+	/* TODO: Send out service changed signal */
+}
+
+static bool ccc_match_service(const void *data, const void *match_data)
+{
+	const struct ccc_state *ccc = data;
+	const struct gatt_db_attribute *attrib = match_data;
+	uint16_t start, end;
+
+	if (!gatt_db_attribute_get_service_handles(attrib, &start, &end))
+		return false;
+
+	return ccc->handle >= start && ccc->handle <= end;
+}
+
+static void remove_device_ccc(void *data, void *user_data)
+{
+	struct device_state *state = data;
+
+	queue_remove_all(state->ccc_states, ccc_match_service, user_data, free);
+}
+
+static void gatt_db_service_removed(struct gatt_db_attribute *attrib,
+								void *user_data)
+{
+	struct btd_gatt_server *server = user_data;
+
+	DBG("Local GATT service removed");
+
+	queue_foreach(server->device_states, remove_device_ccc, attrib);
+
+	/* TODO: Send out service changed signal */
+}
+
 bool btd_gatt_server_register_adapter(struct btd_adapter *adapter)
 {
 	struct btd_gatt_server *server;
@@ -405,6 +444,12 @@ bool btd_gatt_server_register_adapter(struct btd_adapter *adapter)
 	if (!server->device_states)
 		goto fail;
 
+	server->db_id = gatt_db_register(server->db, gatt_db_service_added,
+							gatt_db_service_removed,
+							server, NULL);
+	if (!server->db_id)
+		goto fail;
+
 	addr = btd_adapter_get_address(adapter);
 	server->le_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, addr,
-- 
2.2.0.rc0.207.ga3a616c

