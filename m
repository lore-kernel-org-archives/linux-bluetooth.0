Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 07/11] shared/gatt-client: Add bt_gatt_client_set_debug.
Date: Wed, 20 Aug 2014 13:15:33 -0700
Message-Id: <1408565737-8187-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1408565737-8187-1-git-send-email-armansito@chromium.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the bt_gatt_client_set_debug function, which sets up a callback to be used
internally by util_debug.
---
 src/shared/TODO          |  1 -
 src/shared/gatt-client.c | 23 +++++++++++++++++++++++
 src/shared/gatt-client.h |  6 ++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/src/shared/TODO b/src/shared/TODO
index 2881c97..d59e153 100644
--- a/src/shared/TODO
+++ b/src/shared/TODO
@@ -1,6 +1,5 @@
 TODOs for shared/gatt-client
 
-* Add util_debug support.
 * Add high-level abstraction for services, characteristics, and descriptors.
 * Implement service discovery.
 * Implement characteristic discovery.
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 53a7de1..a0d85e3 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -28,6 +28,10 @@
 struct bt_gatt_client {
 	struct bt_att *att;
 	bool persist;
+
+	bt_gatt_client_debug_func_t debug_callback;
+	bt_gatt_client_destroy_func_t debug_destroy;
+	void *debug_data;
 };
 
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att)
@@ -51,6 +55,9 @@ void bt_gatt_client_destroy(struct bt_gatt_client *client)
 	if (!client)
 		return;
 
+	if (client->debug_destroy)
+		client->debug_destroy(client->debug_data);
+
 	bt_att_unref(client->att);
 	free(client);
 }
@@ -74,6 +81,22 @@ struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client)
 	return client->att;
 }
 
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
 bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index a978691..4038b1e 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -38,6 +38,12 @@ typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
 typedef void (*bt_gatt_client_callback_t)(void *user_data);
 typedef void (*bt_gatt_client_service_changed_func_t)(uint16_t handle,
 							void *user_data);
+typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
+
+bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
+					bt_gatt_client_debug_func_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
 
 bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
 					bt_gatt_client_callback_t callback,
-- 
2.1.0.rc2.206.gedb03e5

