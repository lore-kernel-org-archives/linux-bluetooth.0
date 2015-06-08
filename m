Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/gatt-client: Simplify ready flag
Date: Mon,  8 Jun 2015 16:35:44 +0300
Message-Id: <1433770545-14938-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1433770545-14938-1-git-send-email-luiz.dentz@gmail.com>
References: <1433770545-14938-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes notify_client_ready takes care of setting ready flag so the
caller code don't have to set it before calling notify_client_ready.
---
 src/shared/gatt-client.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index ee3f984..724fc53 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1031,10 +1031,11 @@ done:
 static void notify_client_ready(struct bt_gatt_client *client, bool success,
 							uint8_t att_ecode)
 {
-	if (!client->ready_callback)
+	if (!client->ready_callback || client->ready)
 		return;
 
 	bt_gatt_client_ref(client);
+	client->ready = success;
 	client->ready_callback(success, att_ecode, client->ready_data);
 	bt_gatt_client_unref(client);
 }
@@ -1304,10 +1305,7 @@ static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
 			client->svc_chngd_ind_id);
 
 done:
-	if (!client->ready) {
-		client->ready = success;
-		notify_client_ready(client, success, att_ecode);
-	}
+	notify_client_ready(client, success, att_ecode);
 }
 
 static bool register_service_changed(struct bt_gatt_client *client)
@@ -1474,10 +1472,8 @@ static void init_complete(struct discovery_op *op, bool success,
 	if (!success)
 		goto fail;
 
-	if (register_service_changed(client)) {
-		client->ready = true;
+	if (register_service_changed(client))
 		goto done;
-	}
 
 	util_debug(client->debug_callback, client->debug_data,
 			"Failed to register handler for \"Service Changed\"");
-- 
2.1.0

