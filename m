Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/8] shared/gatt-db: Fix bug in maximum handle check.
Date: Fri, 28 Nov 2014 09:49:15 -0800
Message-Id: <1417196962-3876-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1417196962-3876-1-git-send-email-armansito@chromium.org>
References: <1417196962-3876-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

0xffff is a valid handle and many devices return it as the end group
of their last service. This patch fixes a bug that prevents adding or
inserting such a service into the database.
---
 src/shared/gatt-db.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2515e5a..30fa4df 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -265,7 +265,7 @@ struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
 {
 	struct gatt_db_service *service;
 
-	if (!db || (num_handles + db->next_handle) > UINT16_MAX)
+	if (!db || (num_handles + db->next_handle - 1) > UINT16_MAX)
 		return NULL;
 
 	service = gatt_db_service_create(uuid, primary, num_handles);
@@ -395,7 +395,7 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 	struct insert_loc_data data;
 	struct gatt_db_service *service;
 
-	if (!db || num_handles < 1 || handle + num_handles > UINT16_MAX)
+	if (!db || num_handles < 1 || (handle + num_handles - 1) > UINT16_MAX)
 		return NULL;
 
 	memset(&data, 0, sizeof(data));
@@ -423,7 +423,7 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 	service->num_handles = num_handles;
 
 	/* Fast-forward next_handle if the new service was added to the end */
-	db->next_handle = MAX(handle + num_handles + 1, db->next_handle);
+	db->next_handle = MAX(handle + num_handles, db->next_handle);
 
 	return service->attributes[0];
 
-- 
2.2.0.rc0.207.ga3a616c

