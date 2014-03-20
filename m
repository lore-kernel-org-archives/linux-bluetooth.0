Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 26/62] lib: Remove bt_get_be16()
Date: Thu, 20 Mar 2014 11:42:51 -0300
Message-Id: <1395326607-27068-27-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 37fa04d..3dcb049 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -182,11 +182,6 @@ static inline uint32_t bt_get_be32(const void *ptr)
 	return bswap_32(bt_get_unaligned((const uint32_t *) ptr));
 }
 
-static inline uint16_t bt_get_be16(const void *ptr)
-{
-	return bswap_16(bt_get_unaligned((const uint16_t *) ptr));
-}
-
 static inline void bt_put_be64(uint64_t val, const void *ptr)
 {
 	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
@@ -214,11 +209,6 @@ static inline uint32_t bt_get_be32(const void *ptr)
 	return bt_get_unaligned((const uint32_t *) ptr);
 }
 
-static inline uint16_t bt_get_be16(const void *ptr)
-{
-	return bt_get_unaligned((const uint16_t *) ptr);
-}
-
 static inline void bt_put_be64(uint64_t val, const void *ptr)
 {
 	bt_put_unaligned(val, (uint64_t *) ptr);
-- 
1.8.3.1

