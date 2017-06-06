Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 22/31] monitor: Add LE Remove Device From Periodic Advertiser List decoding
Date: Tue,  6 Jun 2017 11:41:11 +0200
Message-Id: <20170606094120.14541-25-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Add Device To Periodic Advertiser List (0x08|0x0047) plen 8
        Adv address type: Random (0x01)
        Adv address: 07:06:05:04:03:02 (Non-Resolvable)
        SID: 0x08
---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 5a932d8..78f2f57 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2338,6 +2338,13 @@ struct bt_hci_cmd_le_add_dev_periodic_adv_list {
 	uint8_t  sid;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_REMOVE_DEV_PERIODIC_ADV_LIST		0x2048
+struct bt_hci_cmd_le_remove_dev_periodic_adv_list {
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  sid;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index f09c9b1..455f490 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7600,6 +7600,15 @@ static void le_add_dev_periodic_adv_list_cmd(const void *data, uint8_t size)
 	print_field("SID: 0x%2.2x", cmd->sid);
 }
 
+static void le_remove_dev_periodic_adv_list_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_remove_dev_periodic_adv_list *cmd = data;
+
+	print_addr_type("Adv address type", cmd->addr_type);
+	print_addr("Adv address", cmd->addr, cmd->addr_type);
+	print_field("SID: 0x%2.2x", cmd->sid);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8366,7 +8375,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2047, 307, "LE Add Device To Periodic Advertiser List",
 				le_add_dev_periodic_adv_list_cmd, 8, true,
 				status_rsp, 1, true },
-	{ 0x2048, 308, "LE Remove Device From Periodic Advertiser List" },
+	{ 0x2048, 308, "LE Remove Device From Periodic Advertiser List",
+				le_remove_dev_periodic_adv_list_cmd, 8, true,
+				status_rsp, 1, true },
 	{ 0x2049, 309, "LE Clear Periodic Advertiser List" },
 	{ 0x204a, 310, "LE Read Periodic Advertiser List Size" },
 	{ 0x204b, 311, "LE Read Transmit Power" },
-- 
2.9.3

