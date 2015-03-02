Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] core/gatt: Fix creating database without exprimental interfaces
Date: Mon,  2 Mar 2015 23:00:05 +0100
Message-Id: <1425333605-4310-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If bluetoothd is started without -E option gatt database should still
be created (just without experimental D-Bus interfaces).

This fix registering adapters if bluetoothd was started without -E
option.
---
 src/gatt-database.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 65100da..6f081fa 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -73,6 +73,7 @@ struct btd_gatt_database {
 	struct gatt_db_attribute *svc_chngd;
 	struct gatt_db_attribute *svc_chngd_ccc;
 	struct queue *services;
+	bool dbus_registered;
 };
 
 struct external_service {
@@ -298,6 +299,7 @@ static void service_free(void *data)
 static void gatt_database_free(void *data)
 {
 	struct btd_gatt_database *database = data;
+	const char *path = adapter_get_path(database->adapter);
 
 	if (database->le_io) {
 		g_io_channel_shutdown(database->le_io, FALSE, NULL);
@@ -316,6 +318,10 @@ static void gatt_database_free(void *data)
 	if (database->gap_handle)
 		adapter_service_remove(database->adapter, database->gap_handle);
 
+	if (database->dbus_registered)
+		g_dbus_unregister_interface(btd_get_dbus_connection(), path,
+							GATT_MANAGER_IFACE);
+
 	/* TODO: Persistently store CCC states before freeing them */
 	queue_destroy(database->device_states, device_state_free);
 	queue_destroy(database->services, service_free);
@@ -1678,11 +1684,11 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 						manager_methods, NULL, NULL,
 						database, NULL)) {
 		error("Failed to register " GATT_MANAGER_IFACE);
-		goto fail;
-	}
-
-	DBG("GATT Manager registered for adapter: %s",
+	} else {
+		DBG("GATT Manager registered for adapter: %s",
 						adapter_get_path(adapter));
+		database->dbus_registered = true;
+	}
 
 	register_core_services(database);
 
-- 
2.1.4

