Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 04/15] Add helper functions for putting integers on unaligned memory address
Date: Fri, 31 Aug 2012 14:40:00 +0200
Message-ID: <1346416811-23484-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those functions are similar to bt_get_* functions.

---
 lib/bluetooth.h |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index f0776aa..7e6ced9 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -198,6 +198,37 @@ static inline uint16_t bt_get_be16(const void *ptr)
 {
 	return bswap_16(bt_get_unaligned((const uint16_t *) ptr));
 }
+
+static inline void bt_put_le64(uint64_t val, const void *ptr)
+{
+	bt_put_unaligned(val, (uint64_t *) ptr);
+}
+
+static inline void bt_put_be64(uint64_t val, const void *ptr)
+{
+	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
+}
+
+static inline void bt_put_le32(uint32_t val, const void *ptr)
+{
+	bt_put_unaligned(val, (uint32_t *) ptr);
+}
+
+static inline void bt_put_be32(uint32_t val, const void *ptr)
+{
+	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
+}
+
+static inline void bt_put_le16(uint16_t val, const void *ptr)
+{
+	bt_put_unaligned(val, (uint16_t *) ptr);
+}
+
+static inline void bt_put_be16(uint16_t val, const void *ptr)
+{
+	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
+}
+
 #elif __BYTE_ORDER == __BIG_ENDIAN
 static inline uint64_t bt_get_le64(const void *ptr)
 {
@@ -228,6 +259,36 @@ static inline uint16_t bt_get_be16(const void *ptr)
 {
 	return bt_get_unaligned((const uint16_t *) ptr);
 }
+
+static inline void bt_put_le64(uint64_t val, const void *ptr)
+{
+	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
+}
+
+static inline void bt_put_be64(uint64_t val, const void *ptr)
+{
+	bt_put_unaligned(val, (uint64_t *) ptr);
+}
+
+static inline void bt_put_le32(uint32_t val, const void *ptr)
+{
+	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
+}
+
+static inline void bt_put_be32(uint32_t val, const void *ptr)
+{
+	bt_put_unaligned(val, (uint32_t *) ptr);
+}
+
+static inline void bt_put_le16(uint16_t val, const void *ptr)
+{
+	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
+}
+
+static inline void bt_put_be16(uint16_t val, const void *ptr)
+{
+	bt_put_unaligned(val, (uint16_t *) ptr);
+}
 #else
 #error "Unknown byte order"
 #endif
-- 
1.7.9.5

