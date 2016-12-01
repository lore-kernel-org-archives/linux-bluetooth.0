Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/gatt-db: Make gatt_db_clear call gatt_db_clear_range
Date: Thu,  1 Dec 2016 22:40:29 +0200
Message-Id: <20161201204030.27626-2-luiz.dentz@gmail.com>
In-Reply-To: <20161201204030.27626-1-luiz.dentz@gmail.com>
References: <20161201204030.27626-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes gatt_db_clear much simpler while making gatt_db_clear_range
detect full database clear resetting next_handle properly if the
database is empty.
---
 src/shared/gatt-db.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 513451f..8ef6f3b 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -410,14 +410,7 @@ bool gatt_db_remove_service(struct gatt_db *db,
 
 bool gatt_db_clear(struct gatt_db *db)
 {
-	if (!db)
-		return false;
-
-	queue_remove_all(db->services, NULL, NULL, gatt_db_service_destroy);
-
-	db->next_handle = 0;
-
-	return true;
+	return gatt_db_clear_range(db, 1, UINT16_MAX);
 }
 
 static void gatt_db_service_get_handles(const struct gatt_db_service *service,
@@ -455,12 +448,23 @@ bool gatt_db_clear_range(struct gatt_db *db, uint16_t start_handle,
 	if (!db || start_handle > end_handle)
 		return false;
 
+	/* Check if it is a full clear */
+	if (start_handle == 1 && end_handle == UINT16_MAX) {
+		queue_remove_all(db->services, NULL, NULL,
+						gatt_db_service_destroy);
+		goto done;
+	}
+
 	range.start = start_handle;
 	range.end = end_handle;
 
 	queue_remove_all(db->services, match_range, &range,
 						gatt_db_service_destroy);
 
+done:
+	if (gatt_db_isempty(db))
+		db->next_handle = 0;
+
 	return true;
 }
 
-- 
2.9.3

