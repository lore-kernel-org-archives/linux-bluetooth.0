Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v5 01/16] shared: Add bswap_128()
Date: Tue, 18 Mar 2014 17:26:16 -0300
Message-Id: <1395174391-27251-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds a new helper to swap 128-bit values. It is intended to be used for
GATT 128-bit UUID handling, converting 128-bit UUID from big-endian to
little-endian (or the opposite).

No matter the system, bt_uuid_t should always store 128-bit UUID value
using big-endian format (similar to human-readable format).
---
 src/shared/util.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index cc2dbcd..f9170bb 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -91,6 +91,16 @@ void util_debug(util_debug_func_t function, void *user_data,
 void util_hexdump(const char dir, const unsigned char *buf, size_t len,
 				util_debug_func_t function, void *user_data);
 
+static inline void bswap_128(const void *src, void *dst)
+{
+	const uint8_t *s = src;
+	uint8_t *d = dst;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		d[15 - i] = s[i];
+}
+
 static inline void put_le16(uint16_t val, void *dst)
 {
 	put_unaligned(cpu_to_le16(val), (uint16_t *) dst);
-- 
1.8.3.1

