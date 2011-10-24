Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH bluez] add get_le/get_be helpers
Date: Mon, 24 Oct 2011 12:20:04 +0300
Message-Id: <1319448004-8513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Helpers to access LE / BE values. In bluetooth there is a mixture
of LE / BE network byte order.
---
 lib/bluetooth.h |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index b0680e2..5bd4f03 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -125,6 +125,70 @@ do {						\
 	__p->__v = (val);			\
 } while(0)
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+static inline uint64_t bt_get_le64(void *ptr)
+{
+	return bt_get_unaligned((uint64_t *) ptr);
+}
+
+static inline uint64_t bt_get_be64(void *ptr)
+{
+	return bswap_64(bt_get_unaligned((uint64_t *) ptr));
+}
+
+static inline uint32_t bt_get_le32(void *ptr)
+{
+	return bt_get_unaligned((uint32_t *) ptr);
+}
+
+static inline uint32_t bt_get_be32(void *ptr)
+{
+	return bswap_32(bt_get_unaligned((uint32_t *) ptr));
+}
+
+static inline uint16_t bt_get_le16(void *ptr)
+{
+	return bt_get_unaligned((uint16_t *) ptr);
+}
+
+static inline uint16_t bt_get_be16(void *ptr)
+{
+	return bswap_16(bt_get_unaligned((uint16_t *) ptr));
+}
+#elif __BYTE_ORDER == __BIG_ENDIAN
+static inline uint64_t bt_get_le64(void *ptr)
+{
+	return bswap_64(bt_get_unaligned((uint64_t *) ptr));
+}
+
+static inline uint64_t bt_get_be64(void *ptr)
+{
+	return bt_get_unaligned((uint64_t *) ptr);
+}
+
+static inline uint32_t bt_get_le32(void *ptr)
+{
+	return bswap_32(bt_get_unaligned((uint32_t *) ptr));
+}
+
+static inline uint32_t bt_get_be32(void *ptr)
+{
+	return bt_get_unaligned((uint32_t *) ptr);
+}
+
+static inline uint16_t bt_get_le16(void *ptr)
+{
+	return bswap_16(bt_get_unaligned((uint16_t *) ptr));
+}
+
+static inline uint16_t bt_get_be16(void *ptr)
+{
+	return bt_get_unaligned((uint16_t *) ptr);
+}
+#else
+#error "Unknown byte order"
+#endif
+
 /* BD Address */
 typedef struct {
 	uint8_t b[6];
-- 
1.7.4.1

