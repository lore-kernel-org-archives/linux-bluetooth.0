Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 29/62] lib: Remove bt_put_be16()
Date: Thu, 20 Mar 2014 11:42:54 -0300
Message-Id: <1395326607-27068-30-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index eb623cc..aa959ef 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -182,11 +182,6 @@ static inline void bt_put_be32(uint32_t val, const void *ptr)
 	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
 }
 
-static inline void bt_put_be16(uint16_t val, const void *ptr)
-{
-	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
-}
-
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 static inline void bt_put_be64(uint64_t val, const void *ptr)
@@ -199,10 +194,6 @@ static inline void bt_put_be32(uint32_t val, const void *ptr)
 	bt_put_unaligned(val, (uint32_t *) ptr);
 }
 
-static inline void bt_put_be16(uint16_t val, const void *ptr)
-{
-	bt_put_unaligned(val, (uint16_t *) ptr);
-}
 #else
 #error "Unknown byte order"
 #endif
-- 
1.8.3.1

