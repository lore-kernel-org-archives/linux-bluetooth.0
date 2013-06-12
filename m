Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 06/35] emulator: Search virtual devices in LE scan mode
Date: Wed, 12 Jun 2013 08:56:52 -0400
Message-Id: <1371041841-21793-7-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

When a virtual device starts an LE advertising, emulator search other
devices that are in scan mode, in order to send adv data to these
devices.
---
 emulator/btdev.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 160e5bf..2725c76 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -876,6 +876,19 @@ static void remote_version_complete(struct btdev *btdev, uint16_t handle)
 							&rvc, sizeof(rvc));
 }
 
+static void le_set_adv_enable_complete(struct btdev *btdev)
+{
+	int i;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
+
+		if (!btdev_list[i]->le_scan_enable)
+			continue;
+	}
+}
+
 static void le_set_scan_enable_complete(struct btdev *btdev)
 {
 	int i;
@@ -1546,6 +1559,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			status = BT_HCI_ERR_SUCCESS;
 		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
+		if (status == BT_HCI_ERR_SUCCESS && btdev->le_adv_enable)
+			le_set_adv_enable_complete(btdev);
 		break;
 
 	case BT_HCI_CMD_LE_SET_SCAN_PARAMETERS:
-- 
1.7.9.5

