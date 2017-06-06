Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 09/31] monitor: Add LE Read Number of Supported Advertising Sets decoding
Date: Tue,  6 Jun 2017 11:40:58 +0200
Message-Id: <20170606094120.14541-12-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index b91fbe5..ac42cbf 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2240,6 +2240,12 @@ struct bt_hci_rsp_le_read_max_adv_data_len {
 	uint16_t  max_len;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS			0x203b
+struct bt_hci_rsp_le_read_num_supported_adv_sets {
+	uint8_t  status;
+	uint8_t  num_of_sets;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index afebf7d..214f23e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7229,6 +7229,14 @@ static void le_read_max_adv_data_len_rsp(const void *data, uint8_t size)
 	print_field("Max length: %d", rsp->max_len);
 }
 
+static void le_read_num_supported_adv_sets_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_num_supported_adv_sets *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Num supported adv sets: %d", rsp->num_of_sets);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7956,7 +7964,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x203a, 294, "LE Read Maximum Advertising Data Length",
 				null_cmd, 0, true,
 				le_read_max_adv_data_len_rsp, 3, true },
-	{ 0x203b, 295, "LE Read Number of Supported Advertising Sets" },
+	{ 0x203b, 295, "LE Read Number of Supported Advertising Sets",
+				null_cmd, 0, true,
+				le_read_num_supported_adv_sets_rsp, 2, true },
 	{ 0x203c, 296, "LE Remove Advertising Set" },
 	{ 0x203d, 297, "LE Clear Advertising Sets" },
 	{ 0x203e, 298, "LE Set Periodic Advertising Parameters" },
-- 
2.9.3

