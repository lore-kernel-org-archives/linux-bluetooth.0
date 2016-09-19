Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt: Remove CCC state if no longer active
Date: Mon, 19 Sep 2016 18:10:13 +0300
Message-Id: <1474297813-8764-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device object cannot be found or the device is not connected and
is not paired remove the CCC state as it is no longer valid.
---
 src/gatt-database.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 126e1b3..0877b25 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -879,6 +879,7 @@ static void send_notification_to_device(void *data, void *user_data)
 	struct notify *notify = user_data;
 	struct ccc_state *ccc;
 	struct btd_device *device;
+	struct bt_gatt_server *server;
 
 	ccc = find_ccc_state(device_state, notify->ccc_handle);
 	if (!ccc)
@@ -891,7 +892,14 @@ static void send_notification_to_device(void *data, void *user_data)
 						&device_state->bdaddr,
 						device_state->bdaddr_type);
 	if (!device)
+		goto remove;
+
+	server = btd_device_get_gatt_server(device);
+	if (!server) {
+		if (!device_is_paired(device, device_state->bdaddr_type))
+			goto remove;
 		return;
+	}
 
 	/*
 	 * TODO: If the device is not connected but bonded, send the
@@ -899,19 +907,23 @@ static void send_notification_to_device(void *data, void *user_data)
 	 */
 	if (!notify->indicate) {
 		DBG("GATT server sending notification");
-		bt_gatt_server_send_notification(
-					btd_device_get_gatt_server(device),
+		bt_gatt_server_send_notification(server,
 					notify->handle, notify->value,
 					notify->len);
 		return;
 	}
 
 	DBG("GATT server sending indication");
-	bt_gatt_server_send_indication(btd_device_get_gatt_server(device),
-							notify->handle,
-							notify->value,
+	bt_gatt_server_send_indication(server, notify->handle, notify->value,
 							notify->len, conf_cb,
 							NULL, NULL);
+
+	return;
+
+remove:
+	/* Remove device state if device no longer exists or is not paired */
+	if (queue_remove(notify->database->device_states, device_state))
+		device_state_free(device_state);
 }
 
 static void send_notification_to_devices(struct btd_gatt_database *database,
-- 
2.7.4

