Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 05/15] shared/gatt: Remove unused structure
Date: Wed, 14 May 2014 20:30:06 +0200
Message-Id: <1400092216-10358-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400092216-10358-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400092216-10358-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This structure is no longer used in gatt_db implementation.
---
 src/shared/gatt-db.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 62bac41..4f8b1df 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -85,12 +85,6 @@ void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
 							uint16_t length,
 							struct queue *queue);
 
-struct gatt_db_handle_value {
-	uint16_t handle;
-	uint16_t length;
-	uint8_t value[0];
-};
-
 void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
-- 
1.9.0

