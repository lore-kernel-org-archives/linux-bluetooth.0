Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/ad: Fix service data matching
Date: Fri, 22 May 2015 13:15:41 +0300
Message-Id: <1432289742-23389-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1432289742-23389-1-git-send-email-luiz.dentz@gmail.com>
References: <1432289742-23389-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_uuid_cmp return 0 if it matches not a true.
---
 src/shared/ad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 57f0a16..e841d1d 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -576,7 +576,7 @@ static bool service_uuid_match(const void *data, const void *user_data)
 	const struct bt_ad_service_data *s = data;
 	const bt_uuid_t *uuid = user_data;
 
-	return bt_uuid_cmp(&s->uuid, uuid);
+	return !bt_uuid_cmp(&s->uuid, uuid);
 }
 
 bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
-- 
2.1.0

