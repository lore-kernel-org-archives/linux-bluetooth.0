Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] advertising: Fix setting discoverable flag only for peripheral
Date: Tue, 20 Feb 2018 16:13:58 +0100
Message-Id: <20180220151358.20781-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

General Discoverable mode can also be set for non-connectable
advertising. This was affecting GAP/DISC/GENM/BV-03-C qualification
testcase.
---
 src/advertising.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 38d2a2d1f..6e227d4d1 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -622,12 +622,11 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
 
 	DBG("Refreshing advertisement: %s", client->path);
 
-	if (client->type == AD_TYPE_PERIPHERAL) {
+	if (client->type == AD_TYPE_PERIPHERAL)
 		flags = MGMT_ADV_FLAG_CONNECTABLE;
 
-		if (btd_adapter_get_discoverable(client->manager->adapter))
-			flags |= MGMT_ADV_FLAG_DISCOV;
-	}
+	if (btd_adapter_get_discoverable(client->manager->adapter))
+		flags |= MGMT_ADV_FLAG_DISCOV;
 
 	flags |= client->flags;
 
-- 
2.14.3

