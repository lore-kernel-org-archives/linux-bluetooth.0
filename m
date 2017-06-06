Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 23/31] monitor: Add LE Clear Periodic Advertiser List decoding
Date: Tue,  6 Jun 2017 11:41:12 +0200
Message-Id: <20170606094120.14541-26-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     | 2 ++
 monitor/packet.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 78f2f57..11ba897 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2345,6 +2345,8 @@ struct bt_hci_cmd_le_remove_dev_periodic_adv_list {
 	uint8_t  sid;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_CLEAR_PERIODIC_ADV_LIST		0x2049
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 455f490..d7dd913 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8378,7 +8378,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2048, 308, "LE Remove Device From Periodic Advertiser List",
 				le_remove_dev_periodic_adv_list_cmd, 8, true,
 				status_rsp, 1, true },
-	{ 0x2049, 309, "LE Clear Periodic Advertiser List" },
+	{ 0x2049, 309, "LE Clear Periodic Advertiser List",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
 	{ 0x204a, 310, "LE Read Periodic Advertiser List Size" },
 	{ 0x204b, 311, "LE Read Transmit Power" },
 	{ 0x204c, 312, "LE Read RF Path Compensation" },
-- 
2.9.3

