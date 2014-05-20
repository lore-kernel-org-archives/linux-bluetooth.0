Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] shared/gatt: Add helper for getting attribute's permissions
Date: Tue, 20 May 2014 12:16:08 +0200
Message-Id: <1400580968-30559-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400580968-30559-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400580968-30559-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will return attribute's permissions or 0 if attribute was not found.
---
 src/shared/gatt-db.c | 20 ++++++++++++++++++++
 src/shared/gatt-db.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 36316af..29c900f 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -733,3 +733,23 @@ uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle)
 
 	return service->attributes[0]->handle + service->num_handles - 1;
 }
+
+uint8_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle)
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
+	attribute = service->attributes[handle - service_handle];
+	if (!attribute)
+		return 0;
+
+	return attribute->permissions;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 3d46730..d2a2ece 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -91,3 +91,5 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 							uint16_t handle);
 
 uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
+
+uint8_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle);
-- 
1.9.0

