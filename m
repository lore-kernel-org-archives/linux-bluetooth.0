Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v4 02/10] shared/gatt-client: Guard against invalid access
Date: Tue, 16 Dec 2014 18:07:10 -0800
Message-Id: <1418782038-10999-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1418782038-10999-1-git-send-email-armansito@chromium.org>
References: <1418782038-10999-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a ref-count based guard around call sites that invoke
a callback set by the upper-layer, to prevent memory errors after the
callback returns.
---
 src/shared/gatt-client.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index e86c07f..f7a90d1 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -889,6 +889,17 @@ done:
 	op->complete_func(op, success, att_ecode);
 }
 
+static void notify_client_ready(struct bt_gatt_client *client, bool success,
+							uint8_t att_ecode)
+{
+	if (!client->ready_callback)
+		return;
+
+	bt_gatt_client_ref(client);
+	client->ready_callback(success, att_ecode, client->ready_data);
+	bt_gatt_client_unref(client);
+}
+
 static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 {
 	struct discovery_op *op = user_data;
@@ -902,10 +913,7 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 				att_ecode);
 
 		client->in_init = false;
-
-		if (client->ready_callback)
-			client->ready_callback(success, att_ecode,
-							client->ready_data);
+		notify_client_ready(client, success, att_ecode);
 
 		return;
 	}
@@ -930,9 +938,7 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 			"Failed to initiate primary service discovery");
 
 	client->in_init = false;
-
-	if (client->ready_callback)
-		client->ready_callback(false, att_ecode, client->ready_data);
+	notify_client_ready(client, false, att_ecode);
 
 	discovery_op_unref(op);
 }
@@ -1134,8 +1140,7 @@ static void service_changed_register_cb(unsigned int id, uint16_t att_ecode,
 			"Registered handler for \"Service Changed\": %u", id);
 
 done:
-	if (client->ready_callback)
-		client->ready_callback(success, att_ecode, client->ready_data);
+	notify_client_ready(client, success, att_ecode);
 }
 
 static void init_complete(struct discovery_op *op, bool success,
@@ -1194,8 +1199,7 @@ fail:
 	op->success = false;
 
 done:
-	if (client->ready_callback)
-		client->ready_callback(success, att_ecode, client->ready_data);
+	notify_client_ready(client, success, att_ecode);
 }
 
 static void init_fail(struct discovery_op *op)
@@ -1331,9 +1335,13 @@ static void enable_ccc_callback(uint8_t opcode, const void *pdu,
 	}
 
 	/* Success! Report success for all remaining requests. */
+	bt_gatt_client_ref(notify_data->client);
+
 	complete_notify_request(notify_data);
 	queue_remove_all(notify_data->chrc->reg_notify_queue, NULL, NULL,
 						complete_notify_request);
+
+	bt_gatt_client_unref(notify_data->client);
 }
 
 static void disable_ccc_callback(uint8_t opcode, const void *pdu,
@@ -1451,8 +1459,8 @@ static void att_disconnect_cb(int err, void *user_data)
 	client->in_init = false;
 	client->ready = false;
 
-	if (in_init && client->ready_callback)
-		client->ready_callback(false, 0, client->ready_data);
+	if (in_init)
+		notify_client_ready(client, false, 0);
 }
 
 struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
-- 
2.2.0.rc0.207.ga3a616c

