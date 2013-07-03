Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 4/6] emulator: Disallow LE set scan params command when scan is enabled
Date: Wed,  3 Jul 2013 16:54:54 -0400
Message-Id: <1372884896-11419-5-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When LE scan is enabled, the command LE set scan parameters should
return a command disallowed in status of command complete event.
---
 emulator/btdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 925eaf7..f3de1a5 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1475,7 +1475,10 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_LE_SET_SCAN_PARAMETERS:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
-		status = BT_HCI_ERR_SUCCESS;
+		if (btdev->le_scan_enable)
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		else
+			status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 
-- 
1.8.3.2

