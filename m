Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt: Don't register attribute handler until core service are registered
Date: Tue,  8 Nov 2016 10:43:44 +0200
Message-Id: <1478594624-7399-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Wait until GAP and GATT service are registered to register attribute
handlers otherwise it may attempt to generate service changed without
having service changed registered which leads to print errors:

bluetoothd[2376]: Failed to obtain handles for "Service Changed" characteristic
---
 src/gatt-database.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 0877b25..d4bf5ad 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2600,12 +2600,6 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 	database->profiles = queue_new();
 	database->ccc_callbacks = queue_new();
 
-	database->db_id = gatt_db_register(database->db, gatt_db_service_added,
-							gatt_db_service_removed,
-							database, NULL);
-	if (!database->db_id)
-		goto fail;
-
 	addr = btd_adapter_get_address(adapter);
 	database->le_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, addr,
@@ -2641,6 +2635,13 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 
 	register_core_services(database);
 
+	database->db_id = gatt_db_register(database->db, gatt_db_service_added,
+							gatt_db_service_removed,
+							database, NULL);
+	if (!database->db_id)
+		goto fail;
+
+
 	return database;
 
 fail:
-- 
2.7.4

