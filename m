Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/9] shared/gatt-db: Add gatt_db_attribute_get_type
Date: Thu, 30 Oct 2014 15:57:39 +0200
Message-Id: <1414677465-19862-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
References: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 1bbd3c5..87a0653 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -839,7 +839,10 @@ uint16_t gatt_db_attribute_get_end_handle(struct gatt_db_attribute *attrib)
 
 const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
 {
-	return NULL;
+	if (!attrib)
+		return NULL;
+
+	return &attrib->uuid;
 }
 
 bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
-- 
1.9.3

