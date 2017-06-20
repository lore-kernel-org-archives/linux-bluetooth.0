Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v3 7/7] monitor: Add LE Set Privacy Mode decoding
Date: Tue, 20 Jun 2017 09:53:31 +0200
Message-Id: <20170620075331.13897-8-michal.narajowski@codecoup.pl>
In-Reply-To: <20170620075331.13897-1-michal.narajowski@codecoup.pl>
References: <20170620075331.13897-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Privacy Mode (0x08|0x004e) plen 8
        Peer Identity address type: Random (0x01)
        Peer Identity address: 07:06:05:04:03:02 (Non-Resolvable)
        Privacy Mode: Reserved (0x08)
---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 61308e9..d7cb0e4 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2373,6 +2373,13 @@ struct bt_hci_cmd_le_write_rf_path_comp {
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
index 582320b..2ea6d49 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7653,6 +7653,30 @@ static void le_write_rf_path_comp_cmd(const void *data, uint8_t size)
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
@@ -8437,7 +8461,9 @@ static const struct opcode_data opcode_table[] = {
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
2.9.3

