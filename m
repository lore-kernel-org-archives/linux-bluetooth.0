Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] AVRCP: rename avrcp_header to avc_header
Date: Mon, 12 Sep 2011 14:29:54 +0300
Message-Id: <1315826997-13818-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

AVCTP carries AV/C packets/PDUs not AVRCP as avrcp_header suggests.
---
 audio/control.c |   98 +++++++++++++++++++++++++++---------------------------
 1 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index f84c7f7..37b0806 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -212,14 +212,14 @@ struct avctp_header {
 } __attribute__ ((packed));
 #define AVCTP_HEADER_LENGTH 3
 
-struct avrcp_header {
+struct avc_header {
 	uint8_t code:4;
 	uint8_t _hdr0:4;
 	uint8_t subunit_id:3;
 	uint8_t subunit_type:5;
 	uint8_t opcode;
 } __attribute__ ((packed));
-#define AVRCP_HEADER_LENGTH 3
+#define AVC_HEADER_LENGTH 3
 
 struct avrcp_spec_avc_pdu {
 	uint8_t company_id[3];
@@ -242,14 +242,14 @@ struct avctp_header {
 } __attribute__ ((packed));
 #define AVCTP_HEADER_LENGTH 3
 
-struct avrcp_header {
+struct avc_header {
 	uint8_t _hdr0:4;
 	uint8_t code:4;
 	uint8_t subunit_type:5;
 	uint8_t subunit_id:3;
 	uint8_t opcode;
 } __attribute__ ((packed));
-#define AVRCP_HEADER_LENGTH 3
+#define AVC_HEADER_LENGTH 3
 
 struct avrcp_spec_avc_pdu {
 	uint8_t company_id[3];
@@ -721,13 +721,13 @@ static const char *battery_status_to_str(enum battery_status status)
 
 static int avctp_send_event(struct control *control, uint8_t id, void *data)
 {
-	uint8_t buf[AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
+	uint8_t buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH +
 					AVRCP_SPECAVCPDU_HEADER_LENGTH + 9];
 	struct avctp_header *avctp = (void *) buf;
-	struct avrcp_header *avrcp = (void *) &buf[AVCTP_HEADER_LENGTH];
+	struct avc_header *avc = (void *) &buf[AVCTP_HEADER_LENGTH];
 	struct avrcp_spec_avc_pdu *pdu = (void *) &buf[AVCTP_HEADER_LENGTH +
-							AVRCP_HEADER_LENGTH];
-	int sk;
+							AVC_HEADER_LENGTH];
+	int sk = g_io_channel_unix_get_fd(control->io);
 	uint16_t size;
 
 	if (control->state != AVCTP_STATE_CONNECTED)
@@ -743,9 +743,9 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
 	avctp->cr = AVCTP_RESPONSE;
 	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
 
-	avrcp->code = CTYPE_CHANGED;
-	avrcp->subunit_type = SUBUNIT_PANEL;
-	avrcp->opcode = OP_VENDORDEP;
+	avc->code = CTYPE_CHANGED;
+	avc->subunit_type = SUBUNIT_PANEL;
+	avc->opcode = OP_VENDORDEP;
 
 	pdu->company_id[0] = IEEEID_BTSIG >> 16;
 	pdu->company_id[1] = (IEEEID_BTSIG >> 8) & 0xFF;
@@ -780,7 +780,7 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
 	}
 
 	pdu->params_len = htons(size);
-	size += AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
+	size += AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH +
 					AVRCP_SPECAVCPDU_HEADER_LENGTH;
 
 	sk = g_io_channel_unix_get_fd(control->io);
@@ -1451,19 +1451,19 @@ static struct pdu_handler {
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avctp_header *avctp,
-					struct avrcp_header *avrcp,
+					struct avc_header *avc,
 					int operand_count)
 {
 	struct pdu_handler *handler;
-	struct avrcp_spec_avc_pdu *pdu = (void *) avrcp + AVRCP_HEADER_LENGTH;
+	struct avrcp_spec_avc_pdu *pdu = (void *) avc + AVC_HEADER_LENGTH;
 	uint32_t company_id = (pdu->company_id[0] << 16) |
 				(pdu->company_id[1] << 8) |
 				(pdu->company_id[2]);
 
 	if (company_id != IEEEID_BTSIG ||
 				pdu->packet_type != AVCTP_PACKET_SINGLE) {
-		avrcp->code = CTYPE_NOT_IMPLEMENTED;
-		return AVRCP_HEADER_LENGTH;
+		avc->code = CTYPE_NOT_IMPLEMENTED;
+		return AVC_HEADER_LENGTH;
 	}
 
 	pdu->packet_type = 0;
@@ -1477,7 +1477,7 @@ static int handle_vendordep_pdu(struct control *control,
 			break;
 	}
 
-	if (!handler || handler->code != avrcp->code) {
+	if (!handler || handler->code != avc->code) {
 		pdu->params[0] = E_INVALID_COMMAND;
 		goto err_metadata;
 	}
@@ -1487,16 +1487,16 @@ static int handle_vendordep_pdu(struct control *control,
 		goto err_metadata;
 	}
 
-	avrcp->code = handler->func(control, pdu, avctp->transaction);
+	avc->code = handler->func(control, pdu, avctp->transaction);
 
-	return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH +
+	return AVC_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH +
 						ntohs(pdu->params_len);
 
 err_metadata:
 	pdu->params_len = htons(1);
-	avrcp->code = CTYPE_REJECTED;
+	avc->code = CTYPE_REJECTED;
 
-	return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH + 1;
+	return AVC_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH + 1;
 }
 
 static void avctp_disconnected(struct audio_device *dev)
@@ -1593,7 +1593,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 	struct control *control = data;
 	unsigned char buf[1024], *operands;
 	struct avctp_header *avctp;
-	struct avrcp_header *avrcp;
+	struct avc_header *avc;
 	int ret, packet_size, operand_count, sock;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
@@ -1622,65 +1622,65 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 			avctp->cr, avctp->ipid, ntohs(avctp->pid));
 
 	ret -= sizeof(struct avctp_header);
-	if ((unsigned int) ret < sizeof(struct avrcp_header)) {
+	if ((unsigned int) ret < sizeof(struct avc_header)) {
 		error("Too small AVRCP packet");
 		goto failed;
 	}
 
-	avrcp = (struct avrcp_header *) (buf + sizeof(struct avctp_header));
+	avc = (struct avc_header *) (buf + sizeof(struct avctp_header));
 
-	ret -= sizeof(struct avrcp_header);
+	ret -= sizeof(struct avc_header);
 
-	operands = buf + sizeof(struct avctp_header) + sizeof(struct avrcp_header);
+	operands = buf + sizeof(struct avctp_header) + sizeof(struct avc_header);
 	operand_count = ret;
 
-	DBG("AVRCP %s 0x%01X, subunit_type 0x%02X, subunit_id 0x%01X, "
+	DBG("AV/C %s 0x%01X, subunit_type 0x%02X, subunit_id 0x%01X, "
 			"opcode 0x%02X, %d operands",
 			avctp->cr ? "response" : "command",
-			avrcp->code, avrcp->subunit_type, avrcp->subunit_id,
-			avrcp->opcode, operand_count);
+			avc->code, avc->subunit_type, avc->subunit_id,
+			avc->opcode, operand_count);
 
 	if (avctp->packet_type != AVCTP_PACKET_SINGLE) {
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_NOT_IMPLEMENTED;
+		avc->code = CTYPE_NOT_IMPLEMENTED;
 	} else if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
 		avctp->ipid = 1;
 		avctp->cr = AVCTP_RESPONSE;
 		packet_size = sizeof(*avctp);
 	} else if (avctp->cr == AVCTP_COMMAND &&
-			avrcp->code == CTYPE_CONTROL &&
-			avrcp->subunit_type == SUBUNIT_PANEL &&
-			avrcp->opcode == OP_PASSTHROUGH) {
+			avc->code == CTYPE_CONTROL &&
+			avc->subunit_type == SUBUNIT_PANEL &&
+			avc->opcode == OP_PASSTHROUGH) {
 		handle_panel_passthrough(control, operands, operand_count);
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_ACCEPTED;
+		avc->code = CTYPE_ACCEPTED;
 	} else if (avctp->cr == AVCTP_COMMAND &&
-			avrcp->code == CTYPE_STATUS &&
-			(avrcp->opcode == OP_UNITINFO
-			|| avrcp->opcode == OP_SUBUNITINFO)) {
+			avc->code == CTYPE_STATUS &&
+			(avc->opcode == OP_UNITINFO
+			|| avc->opcode == OP_SUBUNITINFO)) {
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_STABLE;
+		avc->code = CTYPE_STABLE;
 		/* The first operand should be 0x07 for the UNITINFO response.
 		 * Neither AVRCP (section 22.1, page 117) nor AVC Digital
 		 * Interface Command Set (section 9.2.1, page 45) specs
 		 * explain this value but both use it */
-		if (operand_count >= 1 && avrcp->opcode == OP_UNITINFO)
+		if (operand_count >= 1 && avc->opcode == OP_UNITINFO)
 			operands[0] = 0x07;
 		if (operand_count >= 2)
 			operands[1] = SUBUNIT_PANEL << 3;
-		DBG("reply to %s", avrcp->opcode == OP_UNITINFO ?
+		DBG("reply to %s", avc->opcode == OP_UNITINFO ?
 				"OP_UNITINFO" : "OP_SUBUNITINFO");
 	} else if (avctp->cr == AVCTP_COMMAND &&
-			avrcp->opcode == OP_VENDORDEP) {
+			avc->opcode == OP_VENDORDEP) {
 		int r_size;
 		operand_count -= 3;
 		avctp->cr = AVCTP_RESPONSE;
-		r_size = handle_vendordep_pdu(control, avctp, avrcp,
+		r_size = handle_vendordep_pdu(control, avctp, avc,
 								operand_count);
 		packet_size = AVCTP_HEADER_LENGTH + r_size;
 	} else {
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_REJECTED;
+		avc->code = CTYPE_REJECTED;
 	}
 
 	ret = write(sock, buf, packet_size);
@@ -2092,10 +2092,10 @@ static DBusMessage *control_is_connected(DBusConnection *conn,
 
 static int avctp_send_passthrough(struct control *control, uint8_t op)
 {
-	unsigned char buf[AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH + 2];
+	unsigned char buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH + 2];
 	struct avctp_header *avctp = (void *) buf;
-	struct avrcp_header *avrcp = (void *) &buf[AVCTP_HEADER_LENGTH];
-	uint8_t *operands = &buf[AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH];
+	struct avc_header *avc = (void *) &buf[AVCTP_HEADER_LENGTH];
+	uint8_t *operands = &buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];
 	int sk = g_io_channel_unix_get_fd(control->io);
 	static uint8_t transaction = 0;
 
@@ -2106,9 +2106,9 @@ static int avctp_send_passthrough(struct control *control, uint8_t op)
 	avctp->cr = AVCTP_COMMAND;
 	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
 
-	avrcp->code = CTYPE_CONTROL;
-	avrcp->subunit_type = SUBUNIT_PANEL;
-	avrcp->opcode = OP_PASSTHROUGH;
+	avc->code = CTYPE_CONTROL;
+	avc->subunit_type = SUBUNIT_PANEL;
+	avc->opcode = OP_PASSTHROUGH;
 
 	operands[0] = op & 0x7f;
 	operands[1] = 0;
-- 
1.7.6.1

