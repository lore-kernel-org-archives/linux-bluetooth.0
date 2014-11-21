Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 3/7] monitor: Add functionality to store extented control in DB
Date: Fri, 21 Nov 2014 19:17:41 +0530
Message-id: <1416577665-21876-4-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
References: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A function added to store extented control in DB.
---
 monitor/l2cap.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 48fab8c..ef84925 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -54,6 +54,7 @@ struct chan_data {
 	uint16_t psm;
 	uint8_t  ctrlid;
 	uint8_t  mode;
+	uint8_t  ext_ctrl;
 };
 
 static struct chan_data chan_list[MAX_CHAN];
@@ -255,6 +256,32 @@ static uint16_t get_chan(const struct l2cap_frame *frame)
 	return 0;
 }
 
+static void assign_ext_ctrl(const struct l2cap_frame *frame,
+					uint8_t ext_ctrl, uint16_t dcid)
+{
+	int i;
+
+	for (i = 0; i < MAX_CHAN; i++) {
+		if (chan_list[i].index != frame->index)
+			continue;
+
+		if (chan_list[i].handle != frame->handle)
+			continue;
+
+		if (frame->in) {
+			if (chan_list[i].scid == dcid) {
+				chan_list[i].ext_ctrl = ext_ctrl;
+				break;
+			}
+		} else {
+			if (chan_list[i].dcid == dcid) {
+				chan_list[i].ext_ctrl = ext_ctrl;
+				break;
+			}
+		}
+	}
+}
+
 #define MAX_INDEX 16
 
 struct index_data {
@@ -573,8 +600,9 @@ static void print_config_options(const struct l2cap_frame *frame,
 					get_le32(data + consumed + 14));
 			break;
 		case 0x07:
-			print_field("  Max window size: %d",
+			print_field("  Extended window size: %d",
 					get_le16(data + consumed + 2));
+			assign_ext_ctrl(frame, 1, cid);
 			break;
 		default:
 			packet_hexdump(data + consumed + 2, len);
-- 
1.9.1

