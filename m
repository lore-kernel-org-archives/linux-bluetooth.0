Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 9/9] shared/gatt-db: Add gatt_db_attribute_get_end_handle
Date: Mon, 27 Oct 2014 18:05:00 +0200
Message-Id: <1414425900-21784-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
References: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2d812f4..29b9481 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -832,7 +832,10 @@ uint16_t gatt_db_attribute_get_start_handle(struct gatt_db_attribute *attrib)
 
 uint16_t gatt_db_attribute_get_end_handle(struct gatt_db_attribute *attrib)
 {
-	return 0;
+	if (!attrib)
+		return 0;
+
+	return attrib->handle + attrib->service->num_handles - 1;
 }
 
 const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
-- 
1.9.3

