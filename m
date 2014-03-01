Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] emulator/btdev: Add dummy support for clearing the LE white list
Date: Sat,  1 Mar 2014 10:25:25 -0400
Message-Id: <1393683925-1216-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add just enough support for being able to bring up LE capable virtual
controllers using "btvirt".

Fixes this error on "btvirt -l2":

Unsupported command 0x2010

And on "hciconfig hci0 up":

Can't init device hci0: Invalid request code (56)
---
 emulator/btdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 4a54a23..b54f91e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2353,6 +2353,13 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &lrwls, sizeof(lrwls));
 		break;
 
+	case BT_HCI_CMD_LE_CLEAR_WHITE_LIST:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
 	case BT_HCI_CMD_LE_READ_SUPPORTED_STATES:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
-- 
1.8.3.2

