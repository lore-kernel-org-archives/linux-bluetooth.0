Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] shared: Add helpers for address convertion
Date: Thu, 11 Jan 2018 10:32:02 +0100
Message-Id: <20180111093202.7194-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This add shared helpers for address convertion to and from string.
Those are also more error resiliant comparing to bdaddr converters
from lib/bluetooth.h.
---
 src/shared/util.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index 3f5f6dfb5..e86fc9ffc 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -26,6 +26,8 @@
 #include <alloca.h>
 #include <byteswap.h>
 #include <string.h>
+#include <stdbool.h>
+#include <stdio.h>
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
@@ -113,6 +115,20 @@ const char *bt_uuid32_to_str(uint32_t uuid);
 const char *bt_uuidstr_to_str(const char *uuid);
 const char *bt_appear_to_str(uint16_t appearance);
 
+static inline bool bt_addr_to_str(const uint8_t addr[6], char *str, size_t len)
+{
+	return snprintf(str, len, "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
+			addr[5], addr[4], addr[3], addr[2], addr[1],
+			addr[0]) == 17;
+}
+
+static inline bool str2addr(const char *str, uint8_t addr[6])
+{
+	return sscanf(str, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+			&addr[5], &addr[4], &addr[3], &addr[2], &addr[1],
+			&addr[0]) == 6;
+}
+
 static inline int8_t get_s8(const void *ptr)
 {
 	return *((int8_t *) ptr);
-- 
2.14.3

