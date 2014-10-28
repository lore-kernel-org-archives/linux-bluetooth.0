Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/9] shared/gatt-db: Add gatt_db_attribute_read
Date: Tue, 28 Oct 2014 18:18:40 +0200
Message-Id: <1414513123-5689-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414513123-5689-1-git-send-email-luiz.dentz@gmail.com>
References: <1414513123-5689-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index f43cac3..b5b6c72 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -891,7 +891,23 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, bdaddr_t *bdaddr,
 				gatt_db_attribute_read_t func, void *user_data)
 {
-	return false;
+	if (!attrib || !func)
+		return false;
+
+	if (attrib->read_func) {
+		attrib->read_func(attrib->handle, offset, opcode, bdaddr,
+							attrib->user_data);
+		return true;
+	}
+
+	/* Check length boundary if value is stored in the db */
+	if (offset >= attrib->value_len)
+		return false;
+
+	func(attrib, 0, &attrib->value[offset], attrib->value_len - offset,
+								user_data);
+
+	return true;
 }
 
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
-- 
1.9.3

