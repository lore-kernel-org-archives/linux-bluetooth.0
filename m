Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 08/31] monitor: Add LE Read Maximum Advertising Data Length decoding
Date: Tue,  6 Jun 2017 11:40:57 +0200
Message-Id: <20170606094120.14541-11-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 8dd0d57..b91fbe5 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2234,6 +2234,12 @@ struct bt_hci_cmd_ext_adv_set {
 	uint8_t  max_events;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_READ_MAX_ADV_DATA_LEN			0x203a
+struct bt_hci_rsp_le_read_max_adv_data_len {
+	uint8_t  status;
+	uint16_t  max_len;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index f109b4f..afebf7d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7221,6 +7221,14 @@ static void le_set_ext_adv_enable_cmd(const void *data, uint8_t size)
 	}
 }
 
+static void le_read_max_adv_data_len_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_max_adv_data_len *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Max length: %d", rsp->max_len);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7945,7 +7953,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2039, 293, "LE Set Extended Advertising Enable",
 				le_set_ext_adv_enable_cmd, 2, false,
 				status_rsp, 1, true },
-	{ 0x203a, 294, "LE Read Maximum Advertising Data Length" },
+	{ 0x203a, 294, "LE Read Maximum Advertising Data Length",
+				null_cmd, 0, true,
+				le_read_max_adv_data_len_rsp, 3, true },
 	{ 0x203b, 295, "LE Read Number of Supported Advertising Sets" },
 	{ 0x203c, 296, "LE Remove Advertising Set" },
 	{ 0x203d, 297, "LE Clear Advertising Sets" },
-- 
2.9.3

