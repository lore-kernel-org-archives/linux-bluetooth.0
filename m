Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/9] shared/gatt-db: Add gatt_db_get_attribute
Date: Mon, 27 Oct 2014 18:04:53 +0200
Message-Id: <1414425900-21784-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
References: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 75fdff2..c3fc2a7 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -797,7 +797,25 @@ bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
 struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 							uint16_t handle)
 {
-	return NULL;
+	struct gatt_db_service *service;
+	uint16_t service_handle;
+
+	if (!db || !handle)
+		return NULL;
+
+	service = queue_find(db->services, find_service_for_handle,
+							INT_TO_PTR(handle));
+	if (!service)
+		return NULL;
+
+	service_handle = service->attributes[0]->handle;
+
+	/*
+	 * We can safely get attribute from attributes array with offset,
+	 * because find_service_for_handle() check if given handle is
+	 * in service range.
+	 */
+	return service->attributes[handle - service_handle];
 }
 
 uint16_t gatt_db_attribute_get_start_handle(struct gatt_db_attribute *attrib)
-- 
1.9.3

