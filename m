Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] shared/gatt: Add function to check if handle was found in database
Date: Fri, 30 May 2014 07:51:12 +0200
Message-Id: <1401429074-31535-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401429074-31535-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401429074-31535-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will return true if attribute with given handle exists in db, otherwise
false.
---
 src/shared/gatt-db.c | 18 ++++++++++++++++++
 src/shared/gatt-db.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 998e93e..de1de57 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -758,3 +758,21 @@ uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle)
 
 	return attribute->permissions;
 }
+
+bool gatt_db_has_attribute(struct gatt_db *db, uint16_t handle)
+{
+	struct gatt_db_attribute *attribute;
+	struct gatt_db_service *service;
+	uint16_t service_handle;
+
+	service = queue_find(db->services, find_service_for_handle,
+							INT_TO_PTR(handle));
+	if (!service)
+		return false;
+
+	service_handle = service->attributes[0]->handle;
+
+	attribute = service->attributes[handle - service_handle];
+
+	return attribute ? true : false;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f2f2f4d..ca36d32 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -93,3 +93,4 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
 
 uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle);
+bool gatt_db_has_attribute(struct gatt_db *db, uint16_t handle);
-- 
1.9.0

