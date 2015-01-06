Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 3/8] core: gatt: Implement GattCharacteristic1.StopNotify
Date: Mon,  5 Jan 2015 18:03:31 -0800
Message-Id: <1420509816-1376-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1420509816-1376-1-git-send-email-armansito@chromium.org>
References: <1420509816-1376-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the StopNotify method of
org.bluez.GattCharacteristic1.
---
 src/gatt-client.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 5c030ee..1edbafc 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1134,8 +1134,25 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	/* TODO: Implement */
-	return btd_error_failed(msg, "Not implemented");
+	struct characteristic *chrc = user_data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	const char *sender = dbus_message_get_sender(msg);
+	struct notify_client *client;
+
+	if (!chrc->notifying)
+		return btd_error_failed(msg, "Not notifying");
+
+	client = queue_remove_if(chrc->notify_clients, match_notify_sender,
+							(void *) sender);
+	if (!client)
+		return btd_error_failed(msg, "No notify session started");
+
+	bt_gatt_client_unregister_notify(gatt, client->notify_id);
+	update_notifying(chrc);
+
+	notify_client_unref(client);
+
+	return dbus_message_new_method_return(msg);
 }
 
 static void append_desc_path(void *data, void *user_data)
-- 
2.2.0.rc0.207.ga3a616c

