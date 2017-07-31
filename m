Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v5 07/11] monitor: Add LE Set Privacy Mode decoding
Date: Mon, 31 Jul 2017 15:39:06 +0200
Message-Id: <20170731133910.26745-8-michal.narajowski@codecoup.pl>
In-Reply-To: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
References: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Privacy Mode (0x08|0x004e) plen 8
        Peer Identity address type: Random (0x01)
        Peer Identity address: 01:01:01:01:01:01 (Non-Resolvable)
        Privacy Mode: Use Device Privacy (0x01)
---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 481b82a5a..595b6a737 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2376,6 +2376,13 @@ struct bt_hci_cmd_le_write_rf_path_comp {
 	uint16_t rf_rx_path_comp;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_SET_PRIV_MODE		0x204e
+struct bt_hci_cmd_le_set_priv_mode {
+	uint8_t  peer_id_addr_type;
+	uint8_t  peer_id_addr[6];
+	uint8_t  priv_mode;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 577310505..fec952a12 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7831,6 +7831,30 @@ static void le_write_rf_path_comp_cmd(const void *data, uint8_t size)
 							cmd->rf_rx_path_comp);
 }
 
+static void le_set_priv_mode_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_priv_mode *cmd = data;
+	const char *str;
+
+	print_addr_type("Peer Identity address type", cmd->peer_id_addr_type);
+	print_addr("Peer Identity address", cmd->peer_id_addr,
+							cmd->peer_id_addr_type);
+
+	switch (cmd->priv_mode) {
+	case 0x00:
+		str = "Use Network Privacy";
+		break;
+	case 0x01:
+		str = "Use Device Privacy";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Privacy Mode: %s (0x%2.2x)", str, cmd->priv_mode);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8615,7 +8639,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x204d, 313, "LE Write RF Path Compensation",
 				le_write_rf_path_comp_cmd, 4, true,
 				status_rsp, 1, true },
-	{ 0x204e, 314, "LE Set Privacy Mode" },
+	{ 0x204e, 314, "LE Set Privacy Mode",
+				le_set_priv_mode_cmd, 8, true,
+				status_rsp, 1, true },
 	{ }
 };
 
-- 
2.11.0

