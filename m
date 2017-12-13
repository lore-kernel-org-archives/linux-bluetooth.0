Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/9] monitor: Detect string format
Date: Wed, 13 Dec 2017 10:36:47 -0200
Message-Id: <20171213123655.24277-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

User may enter UUID in string format other then 128 bits.
---
 monitor/uuid.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/monitor/uuid.c b/monitor/uuid.c
index 9839d03be..bc638a2f3 100644
--- a/monitor/uuid.c
+++ b/monitor/uuid.c
@@ -27,6 +27,7 @@
 #endif
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 
 #include "uuid.h"
@@ -735,12 +736,28 @@ const char *uuid32_to_str(uint32_t uuid)
 const char *uuidstr_to_str(const char *uuid)
 {
 	uint32_t val;
+	size_t len;
 	int i;
 
 	if (!uuid)
 		return NULL;
 
-	if (strlen(uuid) != 36)
+	len = strlen(uuid);
+
+	if (len < 36) {
+		char *endptr = NULL;
+
+		val = strtol(uuid, &endptr, 0);
+		if (!endptr || *endptr != '\0')
+			return NULL;
+
+		if (val > UINT16_MAX)
+			return uuid32_to_str(val);
+
+		return uuid16_to_str(val);
+	}
+
+	if (len != 36)
 		return NULL;
 
 	for (i = 0; uuid128_table[i].str; i++) {
-- 
2.13.6

