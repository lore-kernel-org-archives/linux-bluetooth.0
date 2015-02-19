Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] monitor: Add PSM tracking support for LE CoC
Date: Thu, 19 Feb 2015 17:20:34 +0100
Message-Id: <1424362834-12706-1-git-send-email-szymon.janc@tieto.com>
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
V2: pass ident in struct l2cap_frame as suggested by Johan

 monitor/l2cap.c | 57 +++++++++++++++++++++++++++++++++++++++------------------
 monitor/l2cap.h |  2 ++
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 7a6edbe..5faa26f 100644
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
@@ -135,6 +136,7 @@ static void assign_scid(const struct l2cap_frame *frame,
 	memset(&chan_list[n], 0, sizeof(chan_list[n]));
 	chan_list[n].index = frame->index;
 	chan_list[n].handle = frame->handle;
+	chan_list[n].ident = frame->ident;
 
 	if (frame->in)
 		chan_list[n].dcid = scid;
@@ -171,8 +173,8 @@ static void release_scid(const struct l2cap_frame *frame, uint16_t scid)
 	}
 }
 
-static void assign_dcid(const struct l2cap_frame *frame,
-					uint16_t dcid, uint16_t scid)
+static void assign_dcid(const struct l2cap_frame *frame, uint16_t dcid,
+								uint16_t scid)
 {
 	int i;
 
@@ -183,15 +185,32 @@ static void assign_dcid(const struct l2cap_frame *frame,
 		if (chan_list[i].handle != frame->handle)
 			continue;
 
+		if (frame->ident != 0 && chan_list[i].ident != frame->ident)
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
@@ -1204,7 +1223,7 @@ static void sig_le_conn_rsp(const struct l2cap_frame *frame)
 	print_field("Credits: %u", le16_to_cpu(pdu->credits));
 	print_conn_result(pdu->result);
 
-	/*assign_dcid(frame, le16_to_cpu(pdu->dcid), le16_to_cpu(pdu->scid));*/
+	assign_dcid(frame, le16_to_cpu(pdu->dcid), 0);
 }
 
 static void sig_le_flowctl_creds(const struct l2cap_frame *frame)
@@ -1281,13 +1300,14 @@ static const struct sig_opcode_data le_sig_opcode_table[] = {
 	{ },
 };
 
-static void l2cap_frame_init(struct l2cap_frame *frame,
-				uint16_t index, bool in, uint16_t handle,
+static void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
+				uint16_t handle, uint8_t ident,
 				uint16_t cid, const void *data, uint16_t size)
 {
 	frame->index  = index;
 	frame->in     = in;
 	frame->handle = handle;
+	frame->ident  = ident;
 	frame->cid    = cid;
 	frame->data   = data;
 	frame->size   = size;
@@ -1376,7 +1396,8 @@ static void bredr_sig_packet(uint16_t index, bool in, uint16_t handle,
 			}
 		}
 
-		l2cap_frame_init(&frame, index, in, handle, cid, data, len);
+		l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid,
+								data, len);
 		opcode_data->func(&frame);
 
 		data += len;
@@ -1457,7 +1478,7 @@ static void le_sig_packet(uint16_t index, bool in, uint16_t handle,
 		}
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, cid, data, len);
+	l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid, data, len);
 	opcode_data->func(&frame);
 }
 
@@ -1488,7 +1509,7 @@ static void connless_packet(uint16_t index, bool in, uint16_t handle,
 		break;
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, cid, data, size);
+	l2cap_frame_init(&frame, index, in, handle, 0, cid, data, size);
 }
 
 static void print_controller_list(const uint8_t *data, uint16_t size)
@@ -1857,7 +1878,7 @@ static void amp_packet(uint16_t index, bool in, uint16_t handle,
 		}
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, cid, data + 6, len);
+	l2cap_frame_init(&frame, index, in, handle, 0, cid, data + 6, len);
 	opcode_data->func(&frame);
 }
 
@@ -2400,7 +2421,7 @@ static void att_packet(uint16_t index, bool in, uint16_t handle,
 		}
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, cid, data + 1, size - 1);
+	l2cap_frame_init(&frame, index, in, handle, 0, cid, data + 1, size - 1);
 	opcode_data->func(&frame);
 }
 
@@ -2851,7 +2872,7 @@ static void smp_packet(uint16_t index, bool in, uint16_t handle,
 		}
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, cid, data + 1, size - 1);
+	l2cap_frame_init(&frame, index, in, handle, 0, cid, data + 1, size - 1);
 	opcode_data->func(&frame);
 }
 
@@ -2884,7 +2905,7 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 		smp_packet(index, in, handle, cid, data, size);
 		break;
 	default:
-		l2cap_frame_init(&frame, index, in, handle, cid, data, size);
+		l2cap_frame_init(&frame, index, in, handle, 0, cid, data, size);
 
 		if (frame.mode > 0) {
 			ext_ctrl = get_ext_ctrl(&frame);
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 975f78a..711bcb1 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -29,6 +29,7 @@ struct l2cap_frame {
 	uint16_t index;
 	bool in;
 	uint16_t handle;
+	uint8_t ident;
 	uint16_t cid;
 	uint16_t psm;
 	uint16_t chan;
@@ -44,6 +45,7 @@ static inline void l2cap_frame_pull(struct l2cap_frame *frame,
 		frame->index   = source->index;
 		frame->in      = source->in;
 		frame->handle  = source->handle;
+		frame->ident   = source->ident;
 		frame->cid     = source->cid;
 		frame->psm     = source->psm;
 		frame->chan    = source->chan;
-- 
1.9.1

