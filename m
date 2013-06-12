Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 10/35] emulator: Disallow LE set scan params command when scan is enabled
Date: Wed, 12 Jun 2013 08:56:56 -0400
Message-Id: <1371041841-21793-11-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

When LE scan is enabled, the command LE set scan parameters should
return a command disallowed in status of command complete event.
---
 emulator/btdev.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index cbcf140..e350a96 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1642,7 +1642,10 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
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
1.7.9.5

