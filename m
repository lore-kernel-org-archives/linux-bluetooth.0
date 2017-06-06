Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 10/31] monitor: Add LE Remove Advertising Set decoding
Date: Tue,  6 Jun 2017 11:40:59 +0200
Message-Id: <20170606094120.14541-13-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Remove Advertising Set (0x08|0x003c) plen 1
        Handle: 1
---
 monitor/bt.h     |  5 +++++
 monitor/packet.c | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index ac42cbf..365388e 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2246,6 +2246,11 @@ struct bt_hci_rsp_le_read_num_supported_adv_sets {
 	uint8_t  num_of_sets;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_REMOVE_ADV_SET			0x203c
+struct bt_hci_cmd_le_remove_adv_set {
+	uint8_t  handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 214f23e..c3dfb47 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7237,6 +7237,13 @@ static void le_read_num_supported_adv_sets_rsp(const void *data, uint8_t size)
 	print_field("Num supported adv sets: %d", rsp->num_of_sets);
 }
 
+static void le_remove_adv_set_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_remove_adv_set *cmd = data;
+
+	print_handle(cmd->handle);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7967,7 +7974,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x203b, 295, "LE Read Number of Supported Advertising Sets",
 				null_cmd, 0, true,
 				le_read_num_supported_adv_sets_rsp, 2, true },
-	{ 0x203c, 296, "LE Remove Advertising Set" },
+	{ 0x203c, 296, "LE Remove Advertising Set",
+				le_remove_adv_set_cmd, 1, true,
+				status_rsp, 1, true },
 	{ 0x203d, 297, "LE Clear Advertising Sets" },
 	{ 0x203e, 298, "LE Set Periodic Advertising Parameters" },
 	{ 0x203f, 299, "LE Set Periodic Advertising Data" },
-- 
2.9.3

