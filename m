Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] lib/uuid: Fix bt_uuid_to_le for 128 Bits
Date: Mon,  2 Mar 2015 13:35:46 +0200
Message-Id: <1425296146-12650-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The convention is that 128 Bits are always defined in big endian format
therefore the bytes always needs to be swapped.
---
 lib/bluetooth.h   | 20 ++++++++++++--------
 lib/uuid.c        |  6 +++---
 src/shared/util.h | 10 ----------
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index f214d81..6ca64b6 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -343,6 +343,16 @@ typedef struct {
 	uint8_t data[16];
 } uint128_t;
 
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
 #if __BYTE_ORDER == __BIG_ENDIAN
 
 #define ntoh64(x) (x)
@@ -354,10 +364,7 @@ static inline void ntoh128(const uint128_t *src, uint128_t *dst)
 
 static inline void btoh128(const uint128_t *src, uint128_t *dst)
 {
-	int i;
-
-	for (i = 0; i < 16; i++)
-		dst->data[15 - i] = src->data[i];
+	bswap_128(src, dst);
 }
 
 #else
@@ -375,10 +382,7 @@ static inline uint64_t ntoh64(uint64_t n)
 
 static inline void ntoh128(const uint128_t *src, uint128_t *dst)
 {
-	int i;
-
-	for (i = 0; i < 16; i++)
-		dst->data[15 - i] = src->data[i];
+	bswap_128(src, dst);
 }
 
 static inline void btoh128(const uint128_t *src, uint128_t *dst)
diff --git a/lib/uuid.c b/lib/uuid.c
index 3eb7dbe..4f34b17 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -302,10 +302,10 @@ int bt_uuid_to_le(const bt_uuid_t *src, void *dst)
 		return 0;
 	case BT_UUID32:
 		bt_uuid_to_uuid128(src, &uuid);
-		ntoh128(&uuid.value.u128, dst);
-		return 0;
+		/* Fallthrough */
 	case BT_UUID128:
-		ntoh128(&src->value.u128, dst);
+		/* Convert from 128-bit BE to LE */
+		bswap_128(&src->value.u128, dst);
 		return 0;
 	case BT_UUID_UNSPEC:
 	default:
diff --git a/src/shared/util.h b/src/shared/util.h
index 7dba1b3..30b7d92 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -96,16 +96,6 @@ unsigned char util_get_dt(const char *parent, const char *name);
 uint8_t util_get_uid(unsigned int *bitmap, uint8_t max);
 void util_clear_uid(unsigned int *bitmap, uint8_t id);
 
-static inline void bswap_128(const void *src, void *dst)
-{
-	const uint8_t *s = src;
-	uint8_t *d = dst;
-	int i;
-
-	for (i = 0; i < 16; i++)
-		d[15 - i] = s[i];
-}
-
 static inline uint16_t get_le16(const void *ptr)
 {
 	return le16_to_cpu(get_unaligned((const uint16_t *) ptr));
-- 
2.1.0

