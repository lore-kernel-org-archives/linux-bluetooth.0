Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared/ad: Do not lookup service data twice
Date: Fri, 22 May 2015 13:15:40 +0300
Message-Id: <1432289742-23389-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This remove call to bt_ad_has_service_data inside bt_ad_add_service_data
since it already does the lookup for existing data before.
---
 src/shared/ad.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index dfc6b9a..57f0a16 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -616,11 +616,6 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 
 	new_data->len = len;
 
-	if (bt_ad_has_service_data(ad, new_data)) {
-		uuid_destroy(new_data);
-		return false;
-	}
-
 	if (queue_push_tail(ad->service_data, new_data))
 		return true;
 
-- 
2.1.0

