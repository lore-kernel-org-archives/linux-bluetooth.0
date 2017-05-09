Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/10] shared/gatt-db: Add gatt_db_service_insert_included
Date: Tue,  9 May 2017 23:48:32 +0300
Message-Id: <20170509204840.3270-3-luiz.dentz@gmail.com>
In-Reply-To: <20170509204840.3270-1-luiz.dentz@gmail.com>
References: <20170509204840.3270-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces gatt_db_service_insert_included which is a variant of
gatt_db_service_add_included containing the handle where it should be
inserted.
---
 src/shared/gatt-db.c | 40 ++++++++++++++++++++++++++++++++--------
 src/shared/gatt-db.h |  4 ++++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index efd61f9..2cb80ec 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -834,19 +834,15 @@ gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
 					user_data);
 }
 
-struct gatt_db_attribute *
-gatt_db_service_add_included(struct gatt_db_attribute *attrib,
+static struct gatt_db_attribute *
+service_insert_included(struct gatt_db_service *service, uint16_t handle,
 					struct gatt_db_attribute *include)
 {
-	struct gatt_db_service *service, *included;
+	struct gatt_db_service *included;
 	uint8_t value[MAX_INCLUDED_VALUE_LEN];
 	uint16_t included_handle, len = 0;
 	int index;
 
-	if (!attrib || !include)
-		return NULL;
-
-	service = attrib->service;
 	included = include->service;
 
 	/* Adjust include to point to the first attribute */
@@ -873,7 +869,14 @@ gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 	if (!index)
 		return NULL;
 
-	service->attributes[index] = new_attribute(service, 0,
+	/* Check if handle is in within service range */
+	if (handle && handle <= service->attributes[0]->handle)
+		return NULL;
+
+	if (!handle)
+		handle = get_handle_at_index(service, index - 1) + 1;
+
+	service->attributes[index] = new_attribute(service, handle,
 							&included_service_uuid,
 							value, len);
 	if (!service->attributes[index])
@@ -889,6 +892,27 @@ gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 	return attribute_update(service, index);
 }
 
+struct gatt_db_attribute *
+gatt_db_service_add_included(struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *include)
+{
+	if (!attrib || !include)
+		return NULL;
+
+	return service_insert_included(attrib->service, 0, include);
+}
+
+struct gatt_db_attribute *
+gatt_db_service_insert_included(struct gatt_db_attribute *attrib,
+				uint16_t handle,
+				struct gatt_db_attribute *include)
+{
+	if (!attrib || !handle || !include)
+		return NULL;
+
+	return service_insert_included(attrib->service, handle, include);
+}
+
 bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active)
 {
 	struct gatt_db_service *service;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f8277fd..19583e7 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -96,6 +96,10 @@ gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
 struct gatt_db_attribute *
 gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *include);
+struct gatt_db_attribute *
+gatt_db_service_insert_included(struct gatt_db_attribute *attrib,
+				uint16_t handle,
+				struct gatt_db_attribute *include);
 
 bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active);
 bool gatt_db_service_get_active(struct gatt_db_attribute *attrib);
-- 
2.9.3

