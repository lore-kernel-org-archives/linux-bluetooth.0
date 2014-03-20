Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 31/62] lib: Remove bt_put_be64()
Date: Thu, 20 Mar 2014 11:42:56 -0300
Message-Id: <1395326607-27068-32-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 20407d7..57ac7b5 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -171,23 +171,6 @@ do {						\
 	__p->__v = (val);			\
 } while(0)
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-static inline void bt_put_be64(uint64_t val, const void *ptr)
-{
-	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
-}
-
-#elif __BYTE_ORDER == __BIG_ENDIAN
-
-static inline void bt_put_be64(uint64_t val, const void *ptr)
-{
-	bt_put_unaligned(val, (uint64_t *) ptr);
-}
-
-#else
-#error "Unknown byte order"
-#endif
-
 /* BD Address */
 typedef struct {
 	uint8_t b[6];
-- 
1.8.3.1

