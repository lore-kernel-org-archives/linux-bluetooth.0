Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 09/23] shared/gatt-db: fix error read from invalid offset
Date: Wed, 21 Jan 2015 12:28:46 -0800
Message-Id: <1421872140-7581-10-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read from an invalid offset should return BT_ATT_ERROR_INVALID_OFFSET
instead of BT_ATT_ERROR_UNLIKELY.
---
 src/shared/gatt-db.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 47aae7f..780d640 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -29,6 +29,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/timeout.h"
 #include "src/shared/gatt-db.h"
+#include "src/shared/att-types.h"
 
 #ifndef MAX
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
@@ -1457,8 +1458,10 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 	}
 
 	/* Check boundary if value is stored in the db */
-	if (offset > attrib->value_len)
-		return false;
+	if (offset > attrib->value_len) {
+		func(attrib, BT_ATT_ERROR_INVALID_OFFSET, NULL, 0, user_data);
+		return true;
+	}
 
 	/* Guard against invalid access if offset equals to value length */
 	value = offset == attrib->value_len ? NULL : &attrib->value[offset];
-- 
2.2.0.rc0.207.ga3a616c

