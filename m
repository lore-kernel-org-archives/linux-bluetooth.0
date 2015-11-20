Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2 01/22] monitor/l2cap: Add channel sequence number
Date: Fri, 20 Nov 2015 15:13:19 +0100
Message-Id: <1448028820-25330-2-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds sequence number to channels structure which determines
order in which channels for the same PSM were created. It will be used
for protocols like AVDTP where there is single PSM used for multiple
channels and order it which they were created is important.
---
 monitor/l2cap.c | 44 +++++++++++++++++++++++++++++++-------------
 monitor/l2cap.h |  1 +
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 894c741..de86e64 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -99,6 +99,7 @@ struct chan_data {
 	uint8_t  ctrlid;
 	uint8_t  mode;
 	uint8_t  ext_ctrl;
+	uint8_t  seq_num;
 };
 
 static struct chan_data chan_list[MAX_CHAN];
@@ -107,10 +108,13 @@ static void assign_scid(const struct l2cap_frame *frame,
 				uint16_t scid, uint16_t psm, uint8_t ctrlid)
 {
 	int i, n = -1;
+	uint8_t seq_num = 1;
 
 	for (i = 0; i < MAX_CHAN; i++) {
-		if (n < 0 && chan_list[i].handle == 0x0000)
+		if (n < 0 && chan_list[i].handle == 0x0000) {
 			n = i;
+			continue;
+		}
 
 		if (chan_list[i].index != frame->index)
 			continue;
@@ -118,15 +122,16 @@ static void assign_scid(const struct l2cap_frame *frame,
 		if (chan_list[i].handle != frame->handle)
 			continue;
 
+		if (chan_list[i].psm == psm)
+			seq_num++;
+
 		if (frame->in) {
 			if (chan_list[i].dcid == scid) {
 				n = i;
-				break;
 			}
 		} else {
 			if (chan_list[i].scid == scid) {
 				n = i;
-				break;
 			}
 		}
 	}
@@ -147,6 +152,8 @@ static void assign_scid(const struct l2cap_frame *frame,
 	chan_list[n].psm = psm;
 	chan_list[n].ctrlid = ctrlid;
 	chan_list[n].mode = 0;
+
+	chan_list[n].seq_num = seq_num;
 }
 
 static void release_scid(const struct l2cap_frame *frame, uint16_t scid)
@@ -301,6 +308,16 @@ static uint16_t get_chan(const struct l2cap_frame *frame)
 	return i;
 }
 
+static uint8_t get_seq_num(const struct l2cap_frame *frame)
+{
+	int i = get_chan_data_index(frame);
+
+	if (i < 0)
+		return 0;
+
+	return chan_list[i].seq_num;
+}
+
 static void assign_ext_ctrl(const struct l2cap_frame *frame,
 					uint8_t ext_ctrl, uint16_t dcid)
 {
@@ -1384,16 +1401,17 @@ static void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
 				uint16_t handle, uint8_t ident,
 				uint16_t cid, const void *data, uint16_t size)
 {
-	frame->index  = index;
-	frame->in     = in;
-	frame->handle = handle;
-	frame->ident  = ident;
-	frame->cid    = cid;
-	frame->data   = data;
-	frame->size   = size;
-	frame->psm    = get_psm(frame);
-	frame->mode   = get_mode(frame);
-	frame->chan   = get_chan(frame);
+	frame->index   = index;
+	frame->in      = in;
+	frame->handle  = handle;
+	frame->ident   = ident;
+	frame->cid     = cid;
+	frame->data    = data;
+	frame->size    = size;
+	frame->psm     = get_psm(frame);
+	frame->mode    = get_mode(frame);
+	frame->chan    = get_chan(frame);
+	frame->seq_num = get_seq_num(frame);
 }
 
 static void bredr_sig_packet(uint16_t index, bool in, uint16_t handle,
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 0364454..813c793 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -34,6 +34,7 @@ struct l2cap_frame {
 	uint16_t psm;
 	uint16_t chan;
 	uint8_t mode;
+	uint8_t seq_num;
 	const void *data;
 	uint16_t size;
 };
-- 
2.6.2

