Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 3/6] monitor: Extract extended L2CAP extended control field
Date: Wed, 07 Jan 2015 13:53:17 +0530
Message-id: <1420619000-24211-4-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
References: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for extracting extended L2CAP extended control field.
---
 monitor/l2cap.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index c0bc9a8..5f135b0 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -282,6 +282,31 @@ static void assign_ext_ctrl(const struct l2cap_frame *frame,
 	}
 }
 
+static uint8_t get_ext_ctrl(const struct l2cap_frame *frame)
+{
+	int i;
+
+	for (i = 0; i < MAX_CHAN; i++) {
+		if (chan_list[i].index != frame->index &&
+						chan_list[i].ctrlid == 0)
+			continue;
+
+		if (chan_list[i].handle != frame->handle &&
+					chan_list[i].ctrlid != frame->index)
+			continue;
+
+		if (frame->in) {
+			if (chan_list[i].scid == frame->cid)
+				return chan_list[i].ext_ctrl;
+		} else {
+			if (chan_list[i].dcid == frame->cid)
+				return chan_list[i].ext_ctrl;
+		}
+	}
+
+	return 0;
+}
+
 #define MAX_INDEX 16
 
 struct index_data {
@@ -2721,6 +2746,9 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 			uint16_t cid, const void *data, uint16_t size)
 {
 	struct l2cap_frame frame;
+	uint32_t ctrl32 = 0;
+	uint16_t ctrl16 = 0;
+	uint8_t ext_ctrl;
 
 	switch (cid) {
 	case 0x0001:
@@ -2745,10 +2773,38 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 	default:
 		l2cap_frame_init(&frame, index, in, handle, cid, data, size);
 
-		print_indent(6, COLOR_CYAN, "Channel:", "", COLOR_OFF,
-				" %d len %d [PSM %d mode %d] {chan %d}",
+		if (frame.mode > 0) {
+			ext_ctrl = get_ext_ctrl(&frame);
+
+			if (ext_ctrl) {
+				if (!l2cap_frame_get_le32(&frame, &ctrl32))
+					return;
+
+				print_indent(6, COLOR_CYAN, "Channel:", "",
+						COLOR_OFF, " %d len %d"
+						" ext_ctrl 0x%8.8x"
+						" [PSM %d mode %d] {chan %d}",
+						cid, size, ctrl32, frame.psm,
+						frame.mode, frame.chan);
+			} else {
+				if (!l2cap_frame_get_le16(&frame, &ctrl16))
+					return;
+
+				print_indent(6, COLOR_CYAN, "Channel:", "",
+						COLOR_OFF, " %d len %d"
+						" ctrl 0x%4.4x"
+						" [PSM %d mode %d] {chan %d}",
+						cid, size, ctrl16, frame.psm,
+						frame.mode, frame.chan);
+			}
+
+			printf("\n");
+		} else {
+			print_indent(6, COLOR_CYAN, "Channel:", "", COLOR_OFF,
+					" %d len %d [PSM %d mode %d] {chan %d}",
 						cid, size, frame.psm,
 						frame.mode, frame.chan);
+		}
 
 		switch (frame.psm) {
 		case 0x0001:
-- 
1.9.1

