Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 12/36] shared/gatt: Extend read callback with offset
Date: Tue, 29 Apr 2014 03:14:43 +0200
Message-Id: <1398734107-4793-14-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Offset is needed for read blob.
---
 src/shared/gatt-db.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index d1443cb..73f5119 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -30,8 +30,8 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 					bool primary, uint16_t num_handles);
 bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
 
-typedef void (*gatt_db_read_t) (uint16_t handle, void *req_data,
-							void *user_data);
+typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
+					void *req_data, void *user_data);
 
 typedef void (*gatt_db_write_t) (uint16_t handle, const uint8_t *value,
 						size_t len, void *req_data,
-- 
1.8.4

