Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Fix Alert Level characteristic for Proximity IAS
Date: Thu, 12 Jan 2012 16:56:53 -0400
Message-Id: <1326401813-30140-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to PXP IAS specification (Table 3.2), the Alert Level
characteristic property has only "Write without response" as mandatory
and the rest is excluded.
---
 proximity/reporter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index d8cc58f..a139c7c 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -168,7 +168,7 @@ static void register_immediate_alert(void)
 
 	/* Alert level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE;
+	atval[0] = ATT_CHAR_PROPER_WRITE_WITHOUT_RESP;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
 	/* FIXME: Provide the adapter in next function */
-- 
1.7.0.4

