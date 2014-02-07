Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] tools/sdptool: Fix output formatting
Date: Fri,  7 Feb 2014 16:14:45 -0400
Message-Id: <1391804086-14428-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1391804086-14428-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1391804086-14428-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Print 8-bit and 16-bit integers with in a more readable format.
---
 tools/sdptool.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index d6b7006..1600c3e 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1048,7 +1048,7 @@ static void print_service_desc(void *value, void *user)
 			if (proto == RFCOMM_UUID)
 				printf("    Channel: %d\n", p->val.uint8);
 			else
-				printf("    uint8: 0x%x\n", p->val.uint8);
+				printf("    uint8: 0x%02x\n", p->val.uint8);
 			break;
 		case SDP_UINT16:
 			if (proto == L2CAP_UUID) {
@@ -1060,9 +1060,9 @@ static void print_service_desc(void *value, void *user)
 				if (i == 1)
 					printf("    Version: 0x%04x\n", p->val.uint16);
 				else
-					printf("    uint16: 0x%x\n", p->val.uint16);
+					printf("    uint16: 0x%04x\n", p->val.uint16);
 			else
-				printf("    uint16: 0x%x\n", p->val.uint16);
+				printf("    uint16: 0x%04x\n", p->val.uint16);
 			break;
 		case SDP_SEQ16:
 			printf("    SEQ16:");
-- 
1.7.9.5

