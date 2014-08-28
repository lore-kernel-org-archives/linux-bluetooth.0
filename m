Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 08/13] shared/gatt-client: Add bt_gatt_client_set_debug.
Date: Thu, 28 Aug 2014 14:25:20 -0700
Message-Id: <1409261125-6673-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1409261125-6673-1-git-send-email-armansito@chromium.org>
References: <1409261125-6673-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the bt_gatt_client_set_debug function, which sets up a callback to be used
internally by util_debug.
---
 src/shared/gatt-client.c | 24 ++++++++++++++++++++++++
 src/shared/gatt-client.h |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 98fb456..7c2b7c6 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -28,6 +28,10 @@
 struct bt_gatt_client {
 	struct bt_att *att;
 	int ref_count;
+
+	bt_gatt_client_debug_func_t debug_callback;
+	bt_gatt_client_destroy_func_t debug_destroy;
+	void *debug_data;
 };
 
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
@@ -66,6 +70,9 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 	if (__sync_sub_and_fetch(&client->ref_count, 1))
 		return;
 
+	if (client->debug_destroy)
+		client->debug_destroy(client->debug_data);
+
 	bt_att_unref(client->att);
 	free(client);
 }
@@ -77,3 +84,20 @@ bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
 {
 	/* TODO */
 }
+
+bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
+					bt_gatt_client_debug_func_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy) {
+	if (!client)
+		return false;
+
+	if (client->debug_destroy)
+		client->debug_destroy(client->debug_data);
+
+	client->debug_callback = callback;
+	client->debug_destroy = destroy;
+	client->debug_data = user_data;
+
+	return true;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 73af7c9..65da93c 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -34,8 +34,13 @@ void bt_gatt_client_unref(struct bt_gatt_client *client);
 typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
 typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
+typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
 
 bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
+bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
+					bt_gatt_client_debug_func_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
-- 
2.1.0.rc2.206.gedb03e5

