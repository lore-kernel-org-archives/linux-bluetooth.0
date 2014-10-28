Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/9] shared/gatt-db: Add gatt_db_attribute_write
Date: Tue, 28 Oct 2014 18:18:41 +0200
Message-Id: <1414513123-5689-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414513123-5689-1-git-send-email-luiz.dentz@gmail.com>
References: <1414513123-5689-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b5b6c72..5a912f8 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -900,7 +900,7 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 		return true;
 	}
 
-	/* Check length boundary if value is stored in the db */
+	/* Check boundary if value is stored in the db */
 	if (offset >= attrib->value_len)
 		return false;
 
@@ -916,5 +916,33 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					gatt_db_attribute_write_t func,
 					void *user_data)
 {
-	return false;
+	if (!attrib)
+		return false;
+
+	if (attrib->write_func) {
+		attrib->write_func(attrib->handle, offset, value, len, opcode,
+						bdaddr, attrib->user_data);
+		return true;
+	}
+
+	/* For values stored in db allocate on demand */
+	if (!attrib->value) {
+		attrib->value = malloc0(len + offset);
+		if (!attrib->value)
+			return false;
+		attrib->value_len = len + offset;
+	} else if (offset >= attrib->value_len ||
+				len > (unsigned) (attrib->value_len - offset)) {
+		attrib->value = realloc(attrib->value, len + offset);
+		if (!attrib->value)
+			return 0;
+		attrib->value_len = len + offset;
+	}
+
+	memcpy(&attrib->value[offset], value, len);
+
+	if (func)
+		func(attrib, 0, user_data);
+
+	return true;
 }
-- 
1.9.3

