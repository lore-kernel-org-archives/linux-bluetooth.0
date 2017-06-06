Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 19/31] monitor: Add LE Periodic Advertising Create Sync Cancel decoding
Date: Tue,  6 Jun 2017 11:41:08 +0200
Message-Id: <20170606094120.14541-22-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     | 2 ++
 monitor/packet.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 014cde6..217e8f1 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2324,6 +2324,8 @@ struct bt_hci_cmd_le_periodic_adv_create_sync {
 	uint8_t  unused;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL		0x2045
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 273f06f..678663b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8341,7 +8341,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2044, 304, "LE Periodic Advertising Create Sync",
 				le_periodic_adv_create_sync_cmd, 14, true,
 				status_rsp, 1, true },
-	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel" },
+	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
 	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync" },
 	{ 0x2047, 307, "LE Add Device To Periodic Advertiser List" },
 	{ 0x2048, 308, "LE Remove Device From Periodic Advertiser List" },
-- 
2.9.3

