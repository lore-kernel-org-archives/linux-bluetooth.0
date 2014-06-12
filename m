Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/10] android/gatt: Do not disconnect immediately after discovering primaries
Date: Thu, 12 Jun 2014 15:33:27 +0300
Message-Id: <1402576409-9352-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402576409-9352-1-git-send-email-luiz.dentz@gmail.com>
References: <1402576409-9352-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is needed in Android in order react to services found.
---
 android/gatt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0a8684e..d63efc9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -68,6 +68,8 @@
 #define GATT_PERM_WRITE_SIGNED		0x00010000
 #define GATT_PERM_WRITE_SIGNED_MITM	0x00020000
 
+#define GATT_CONN_TIMEOUT 2
+
 static const uint8_t BLUETOOTH_UUID[] = {
 	0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
 	0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
@@ -169,6 +171,8 @@ struct app_connection {
 	struct queue *transactions;
 	int32_t id;
 
+	guint timeout_id;
+
 	bool wait_execute_write;
 };
 
@@ -832,6 +836,9 @@ static void destroy_connection(void *data)
 {
 	struct app_connection *conn = data;
 
+	if (conn->timeout_id > 0)
+		g_source_remove(conn->timeout_id);
+
 	if (!queue_find(gatt_devices, match_by_value, conn->device))
 		goto cleanup;
 
@@ -1213,6 +1220,17 @@ reply:
 	send_client_search_complete_notify(gatt_status, cb_data->conn->id);
 	free(cb_data);
 }
+static gboolean connection_timeout(void *user_data)
+{
+	struct app_connection *conn = user_data;
+
+	conn->timeout_id = 0;
+
+	queue_remove(app_connections, conn);
+	destroy_connection(conn);
+
+	return FALSE;
+}
 
 static void discover_primary_cb(uint8_t status, GSList *services,
 								void *user_data)
@@ -1255,8 +1273,9 @@ static void discover_primary_cb(uint8_t status, GSList *services,
 	bt_device_set_uuids(&dev->bdaddr, uuids);
 
 	free(cb_data);
-	queue_remove(app_connections, conn);
-	destroy_connection(conn);
+
+	conn->timeout_id = g_timeout_add_seconds(GATT_CONN_TIMEOUT,
+						connection_timeout, conn);
 }
 
 static guint search_dev_for_srvc(struct app_connection *conn, bt_uuid_t *uuid)
-- 
1.9.3

