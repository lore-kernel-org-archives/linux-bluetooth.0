Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/9] shared/gatt-db: Add gatt_db_attribute_read
Date: Mon, 27 Oct 2014 18:04:57 +0200
Message-Id: <1414425900-21784-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
References: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 9ead5e3..acd2e9a 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -882,7 +882,22 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, bdaddr_t *bdaddr,
 				gatt_db_attribute_read_t func, void *user_data)
 {
-	return false;
+	if (!attrib || !func)
+		return false;
+
+	if (offset > attrib->value_len)
+		return false;
+
+	if (attrib->read_func) {
+		attrib->read_func(attrib->handle, offset, opcode, bdaddr,
+							attrib->user_data);
+		return true;
+	}
+
+	func(attrib, 0, &attrib->value[offset], attrib->value_len - offset,
+								user_data);
+
+	return true;
 }
 
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
-- 
1.9.3

