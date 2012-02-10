Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 03/22] lib: Fix the unaligned memory "getters" not receiving a const pointer
Date: Fri, 10 Feb 2012 18:39:48 -0300
Message-Id: <1328910007-25604-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It should be clear that those functions doesn't change the value of the
pointer passed to them.
---
 lib/bluetooth.h |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index ba241a1..c70bcf9 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -126,22 +126,22 @@ do {						\
 	__p->__v = (val);			\
 } while(0)
 
-static inline uint64_t bt_get_h64(void *ptr)
+static inline uint64_t bt_get_h64(const void *ptr)
 {
 	return bt_get_unaligned((uint64_t *) ptr);
 }
 
-static inline uint32_t bt_get_h32(void *ptr)
+static inline uint32_t bt_get_h32(const void *ptr)
 {
 	return bt_get_unaligned((uint32_t *) ptr);
 }
 
-static inline uint8_t bt_get_h16(void *ptr)
+static inline uint16_t bt_get_h16(const void *ptr)
 {
 	return bt_get_unaligned((uint16_t *) ptr);
 }
 
-static inline uint8_t bt_get_h8(void *ptr)
+static inline uint8_t bt_get_h8(const void *ptr)
 {
 	return bt_get_unaligned((uint8_t *) ptr);
 }
@@ -167,7 +167,7 @@ static inline void bt_put_h8(uint8_t val, void *ptr)
 }
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
-static inline uint64_t bt_get_le64(void *ptr)
+static inline uint64_t bt_get_le64(const void *ptr)
 {
 	return bt_get_unaligned((uint64_t *) ptr);
 }
@@ -177,7 +177,7 @@ static inline void bt_put_le64(uint64_t val, void *ptr)
 	bt_put_unaligned(val, (uint64_t *) ptr);
 }
 
-static inline uint64_t bt_get_be64(void *ptr)
+static inline uint64_t bt_get_be64(const void *ptr)
 {
 	return bswap_64(bt_get_unaligned((uint64_t *) ptr));
 }
@@ -187,7 +187,7 @@ static inline void bt_put_be64(uint64_t val, void *ptr)
 	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
 }
 
-static inline uint32_t bt_get_le32(void *ptr)
+static inline uint32_t bt_get_le32(const void *ptr)
 {
 	return bt_get_unaligned((uint32_t *) ptr);
 }
@@ -197,7 +197,7 @@ static inline void bt_put_le32(uint32_t val, void *ptr)
 	bt_put_unaligned(val, (uint32_t *) ptr);
 }
 
-static inline uint32_t bt_get_be32(void *ptr)
+static inline uint32_t bt_get_be32(const void *ptr)
 {
 	return bswap_32(bt_get_unaligned((uint32_t *) ptr));
 }
@@ -207,7 +207,7 @@ static inline void bt_put_be32(uint32_t val, void *ptr)
 	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
 }
 
-static inline uint16_t bt_get_le16(void *ptr)
+static inline uint16_t bt_get_le16(const void *ptr)
 {
 	return bt_get_unaligned((uint16_t *) ptr);
 }
@@ -217,7 +217,7 @@ static inline void bt_put_le16(uint16_t val, void *ptr)
 	bt_put_unaligned(val, (uint16_t *) ptr);
 }
 
-static inline uint16_t bt_get_be16(void *ptr)
+static inline uint16_t bt_get_be16(const void *ptr)
 {
 	return bswap_16(bt_get_unaligned((uint16_t *) ptr));
 }
@@ -227,7 +227,7 @@ static inline void bt_put_be16(uint16_t val, void *ptr)
 	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
 }
 #elif __BYTE_ORDER == __BIG_ENDIAN
-static inline uint64_t bt_get_le64(void *ptr)
+static inline uint64_t bt_get_le64(const void *ptr)
 {
 	return bswap_64(bt_get_unaligned((uint64_t *) ptr));
 }
@@ -237,7 +237,7 @@ static inline void bt_put_le64(uint64_t val, void *ptr)
 	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
 }
 
-static inline uint64_t bt_get_be64(void *ptr)
+static inline uint64_t bt_get_be64(const void *ptr)
 {
 	return bt_get_unaligned((uint64_t *) ptr);
 }
@@ -247,7 +247,7 @@ static inline void bt_put_be64(uint64_t val, void *ptr)
 	bt_put_unaligned(val, (uint64_t *) ptr);
 }
 
-static inline uint32_t bt_get_le32(void *ptr)
+static inline uint32_t bt_get_le32(const void *ptr)
 {
 	return bswap_32(bt_get_unaligned((uint32_t *) ptr));
 }
@@ -257,7 +257,7 @@ static inline void bt_put_le32(uint32_t val, void *ptr)
 	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
 }
 
-static inline uint32_t bt_get_be32(void *ptr)
+static inline uint32_t bt_get_be32(const void *ptr)
 {
 	return bt_get_unaligned((uint32_t *) ptr);
 }
@@ -267,7 +267,7 @@ static inline void bt_put_be32(uint32_t val, void *ptr)
 	bt_put_unaligned(val, (uint32_t *) ptr);
 }
 
-static inline uint16_t bt_get_le16(void *ptr)
+static inline uint16_t bt_get_le16(const void *ptr)
 {
 	return bswap_16(bt_get_unaligned((uint16_t *) ptr));
 }
@@ -277,7 +277,7 @@ static inline void bt_put_le16(uint16_t val, void *ptr)
 	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
 }
 
-static inline uint16_t bt_get_be16(void *ptr)
+static inline uint16_t bt_get_be16(const void *ptr)
 {
 	return bt_get_unaligned((uint16_t *) ptr);
 }
-- 
1.7.8.1

