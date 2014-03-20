Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 48/62] attrib: Remove att_get_u32()
Date: Thu, 20 Mar 2014 11:43:13 -0300
Message-Id: <1395326607-27068-49-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 4db015d..ad6bdf6 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -118,12 +118,6 @@ static inline uint16_t att_get_u16(const void *ptr)
 	return btohs(bt_get_unaligned(u16_ptr));
 }
 
-static inline uint32_t att_get_u32(const void *ptr)
-{
-	const uint32_t *u32_ptr = ptr;
-	return btohl(bt_get_unaligned(u32_ptr));
-}
-
 static inline uint128_t att_get_u128(const void *ptr)
 {
 	const uint128_t *u128_ptr = ptr;
-- 
1.8.3.1

