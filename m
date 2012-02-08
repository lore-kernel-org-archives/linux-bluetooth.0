Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] proximity: Remove unused variable
Date: Wed,  8 Feb 2012 12:12:50 -0400
Message-Id: <1328717570-19343-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/reporter.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index 737faf9..9777574 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -50,8 +50,6 @@ enum {
 	HIGH_ALERT = 0x02,
 };
 
-static uint16_t tx_power_handle;
-
 static void register_link_loss(struct btd_adapter *adapter)
 {
 	uint16_t start_handle, h;
@@ -123,7 +121,6 @@ static void register_tx_power(struct btd_adapter *adapter)
 	/* Power level value */
 	bt_uuid16_create(&uuid, POWER_LEVEL_CHR_UUID);
 	att_put_u8(0x00, &atval[0]);
-	tx_power_handle = h;
 	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Client characteristic configuration */
-- 
1.7.5.4

