Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v2 1/2] Monitor: Modify design of AVRCP callback functions
Date: Fri, 12 Sep 2014 18:46:56 +0530
Message-id: <1410527817-17666-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Modified the design of AVRCP callback functions.
---
 monitor/avctp.c | 103 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 37 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index c7e242b..f366b87 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -158,6 +158,13 @@
 #define AVRCP_ATTRIBUTE_SHUFFLE		0x03
 #define AVRCP_ATTRIBUTE_SCAN		0x04
 
+struct avctp_frame {
+	uint8_t hdr;
+	uint8_t pt;
+	uint16_t pid;
+	struct l2cap_frame l2cap_frame;
+};
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -517,15 +524,19 @@ static const char *charset2str(uint16_t charset)
 	}
 }
 
-static bool avrcp_passthrough_packet(struct l2cap_frame *frame)
+static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+
 	packet_hexdump(frame->data, frame->size);
 	return true;
 }
 
-static bool avrcp_get_capabilities(struct l2cap_frame *frame, uint8_t ctype,
-						uint8_t len, uint8_t indent)
+static bool avrcp_get_capabilities(struct avctp_frame *avctp_frame,
+					uint8_t ctype, uint8_t len,
+					uint8_t indent)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	uint8_t cap, count;
 	int i;
 
@@ -576,10 +587,11 @@ static bool avrcp_get_capabilities(struct l2cap_frame *frame, uint8_t ctype,
 	return true;
 }
 
-static bool avrcp_list_player_attributes(struct l2cap_frame *frame,
+static bool avrcp_list_player_attributes(struct avctp_frame *avctp_frame,
 						uint8_t ctype, uint8_t len,
 						uint8_t indent)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	uint8_t num;
 	int i;
 
@@ -604,9 +616,11 @@ static bool avrcp_list_player_attributes(struct l2cap_frame *frame,
 	return true;
 }
 
-static bool avrcp_list_player_values(struct l2cap_frame *frame, uint8_t ctype,
-						uint8_t len, uint8_t indent)
+static bool avrcp_list_player_values(struct avctp_frame *avctp_frame,
+					uint8_t ctype, uint8_t len,
+					uint8_t indent)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	static uint8_t attr = 0;
 	uint8_t num;
 
@@ -640,10 +654,11 @@ response:
 	return true;
 }
 
-static bool avrcp_get_current_player_value(struct l2cap_frame *frame,
+static bool avrcp_get_current_player_value(struct avctp_frame *avctp_frame,
 						uint8_t ctype, uint8_t len,
 						uint8_t indent)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	uint8_t num;
 
 	if (!l2cap_frame_get_u8(frame, &num))
@@ -688,9 +703,11 @@ response:
 	return true;
 }
 
-static bool avrcp_set_player_value(struct l2cap_frame *frame, uint8_t ctype,
-					uint8_t len, uint8_t indent)
+static bool avrcp_set_player_value(struct avctp_frame *avctp_frame,
+					uint8_t ctype, uint8_t len,
+					uint8_t indent)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	uint8_t num;
 
 	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
@@ -720,10 +737,11 @@ static bool avrcp_set_player_value(struct l2cap_frame *frame, uint8_t ctype,
 	return true;
 }
 
-static bool avrcp_get_player_attribute_text(struct l2cap_frame *frame,
+static bool avrcp_get_player_attribute_text(struct avctp_frame *avctp_frame,
 						uint8_t ctype, uint8_t len,
 						uint8_t indent)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	uint8_t num;
 
 	if (!l2cap_frame_get_u8(frame, &num))
@@ -783,10 +801,11 @@ response:
 	return true;
 }
 
-static bool avrcp_get_player_value_text(struct l2cap_frame *frame,
+static bool avrcp_get_player_value_text(struct avctp_frame *avctp_frame,
 					uint8_t ctype, uint8_t len,
 					uint8_t indent)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	static uint8_t attr = 0;
 	uint8_t num;
 
@@ -858,9 +877,11 @@ response:
 	return true;
 }
 
-static bool avrcp_displayable_charset(struct l2cap_frame *frame, uint8_t ctype,
-					uint8_t len, uint8_t indent)
+static bool avrcp_displayable_charset(struct avctp_frame *avctp_frame,
+					uint8_t ctype, uint8_t len,
+					uint8_t indent)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	uint8_t num;
 
 	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
@@ -886,8 +907,8 @@ static bool avrcp_displayable_charset(struct l2cap_frame *frame, uint8_t ctype,
 
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
-	bool (*func) (struct l2cap_frame *frame, uint8_t ctype, uint8_t len,
-							uint8_t indent);
+	bool (*func) (struct avctp_frame *avctp_frame, uint8_t ctype,
+						uint8_t len, uint8_t indent);
 };
 
 static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
@@ -915,10 +936,11 @@ static bool avrcp_rejected_packet(struct l2cap_frame *frame, uint8_t indent)
 	return true;
 }
 
