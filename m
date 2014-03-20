Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 22/62] lib: Remove bt_put_le64()
Date: Thu, 20 Mar 2014 11:42:47 -0300
Message-Id: <1395326607-27068-23-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index cb6f563..a476180 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -202,11 +202,6 @@ static inline uint16_t bt_get_be16(const void *ptr)
 	return bswap_16(bt_get_unaligned((const uint16_t *) ptr));
 }
 
-static inline void bt_put_le64(uint64_t val, const void *ptr)
-{
-	bt_put_unaligned(val, (uint64_t *) ptr);
-}
-
 static inline void bt_put_be64(uint64_t val, const void *ptr)
 {
 	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
@@ -253,11 +248,6 @@ static inline uint16_t bt_get_be16(const void *ptr)
 	return bt_get_unaligned((const uint16_t *) ptr);
 }
 
-static inline void bt_put_le64(uint64_t val, const void *ptr)
-{
-	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
-}
-
 static inline void bt_put_be64(uint64_t val, const void *ptr)
 {
 	bt_put_unaligned(val, (uint64_t *) ptr);
-- 
1.8.3.1

