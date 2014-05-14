Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 09/15] shared/gatt: Remove unused structure
Date: Wed, 14 May 2014 20:30:10 +0200
Message-Id: <1400092216-10358-10-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400092216-10358-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400092216-10358-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This structure is no longer used.
---
 src/shared/gatt-db.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 02d564b..24bce21 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -90,11 +90,6 @@ void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 							const bt_uuid_t type,
 							struct queue *queue);
 
-struct gatt_db_find_information {
-	uint16_t handle;
-	bt_uuid_t uuid;
-};
-
 void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							struct queue *queue);
-- 
1.9.0

