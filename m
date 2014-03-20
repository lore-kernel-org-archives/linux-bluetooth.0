Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 30/62] lib: Remove bt_put_be32()
Date: Thu, 20 Mar 2014 11:42:55 -0300
Message-Id: <1395326607-27068-31-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index aa959ef..20407d7 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -177,11 +177,6 @@ static inline void bt_put_be64(uint64_t val, const void *ptr)
 	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
 }
 
-static inline void bt_put_be32(uint32_t val, const void *ptr)
-{
-	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
-}
-
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 static inline void bt_put_be64(uint64_t val, const void *ptr)
@@ -189,11 +184,6 @@ static inline void bt_put_be64(uint64_t val, const void *ptr)
 	bt_put_unaligned(val, (uint64_t *) ptr);
 }
 
-static inline void bt_put_be32(uint32_t val, const void *ptr)
-{
-	bt_put_unaligned(val, (uint32_t *) ptr);
-}
-
 #else
 #error "Unknown byte order"
 #endif
-- 
1.8.3.1

