Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 24/31] monitor: Add LE Read Periodic Advertiser List Size decoding
Date: Tue,  6 Jun 2017 11:41:13 +0200
Message-Id: <20170606094120.14541-27-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 11ba897..df89ea7 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2347,6 +2347,12 @@ struct bt_hci_cmd_le_remove_dev_periodic_adv_list {
 
 #define BT_HCI_CMD_LE_CLEAR_PERIODIC_ADV_LIST		0x2049
 
+#define BT_HCI_CMD_LE_READ_PERIODIC_ADV_LIST_SIZE		0x204a
+struct bt_hci_rsp_le_read_dev_periodic_adv_list_size {
+	uint8_t  status;
+	uint8_t  list_size;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index d7dd913..64847fa 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7609,6 +7609,14 @@ static void le_remove_dev_periodic_adv_list_cmd(const void *data, uint8_t size)
 	print_field("SID: 0x%2.2x", cmd->sid);
 }
 
+static void le_read_periodic_adv_list_size_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_dev_periodic_adv_list_size *rsp = data;
+
+	print_status(rsp->status);
+	print_field("List size: 0x%2.2x", rsp->list_size);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8381,7 +8389,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2049, 309, "LE Clear Periodic Advertiser List",
 				null_cmd, 0, true,
 				status_rsp, 1, true },
-	{ 0x204a, 310, "LE Read Periodic Advertiser List Size" },
+	{ 0x204a, 310, "LE Read Periodic Advertiser List Size",
+				null_cmd, 0, true,
+				le_read_periodic_adv_list_size_rsp, 2, true },
 	{ 0x204b, 311, "LE Read Transmit Power" },
 	{ 0x204c, 312, "LE Read RF Path Compensation" },
 	{ 0x204d, 313, "LE Write RF Path Compensation" },
-- 
2.9.3

