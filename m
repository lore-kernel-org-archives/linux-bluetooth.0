Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] monitor: Pass identifier to L2CAP signaling command handler
Date: Thu, 19 Feb 2015 14:40:53 +0100
Message-Id: <1424353254-28363-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used to correctly match LE Connection Request and
Response.
---
 monitor/l2cap.c | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 7a6edbe..c59cb55 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -937,7 +937,7 @@ static void print_conn_param_result(uint16_t result)
 	print_field("Result: %s (0x%4.4x)", str, le16_to_cpu(result));
 }
 
-static void sig_cmd_reject(const struct l2cap_frame *frame)
+static void sig_cmd_reject(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_cmd_reject *pdu = frame->data;
 	const void *data = frame->data;
@@ -982,7 +982,7 @@ static void sig_cmd_reject(const struct l2cap_frame *frame)
 	}
 }
 
-static void sig_conn_req(const struct l2cap_frame *frame)
+static void sig_conn_req(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_conn_req *pdu = frame->data;
 
@@ -992,7 +992,7 @@ static void sig_conn_req(const struct l2cap_frame *frame)
 	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0);
 }
 
-static void sig_conn_rsp(const struct l2cap_frame *frame)
+static void sig_conn_rsp(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_conn_rsp *pdu = frame->data;
 
@@ -1004,7 +1004,7 @@ static void sig_conn_rsp(const struct l2cap_frame *frame)
 	assign_dcid(frame, le16_to_cpu(pdu->dcid), le16_to_cpu(pdu->scid));
 }
 
-static void sig_config_req(const struct l2cap_frame *frame)
+static void sig_config_req(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_config_req *pdu = frame->data;
 
@@ -1013,7 +1013,7 @@ static void sig_config_req(const struct l2cap_frame *frame)
 	print_config_options(frame, 4, le16_to_cpu(pdu->dcid), false);
 }
 
-static void sig_config_rsp(const struct l2cap_frame *frame)
+static void sig_config_rsp(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_config_rsp *pdu = frame->data;
 
@@ -1023,7 +1023,7 @@ static void sig_config_rsp(const struct l2cap_frame *frame)
 	print_config_options(frame, 6, le16_to_cpu(pdu->scid), true);
 }
 
-static void sig_disconn_req(const struct l2cap_frame *frame)
+static void sig_disconn_req(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_disconn_req *pdu = frame->data;
 
@@ -1031,7 +1031,7 @@ static void sig_disconn_req(const struct l2cap_frame *frame)
 	print_cid("Source", pdu->scid);
 }
 
-static void sig_disconn_rsp(const struct l2cap_frame *frame)
+static void sig_disconn_rsp(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_disconn_rsp *pdu = frame->data;
 
@@ -1041,24 +1041,24 @@ static void sig_disconn_rsp(const struct l2cap_frame *frame)
 	release_scid(frame, le16_to_cpu(pdu->scid));
 }
 
-static void sig_echo_req(const struct l2cap_frame *frame)
+static void sig_echo_req(const struct l2cap_frame *frame, uint8_t ident)
 {
 	packet_hexdump(frame->data, frame->size);
 }
 
-static void sig_echo_rsp(const struct l2cap_frame *frame)
+static void sig_echo_rsp(const struct l2cap_frame *frame, uint8_t ident)
 {
 	packet_hexdump(frame->data, frame->size);
 }
 
-static void sig_info_req(const struct l2cap_frame *frame)
+static void sig_info_req(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_info_req *pdu = frame->data;
 
 	print_info_type(pdu->type);
 }
 
-static void sig_info_rsp(const struct l2cap_frame *frame)
+static void sig_info_rsp(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_info_rsp *pdu = frame->data;
 	const void *data = frame->data;
@@ -1109,7 +1109,7 @@ static void sig_info_rsp(const struct l2cap_frame *frame)
 	}
 }
 
-static void sig_create_chan_req(const struct l2cap_frame *frame)
+static void sig_create_chan_req(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_create_chan_req *pdu = frame->data;
 
@@ -1121,7 +1121,7 @@ static void sig_create_chan_req(const struct l2cap_frame *frame)
 								pdu->ctrlid);
 }
 
-static void sig_create_chan_rsp(const struct l2cap_frame *frame)
+static void sig_create_chan_rsp(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_create_chan_rsp *pdu = frame->data;
 
@@ -1133,7 +1133,7 @@ static void sig_create_chan_rsp(const struct l2cap_frame *frame)
 	assign_dcid(frame, le16_to_cpu(pdu->dcid), le16_to_cpu(pdu->scid));
 }
 
