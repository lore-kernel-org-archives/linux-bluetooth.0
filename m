Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] shared/gatt: Define Read only permissions value while creating database
Date: Wed, 28 May 2014 08:53:58 +0200
Message-Id: <1401260041-693-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This value will be set by user when creating database. It is needed
to set proper permissions in service declaration, include declaration
and characteristic declaration.
---
 android/gatt.c       |  2 +-
 src/shared/gatt-db.c | 13 +++++++------
 src/shared/gatt-db.h |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9234b46..99e91f4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5497,7 +5497,7 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	gatt_apps = queue_new();
 	app_connections = queue_new();
 	listen_apps = queue_new();
-	gatt_db = gatt_db_new();
+	gatt_db = gatt_db_new(GATT_PERM_READ);
 	crypto = bt_crypto_new();
 
 	if (!gatt_devices || !gatt_apps || !listen_apps ||
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 998e93e..5d5739d 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -43,6 +43,7 @@ static const bt_uuid_t included_service_uuid = { .type = BT_UUID16,
 struct gatt_db {
 	uint16_t next_handle;
 	struct queue *services;
+	uint32_t read_only_perm;
 };
 
 struct gatt_db_attribute {
@@ -107,7 +108,7 @@ static void attribute_destroy(void *data)
 	free(attribute);
 }
 
-struct gatt_db *gatt_db_new(void)
+struct gatt_db *gatt_db_new(uint32_t read_only_perm)
 {
 	struct gatt_db *db;
 
@@ -121,6 +122,7 @@ struct gatt_db *gatt_db_new(void)
 		return NULL;
 	}
 
+	db->read_only_perm = read_only_perm;
 	db->next_handle = 0x0001;
 
 	return db;
@@ -192,6 +194,8 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 		return 0;
 	}
 
+	service->attributes[0]->permissions = db->read_only_perm;
+
 	if (!queue_push_tail(db->services, service)) {
 		gatt_db_service_destroy(service);
 		return 0;
@@ -301,6 +305,7 @@ uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
 	if (!service->attributes[i])
 		return 0;
 
+	service->attributes[i]->permissions = db->read_only_perm;
 	update_attribute_handle(service, i++);
 
 	service->attributes[i] = new_attribute(uuid, NULL, 0);
@@ -389,11 +394,7 @@ uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
 	if (!service->attributes[index])
 		return 0;
 
-	/* The Attribute Permissions shall be read only and not require
-	 * authentication or authorization. Vol 2. Part G. 3.2
-	 *
-	 * TODO handle permissions
-	 */
+	service->attributes[0]->permissions = db->read_only_perm;
 	set_attribute_data(service->attributes[index], NULL, NULL, 0, NULL);
 
 	return update_attribute_handle(service, index);
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f2f2f4d..7336823 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -23,7 +23,7 @@
 
 struct gatt_db;
 
-struct gatt_db *gatt_db_new(void);
+struct gatt_db *gatt_db_new(uint32_t read_only_perm);
 void gatt_db_destroy(struct gatt_db *db);
 
 uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
-- 
1.9.0

