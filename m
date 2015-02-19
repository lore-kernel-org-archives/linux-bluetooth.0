Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] monitor: Add PSM tracking support for LE CoC
Date: Thu, 19 Feb 2015 14:40:54 +0100
Message-Id: <1424353254-28363-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1424353254-28363-1-git-send-email-szymon.janc@tieto.com>
References: <1424353254-28363-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This uses identifier to match simultaneous L2CAP connect requests
and responses.

< ACL Data TX: Handle 3585 flags 0x00 dlen 18
    LE L2CAP: LE Connection Request (0x14) ident 2 len 10
      PSM: 131 (0x0083)
      Source CID: 65
      MTU: 672
      MPS: 672
      Credits: 10
> ACL Data RX: Handle 3585 flags 0x02 dlen 18
    LE L2CAP: LE Connection Response (0x15) ident 2 len 10
      Destination CID: 65
      MTU: 23
      MPS: 23
      Credits: 5
      Result: Connection successful (0x0000)
< ACL Data TX: Handle 3585 flags 0x00 dlen 27
    Channel: 65 len 23 [PSM 131 mode 0] {chan 1}
      17 00 00 00 00 00 17 00 7f 7f 7f 7f 7f 7f 7f 7f  ................
      7f 7f 7f 7f 7f 7f 7f                             .......
< ACL Data TX: Handle 3585 flags 0x00 dlen 6
    Channel: 65 len 2 [PSM 131 mode 0] {chan 1}
      7f 7f                                            ..
---
 monitor/l2cap.c | 55 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index c59cb55..3c6006e 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -91,6 +91,7 @@
 struct chan_data {
 	uint16_t index;
 	uint16_t handle;
+	uint8_t ident;
 	uint16_t scid;
 	uint16_t dcid;
 	uint16_t psm;
@@ -101,8 +102,8 @@ struct chan_data {
 
 static struct chan_data chan_list[MAX_CHAN];
 
-static void assign_scid(const struct l2cap_frame *frame,
-				uint16_t scid, uint16_t psm, uint8_t ctrlid)
+static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
+				uint16_t psm, uint8_t ctrlid, uint8_t ident)
 {
 	int i, n = -1;
 
@@ -135,6 +136,7 @@ static void assign_scid(const struct l2cap_frame *frame,
 	memset(&chan_list[n], 0, sizeof(chan_list[n]));
 	chan_list[n].index = frame->index;
 	chan_list[n].handle = frame->handle;
+	chan_list[n].ident = ident;
 
 	if (frame->in)
 		chan_list[n].dcid = scid;
@@ -171,8 +173,8 @@ static void release_scid(const struct l2cap_frame *frame, uint16_t scid)
 	}
 }
 
-static void assign_dcid(const struct l2cap_frame *frame,
-					uint16_t dcid, uint16_t scid)
+static void assign_dcid(const struct l2cap_frame *frame, uint16_t dcid,
+						uint16_t scid, uint8_t ident)
 {
 	int i;
 
@@ -183,15 +185,32 @@ static void assign_dcid(const struct l2cap_frame *frame,
 		if (chan_list[i].handle != frame->handle)
 			continue;
 
+		if (chan_list[i].ident != ident)
+			continue;
+
 		if (frame->in) {
-			if (chan_list[i].scid == scid) {
-				chan_list[i].dcid = dcid;
-				break;
+			if (scid) {
+				if (chan_list[i].scid == scid) {
+					chan_list[i].dcid = dcid;
+					break;
+				}
+			} else {
+				if (chan_list[i].scid && !chan_list[i].dcid) {
+					chan_list[i].dcid = dcid;
+					break;
+				}
 			}
 		} else {
-			if (chan_list[i].dcid == scid) {
-				chan_list[i].scid = dcid;
-				break;
+			if (scid) {
+				if (chan_list[i].dcid == scid) {
+					chan_list[i].scid = dcid;
+					break;
+				}
+			} else {
+				if (chan_list[i].dcid && !chan_list[i].scid) {
+					chan_list[i].scid = dcid;
+					break;
+				}
 			}
 		}
 	}
@@ -989,7 +1008,8 @@ static void sig_conn_req(const struct l2cap_frame *frame, uint8_t ident)
 	print_psm(pdu->psm);
 	print_cid("Source", pdu->scid);
 
-	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0);
+	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0,
+									ident);
 }
 
 static void sig_conn_rsp(const struct l2cap_frame *frame, uint8_t ident)
@@ -1001,7 +1021,8 @@ static void sig_conn_rsp(const struct l2cap_frame *frame, uint8_t ident)
 	print_conn_result(pdu->result);
 	print_conn_status(pdu->status);
 
-	assign_dcid(frame, le16_to_cpu(pdu->dcid), le16_to_cpu(pdu->scid));
+	assign_dcid(frame, le16_to_cpu(pdu->dcid), le16_to_cpu(pdu->scid),
+									ident);
 }
 
 static void sig_config_req(const struct l2cap_frame *frame, uint8_t ident)
@@ -1118,7 +1139,7 @@ static void sig_create_chan_req(const struct l2cap_frame *frame, uint8_t ident)
 	print_field("Controller ID: %d", pdu->ctrlid);
 
 	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm),
-								pdu->ctrlid);
+							pdu->ctrlid, ident);
 }
 
 static void sig_create_chan_rsp(const struct l2cap_frame *frame, uint8_t ident)
@@ -1130,7 +1151,8 @@ static void sig_create_chan_rsp(const struct l2cap_frame *frame, uint8_t ident)
 	print_conn_result(pdu->result);
 	print_conn_status(pdu->status);
 
-	assign_dcid(frame, le16_to_cpu(pdu->dcid), le16_to_cpu(pdu->scid));
+	assign_dcid(frame, le16_to_cpu(pdu->dcid), le16_to_cpu(pdu->scid),
+									ident);
 }
 
 static void sig_move_chan_req(const struct l2cap_frame *frame, uint8_t ident)
@@ -1192,7 +1214,8 @@ static void sig_le_conn_req(const struct l2cap_frame *frame, uint8_t ident)
 	print_field("MPS: %u", le16_to_cpu(pdu->mps));
 	print_field("Credits: %u", le16_to_cpu(pdu->credits));
 
-	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0);
+	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0,
+									ident);
 }
 
 static void sig_le_conn_rsp(const struct l2cap_frame *frame, uint8_t ident)
@@ -1205,7 +1228,7 @@ static void sig_le_conn_rsp(const struct l2cap_frame *frame, uint8_t ident)
 	print_field("Credits: %u", le16_to_cpu(pdu->credits));
 	print_conn_result(pdu->result);
 
-	/*assign_dcid(frame, le16_to_cpu(pdu->dcid), le16_to_cpu(pdu->scid));*/
+	assign_dcid(frame, le16_to_cpu(pdu->dcid), 0, ident);
 }
 
 static void sig_le_flowctl_creds(const struct l2cap_frame *frame, uint8_t ident)
-- 
1.9.1

