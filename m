Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 09/14] core: Add Service Changed characteristic
Date: Wed, 11 Feb 2015 19:17:39 -0800
Message-Id: <1423711064-7390-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1423711064-7390-1-git-send-email-armansito@chromium.org>
References: <1423711064-7390-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch exports the "Service Changed" characteristic and its CCC
descriptor in btd_gatt_server.
---
 src/gatt-database.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index b8dc361..48c8321 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -50,6 +50,8 @@ struct btd_gatt_database {
 	unsigned int db_id;
 	GIOChannel *le_io;
 	struct queue *device_states;
+	struct gatt_db_attribute *svc_chngd;
+	struct gatt_db_attribute *svc_chngd_ccc;
 };
 
 struct device_state {
@@ -359,12 +361,20 @@ static void populate_gatt_service(struct btd_gatt_database *server)
 {
 	bt_uuid_t uuid;
 	struct gatt_db_attribute *service;
+	uint16_t start_handle;
 
 	/* Add the GATT service */
 	bt_uuid16_create(&uuid, UUID_GATT);
-	service = gatt_db_add_service(server->db, &uuid, true, 1);
+	service = gatt_db_add_service(server->db, &uuid, true, 4);
+	gatt_db_attribute_get_service_handles(service, &start_handle, NULL);
 
-	/* TODO: Add "Service Changed" characteristic and handle CCC */
+	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
+	server->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
+				BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_INDICATE,
+				NULL, NULL, server);
+
+	server->svc_chngd_ccc = btd_gatt_database_add_ccc(server->adapter,
+								start_handle);
 
 	gatt_db_service_set_active(service, true);
 }
-- 
2.2.0.rc0.207.ga3a616c

