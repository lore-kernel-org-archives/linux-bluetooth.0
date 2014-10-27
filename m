Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9] shared/gatt-db: Add gatt_db_attribute_write
Date: Mon, 27 Oct 2014 18:04:58 +0200
Message-Id: <1414425900-21784-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
References: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index acd2e9a..4ff7358 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -906,5 +906,20 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					gatt_db_attribute_write_t func,
 					void *user_data)
 {
-	return false;
+	if (!attrib)
+		return false;
+
+	if (offset > attrib->value_len ||
+				len > (unsigned) (attrib->value_len - offset))
+		return false;
+
+	if (attrib->write_func) {
+		attrib->write_func(attrib->handle, offset, value, len, opcode,
+						bdaddr, attrib->user_data);
+		return true;
+	}
+
+	memcpy(&attrib->value[offset], value, len);
+
+	return true;
 }
-- 
1.9.3

