Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 24/62] lib: Remove bt_get_le32()
Date: Thu, 20 Mar 2014 11:42:49 -0300
Message-Id: <1395326607-27068-25-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 58ad96a..f045070 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -182,11 +182,6 @@ static inline uint64_t bt_get_be64(const void *ptr)
 	return bswap_64(bt_get_unaligned((const uint64_t *) ptr));
 }
 
-static inline uint32_t bt_get_le32(const void *ptr)
-{
-	return bt_get_unaligned((const uint32_t *) ptr);
-}
-
 static inline uint32_t bt_get_be32(const void *ptr)
 {
 	return bswap_32(bt_get_unaligned((const uint32_t *) ptr));
@@ -223,11 +218,6 @@ static inline uint64_t bt_get_be64(const void *ptr)
 	return bt_get_unaligned((const uint64_t *) ptr);
 }
 
-static inline uint32_t bt_get_le32(const void *ptr)
-{
-	return bswap_32(bt_get_unaligned((const uint32_t *) ptr));
-}
-
 static inline uint32_t bt_get_be32(const void *ptr)
 {
 	return bt_get_unaligned((const uint32_t *) ptr);
-- 
1.8.3.1

