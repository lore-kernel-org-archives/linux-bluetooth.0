Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 5/6] emulator: Dummy LE set advertising parameters
Date: Wed,  3 Jul 2013 16:54:55 -0400
Message-Id: <1372884896-11419-6-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement basic LE set adv parameters command.
---
 emulator/btdev.c | 10 ++++++++++
 monitor/bt.h     | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f3de1a5..c98a20d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1451,6 +1451,16 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &lrlf, sizeof(lrlf));
 		break;
 
+	case BT_HCI_CMD_LE_SET_ADV_PARAMETERS:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		if (btdev->le_adv_enable)
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		else
+			status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
 	case BT_HCI_CMD_LE_READ_ADV_TX_POWER:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
diff --git a/monitor/bt.h b/monitor/bt.h
index da62a3d..0f1c1d8 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -842,6 +842,18 @@ struct bt_hci_cmd_le_set_random_address {
 	uint8_t  addr[6];
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_SET_ADV_PARAMETERS	0x2006
+struct bt_hci_cmd_le_set_adv_parameters {
+	uint16_t adv_interval_min;
+	uint16_t adv_interval_max;
+	uint8_t adv_type;
+	uint8_t own_address_type;
+	uint8_t direct_address_type;
+	uint8_t direct_address[6];
+	uint8_t adv_channel_map;
+	uint8_t adv_filter_policy;
+} __attribute__ ((packed));
+
 #define BT_HCI_CMD_LE_READ_ADV_TX_POWER		0x2007
 struct bt_hci_rsp_le_read_adv_tx_power {
 	uint8_t  status;
-- 
1.8.3.2

