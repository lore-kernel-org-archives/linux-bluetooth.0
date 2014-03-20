Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 52/62] attrib: Remove att_get_uuid128()
Date: Thu, 20 Mar 2014 11:43:17 -0300
Message-Id: <1395326607-27068-53-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 46bd253..0b98df3 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -152,17 +152,6 @@ static inline void att_put_uuid(bt_uuid_t src, void *dst)
 		att_put_uuid128(src, dst);
 }
 
-static inline bt_uuid_t att_get_uuid128(const void *ptr)
-{
-	bt_uuid_t uuid;
-	uint128_t value;
-
-	value  = att_get_u128(ptr);
-	bt_uuid128_create(&uuid, value);
-
-	return uuid;
-}
-
 struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len);
 void att_data_list_free(struct att_data_list *list);
 
-- 
1.8.3.1

