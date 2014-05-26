Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/6] shared/gatt: Add helper for getting attribute's permissions
Date: Mon, 26 May 2014 11:10:25 +0200
Message-Id: <1401095429-28432-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will return attribute's permissions or 0 if attribute was not found.
---
 src/shared/gatt-db.c | 25 +++++++++++++++++++++++++
 src/shared/gatt-db.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 90c09bb..d6f3143 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -733,3 +733,28 @@ uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle)
 
 	return service->attributes[0]->handle + service->num_handles - 1;
 }
+
+uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle)
+{
+	struct gatt_db_attribute *attribute;
+	struct gatt_db_service *service;
+	uint16_t service_handle;
+
+	service = queue_find(db->services, find_service_for_handle,
+							INT_TO_PTR(handle));
+	if (!service)
+		return 0;
+
+	service_handle = service->attributes[0]->handle;
+
+	/*
+	 * We can safely get attribute from attributes array with offset,
+	 * because find_service_for_handle() check if given handle is
+	 * in service range.
+	 */
+	attribute = service->attributes[handle - service_handle];
+	if (!attribute)
+		return 0;
+
+	return attribute->permissions;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 350e34e..f2f2f4d 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -91,3 +91,5 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 							uint16_t handle);
 
 uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
+
+uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle);
-- 
1.9.0

