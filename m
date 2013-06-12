Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 05/35] emulator: Search virtual devices in LE advertising mode
Date: Wed, 12 Jun 2013 08:56:51 -0400
Message-Id: <1371041841-21793-6-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

After LE scan is enabled, the emulator search virtual devices that are
in advertising mode, in order to copy adv data.
---
 emulator/btdev.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a7af6b3..160e5bf 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -876,6 +876,19 @@ static void remote_version_complete(struct btdev *btdev, uint16_t handle)
 							&rvc, sizeof(rvc));
 }
 
+static void le_set_scan_enable_complete(struct btdev *btdev)
+{
+	int i;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
+
+		if (!btdev_list[i]->le_adv_enable)
+			continue;
+	}
+}
+
 static void default_cmd(struct btdev *btdev, uint16_t opcode,
 						const void *data, uint8_t len)
 {
@@ -1554,6 +1567,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			status = BT_HCI_ERR_SUCCESS;
 		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
+		if (status == BT_HCI_ERR_SUCCESS && btdev->le_scan_enable)
+			le_set_scan_enable_complete(btdev);
 		break;
 
 	case BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE:
-- 
1.7.9.5

