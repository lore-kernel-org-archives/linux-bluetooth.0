Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 14/31] monitor: Add LE Set Periodic Advertising Enable decoding
Date: Tue,  6 Jun 2017 11:41:03 +0200
Message-Id: <20170606094120.14541-17-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Periodic Advertising Enable (0x08|0x0040) plen 2
        Enable: Enabled
        Handle: 2
---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 25 ++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index d093162..c44aad7 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2268,6 +2268,12 @@ struct bt_hci_cmd_le_set_periodic_adv_data {
 	uint8_t  data_len;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_SET_PERIODIC_ADV_ENABLE			0x2040
+struct bt_hci_cmd_le_set_periodic_adv_enable {
+	uint8_t  enable;
+	uint8_t  handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 0a1d17c..1c113ff 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7312,6 +7312,27 @@ static void le_set_periodic_adv_data_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 3, size - 3);
 }
 
+static void le_set_periodic_adv_enable_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
+	const char *str;
+
+	switch (cmd->enable) {
+	case 0x00:
+		str = "Disable";
+		break;
+	case 0x01:
+		str = "Enabled";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Enable: %s", str);
+	print_handle(cmd->handle);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8054,7 +8075,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x203f, 299, "LE Set Periodic Advertising Data",
 				le_set_periodic_adv_data_cmd, 3, false,
 				status_rsp, 1, true },
-	{ 0x2040, 300, "LE Set Periodic Advertising Enable" },
+	{ 0x2040, 300, "LE Set Periodic Advertising Enable",
+				le_set_periodic_adv_enable_cmd, 2, true,
+				status_rsp, 1, true },
 	{ 0x2041, 301, "LE Set Extended Scan Parameters" },
 	{ 0x2042, 302, "LE Set Extended Scan Enable" },
 	{ 0x2043, 303, "LE Extended Create Connection" },
-- 
2.9.3

