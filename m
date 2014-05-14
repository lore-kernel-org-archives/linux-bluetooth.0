Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 07/15] shared/gatt: Add helper function to get attribute type
Date: Wed, 14 May 2014 20:30:08 +0200
Message-Id: <1400092216-10358-8-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400092216-10358-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400092216-10358-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will return uuid with attribute type or NULL if attribute was not
found in database.
---
 src/shared/gatt-db.c | 21 +++++++++++++++++++++
 src/shared/gatt-db.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index cb63754..0cca86f 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -730,3 +730,24 @@ bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
 
 	return true;
 }
+
+const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
+							uint16_t handle)
+{
+	struct gatt_db_service *service;
+	struct gatt_db_attribute *attribute;
+	uint16_t service_handle;
+
+	service = queue_find(db->services, find_service_for_handle,
+						INT_TO_PTR(handle));
+	if (!service)
+		return NULL;
+
+	service_handle = service->attributes[0]->handle;
+
+	attribute = service->attributes[handle - service_handle];
+	if (!attribute)
+		return NULL;
+
+	return &attribute->uuid;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 4f8b1df..02d564b 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -106,3 +106,6 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t att_opcode, bdaddr_t *bdaddr);
+
+const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
+							uint16_t handle);
-- 
1.9.0

