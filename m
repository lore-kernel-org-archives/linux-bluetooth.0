Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 1/2] proximity: Remove att_put_u8() usage
Date: Tue, 25 Mar 2014 11:50:18 -0300
Message-Id: <1395759019-9643-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/proximity/reporter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 5861923..9be4a95 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -130,7 +130,7 @@ static void register_tx_power(struct btd_adapter *adapter)
 
 	/* Power level value */
 	bt_uuid16_create(&uuid, POWER_LEVEL_CHR_UUID);
-	att_put_u8(0x00, &atval[0]);
+	atval[0] = 0x00;
 	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Client characteristic configuration */
-- 
1.8.3.1

