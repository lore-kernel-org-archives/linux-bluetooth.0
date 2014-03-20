Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 55/62] attrib: Remove att_put_uuid128()
Date: Thu, 20 Mar 2014 11:43:20 -0300
Message-Id: <1395326607-27068-56-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 6155848..00dd8d0 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -129,11 +129,6 @@ static inline void att_put_uuid16(bt_uuid_t src, void *dst)
 	att_put_u16(src.value.u16, dst);
 }
 
-static inline void att_put_uuid128(bt_uuid_t src, void *dst)
-{
-	att_put_u128(src.value.u128, dst);
-}
-
 struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len);
 void att_data_list_free(struct att_data_list *list);
 
-- 
1.8.3.1

