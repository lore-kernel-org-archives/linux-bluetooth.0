Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 28/62] lib: Remove bt_get_be64()
Date: Thu, 20 Mar 2014 11:42:53 -0300
Message-Id: <1395326607-27068-29-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 6843c7f..eb623cc 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -172,11 +172,6 @@ do {						\
 } while(0)
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
-static inline uint64_t bt_get_be64(const void *ptr)
-{
-	return bswap_64(bt_get_unaligned((const uint64_t *) ptr));
-}
-
 static inline void bt_put_be64(uint64_t val, const void *ptr)
 {
 	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
@@ -194,11 +189,6 @@ static inline void bt_put_be16(uint16_t val, const void *ptr)
 
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
-static inline uint64_t bt_get_be64(const void *ptr)
-{
-	return bt_get_unaligned((const uint64_t *) ptr);
-}
-
 static inline void bt_put_be64(uint64_t val, const void *ptr)
 {
 	bt_put_unaligned(val, (uint64_t *) ptr);
-- 
1.8.3.1

