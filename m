Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v2 3/5] monitor: Add LE Set default PHY decoding
Date: Wed, 12 Apr 2017 14:41:25 +0200
Message-Id: <20170412124127.31486-3-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20170412124127.31486-1-lukasz.rymanowski@codecoup.pl>
References: <20170412124127.31486-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3
        All PHYs preference: 0x00
        TX PHYs preference: 0x07
          LE 1M
          LE 2M
          LE Coded
        RX PHYs preference: 0x0e
          LE 2M
          LE Coded
          Reserved (0x08)

< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3
        All PHYs preference: 0x03
          No TX PHY preference
          No RX PHY preference
        TX PHYs preference: 0x00
        RX PHYs preference: 0x00
---
 monitor/bt.h     |  7 ++++++
 monitor/packet.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index a6c12a3..9dd726e 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2145,6 +2145,13 @@ struct bt_hci_rsp_le_read_phy {
 	uint8_t rx_phy;
 } __attribute__((packed));
 
+#define BT_HCI_CMD_LE_SET_DEFAULT_PHY		0x2031
+struct bt_hci_cmd_le_set_default_phy {
+	uint8_t all_phys;
+	uint8_t tx_phys;
+	uint8_t rx_phys;
+} __attribute__((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 673b571..f8b42ac 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6776,6 +6776,73 @@ static void le_read_phy_rsp(const void *data, uint8_t size)
 	print_le_phy("RX PHY", rsp->rx_phy);
 }
 
+static const struct {
+	uint8_t bit;
+	const char *str;
+} le_phys[] = {
+	{  0, "LE 1M"	},
+	{  1, "LE 2M"	},
+	{  2, "LE Coded"},
+	{ }
+};
+
+static const struct {
+	uint8_t bit;
+	const char *str;
+} le_phy_preference[] = {
+	{  0, "No TX PHY preference"	},
+	{  1, "No RX PHY preference"	},
+	{ }
+};
+
+static void le_set_default_phy_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_default_phy *cmd = data;
+	int i;
+	uint8_t mask = cmd->all_phys;
+
+	print_field("All PHYs preference: 0x%2.2x", cmd->all_phys);
+
+	for (i = 0; le_phy_preference[i].str; i++) {
+		if (cmd->all_phys & (((uint8_t) 1) << le_phy_preference[i].bit)) {
+			print_field("  %s", le_phy_preference[i].str);
+			mask &= ~(((uint64_t) 1) << le_phy_preference[i].bit);
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_field("TX PHYs preference: 0x%2.2x", cmd->tx_phys);
+	mask = cmd->tx_phys;
+
+	for (i = 0; le_phys[i].str; i++) {
+		if (cmd->tx_phys & (((uint8_t) 1) << le_phys[i].bit)) {
+			print_field("  %s", le_phys[i].str);
+			mask &= ~(((uint64_t) 1) << le_phys[i].bit);
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_field("RX PHYs preference: 0x%2.2x", cmd->rx_phys);
+	mask = cmd->rx_phys;
+
+	for (i = 0; le_phys[i].str; i++) {
+		if (cmd->rx_phys & (((uint8_t) 1) << le_phys[i].bit)) {
+			print_field("  %s", le_phys[i].str);
+			mask &= ~(((uint64_t) 1) << le_phys[i].bit);
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7474,7 +7541,8 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2030, 284, "LE Read PHY",
 				le_read_phy_cmd, 2, true,
 				le_read_phy_rsp, 5, true},
-	{ 0x2031, 285, "LE Set Default PHY" },
+	{ 0x2031, 285, "LE Set Default PHY",
+				le_set_default_phy_cmd, 3, true},
 	{ 0x2032, 286, "LE Set PHY" },
 	{ 0x2033, 287, "LE Enhanced Receiver Test" },
 	{ 0x2034, 288, "LE Enhanced Transmitter Test" },
-- 
2.9.3

