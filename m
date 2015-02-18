Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] monitor: Factor out channel selection to separate function
Date: Wed, 18 Feb 2015 22:46:31 +0100
Message-Id: <1424295992-29506-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to have conditions check in single place.
---
 monitor/l2cap.c | 85 +++++++++++++++++----------------------------------------
 1 file changed, 25 insertions(+), 60 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 0030a4c..342bd8e 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -223,7 +223,7 @@ static void assign_mode(const struct l2cap_frame *frame,
 	}
 }
 
-static uint16_t get_psm(const struct l2cap_frame *frame)
+static int get_chan_data_index(const struct l2cap_frame *frame)
 {
 	int i;
 
@@ -238,64 +238,44 @@ static uint16_t get_psm(const struct l2cap_frame *frame)
 
 		if (frame->in) {
 			if (chan_list[i].scid == frame->cid)
-				return chan_list[i].psm;
+				return i;
 		} else {
 			if (chan_list[i].dcid == frame->cid)
-				return chan_list[i].psm;
+				return i;
 		}
 	}
 
-	return 0;
+	return -1;
 }
 
-static uint8_t get_mode(const struct l2cap_frame *frame)
+static uint16_t get_psm(const struct l2cap_frame *frame)
 {
-	int i;
+	int i = get_chan_data_index(frame);
 
-	for (i = 0; i < MAX_CHAN; i++) {
-		if (chan_list[i].index != frame->index &&
-					chan_list[i].ctrlid == 0)
-			continue;
+	if (i < 0)
+		return 0;
 
-		if (chan_list[i].handle != frame->handle &&
-					chan_list[i].ctrlid != frame->index)
-			continue;
+	return chan_list[i].psm;
+}
 
-		if (frame->in) {
-			if (chan_list[i].scid == frame->cid)
-				return chan_list[i].mode;
-		} else {
-			if (chan_list[i].dcid == frame->cid)
-				return chan_list[i].mode;
-		}
-	}
+static uint8_t get_mode(const struct l2cap_frame *frame)
+{
+	int i = get_chan_data_index(frame);
+
+	if (i < 0)
+		return 0;
 
-	return 0;
+	return chan_list[i].mode;
 }
 
 static uint16_t get_chan(const struct l2cap_frame *frame)
 {
-	int i;
-
-	for (i = 0; i < MAX_CHAN; i++) {
-		if (chan_list[i].index != frame->index &&
-					chan_list[i].ctrlid == 0)
-			continue;
+	int i = get_chan_data_index(frame);
 
-		if (chan_list[i].handle != frame->handle &&
-					chan_list[i].ctrlid != frame->index)
-			continue;
-
-		if (frame->in) {
-			if (chan_list[i].scid == frame->cid)
-				return i;
-		} else {
-			if (chan_list[i].dcid == frame->cid)
-				return i;
-		}
-	}
+	if (i < 0)
+		return 0;
 
-	return 0;
+	return i;
 }
 
 static void assign_ext_ctrl(const struct l2cap_frame *frame,
@@ -326,27 +306,12 @@ static void assign_ext_ctrl(const struct l2cap_frame *frame,
 
 static uint8_t get_ext_ctrl(const struct l2cap_frame *frame)
 {
-	int i;
+	int i = get_chan_data_index(frame);
 
-	for (i = 0; i < MAX_CHAN; i++) {
-		if (chan_list[i].index != frame->index &&
-						chan_list[i].ctrlid == 0)
-			continue;
-
-		if (chan_list[i].handle != frame->handle &&
-					chan_list[i].ctrlid != frame->index)
-			continue;
-
-		if (frame->in) {
-			if (chan_list[i].scid == frame->cid)
-				return chan_list[i].ext_ctrl;
-		} else {
-			if (chan_list[i].dcid == frame->cid)
-				return chan_list[i].ext_ctrl;
-		}
-	}
+	if (i < 0)
+		return 0;
 
-	return 0;
+	return chan_list[i].ext_ctrl;
 }
 
 static char *sar2str(uint8_t sar)
-- 
1.9.3

