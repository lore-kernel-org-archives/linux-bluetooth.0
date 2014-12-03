Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 1/8] shared/gatt-db: Add gatt_db_isempty.
Date: Tue,  2 Dec 2014 16:12:36 -0800
Message-Id: <1417565563-29239-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1417565563-29239-1-git-send-email-armansito@chromium.org>
References: <1417565563-29239-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the gatt_db_isempty function which returns true if the database
is not populated with any services.
---
 src/shared/gatt-db.c | 8 ++++++++
 src/shared/gatt-db.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b10db4a..238872c 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -205,6 +205,14 @@ void gatt_db_unref(struct gatt_db *db)
 	gatt_db_destroy(db);
 }
 
+bool gatt_db_isempty(struct gatt_db *db)
+{
+	if (!db)
+		return true;
+
+	return queue_isempty(db->services);
+}
+
 static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
 {
 	bt_uuid_t uuid128;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 7018b14..5db9f9b 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -29,6 +29,8 @@ struct gatt_db *gatt_db_new(void);
 struct gatt_db *gatt_db_ref(struct gatt_db *db);
 void gatt_db_unref(struct gatt_db *db);
 
+bool gatt_db_isempty(struct gatt_db *db);
+
 struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
 						const bt_uuid_t *uuid,
 						bool primary,
-- 
2.2.0.rc0.207.ga3a616c

