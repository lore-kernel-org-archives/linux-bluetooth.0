Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 20/31] monitor: Add LE Periodic Advertising Terminate Sync decoding
Date: Tue,  6 Jun 2017 11:41:09 +0200
Message-Id: <20170606094120.14541-23-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Periodic Advertising Terminate Sync (0x08|0x0046) plen 2
        Sync handle: 0x0201
---
 monitor/bt.h     |  5 +++++
 monitor/packet.c | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 217e8f1..65c69c0 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2326,6 +2326,11 @@ struct bt_hci_cmd_le_periodic_adv_create_sync {
 
 #define BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL		0x2045
 
+#define BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC		0x2046
+struct bt_hci_cmd_le_periodic_adv_term_sync {
+	uint16_t  sync_handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 678663b..35172f4 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7584,6 +7584,13 @@ static void le_periodic_adv_create_sync_cmd(const void *data, uint8_t size)
 	print_field("Unused: 0x%2.2x", cmd->unused);
 }
 
+static void le_periodic_adv_term_sync_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_periodic_adv_term_sync *cmd = data;
+
+	print_field("Sync handle: 0x%4.4x", cmd->sync_handle);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8344,7 +8351,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel",
 				null_cmd, 0, true,
 				status_rsp, 1, true },
-	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync" },
+	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync",
+				le_periodic_adv_term_sync_cmd, 2, true,
+				status_rsp, 1, true },
 	{ 0x2047, 307, "LE Add Device To Periodic Advertiser List" },
 	{ 0x2048, 308, "LE Remove Device From Periodic Advertiser List" },
 	{ 0x2049, 309, "LE Clear Periodic Advertiser List" },
-- 
2.9.3

