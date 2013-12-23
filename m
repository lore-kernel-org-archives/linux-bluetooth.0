Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btdev: Return Command Status for Authentication Requested
Date: Mon, 23 Dec 2013 15:43:27 +0200
Message-Id: <1387806207-11906-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 emulator/btdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d0dff74..9338260 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1191,6 +1191,12 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
 		break;
 
+	case BT_HCI_CMD_AUTH_REQUESTED:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		break;
+
 	case BT_HCI_CMD_REMOTE_NAME_REQUEST:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-- 
1.8.3.2

