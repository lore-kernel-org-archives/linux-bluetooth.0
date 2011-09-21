Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Fix characteristic property on GATT example plugin
Date: Tue, 20 Sep 2011 22:57:05 -0400
Message-Id: <1316573825-31326-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Any GATT characteristics which have a Client Characteristic
Configuration must have "Notify" property set.
---
 plugins/gatt-example.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f86e76d..334f74a 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -81,7 +81,7 @@ static void register_battery_service(void)
 
 	/* Battery: battery state characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_NOTIFY;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(BATTERY_STATE_UUID, &atval[3]);
 	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
-- 
1.7.0.4

