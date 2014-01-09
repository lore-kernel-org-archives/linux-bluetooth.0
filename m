Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] hcidump: Fix missing break
Date: Thu,  9 Jan 2014 18:11:02 +0200
Message-Id: <1389283864-15135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/parser/avrcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/parser/avrcp.c b/tools/parser/avrcp.c
index b523533..7c320ea 100644
--- a/tools/parser/avrcp.c
+++ b/tools/parser/avrcp.c
@@ -1180,12 +1180,16 @@ response:
 		switch (status) {
 		case 0x00:
 			printf("(POWER_ON)\n");
+			break;
 		case 0x01:
 			printf("(POWER_OFF)\n");
+			break;
 		case 0x02:
 			printf("(UNPLUGGED)\n");
+			break;
 		default:
 			printf("(UNKOWN)\n");
+			break;
 		}
 		break;
 	case AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED:
-- 
1.8.3.2

