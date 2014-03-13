Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v2 01/17] shared: Add put_uuid()
Date: Thu, 13 Mar 2014 11:38:37 -0300
Message-Id: <1394721533-6932-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add helper to put 16/32/128-bit UUID values to the given buffer using
little-endian representation.
---
 src/shared/util.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index d7d4a94..f614c99 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -26,6 +26,8 @@
 #include <alloca.h>
 #include <byteswap.h>
 
+#include "lib/uuid.h"
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
 #define le32_to_cpu(val) (val)
@@ -90,3 +92,13 @@ void util_debug(util_debug_func_t function, void *user_data,
 
 void util_hexdump(const char dir, const unsigned char *buf, size_t len,
 				util_debug_func_t function, void *user_data);
+
+static inline void put_uuid(const bt_uuid_t *src, void *dst)
+{
+	if (src->type == BT_UUID16)
+		put_unaligned(cpu_to_le16(src->value.u16), (uint16_t *) dst);
+	else if (src->type == BT_UUID32)
+		put_unaligned(cpu_to_le32(src->value.u32), (uint32_t *) dst);
+	else
+		htob128(&(src->value.u128), (uint128_t *) dst);
+}
-- 
1.8.3.1

