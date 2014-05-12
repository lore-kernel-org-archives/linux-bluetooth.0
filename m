Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] shared/gatt: Add function to get end group handle
Date: Mon, 12 May 2014 15:02:36 +0200
Message-Id: <1399899758-4944-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com>
References: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This helper will return end group handle of attribute.
---
 src/shared/gatt-db.c | 12 ++++++++++++
 src/shared/gatt-db.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 532e0b7..41457e2 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -744,3 +744,15 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 
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
index cc9120c..ddb40da 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -104,3 +104,5 @@ bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
 
 const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 							uint16_t handle);
+
+uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
-- 
1.8.5.3

