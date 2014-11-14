Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ] shared/gatt-db: Leave value untouched if realloc fails.
Date: Fri, 14 Nov 2014 12:35:09 -0800
Message-Id: <1415997309-28950-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

gatt_db_attribute_write currently sets the attrib->value pointer to NULL
and leaks the old memory block, since realloc leaves the initial block
untouched if it fails and returns NULL. This patch fixes this so that
the attribute value isn't modified if realloc fails.
---
 src/shared/gatt-db.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index a39eec2..ab08c69 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -929,12 +929,18 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 	/* For values stored in db allocate on demand */
 	if (!attrib->value || offset >= attrib->value_len ||
 				len > (unsigned) (attrib->value_len - offset)) {
-		attrib->value = realloc(attrib->value, len + offset);
-		if (!attrib->value)
+		void *buf;
+
+		buf = realloc(attrib->value, len + offset);
+		if (!buf)
 			return false;
+
+		attrib->value = buf;
+
 		/* Init data in the first allocation */
 		if (!attrib->value_len)
 			memset(attrib->value, 0, offset);
+
 		attrib->value_len = len + offset;
 	}
 
-- 
2.1.0.rc2.206.gedb03e5

