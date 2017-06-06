Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 11/31] monitor: Add LE Clear Advertising Sets decoding
Date: Tue,  6 Jun 2017 11:41:00 +0200
Message-Id: <20170606094120.14541-14-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     | 2 ++
 monitor/packet.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 365388e..6d2a76e 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2251,6 +2251,8 @@ struct bt_hci_cmd_le_remove_adv_set {
 	uint8_t  handle;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_CLEAR_ADV_SETS			0x203d
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index c3dfb47..9caaeaf 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7977,7 +7977,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x203c, 296, "LE Remove Advertising Set",
 				le_remove_adv_set_cmd, 1, true,
 				status_rsp, 1, true },
-	{ 0x203d, 297, "LE Clear Advertising Sets" },
+	{ 0x203d, 297, "LE Clear Advertising Sets",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
 	{ 0x203e, 298, "LE Set Periodic Advertising Parameters" },
 	{ 0x203f, 299, "LE Set Periodic Advertising Data" },
 	{ 0x2040, 300, "LE Set Periodic Advertising Enable" },
-- 
2.9.3

