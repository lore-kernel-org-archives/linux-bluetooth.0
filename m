Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ahmed Alsharif <ahmeds2000x@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ahmed Alsharif <ahmeds2000x@gmail.com>
Subject: [PATCH BlueZ 1/1] remove InProgress error from StartNotify() The error is only returned when the device is not connected, even though StartNotify is supposed to work in that case as well.
Date: Sat, 30 Dec 2017 11:07:02 +0100
Message-Id: <20171230100702.14124-2-ahmeds2000x@gmail.com>
In-Reply-To: <20171230100702.14124-1-ahmeds2000x@gmail.com>
References: <20171230100702.14124-1-ahmeds2000x@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/gatt-api.txt  | 1 -
 src/gatt-client.c | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index ccf3a8b6d..681b1bd8f 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -162,7 +162,6 @@ Methods		array{byte} ReadValue(dict options)
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.NotPermitted
-					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotSupported
 
 		void StopNotify()
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 2f01867dc..5efbaa5ed 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1521,12 +1521,13 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 				chrc->props & BT_GATT_CHRC_PROP_INDICATE))
 		return btd_error_not_supported(msg);
 
-	/* Each client can only have one active notify session. */
+	/*
+	 * Each client can only have one active notify session. If the client
+	 * already has one, we just return with no error.
+	 */
 	client = queue_find(chrc->notify_clients, match_notify_sender, sender);
 	if (client)
-		return client->notify_id ?
-				g_dbus_create_reply(msg, DBUS_TYPE_INVALID) :
-				btd_error_in_progress(msg);
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 
 	client = notify_client_create(chrc, sender);
 	if (!client)
-- 
2.11.0

