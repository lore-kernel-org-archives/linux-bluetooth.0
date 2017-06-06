Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 21/31] monitor: Add LE Add Device To Periodic Advertiser List decoding
Date: Tue,  6 Jun 2017 11:41:10 +0200
Message-Id: <20170606094120.14541-24-michal.narajowski@codecoup.pl>
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
index 65c69c0..5a932d8 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2331,6 +2331,13 @@ struct bt_hci_cmd_le_periodic_adv_term_sync {
 	uint16_t  sync_handle;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_ADD_DEV_PERIODIC_ADV_LIST		0x2047
+struct bt_hci_cmd_le_add_dev_periodic_adv_list {
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  sid;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 35172f4..f09c9b1 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7591,6 +7591,15 @@ static void le_periodic_adv_term_sync_cmd(const void *data, uint8_t size)
 	print_field("Sync handle: 0x%4.4x", cmd->sync_handle);
 }
 
+static void le_add_dev_periodic_adv_list_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_add_dev_periodic_adv_list *cmd = data;
+
+	print_addr_type("Adv address type", cmd->addr_type);
+	print_addr("Adv address", cmd->addr, cmd->addr_type);
+	print_field("SID: 0x%2.2x", cmd->sid);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8354,7 +8363,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync",
 				le_periodic_adv_term_sync_cmd, 2, true,
 				status_rsp, 1, true },
-	{ 0x2047, 307, "LE Add Device To Periodic Advertiser List" },
+	{ 0x2047, 307, "LE Add Device To Periodic Advertiser List",
+				le_add_dev_periodic_adv_list_cmd, 8, true,
+				status_rsp, 1, true },
 	{ 0x2048, 308, "LE Remove Device From Periodic Advertiser List" },
 	{ 0x2049, 309, "LE Clear Periodic Advertiser List" },
 	{ 0x204a, 310, "LE Read Periodic Advertiser List Size" },
-- 
2.9.3

