Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/8] btdev: Refactor Le Rand using Linux crypto infrastructure
Date: Fri, 15 May 2015 16:46:20 +0300
Message-Id: <1431697586-20611-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use standard Linux crypto infrastructure for emulating HCI LE Rand
command.
---
 emulator/btdev.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 18edac6..f4108b3 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2895,6 +2895,19 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &lenc, sizeof(lenc));
 		break;
 
+	case BT_HCI_CMD_LE_RAND:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		if (!bt_crypto_random_bytes(btdev->crypto,
+					    (uint8_t *)&lr.number, 8)) {
+			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
+				   opcode);
+			break;
+		}
+		lr.status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &lr, sizeof(lr));
+		break;
+
 	case BT_HCI_CMD_LE_READ_SUPPORTED_STATES:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
@@ -2923,14 +2936,6 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 
-	case BT_HCI_CMD_LE_RAND:
-		if (btdev->type == BTDEV_TYPE_BREDR)
-			goto unsupported;
-		lr.status = BT_HCI_ERR_SUCCESS;
-		lr.number = rand();
-		cmd_complete(btdev, opcode, &lr, sizeof(lr));
-		break;
-
 	case BT_HCI_CMD_LE_READ_REMOTE_FEATURES:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
-- 
2.1.4

