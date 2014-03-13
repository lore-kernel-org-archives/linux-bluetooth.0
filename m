Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v3 05/20] shared: Add put_le128()
Date: Thu, 13 Mar 2014 17:22:33 -0300
Message-Id: <1394742168-31073-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add helper to put uint128 values to the given pointer using little-endian
representation. This helper is only a wrapper of cpu_to_le128().
---
 src/shared/util.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index cc2dbcd..f3db8fb 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -26,6 +26,8 @@
 #include <alloca.h>
 #include <byteswap.h>
 
+#include <bluetooth/bluetooth.h>
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
 #define le32_to_cpu(val) (val)
@@ -56,6 +58,27 @@
 #error "Unknown byte order"
 #endif
 
+#if __BYTE_ORDER == __BIG_ENDIAN
+
+static inline void cpu_to_le128(const uint128_t *src, uint128_t *dst)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		dst->data[15 - i] = src->data[i];
+}
+
+#else
+
+static inline void cpu_to_le128(const uint128_t *src, uint128_t *dst)
+{
+	*dst = *src;
+}
+
+#endif
+
+#define put_le128(val, dst) cpu_to_le128(val, dst)
+
 #define get_unaligned(ptr)			\
 ({						\
 	struct __attribute__((packed)) {	\
-- 
1.8.3.1

