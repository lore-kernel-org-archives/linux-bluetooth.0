Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/9] shared/gatt-db: Add gatt_db_attribute_get_permissions
Date: Thu, 30 Oct 2014 15:57:41 +0200
Message-Id: <1414677465-19862-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
References: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index bb69032..00023db 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -879,7 +879,12 @@ bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
 bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
 							uint32_t *permissions)
 {
-	return false;
+	if (!attrib || !permissions)
+		return false;
+
+	*permissions = attrib->permissions;
+
+	return true;
 }
 
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
-- 
1.9.3

