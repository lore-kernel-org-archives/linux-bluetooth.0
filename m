Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 49/62] attrib: Remove att_put_u32()
Date: Thu, 20 Mar 2014 11:43:14 -0300
Message-Id: <1395326607-27068-50-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index ad6bdf6..89698dc 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -133,11 +133,6 @@ static inline void att_put_u16(uint16_t src, void *dst)
 	bt_put_unaligned(htobs(src), (uint16_t *) dst);
 }
 
-static inline void att_put_u32(uint32_t src, void *dst)
-{
-	bt_put_unaligned(htobl(src), (uint32_t *) dst);
-}
-
 static inline void att_put_u128(uint128_t src, void *dst)
 {
 	uint128_t *d128 = dst;
-- 
1.8.3.1

