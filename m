Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/utils: Add helpers for bitfield fast uid generation
Date: Fri, 13 Feb 2015 16:10:33 +0200
Message-Id: <1423836633-2913-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1423819382-20018-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423819382-20018-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For small unique id generation we may use bitfield since it is very fast
and memory efficient. If we need to generate id from 1 to 64 helper
functions are added to utils.
---
 src/shared/util.c | 24 ++++++++++++++++++++++++
 src/shared/util.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 74ffb08..3ae6b9e 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -106,3 +106,27 @@ unsigned char util_get_dt(const char *parent, const char *name)
 
 	return DT_UNKNOWN;
 }
+
+/* Helpers for bitfield operations */
+/* Find unique id from 1 to max */
+uint8_t util_get_bitmap64_uid(uint64_t *bitmap, uint8_t max)
+{
+	uint64_t temp = *bitmap >> 1;
+	uint64_t id = 1;
+
+	for (; temp & 0x01; temp >>= 1)
+		id++;
+
+	if (id > max)
+		return 0;
+
+	*bitmap |= 0x01l << id;
+
+	return id;
+}
+
+/* Clear id bit in bitmap */
+void util_clear_bitmap64(uint64_t *bitmap, uint8_t id)
+{
+	*bitmap &= ~(0x01l << id);
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index 8437662..8f28c24 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -93,6 +93,9 @@ void util_hexdump(const char dir, const unsigned char *buf, size_t len,
 
 unsigned char util_get_dt(const char *parent, const char *name);
 
+uint8_t util_get_bitmap64_uid(uint64_t *bitmap, uint8_t max);
+void util_clear_bitmap64(uint64_t *bitmap, uint8_t id);
+
 static inline void bswap_128(const void *src, void *dst)
 {
 	const uint8_t *s = src;
-- 
2.1.0

