Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 57/62] attrib: Remove att_put_uuid16()
Date: Thu, 20 Mar 2014 11:43:22 -0300
Message-Id: <1395326607-27068-58-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 0875a3b..4da25dc 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -117,11 +117,6 @@ static inline void att_put_u16(uint16_t src, void *dst)
 	bt_put_unaligned(htobs(src), (uint16_t *) dst);
 }
 
-static inline void att_put_uuid16(bt_uuid_t src, void *dst)
-{
-	att_put_u16(src.value.u16, dst);
-}
-
 struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len);
 void att_data_list_free(struct att_data_list *list);
 
-- 
1.8.3.1

