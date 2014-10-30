Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 7/9] shared/gatt-db: Add gatt_db_attribute_write
Date: Thu, 30 Oct 2014 15:57:43 +0200
Message-Id: <1414677465-19862-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
References: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index a70af7b..6296a82 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -921,5 +921,30 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					gatt_db_attribute_write_t func,
 					void *user_data)
 {
-	return false;
+	if (!attrib && !func)
+		return false;
+
+	if (attrib->write_func) {
+		attrib->write_func(attrib->handle, offset, value, len, opcode,
+						bdaddr, attrib->user_data);
+		return true;
+	}
+
+	/* For values stored in db allocate on demand */
+	if (!attrib->value || offset >= attrib->value_len ||
+				len > (unsigned) (attrib->value_len - offset)) {
+		attrib->value = realloc(attrib->value, len + offset);
+		if (!attrib->value)
+			return false;
+		/* Init data in the first allocation */
+		if (!attrib->value_len)
+			memset(attrib->value, 0, offset);
+		attrib->value_len = len + offset;
+	}
+
+	memcpy(&attrib->value[offset], value, len);
+
+	func(attrib, 0, user_data);
+
+	return true;
 }
-- 
1.9.3

