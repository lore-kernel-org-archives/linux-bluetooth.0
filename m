Return-Path: <cyrus@holtmann.org>
Message-ID: <55AF7668.7030903@ubnt.com>
Date: Wed, 22 Jul 2015 13:54:32 +0300
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] core/advertising: Fix byte order for MGMT_OP_ADD_ADVERTISING
 flags
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix byte order for MGMT_OP_ADD_ADVERTISING flags
---
 src/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index d56b7a2..8c249d1 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -500,7 +500,7 @@ static DBusMessage *refresh_advertisement(struct advertisement *ad)
 		return btd_error_failed(ad->reg, "Failed");
 	}
 
-	cp->flags = flags;
+	cp->flags = htobl(flags);
 	cp->instance = ad->instance;
 	cp->adv_data_len = adv_data_len;
 	memcpy(cp->data, adv_data, adv_data_len);
-- 
1.9.1

