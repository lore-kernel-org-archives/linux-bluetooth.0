Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Remove read permission from IAS Alert Level
Date: Wed, 21 Dec 2011 15:37:11 -0300
Message-Id: <1324492631-24076-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Immediate Alert Level Service specification, Alert Level
characteristic allows write without response command only.
---
 proximity/reporter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index 77a7dcd..c33f902 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -156,7 +156,7 @@ static void register_immediate_alert(void)
 
 	/* Alert level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE;
+	atval[0] = ATT_CHAR_PROPER_WRITE;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
 	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
-- 
1.7.8

