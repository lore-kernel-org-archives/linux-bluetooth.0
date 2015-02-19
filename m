Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/2] shared/gatt-db: Don't fail if realloc returns NULL
Date: Wed, 18 Feb 2015 16:12:33 -0800
Message-Id: <1424304754-11874-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

gatt_db_attribute_write returns false if realloc returns NULL in the
case where there is no callback. If the write is performed with a 0
length value and 0 offset, realloc will return NULL according to its
specification (as it will practically act as 'free'). This patch fixes
the code so that this case isn't treated as an error.
---
 src/shared/gatt-db.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 3d2e690..b331f54 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1464,7 +1464,7 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 	}
 
 	/* Guard against invalid access if offset equals to value length */
-	value = offset == attrib->value_len ? NULL : &attrib->value[offset];
+	value = attrib->value_len - offset ? &attrib->value[offset] : NULL;
 
 	func(attrib, 0, value, attrib->value_len - offset, user_data);
 
@@ -1557,15 +1557,14 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 		void *buf;
 
 		buf = realloc(attrib->value, len + offset);
-		if (!buf)
+		if (!buf && len + offset > 0)
 			return false;
 
-		attrib->value = buf;
-
 		/* Init data in the first allocation */
-		if (!attrib->value_len)
-			memset(attrib->value, 0, offset);
+		if (!attrib->value)
+			memset(buf, 0, offset);
 
+		attrib->value = buf;
 		attrib->value_len = len + offset;
 	}
 
-- 
2.2.0.rc0.207.ga3a616c

