Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/advertising: Fix not adding local name and appearance flags
Date: Fri, 22 Jul 2016 16:56:25 +0300
Message-Id: <1469195785-8907-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the advertisement is cause the connectable flag to be set add local
name and appearance so the scan response is generated properly as the
remote may attempt connect/pair these information shall be made available
as well.
---
 src/advertising.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index d2019de..52b536d 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -473,7 +473,8 @@ static DBusMessage *refresh_advertisement(struct advertisement *ad)
 	DBG("Refreshing advertisement: %s", ad->path);
 
 	if (ad->type == AD_TYPE_PERIPHERAL)
-		flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
+		flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV |
+			MGMT_ADV_FLAG_APPEARANCE | MGMT_ADV_FLAG_LOCAL_NAME;
 
 	if (ad->include_tx_power)
 		flags |= MGMT_ADV_FLAG_TX_POWER;
-- 
2.7.4

