Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/10] shared/gatt-db: Add gatt_db_get_service
Date: Tue,  9 May 2017 23:48:31 +0300
Message-Id: <20170509204840.3270-2-luiz.dentz@gmail.com>
In-Reply-To: <20170509204840.3270-1-luiz.dentz@gmail.com>
References: <20170509204840.3270-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds gatt_db_get_service which can be used to lookup service by
handle.
---
 src/shared/gatt-db.c | 21 ++++++++++++++++++---
 src/shared/gatt-db.h |  3 +++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8ef6f3b..efd61f9 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1316,20 +1316,35 @@ static bool find_service_for_handle(const void *data, const void *user_data)
 	return (start <= handle) && (handle <= end);
 }
 
-struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
+struct gatt_db_attribute *gatt_db_get_service(struct gatt_db *db,
 							uint16_t handle)
 {
 	struct gatt_db_service *service;
-	int i;
 
 	if (!db || !handle)
 		return NULL;
 
 	service = queue_find(db->services, find_service_for_handle,
-							UINT_TO_PTR(handle));
+						UINT_TO_PTR(handle));
 	if (!service)
 		return NULL;
 
+	return service->attributes[0];
+}
+
+struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
+							uint16_t handle)
+{
+	struct gatt_db_attribute *attrib;
+	struct gatt_db_service *service;
+	int i;
+
+	attrib = gatt_db_get_service(db, handle);
+	if (!attrib)
+		return NULL;
+
+	service = attrib->service;
+
 	for (i = 0; i < service->num_handles; i++) {
 		if (!service->attributes[i])
 			continue;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 134ec63..f8277fd 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -170,6 +170,9 @@ unsigned int gatt_db_register(struct gatt_db *db,
 					gatt_db_destroy_func_t destroy);
 bool gatt_db_unregister(struct gatt_db *db, unsigned int id);
 
+struct gatt_db_attribute *gatt_db_get_service(struct gatt_db *db,
+							uint16_t handle);
+
 struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 							uint16_t handle);
 
-- 
2.9.3

