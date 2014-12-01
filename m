Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 2/2] shared/gatt-db: Prevent insert at invalid handle 0
Date: Mon,  1 Dec 2014 15:59:42 -0800
Message-Id: <1417478382-37027-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1417478382-37027-1-git-send-email-jamuraa@chromium.org>
References: <1417478382-37027-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handles can't be placed at 0x0000.
---
 src/shared/gatt-db.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2a35bae..2a0fcb1 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -376,7 +376,8 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 	struct insert_loc_data data;
 	struct gatt_db_service *service;
 
-	if (!db || num_handles < 1 || (handle + num_handles - 1) > UINT16_MAX)
+	if (!db || num_handles < 1 || handle < 1 ||
+					(handle + num_handles - 1) > UINT16_MAX)
 		return NULL;
 
 	memset(&data, 0, sizeof(data));
-- 
2.2.0.rc0.207.ga3a616c

