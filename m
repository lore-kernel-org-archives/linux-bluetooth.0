Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 6/6] emulator: Refactor le set scan enable command handler
Date: Mon, 31 Aug 2015 12:18:08 +0200
Message-Id: <1441016288-23010-6-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1441016288-23010-1-git-send-email-mariusz.skamra@tieto.com>
References: <1441016288-23010-1-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <20150829032025.GA8367@t440s>
References: <20150829032025.GA8367@t440s>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

le_set_scan_enable_complete should be called as post hook action.
---
 emulator/btdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7ff750d..e8cead8 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3005,8 +3005,6 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			status = BT_HCI_ERR_SUCCESS;
 		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
-		if (status == BT_HCI_ERR_SUCCESS && btdev->le_scan_enable)
-			le_set_scan_enable_complete(btdev);
 		break;
 
 	case BT_HCI_CMD_LE_CREATE_CONN:
@@ -3254,6 +3252,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_conn_update *lecu;
 	const struct bt_hci_cmd_le_conn_param_req_reply *lcprr;
 	const struct bt_hci_cmd_le_conn_param_req_neg_reply *lcprnr;
+	const struct bt_hci_cmd_le_set_scan_enable *lsse;
 
 	switch (opcode) {
 	case BT_HCI_CMD_INQUIRY:
@@ -3441,6 +3440,14 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		rej_le_conn_update(btdev, le16_to_cpu(lcprnr->handle),
 					le16_to_cpu(lcprnr->reason));
 		break;
+		break;
+	case BT_HCI_CMD_LE_SET_SCAN_ENABLE:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			return;
+		lsse = data;
+		if (btdev->le_scan_enable && lsse->enable)
+			le_set_scan_enable_complete(btdev);
+
 	}
 }
 
-- 
2.4.3

