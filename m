Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] emulator: Add initial support for Controller to Host flow control
Date: Mon, 18 May 2015 21:33:14 +0200
Message-Id: <1431977594-6029-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This just allow to enable Controller to Host flow control and
properly don't send Command Status for Host Number Of Completed
Packets Command.

Proper handling on ACL data is still missing though.
---
 emulator/btdev.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d9a0c5d..ca9788b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -138,6 +138,8 @@ struct btdev {
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
 	uint8_t  sync_train_service_data;
+
+	uint8_t  flow_control;
 };
 
 struct inquiry_data {
@@ -1917,6 +1919,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
 	const struct bt_hci_cmd_read_rssi *rrssi;
 	const struct bt_hci_cmd_read_tx_power *rtxp;
+	const struct bt_hci_cmd_set_host_flow_control *cflow;
+	const struct bt_hci_cmd_host_num_completed_packets *host_num;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -2980,6 +2984,28 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &lte, sizeof(lte));
 		break;
 
+	case BT_HCI_CMD_SET_HOST_FLOW_CONTROL:
+		cflow = data;
+		if (cflow->enable > 0x03) {
+			status = BT_HCI_ERR_INVALID_PARAMETERS;
+		} else {
+			status = BT_HCI_ERR_SUCCESS;
+			btdev->flow_control = cflow->enable;
+		}
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_HOST_NUM_COMPLETED_PACKETS:
+		host_num = data;
+		if (btdev->flow_control > 0x00) {
+			uint16_t i;
+
+			for (i = 0; i < host_num->count; i++) {
+				/* TODO */
+			}
+		}
+		break;
+
 	default:
 		goto unsupported;
 	}
-- 
1.9.3

