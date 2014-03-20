Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 56/62] attrib: Remove att_put_u128()
Date: Thu, 20 Mar 2014 11:43:21 -0300
Message-Id: <1395326607-27068-57-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 00dd8d0..0875a3b 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -117,13 +117,6 @@ static inline void att_put_u16(uint16_t src, void *dst)
 	bt_put_unaligned(htobs(src), (uint16_t *) dst);
 }
 
-static inline void att_put_u128(uint128_t src, void *dst)
-{
-	uint128_t *d128 = dst;
-
-	htob128(&src, d128);
-}
-
 static inline void att_put_uuid16(bt_uuid_t src, void *dst)
 {
 	att_put_u16(src.value.u16, dst);
-- 
1.8.3.1

