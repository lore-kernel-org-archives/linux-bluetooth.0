Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Add Passthrough signal to handle_panel_passthrough
Date: Thu, 11 Aug 2011 09:14:45 -0500
Cc: lucas.demarchi@profusion.mobi, luiz.dentz@gmail.com,
	david_stockwell@att.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108110914.46199.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add Passthrough signal to handle_panel_passthrough,
  rename avrcp->code to avrcp->ctype for consistency,
  correct sense of Key State flag field.

Based on Release 4.96
---
 audio/control.c |  121 
+++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 99 insertions(+), 22 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 8ddcc10..472cab2 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -230,7 +230,7 @@ struct avctp_header {
 #define AVCTP_HEADER_LENGTH 3
 
 struct avrcp_header {
-	uint8_t code:4;
+	uint8_t ctype:4;
 	uint8_t _hdr0:4;
 	uint8_t subunit_id:3;
 	uint8_t subunit_type:5;
@@ -261,7 +261,7 @@ struct avctp_header {
 
 struct avrcp_header {
 	uint8_t _hdr0:4;
-	uint8_t code:4;
+	uint8_t ctype:4;
 	uint8_t subunit_type:5;
 	uint8_t subunit_id:3;
 	uint8_t opcode;
@@ -551,6 +551,23 @@ static sdp_record_t *avrcp_tg_record(void)
 	return record;
 }
 
+/**
+ *	@brief	get_company_id: Three-byte Company_ID from AVRCP message
+ *
+ *	AVRCP uses three-byte company_ids, which must be converted from
+ *	BT/network big-endian order to internal form.
+ */
+static gint32 get_company_id(unsigned char *cid)
+{
+	gint32 company_id = 0;
+	company_id = *cid;
+	company_id <<= 8;
+	company_id |= *(cid+1);
+	company_id <<= 8;
+	company_id |= *(cid+2);
+	return company_id;
+}
+
 static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
 {
 	struct uinput_event event;
@@ -572,17 +589,74 @@ static void send_key(int fd, uint16_t key, int pressed)
 	send_event(fd, EV_SYN, SYN_REPORT, 0);
 }
 
+/**
+ *	@brief: handle_panel_passthrough: Handles AVRCP 1.0+ PASSTHROUGH command.
+ *
+ *	Original version only passed the keystroke to uinput.
+ *
+ *	Added a Passthrough signal, with the key state AND the optional
+ *	following company_id and vendor-unique message.
+ */
+
 static void handle_panel_passthrough(struct control *control,
-					const unsigned char *operands,
-					int operand_count)
+				     struct avrcp_passthru *avrcp,
+				     int avrcp_length)
 {
 	const char *status;
 	int pressed, i;
+	guchar key_pressed;
+	gboolean key_status;
+	gint32 pass_company_id;
+	gchar *pass_string;
 
-	if (operand_count == 0)
+	if ((unsigned int) avrcp_length < sizeof(struct avrcp_passthru) - 5)
 		return;
 
-	if (operands[0] & 0x80) {
+	/*
+	 * Following creates the Passthrough signal.
+	 * Key_state is zero if key is pressed (AVRCP v14r00 sect 22.3, p119)
+	 */
+
+	key_pressed = avrcp->key;
+	key_status = !avrcp->key_state;
+	DBG("Passthrough Key: %x Pressed: %s",
+			key_pressed, key_status ? "true" : "false");
+	if (key_pressed == VENDOR_UNIQUE_OP) {
+		if ((unsigned int) avrcp_length >
+				sizeof(struct avrcp_passthru)) {
+			pass_company_id = get_company_id(avrcp->company_id);
+			pass_string = g_strndup((const char *) avrcp->op_data,
+						(gsize) avrcp->op_len - 3);
+			DBG("Passthrough Company_ID: %06X String: %s",
+			    pass_company_id, pass_string);
+		} else if (avrcp_length == sizeof(struct avrcp_passthru)) {
+			pass_company_id = get_company_id(avrcp->company_id);
+			pass_string = (gchar *) g_malloc0(1);
+			DBG("Passthrough Company_ID: %06X String: <none>",
+			    pass_company_id);
+		} else {
+			pass_company_id = -1;
+			pass_string = (gchar *) g_malloc0(1);
+			DBG("Passthrough: No Company_ID or String!");
+		};
+	} else {
+		pass_company_id = -1;
+		pass_string = (gchar *) g_malloc0(1);
+	};
+
+	g_dbus_emit_signal(control->dev->conn, control->dev->path,
+		AUDIO_CONTROL_INTERFACE, "Passthrough",
+		DBUS_TYPE_BYTE, &key_pressed,
+		DBUS_TYPE_BOOLEAN, &key_status,
+		DBUS_TYPE_INT32, &pass_company_id,
+		DBUS_TYPE_STRING, &pass_string,
+		DBUS_TYPE_INVALID);
+
+	g_free(pass_string);
+
+	/* From here on, we are doing the equivalent of "SendKeys" */
+
+	if (avrcp->key_state) {
 		status = "released";
 		pressed = 0;
 	} else {
@@ -593,7 +667,7 @@ static void handle_panel_passthrough(struct control 
*control,
 	for (i = 0; key_map[i].name != NULL; i++) {
 		uint8_t key_quirks;
 
-		if ((operands[0] & 0x7F) != key_map[i].avrcp)
+		if (avrcp->key != key_map[i].avrcp)
 			continue;
 
 		DBG("AVRCP: %s %s", key_map[i].name, status);
@@ -616,9 +690,12 @@ static void handle_panel_passthrough(struct control 
*control,
 		break;
 	}
 
+	/* Note that the following will flag Vendor Dependent keypresses
+	   and any others not in the key_map.  However, this does not affect
+	   the functionality. */
+
 	if (key_map[i].name == NULL)
-		DBG("AVRCP: unknown button 0x%02X %s",
-						operands[0] & 0x7F, status);
+		DBG("AVRCP: unknown button 0x%02X %s", avrcp->key, status);
 }
 
 /* handle vendordep pdu inside an avctp packet */
@@ -626,7 +703,7 @@ static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
 					int operand_count)
 {
-	avrcp->code = CTYPE_NOT_IMPLEMENTED;
+	avrcp->ctype = CTYPE_NOT_IMPLEMENTED;
 	return AVRCP_HEADER_LENGTH;
 }
 
@@ -760,37 +837,36 @@ static gboolean control_cb(GIOChannel *chan, 
GIOCondition cond,
 
 	avrcp = (struct avrcp_header *) (buf + sizeof(struct avctp_header));
 
-	ret -= sizeof(struct avrcp_header);
-
 	operands = buf + sizeof(struct avctp_header) + sizeof(struct 
avrcp_header);
-	operand_count = ret;
+	operand_count = ret - sizeof(struct avrcp_header);
 
 	DBG("AVRCP %s 0x%01X, subunit_type 0x%02X, subunit_id 0x%01X, "
 			"opcode 0x%02X, %d operands",
 			avctp->cr ? "response" : "command",
-			avrcp->code, avrcp->subunit_type, avrcp->subunit_id,
+			avrcp->ctype, avrcp->subunit_type, avrcp->subunit_id,
 			avrcp->opcode, operand_count);
 
 	if (avctp->packet_type != AVCTP_PACKET_SINGLE) {
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_NOT_IMPLEMENTED;
+		avrcp->ctype = CTYPE_NOT_IMPLEMENTED;
 	} else if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
 		avctp->ipid = 1;
 		avctp->cr = AVCTP_RESPONSE;
 		packet_size = sizeof(*avctp);
 	} else if (avctp->cr == AVCTP_COMMAND &&
-			avrcp->code == CTYPE_CONTROL &&
+			avrcp->ctype == CTYPE_CONTROL &&
 			avrcp->subunit_type == SUBUNIT_PANEL &&
 			avrcp->opcode == OP_PASSTHROUGH) {
-		handle_panel_passthrough(control, operands, operand_count);
+		handle_panel_passthrough(control,
+					 (struct avrcp_passthru *) avrcp, ret);
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_ACCEPTED;
+		avrcp->ctype = CTYPE_ACCEPTED;
 	} else if (avctp->cr == AVCTP_COMMAND &&
-			avrcp->code == CTYPE_STATUS &&
+			avrcp->ctype == CTYPE_STATUS &&
 			(avrcp->opcode == OP_UNITINFO
 			|| avrcp->opcode == OP_SUBUNITINFO)) {
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_STABLE;
+		avrcp->ctype = CTYPE_STABLE;
 		/* The first operand should be 0x07 for the UNITINFO response.
 		 * Neither AVRCP (section 22.1, page 117) nor AVC Digital
 		 * Interface Command Set (section 9.2.1, page 45) specs
@@ -810,7 +886,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition 
cond,
 		packet_size = AVCTP_HEADER_LENGTH + r_size;
 	} else {
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_REJECTED;
+		avrcp->ctype = CTYPE_REJECTED;
 	}
 	ret = write(sock, buf, packet_size);
 	if (ret != packet_size)
@@ -1222,7 +1298,7 @@ static int avctp_send_passthrough(struct control 
*control, uint8_t op)
 	avctp->cr = AVCTP_COMMAND;
 	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
 
-	avrcp->code = CTYPE_CONTROL;
+	avrcp->ctype = CTYPE_CONTROL;
 	avrcp->subunit_type = SUBUNIT_PANEL;
 	avrcp->opcode = OP_PASSTHROUGH;
 
@@ -1324,6 +1400,7 @@ static GDBusSignalTable control_signals[] = {
 	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED},
 	{ "PropertyChanged",		"sv"	},
+	{ "Passthrough",		"ybis"	},
 	{ NULL, NULL }
 };
 
-- 
1.7.4.4

