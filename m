Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 13/15] shared/gatt: Remove unused structure
Date: Wed, 14 May 2014 12:18:17 +0200
Message-Id: <1400062699-2372-14-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This structure is no longer used.
---
 src/shared/gatt-db.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 6ec7e22..529abd0 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -60,13 +60,6 @@ uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
 bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
 								bool active);
 
-struct gatt_db_group {
-	uint16_t handle;
-	uint16_t end_group;
-	uint16_t len;
-	uint8_t value[0];
-};
-
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
-- 
1.9.0

