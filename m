Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 03/31] monitor: Add LE Set Advertising Set Random Address decoding
Date: Tue,  6 Jun 2017 11:40:52 +0200
Message-Id: <20170606094120.14541-6-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Advertising Set Random Address (0x08|0x0035) plen 7
        Advertising handle: 0x01
        Advertising random address: FF:EE:DD:CC:BB:AA (OUI FF-EE-DD)
---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index a877b2c..d2e3e16 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2176,6 +2176,12 @@ struct bt_hci_cmd_le_enhanced_transmitter_test {
 	uint8_t phy;
 } __attribute__((packed));
 
+#define BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR			0x2035
+struct bt_hci_cmd_le_set_adv_set_rand_addr {
+	uint8_t  handle;
+	uint8_t  bdaddr[6];
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index b77b2cc..771b7bb 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6931,6 +6931,14 @@ static void le_enhanced_transmitter_test_cmd(const void *data, uint8_t size)
 	print_field("PHY: %s (0x%2.2x)", str, cmd->phy);
 }
 
+static void le_set_adv_set_rand_addr(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_adv_set_rand_addr *cmd = data;
+
+	print_field("Advertising handle: 0x%2.2x", cmd->handle);
+	print_addr("Advertising random address", cmd->bdaddr, 0x00);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7640,7 +7648,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2034, 288, "LE Enhanced Transmitter Test",
 				le_enhanced_transmitter_test_cmd, 4, true,
 				status_rsp, 1, true },
-	{ 0x2035, 289, "LE Set Advertising Set Random Address" },
+	{ 0x2035, 289, "LE Set Advertising Set Random Address",
+				le_set_adv_set_rand_addr, 7, true,
+				status_rsp, 1, true },
 	{ 0x2036, 290, "LE Set Extended Advertising Parameters" },
 	{ 0x2037, 291, "LE Set Extended Advertising Data" },
 	{ 0x2038, 292, "LE Set Extended Scan Response Data" },
-- 
2.9.3

