Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] btdev: Return Command Status for Authentication Requested
Date: Fri,  3 Jan 2014 15:45:54 +0200
Message-Id: <1388756754-30760-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20131223170651.GA17118@x220.p-661hnu-f1>
References: <20131223170651.GA17118@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for "Authentication Requested" command
---
 emulator/btdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 93361cd..0349f8a 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -269,6 +269,7 @@ static void set_bredr_commands(struct btdev *btdev)
 	btdev->commands[0]  |= 0x80;	/* Cancel Create Connection */
 	btdev->commands[1]  |= 0x01;	/* Accept Connection Request */
 	btdev->commands[1]  |= 0x02;	/* Reject Connection Request */
+	btdev->commands[1]  |= 0x80;	/* Authentication Requested */
 	btdev->commands[2]  |= 0x08;	/* Remote Name Request */
 	btdev->commands[2]  |= 0x10;	/* Cancel Remote Name Request */
 	btdev->commands[2]  |= 0x20;	/* Read Remote Supported Features */
@@ -1202,6 +1203,12 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
 		break;
 
+	case BT_HCI_CMD_AUTH_REQUESTED:
+		if (btdev->type == BTDEV_TYPE_LE)
+			goto unsupported;
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		break;
+
 	case BT_HCI_CMD_REMOTE_NAME_REQUEST:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-- 
1.8.3.2

