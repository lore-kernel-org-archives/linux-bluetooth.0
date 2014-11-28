Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/8] shared/gatt-db: Add helper to get service handles.
Date: Fri, 28 Nov 2014 09:49:16 -0800
Message-Id: <1417196962-3876-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1417196962-3876-1-git-send-email-armansito@chromium.org>
References: <1417196962-3876-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds gatt_db_service_get_handles which is an internal helper
to obtain service handles from a gatt_db_service directly.
---
 src/shared/gatt-db.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 30fa4df..b210376 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -317,6 +317,18 @@ bool gatt_db_clear(struct gatt_db *db)
 	return true;
 }
 
+static void gatt_db_service_get_handles(const struct gatt_db_service *service,
+							uint16_t *start_handle,
+							uint16_t *end_handle)
+{
+	if (start_handle)
+		*start_handle = service->attributes[0]->handle;
+
+	if (end_handle)
+		*end_handle = service->attributes[0]->handle +
+						service->num_handles - 1;
+}
+
 struct clear_range {
 	uint16_t start, end;
 };
@@ -327,8 +339,7 @@ static bool match_range(const void *a, const void *b)
 	const struct clear_range *range = b;
 	uint16_t svc_start, svc_end;
 
-	svc_start = service->attributes[0]->handle;
-	svc_end = service->attributes[0]->handle + service->num_handles - 1;
+	gatt_db_service_get_handles(service, &svc_start, &svc_end);
 
 	return svc_start <= range->end && svc_end >= range->start;
 }
@@ -366,8 +377,7 @@ static void search_for_insert_loc(void *data, void *user_data)
 	if (loc_data->done)
 		return;
 
-	cur_start = service->attributes[0]->handle;
-	cur_end = service->attributes[0]->handle + service->num_handles - 1;
+	gatt_db_service_get_handles(service, &cur_start, &cur_end);
 
 	/* Abort if the requested range overlaps with an existing service. */
 	if ((loc_data->start >= cur_start && loc_data->start <= cur_end) ||
@@ -1038,8 +1048,8 @@ bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
 }
 
 bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
-						uint16_t *start_handle,
-						uint16_t *end_handle)
+							uint16_t *start_handle,
+							uint16_t *end_handle)
 {
 	struct gatt_db_service *service;
 
@@ -1048,12 +1058,7 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
 
 	service = attrib->service;
 
-	if (start_handle)
-		*start_handle = service->attributes[0]->handle;
-
-	if (end_handle)
-		*end_handle = service->attributes[0]->handle +
-						service->num_handles - 1;
+	gatt_db_service_get_handles(service, start_handle, end_handle);
 
 	return true;
 }
@@ -1073,11 +1078,7 @@ bool gatt_db_attribute_get_service_data(struct gatt_db_attribute *attrib,
 	service = attrib->service;
 	decl = service->attributes[0];
 
-	if (start_handle)
-		*start_handle = decl->handle;
-
-	if (end_handle)
-		*end_handle = decl->handle + service->num_handles - 1;
+	gatt_db_service_get_handles(service, start_handle, end_handle);
 
 	if (primary)
 		*primary = bt_uuid_cmp(&decl->uuid, &secondary_service_uuid);
-- 
2.2.0.rc0.207.ga3a616c

