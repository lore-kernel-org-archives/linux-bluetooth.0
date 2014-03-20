Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 27/62] lib: Remove bt_get_be32()
Date: Thu, 20 Mar 2014 11:42:52 -0300
Message-Id: <1395326607-27068-28-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 3dcb049..6843c7f 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -177,11 +177,6 @@ static inline uint64_t bt_get_be64(const void *ptr)
 	return bswap_64(bt_get_unaligned((const uint64_t *) ptr));
 }
 
-static inline uint32_t bt_get_be32(const void *ptr)
-{
-	return bswap_32(bt_get_unaligned((const uint32_t *) ptr));
-}
-
 static inline void bt_put_be64(uint64_t val, const void *ptr)
 {
 	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
@@ -204,11 +199,6 @@ static inline uint64_t bt_get_be64(const void *ptr)
 	return bt_get_unaligned((const uint64_t *) ptr);
 }
 
-static inline uint32_t bt_get_be32(const void *ptr)
-{
-	return bt_get_unaligned((const uint32_t *) ptr);
-}
-
 static inline void bt_put_be64(uint64_t val, const void *ptr)
 {
 	bt_put_unaligned(val, (uint64_t *) ptr);
-- 
1.8.3.1