-static bool avrcp_pdu_packet(struct l2cap_frame *frame, uint8_t ctype,
+static bool avrcp_pdu_packet(struct avctp_frame *avctp_frame, uint8_t ctype,
 								uint8_t indent)
 {
-	uint8_t pduid, pt;
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint8_t pduid;
 	uint16_t len;
 	int i;
 	const struct avrcp_ctrl_pdu_data *ctrl_pdu_data = NULL;
@@ -926,14 +948,14 @@ static bool avrcp_pdu_packet(struct l2cap_frame *frame, uint8_t ctype,
 	if (!l2cap_frame_get_u8(frame, &pduid))
 		return false;
 
-	if (!l2cap_frame_get_u8(frame, &pt))
+	if (!l2cap_frame_get_u8(frame, &avctp_frame->pt))
 		return false;
 
 	if (!l2cap_frame_get_be16(frame, &len))
 		return false;
 
 	print_indent(indent, COLOR_OFF, "AVRCP: ", pdu2str(pduid), COLOR_OFF,
-					" pt %s len 0x%04x", pt2str(pt), len);
+			" pt %s len 0x%04x", pt2str(avctp_frame->pt), len);
 
 	if (frame->size != len)
 		return false;
@@ -953,11 +975,13 @@ static bool avrcp_pdu_packet(struct l2cap_frame *frame, uint8_t ctype,
 		return true;
 	}
 
-	return ctrl_pdu_data->func(frame, ctype, len, indent + 2);
+	return ctrl_pdu_data->func(avctp_frame, ctype, len, indent + 2);
 }
 
-static bool avrcp_control_packet(struct l2cap_frame *frame)
+static bool avrcp_control_packet(struct avctp_frame *avctp_frame)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+
 	uint8_t ctype, address, subunit, opcode, company[3], indent = 2;
 
 	if (!l2cap_frame_get_u8(frame, &ctype) ||
@@ -988,7 +1012,7 @@ static bool avrcp_control_packet(struct l2cap_frame *frame)
 
 	switch (opcode) {
 	case 0x7c:
-		return avrcp_passthrough_packet(frame);
+		return avrcp_passthrough_packet(avctp_frame);
 	case 0x00:
 		if (!l2cap_frame_get_u8(frame, &company[0]) ||
 				!l2cap_frame_get_u8(frame, &company[1]) ||
@@ -998,29 +1022,32 @@ static bool avrcp_control_packet(struct l2cap_frame *frame)
 		print_field("%*cCompany ID: 0x%02x%02x%02x", indent, ' ',
 					company[0], company[1], company[2]);
 
-		return avrcp_pdu_packet(frame, ctype, 10);
+		return avrcp_pdu_packet(avctp_frame, ctype, 10);
 	default:
 		packet_hexdump(frame->data, frame->size);
 		return true;
 	}
 }
 
-static bool avrcp_browsing_packet(struct l2cap_frame *frame, uint8_t hdr)
+static bool avrcp_browsing_packet(struct avctp_frame *avctp_frame)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+
 	packet_hexdump(frame->data, frame->size);
 	return true;
 }
 
-static void avrcp_packet(struct l2cap_frame *frame, uint8_t hdr)
+static void avrcp_packet(struct avctp_frame *avctp_frame)
 {
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	bool ret;
 
 	switch (frame->psm) {
 	case 0x17:
-		ret = avrcp_control_packet(frame);
+		ret = avrcp_control_packet(avctp_frame);
 		break;
 	case 0x1B:
-		ret = avrcp_browsing_packet(frame, hdr);
+		ret = avrcp_browsing_packet(avctp_frame);
 		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
@@ -1035,15 +1062,16 @@ static void avrcp_packet(struct l2cap_frame *frame, uint8_t hdr)
 
 void avctp_packet(const struct l2cap_frame *frame)
 {
-	uint8_t hdr;
-	uint16_t pid;
-	struct l2cap_frame avctp_frame;
+	struct l2cap_frame *l2cap_frame;
+	struct avctp_frame avctp_frame;
 	const char *pdu_color;
 
-	l2cap_frame_pull(&avctp_frame, frame, 0);
+	l2cap_frame_pull(&avctp_frame.l2cap_frame, frame, 0);
+
+	l2cap_frame = &avctp_frame.l2cap_frame;
 
-	if (!l2cap_frame_get_u8(&avctp_frame, &hdr) ||
-				!l2cap_frame_get_be16(&avctp_frame, &pid)) {
+	if (!l2cap_frame_get_u8(l2cap_frame, &avctp_frame.hdr) ||
+			!l2cap_frame_get_be16(l2cap_frame, &avctp_frame.pid)) {
 		print_text(COLOR_ERROR, "frame too short");
 		packet_hexdump(frame->data, frame->size);
 		return;
@@ -1057,11 +1085,12 @@ void avctp_packet(const struct l2cap_frame *frame)
 	print_indent(6, pdu_color, "AVCTP", "", COLOR_OFF,
 				" %s: %s: type 0x%02x label %d PID 0x%04x",
 				frame->psm == 23 ? "Control" : "Browsing",
-				hdr & 0x02 ? "Response" : "Command",
-				hdr & 0x0c, hdr >> 4, pid);
+				avctp_frame.hdr & 0x02 ? "Response" : "Command",
+				avctp_frame.hdr & 0x0c, avctp_frame.hdr >> 4,
+				avctp_frame.pid);
 
-	if (pid == 0x110e || pid == 0x110c)
-		avrcp_packet(&avctp_frame, hdr);
+	if (avctp_frame.pid == 0x110e || avctp_frame.pid == 0x110c)
+		avrcp_packet(&avctp_frame);
 	else
 		packet_hexdump(frame->data, frame->size);
 }
-- 
1.9.1

