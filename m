Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 01/12] tools: Fix strncat() usage in hciconfig/hcitool
Date: Fri,  3 Jan 2014 21:55:17 -0400
Message-Id: <1388800528-10699-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to strncat() manpage:

"If src contains n or more characters, strncat() writes n+1 characters
to dest (n from src plus the terminating null byte).  Therefore, the
size of dest must be at least strlen(dest)+n+1"

While the current usage of strncat() cannot cause an overflow, if a
bigger string is added to the switch()'s without increasing the static
buffer, it would overflow by one byte due to the incorrect size
calculation.

Fixes clang errors like:

tools/hciconfig.c:827:33: error: the value of the size argument in
'strncat' is too large, might lead to a buffer overflow
[-Werror,-Wstrncat-size]
---
 tools/hciconfig.c | 21 ++++++++++++++-------
 tools/hcitool.c   | 23 +++++++++++++++--------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index fe45167..6c7f8ed 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -824,25 +824,32 @@ static char *get_minor_device_name(int major, int minor)
 		case 0:
 			break;
 		case 1:
-			strncat(cls_str, "Joystick", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Joystick",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		case 2:
-			strncat(cls_str, "Gamepad", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Gamepad",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		case 3:
-			strncat(cls_str, "Remote control", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Remote control",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		case 4:
-			strncat(cls_str, "Sensing device", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Sensing device",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		case 5:
-			strncat(cls_str, "Digitizer tablet", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Digitizer tablet",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		case 6:
-			strncat(cls_str, "Card reader", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Card reader",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		default:
-			strncat(cls_str, "(reserved)", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "(reserved)",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		}
 		if (strlen(cls_str) > 0)
diff --git a/tools/hcitool.c b/tools/hcitool.c
index f2e4fa4..d85ece1 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -336,25 +336,32 @@ static char *get_minor_device_name(int major, int minor)
 		case 0:
 			break;
 		case 1:
-			strncat(cls_str, "Joystick", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Joystick",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		case 2:
-			strncat(cls_str, "Gamepad", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Gamepad",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		case 3:
-			strncat(cls_str, "Remote control", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Remote control",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		case 4:
-			strncat(cls_str, "Sensing device", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Sensing device",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		case 5:
-			strncat(cls_str, "Digitizer tablet", sizeof(cls_str) - strlen(cls_str));
-		break;
+			strncat(cls_str, "Digitizer tablet",
+					sizeof(cls_str) - strlen(cls_str) - 1);
+			break;
 		case 6:
-			strncat(cls_str, "Card reader", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "Card reader",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		default:
-			strncat(cls_str, "(reserved)", sizeof(cls_str) - strlen(cls_str));
+			strncat(cls_str, "(reserved)",
+					sizeof(cls_str) - strlen(cls_str) - 1);
 			break;
 		}
 		if (strlen(cls_str) > 0)
-- 
1.8.3.2

