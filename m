Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 8/9] shared/gatt-db: Add gatt_db_attribute_read
Date: Fri, 31 Oct 2014 15:39:53 +0200
Message-Id: <1414762794-30166-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
References: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b447199..f6ce5f3 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -914,7 +914,28 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, bdaddr_t *bdaddr,
 				gatt_db_attribute_read_t func, void *user_data)
 {
-	return false;
+	uint8_t *value;
+
+	if (!attrib || !func)
+		return false;
+
+	if (attrib->read_func) {
+		/* TODO: Pass callback function to read_func */
+		attrib->read_func(attrib->handle, offset, opcode, bdaddr,
+							attrib->user_data);
+		return true;
+	}
+
+	/* Check boundary if value is stored in the db */
+	if (offset > attrib->value_len)
+		return false;
+
+	/* Guard against invalid access if offset equals to value length */
+	value = offset == attrib->value_len ? NULL : &attrib->value[offset];
+
+	func(attrib, 0, value, attrib->value_len - offset, user_data);
+
+	return true;
 }
 
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
-- 
1.9.3

