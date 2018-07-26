Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ RESEND] monitor: Fix 2-DH5 packet type print
Date: Thu, 26 Jul 2018 17:03:52 +0530
Message-Id: <1532604832-355-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

3-DH5 is printed instaed of 2-DH5
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d99470c..aca0761 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -759,7 +759,7 @@ static const struct bitfield_data pkt_type_table[] = {
 	{  9, "3-DH3 may not be used"	},
 	{ 10, "DM3 may be used"		},
 	{ 11, "DH3 may be used"		},
-	{ 12, "3-DH5 may not be used"	},
+	{ 12, "2-DH5 may not be used"	},
 	{ 13, "3-DH5 may not be used"	},
 	{ 14, "DM5 may be used"		},
 	{ 15, "DH5 may be used"		},
-- 
2.7.4

