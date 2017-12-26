Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ahmed Alsharif <ahmeds2000x@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ahmed <ahmeds2000x@gmail.com>
Subject: [PATCH BlueZ 1/1] Fix bug in characteristic_start_notify.
Date: Tue, 26 Dec 2017 04:55:08 +0100
Message-Id: <20171226035508.30625-2-ahmeds2000x@gmail.com>
In-Reply-To: <20171226035508.30625-1-ahmeds2000x@gmail.com>
References: <20171226035508.30625-1-ahmeds2000x@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ahmed <ahmeds2000x@gmail.com>

---
 src/gatt-client.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 2f01867dc..f08bfdfb5 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1514,6 +1514,9 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	struct async_dbus_op *op;
 	struct notify_client *client;
 
+	if (!gatt)
+		return btd_error_not_connected(msg);
+
 	if (chrc->notify_io)
 		return btd_error_not_permitted(msg, "Notify acquired");
 
@@ -1535,26 +1538,6 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	queue_push_tail(chrc->notify_clients, client);
 	queue_push_tail(chrc->service->client->all_notify_clients, client);
 
-	/*
-	 * If the device is currently not connected, return success. We will
-	 * automatically try and register all clients when a GATT client becomes
-	 * ready.
-	 */
-	if (!gatt) {
-		DBusMessage *reply;
-
-		reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-		if (reply)
-			return reply;
-
-		/*
-		 * Clean up and respond with an error instead of timing out to
-		 * avoid any ambiguities.
-		 */
-		error("Failed to construct D-Bus message reply");
-		goto fail;
-	}
-
 	op = async_dbus_op_new(msg, client);
 
 	client->notify_id = bt_gatt_client_register_notify(gatt,
@@ -1565,15 +1548,6 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 		return NULL;
 
 	async_dbus_op_free(op);
-
-fail:
-	queue_remove(chrc->notify_clients, client);
-	queue_remove(chrc->service->client->all_notify_clients, client);
-
-	/* Directly free the client */
-	notify_client_free(client);
-
-	return btd_error_failed(msg, "Failed to register notify session");
 }
 
 static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
-- 
2.11.0

