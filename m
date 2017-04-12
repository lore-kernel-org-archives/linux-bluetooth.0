Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v2 4/5] monitor: Add LE Set PHY decoding
Date: Wed, 12 Apr 2017 14:41:26 +0200
Message-Id: <20170412124127.31486-4-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20170412124127.31486-1-lukasz.rymanowski@codecoup.pl>
References: <20170412124127.31486-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set PHY (0x08|0x0032) plen 7
        Handle: 1
        All PHYs preference: 0x00
        TX PHYs preference: 0x07
          LE 1M
          LE 2M
          LE Coded
        RX PHYs preference: 0x07
          LE 1M
          LE 2M
          LE Coded
        PHY options preference: S8 coding (0x0002)
---
 monitor/bt.h     |  9 +++++++++
 monitor/packet.c | 54 ++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 9dd726e..d6e0046 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2152,6 +2152,15 @@ struct bt_hci_cmd_le_set_default_phy {
 	uint8_t rx_phys;
 } __attribute__((packed));
 
+#define BT_HCI_CMD_LE_SET_PHY			0x2032
+struct bt_hci_cmd_le_set_phy {
+	uint16_t handle;
+	uint8_t all_phys;
+	uint8_t tx_phys;
+	uint8_t rx_phys;
+	uint16_t phy_opts;
+} __attribute__((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index f8b42ac..61bc92d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6795,16 +6795,16 @@ static const struct {
 	{ }
 };
 
-static void le_set_default_phy_cmd(const void *data, uint8_t size)
+static void print_le_phys_preference(uint8_t all_phys, uint8_t tx_phys,
+							uint8_t rx_phys)
 {
-	const struct bt_hci_cmd_le_set_default_phy *cmd = data;
 	int i;
-	uint8_t mask = cmd->all_phys;
+	uint8_t mask = all_phys;
 
-	print_field("All PHYs preference: 0x%2.2x", cmd->all_phys);
+	print_field("All PHYs preference: 0x%2.2x", all_phys);
 
 	for (i = 0; le_phy_preference[i].str; i++) {
-		if (cmd->all_phys & (((uint8_t) 1) << le_phy_preference[i].bit)) {
+		if (all_phys & (((uint8_t) 1) << le_phy_preference[i].bit)) {
 			print_field("  %s", le_phy_preference[i].str);
 			mask &= ~(((uint64_t) 1) << le_phy_preference[i].bit);
 		}
@@ -6814,11 +6814,11 @@ static void le_set_default_phy_cmd(const void *data, uint8_t size)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("TX PHYs preference: 0x%2.2x", cmd->tx_phys);
-	mask = cmd->tx_phys;
+	print_field("TX PHYs preference: 0x%2.2x", tx_phys);
+	mask = tx_phys;
 
 	for (i = 0; le_phys[i].str; i++) {
-		if (cmd->tx_phys & (((uint8_t) 1) << le_phys[i].bit)) {
+		if (tx_phys & (((uint8_t) 1) << le_phys[i].bit)) {
 			print_field("  %s", le_phys[i].str);
 			mask &= ~(((uint64_t) 1) << le_phys[i].bit);
 		}
@@ -6828,11 +6828,11 @@ static void le_set_default_phy_cmd(const void *data, uint8_t size)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("RX PHYs preference: 0x%2.2x", cmd->rx_phys);
-	mask = cmd->rx_phys;
+	print_field("RX PHYs preference: 0x%2.2x", rx_phys);
+	mask = rx_phys;
 
 	for (i = 0; le_phys[i].str; i++) {
-		if (cmd->rx_phys & (((uint8_t) 1) << le_phys[i].bit)) {
+		if (rx_phys & (((uint8_t) 1) << le_phys[i].bit)) {
 			print_field("  %s", le_phys[i].str);
 			mask &= ~(((uint64_t) 1) << le_phys[i].bit);
 		}
@@ -6843,6 +6843,35 @@ static void le_set_default_phy_cmd(const void *data, uint8_t size)
 							" (0x%2.2x)", mask);
 }
 
+static void le_set_default_phy_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_default_phy *cmd = data;
+
+	print_le_phys_preference(cmd->all_phys, cmd->tx_phys, cmd->rx_phys);
+}
+
+static void le_set_phy_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_phy *cmd = data;
+	const char *str;
+
+	print_handle(cmd->handle);
+	print_le_phys_preference(cmd->all_phys, cmd->tx_phys, cmd->rx_phys);
+	switch (le16_to_cpu(cmd->phy_opts)) {
+	case 0x0001:
+		str = "S2 coding";
+		break;
+	case 0x0002:
+		str = "S8 coding";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("PHY options preference: %s (0x%4.4x)", str, cmd->phy_opts);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7543,7 +7572,8 @@ static const struct opcode_data opcode_table[] = {
 				le_read_phy_rsp, 5, true},
 	{ 0x2031, 285, "LE Set Default PHY",
 				le_set_default_phy_cmd, 3, true},
-	{ 0x2032, 286, "LE Set PHY" },
+	{ 0x2032, 286, "LE Set PHY",
+				le_set_phy_cmd, 7, true},
 	{ 0x2033, 287, "LE Enhanced Receiver Test" },
 	{ 0x2034, 288, "LE Enhanced Transmitter Test" },
 	{ 0x2035, 289, "LE Set Advertising Set Random Address" },
-- 
2.9.3

