Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 3/8] shared/utils: Add helpers for bitfield id generation
Date: Mon, 16 Feb 2015 15:02:25 +0200
Message-Id: <1424091750-29487-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For small unique id generation we may use bitfield since it is very fast
and memory efficient. Helpers are added to generate id from 1 to 32 to
utils.
---
 src/shared/util.c | 29 +++++++++++++++++++++++++++++
 src/shared/util.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 74ffb08..a70c709 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -33,6 +33,7 @@
 #include <unistd.h>
 #include <dirent.h>
 #include <limits.h>
+#include <string.h>
 
 #include "src/shared/util.h"
 
@@ -106,3 +107,31 @@ unsigned char util_get_dt(const char *parent, const char *name)
 
 	return DT_UNKNOWN;
 }
+
+/* Helpers for bitfield operations */
+
+/* Find unique id in range from 1 to max but no bigger then
+ * sizeof(int) * 8. ffs() is used since it is POSIX standard
+ */
+uint8_t util_get_uid(unsigned int *bitmap, uint8_t max)
+{
+	uint8_t id;
+
+	id = ffs(~*bitmap);
+
+	if (!id || id > max)
+		return 0;
+
+	*bitmap |= 1 << (id - 1);
+
+	return id;
+}
+
+/* Clear id bit in bitmap */
+void util_clear_uid(unsigned int *bitmap, uint8_t id)
+{
+	if (!id)
+		return;
+
+	*bitmap &= ~(1 << (id - 1));
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index 8437662..7dba1b3 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -93,6 +93,9 @@ void util_hexdump(const char dir, const unsigned char *buf, size_t len,
 
 unsigned char util_get_dt(const char *parent, const char *name);
 
+uint8_t util_get_uid(unsigned int *bitmap, uint8_t max);
+void util_clear_uid(unsigned int *bitmap, uint8_t id);
+
 static inline void bswap_128(const void *src, void *dst)
 {
 	const uint8_t *s = src;
-- 
2.1.0

