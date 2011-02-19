Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/2] Add missing UUID16 field to Included Svc Attribute
Date: Sat, 19 Feb 2011 12:45:42 -0800
Message-Id: <1298148343-10535-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1298148343-10535-1-git-send-email-bgix@codeaurora.org>
References: <1298148343-10535-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/example.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index cd18168..395650a 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -124,7 +124,8 @@ static int register_attributes(void)
 	/* Thermometer: Include */
 	att_put_u16(0x0550, &atval[0]);
 	att_put_u16(0x0568, &atval[2]);
-	attrib_db_add(0x0202, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
+	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[4]);
+	attrib_db_add(0x0202, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Thermometer: temperature characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-- 
1.7.1
--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
