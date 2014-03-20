Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 20/62] lib: Remove bt_put_le16()
Date: Thu, 20 Mar 2014 11:42:45 -0300
Message-Id: <1395326607-27068-21-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 61c1f9a..8865c00 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -222,11 +222,6 @@ static inline void bt_put_be32(uint32_t val, const void *ptr)
 	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
 }
 
-static inline void bt_put_le16(uint16_t val, const void *ptr)
-{
-	bt_put_unaligned(val, (uint16_t *) ptr);
-}
-
 static inline void bt_put_be16(uint16_t val, const void *ptr)
 {
 	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
@@ -283,11 +278,6 @@ static inline void bt_put_be32(uint32_t val, const void *ptr)
 	bt_put_unaligned(val, (uint32_t *) ptr);
 }
 
-static inline void bt_put_le16(uint16_t val, const void *ptr)
-{
-	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
-}
-
 static inline void bt_put_be16(uint16_t val, const void *ptr)
 {
 	bt_put_unaligned(val, (uint16_t *) ptr);
-- 
1.8.3.1

