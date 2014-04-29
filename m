Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 20/40] shared: Extend write callback with offset
Date: Tue, 29 Apr 2014 18:47:09 +0200
Message-Id: <1398790049-30303-21-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of prepare right offset is needed.
---
 src/shared/gatt-db.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 5a6513a..c1b7b41 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -38,7 +38,8 @@ typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
 						gatt_db_complete_func_t cb,
 						void *user_data);
 
-typedef void (*gatt_db_write_t) (uint16_t handle, const uint8_t *value,
+typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
+						const uint8_t *value,
 						size_t len, void *req_data,
 						gatt_db_complete_func_t cb,
 						void *user_data);
-- 
1.8.4

