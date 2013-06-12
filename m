Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 09/35] emulator: Dummy LE set advertising parameters
Date: Wed, 12 Jun 2013 08:56:55 -0400
Message-Id: <1371041841-21793-10-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement basic LE set adv parameters command.
---
 emulator/btdev.c |   10 ++++++++++
 monitor/bt.h     |   12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 178971f..cbcf140 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1606,6 +1606,16 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
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
index 9f237ee..e900525 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -838,6 +838,18 @@ struct bt_hci_cmd_le_set_random_address {
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
1.7.9.5

