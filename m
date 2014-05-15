Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 10/15] shared/gatt: Add function to get end group handle
Date: Thu, 15 May 2014 15:02:32 +0200
Message-Id: <1400158957-22216-11-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function will return end group handle or zero if attribute
not found.
---
 src/shared/gatt-db.c | 12 ++++++++++++
 src/shared/gatt-db.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 0cca86f..2ac9f2d 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -751,3 +751,15 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 
 	return &attribute->uuid;
 }
+
+uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle)
+{
+	struct gatt_db_service *service;
+
+	service = queue_find(db->services, find_service_for_handle,
+						INT_TO_PTR(handle));
+	if (!service)
+		return 0;
+
+	return service->attributes[0]->handle + service->num_handles - 1;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 24bce21..1a18fb7 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -104,3 +104,5 @@ bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
 
 const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 							uint16_t handle);
+
+uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
-- 
1.9.0

