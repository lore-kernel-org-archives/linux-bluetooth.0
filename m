Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 11/14] core: gatt-server: Send "Service Changed"
Date: Wed, 11 Feb 2015 19:17:41 -0800
Message-Id: <1423711064-7390-12-git-send-email-armansito@chromium.org>
In-Reply-To: <1423711064-7390-1-git-send-email-armansito@chromium.org>
References: <1423711064-7390-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, the local GATT server sends out "Service Changed"
indications to devices that have configured the corresponding CCC
descriptor, when a local attribute database is modified.
---
 src/gatt-database.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 48c8321..6a3d095 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -30,6 +30,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
 #include "log.h"
 #include "adapter.h"
 #include "device.h"
@@ -385,10 +386,117 @@ static void register_core_services(struct btd_gatt_database *server)
 	populate_gatt_service(server);
 }
 
+struct not_data {
+	struct btd_gatt_database *server;
+	uint16_t handle, ccc_handle;
+	const uint8_t *value;
+	uint16_t len;
+	bool indicate;
+};
+
+static void conf_cb(void *user_data)
+{
+	DBG("GATT server received confirmation");
+}
+
+static void send_notification_to_device(void *data, void *user_data)
+{
+	struct device_state *device_state = data;
+	struct not_data *not_data = user_data;
+	struct ccc_state *ccc;
+	struct btd_device *device;
+
+	ccc = find_ccc_state(device_state, not_data->ccc_handle);
+	if (!ccc)
+		return;
+
+	if (!ccc->value[0] || (not_data->indicate && !(ccc->value[0] & 0x02)))
+		return;
+
+	device = btd_adapter_get_device(not_data->server->adapter,
+						&device_state->bdaddr,
+						device_state->bdaddr_type);
+	if (!device)
+		return;
+
+	/*
+	 * TODO: If the device is not connected but bonded, send the
+	 * notification/indication when it becomes connected.
+	 */
+
+	if (!not_data->indicate) {
+		DBG("GATT server sending notification");
+		bt_gatt_server_send_notification(
+					btd_device_get_gatt_server(device),
+					not_data->handle, not_data->value,
+					not_data->len);
+		return;
+	}
+
+	DBG("GATT server sending indication");
+	bt_gatt_server_send_indication(btd_device_get_gatt_server(device),
+							not_data->handle,
+							not_data->value,
+							not_data->len, conf_cb,
+							NULL, NULL);
+}
+
+static void send_notification_to_devices(struct btd_gatt_database *server,
+					uint16_t handle, const uint8_t *value,
+					uint16_t len, uint16_t ccc_handle,
+					bool indicate)
+{
+	struct not_data not_data;
+
+	memset(&not_data, 0, sizeof(not_data));
+
+	not_data.server = server;
+	not_data.handle = handle;
+	not_data.ccc_handle = ccc_handle;
+	not_data.value = value;
+	not_data.len = len;
+	not_data.indicate = indicate;
+
+	queue_foreach(server->device_states, send_notification_to_device,
+								&not_data);
+}
+
+static void send_service_changed(struct btd_gatt_database *server,
+					struct gatt_db_attribute *attrib)
+{
+	uint16_t start, end;
+	uint8_t value[4];
+	uint16_t handle, ccc_handle;
+
+	if (!gatt_db_attribute_get_service_handles(attrib, &start, &end)) {
+		error("Failed to obtain changed service handles");
+		return;
+	}
+
+	handle = gatt_db_attribute_get_handle(server->svc_chngd);
+	ccc_handle = gatt_db_attribute_get_handle(server->svc_chngd_ccc);
+
+	if (!handle || !ccc_handle) {
+		error("Failed to obtain handles for \"Service Changed\""
+							" characteristic");
+		return;
+	}
+
+	put_le16(start, value);
+	put_le16(end, value + 2);
+
+	send_notification_to_devices(server, handle, value, sizeof(value),
+							ccc_handle, true);
+}
+
 static void gatt_db_service_added(struct gatt_db_attribute *attrib,
 								void *user_data)
 {
-	/* TODO: Send out service changed signal */
+	struct btd_gatt_database *server = user_data;
+
+	DBG("GATT Service added to local database");
+
+	send_service_changed(server, attrib);
 }
 
 static bool ccc_match_service(const void *data, const void *match_data)
@@ -417,9 +525,9 @@ static void gatt_db_service_removed(struct gatt_db_attribute *attrib,
 
 	DBG("Local GATT service removed");
 
-	queue_foreach(server->device_states, remove_device_ccc, attrib);
+	send_service_changed(server, attrib);
 
-	/* TODO: Send out service changed signal */
+	queue_foreach(server->device_states, remove_device_ccc, attrib);
 }
 
 bool btd_gatt_database_register_adapter(struct btd_adapter *adapter)
-- 
2.2.0.rc0.207.ga3a616c