-static void sig_move_chan_req(const struct l2cap_frame *frame)
+static void sig_move_chan_req(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_move_chan_req *pdu = frame->data;
 
@@ -1141,7 +1141,7 @@ static void sig_move_chan_req(const struct l2cap_frame *frame)
 	print_field("Controller ID: %d", pdu->ctrlid);
 }
 
-static void sig_move_chan_rsp(const struct l2cap_frame *frame)
+static void sig_move_chan_rsp(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_move_chan_rsp *pdu = frame->data;
 
@@ -1149,7 +1149,7 @@ static void sig_move_chan_rsp(const struct l2cap_frame *frame)
 	print_move_result(pdu->result);
 }
 
-static void sig_move_chan_cfm(const struct l2cap_frame *frame)
+static void sig_move_chan_cfm(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_move_chan_cfm *pdu = frame->data;
 
@@ -1157,14 +1157,15 @@ static void sig_move_chan_cfm(const struct l2cap_frame *frame)
 	print_move_cfm_result(pdu->result);
 }
 
-static void sig_move_chan_cfm_rsp(const struct l2cap_frame *frame)
+static void sig_move_chan_cfm_rsp(const struct l2cap_frame *frame,
+								uint8_t ident)
 {
 	const struct bt_l2cap_pdu_move_chan_cfm_rsp *pdu = frame->data;
 
 	print_cid("Initiator", pdu->icid);
 }
 
-static void sig_conn_param_req(const struct l2cap_frame *frame)
+static void sig_conn_param_req(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_conn_param_req *pdu = frame->data;
 
@@ -1174,14 +1175,14 @@ static void sig_conn_param_req(const struct l2cap_frame *frame)
 	print_field("Timeout multiplier: %d", le16_to_cpu(pdu->timeout));
 }
 
-static void sig_conn_param_rsp(const struct l2cap_frame *frame)
+static void sig_conn_param_rsp(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_conn_param_rsp *pdu = frame->data;
 
 	print_conn_param_result(pdu->result);
 }
 
-static void sig_le_conn_req(const struct l2cap_frame *frame)
+static void sig_le_conn_req(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_le_conn_req *pdu = frame->data;
 
@@ -1194,7 +1195,7 @@ static void sig_le_conn_req(const struct l2cap_frame *frame)
 	assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0);
 }
 
-static void sig_le_conn_rsp(const struct l2cap_frame *frame)
+static void sig_le_conn_rsp(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_le_conn_rsp *pdu = frame->data;
 
@@ -1207,7 +1208,7 @@ static void sig_le_conn_rsp(const struct l2cap_frame *frame)
 	/*assign_dcid(frame, le16_to_cpu(pdu->dcid), le16_to_cpu(pdu->scid));*/
 }
 
-static void sig_le_flowctl_creds(const struct l2cap_frame *frame)
+static void sig_le_flowctl_creds(const struct l2cap_frame *frame, uint8_t ident)
 {
 	const struct bt_l2cap_pdu_le_flowctl_creds *pdu = frame->data;
 
@@ -1218,7 +1219,7 @@ static void sig_le_flowctl_creds(const struct l2cap_frame *frame)
 struct sig_opcode_data {
 	uint8_t opcode;
 	const char *str;
-	void (*func) (const struct l2cap_frame *frame);
+	void (*func)(const struct l2cap_frame *frame, uint8_t identifier);
 	uint16_t size;
 	bool fixed;
 };
@@ -1377,7 +1378,7 @@ static void bredr_sig_packet(uint16_t index, bool in, uint16_t handle,
 		}
 
 		l2cap_frame_init(&frame, index, in, handle, cid, data, len);
-		opcode_data->func(&frame);
+		opcode_data->func(&frame, hdr->ident);
 
 		data += len;
 		size -= len;
@@ -1458,7 +1459,7 @@ static void le_sig_packet(uint16_t index, bool in, uint16_t handle,
 	}
 
 	l2cap_frame_init(&frame, index, in, handle, cid, data, len);
-	opcode_data->func(&frame);
+	opcode_data->func(&frame, hdr->ident);
 }
 
 static void connless_packet(uint16_t index, bool in, uint16_t handle,
-- 
1.9.1

