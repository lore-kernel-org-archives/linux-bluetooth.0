Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 02/22] lib: Add functions to storing values in unaligned places
Date: Fri, 10 Feb 2012 18:39:47 -0300
Message-Id: <1328910007-25604-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index e9ced19..ba241a1 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -172,60 +172,120 @@ static inline uint64_t bt_get_le64(void *ptr)
 	return bt_get_unaligned((uint64_t *) ptr);
 }
 
+static inline void bt_put_le64(uint64_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint64_t *) ptr);
+}
+
 static inline uint64_t bt_get_be64(void *ptr)
 {
 	return bswap_64(bt_get_unaligned((uint64_t *) ptr));
 }
 
+static inline void bt_put_be64(uint64_t val, void *ptr)
+{
+	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
+}
+
 static inline uint32_t bt_get_le32(void *ptr)
 {
 	return bt_get_unaligned((uint32_t *) ptr);
 }
 
+static inline void bt_put_le32(uint32_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint32_t *) ptr);
+}
+
 static inline uint32_t bt_get_be32(void *ptr)
 {
 	return bswap_32(bt_get_unaligned((uint32_t *) ptr));
 }
 
+static inline void bt_put_be32(uint32_t val, void *ptr)
+{
+	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
+}
+
 static inline uint16_t bt_get_le16(void *ptr)
 {
 	return bt_get_unaligned((uint16_t *) ptr);
 }
 
+static inline void bt_put_le16(uint16_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint16_t *) ptr);
+}
+
 static inline uint16_t bt_get_be16(void *ptr)
 {
 	return bswap_16(bt_get_unaligned((uint16_t *) ptr));
 }
+
+static inline void bt_put_be16(uint16_t val, void *ptr)
+{
+	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
+}
 #elif __BYTE_ORDER == __BIG_ENDIAN
 static inline uint64_t bt_get_le64(void *ptr)
 {
 	return bswap_64(bt_get_unaligned((uint64_t *) ptr));
 }
 
+static inline void bt_put_le64(uint64_t val, void *ptr)
+{
+	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
+}
+
 static inline uint64_t bt_get_be64(void *ptr)
 {
 	return bt_get_unaligned((uint64_t *) ptr);
 }
 
+static inline void bt_put_be64(uint64_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint64_t *) ptr);
+}
+
 static inline uint32_t bt_get_le32(void *ptr)
 {
 	return bswap_32(bt_get_unaligned((uint32_t *) ptr));
 }
 
+static inline void bt_put_le32(uint32_t val, void *ptr)
+{
+	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
+}
+
 static inline uint32_t bt_get_be32(void *ptr)
 {
 	return bt_get_unaligned((uint32_t *) ptr);
 }
 
+static inline void bt_put_be32(uint32_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint32_t *) ptr);
+}
+
 static inline uint16_t bt_get_le16(void *ptr)
 {
 	return bswap_16(bt_get_unaligned((uint16_t *) ptr));
 }
 
+static inline void bt_put_le16(uint16_t val, void *ptr)
+{
+	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
+}
+
 static inline uint16_t bt_get_be16(void *ptr)
 {
 	return bt_get_unaligned((uint16_t *) ptr);
 }
+
+static inline void bt_put_be16(uint16_t val, void *ptr)
+{
+	bt_put_unaligned(val, (uint16_t *) ptr);
+}
 #else
 #error "Unknown byte order"
 #endif
-- 
1.7.8.1

