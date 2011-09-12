Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] AVRCP: rename avrcp_spec_avc_pdu to avrcp_header
Date: Mon, 12 Sep 2011 14:29:55 +0300
Message-Id: <1315826997-13818-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since old avrcp_header got renamed to avc_header now we can use
avrcp_header for AVRCP PDUs.
---
 audio/control.c |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 37b0806..73130e4 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -221,7 +221,7 @@ struct avc_header {
 } __attribute__ ((packed));
 #define AVC_HEADER_LENGTH 3
 
-struct avrcp_spec_avc_pdu {
+struct avrcp_header {
 	uint8_t company_id[3];
 	uint8_t pdu_id;
 	uint8_t packet_type:2;
@@ -229,7 +229,7 @@ struct avrcp_spec_avc_pdu {
 	uint16_t params_len;
 	uint8_t params[0];
 } __attribute__ ((packed));
-#define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
+#define AVRCP_HEADER_LENGTH 7
 
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
@@ -251,7 +251,7 @@ struct avc_header {
 } __attribute__ ((packed));
 #define AVC_HEADER_LENGTH 3
 
-struct avrcp_spec_avc_pdu {
+struct avrcp_header {
 	uint8_t company_id[3];
 	uint8_t pdu_id;
 	uint8_t rsvd:6;
@@ -259,7 +259,7 @@ struct avrcp_spec_avc_pdu {
 	uint16_t params_len;
 	uint8_t params[0];
 } __attribute__ ((packed));
-#define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
+#define AVRCP_HEADER_LENGTH 7
 
 #else
 #error "Unknown byte order"
@@ -722,10 +722,10 @@ static const char *battery_status_to_str(enum battery_status status)
 static int avctp_send_event(struct control *control, uint8_t id, void *data)
 {
 	uint8_t buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH +
-					AVRCP_SPECAVCPDU_HEADER_LENGTH + 9];
+					AVRCP_HEADER_LENGTH + 9];
 	struct avctp_header *avctp = (void *) buf;
 	struct avc_header *avc = (void *) &buf[AVCTP_HEADER_LENGTH];
-	struct avrcp_spec_avc_pdu *pdu = (void *) &buf[AVCTP_HEADER_LENGTH +
+	struct avrcp_header *pdu = (void *) &buf[AVCTP_HEADER_LENGTH +
 							AVC_HEADER_LENGTH];
 	int sk = g_io_channel_unix_get_fd(control->io);
 	uint16_t size;
@@ -781,7 +781,7 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
 
 	pdu->params_len = htons(size);
 	size += AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH +
-					AVRCP_SPECAVCPDU_HEADER_LENGTH;
+					AVRCP_HEADER_LENGTH;
 
 	sk = g_io_channel_unix_get_fd(control->io);
 
@@ -987,7 +987,7 @@ static void mp_set_media_attributes(struct control *control,
 }
 
 static uint8_t avrcp_handle_get_capabilities(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1027,7 +1027,7 @@ err:
 }
 
 static uint8_t avrcp_handle_list_player_attributes(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1061,7 +1061,7 @@ done:
 }
 
 static uint8_t avrcp_handle_list_player_values(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1092,7 +1092,7 @@ err:
 }
 
 static uint8_t avrcp_handle_get_element_attributes(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1161,7 +1161,7 @@ err:
 }
 
 static uint8_t avrcp_handle_get_current_player_value(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1225,7 +1225,7 @@ err:
 }
 
 static uint8_t avrcp_handle_set_player_value(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1278,7 +1278,7 @@ err:
 }
 
 static uint8_t avrcp_handle_displayable_charset(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1298,7 +1298,7 @@ static uint8_t avrcp_handle_displayable_charset(struct control *control,
 }
 
 static uint8_t avrcp_handle_ct_battery_status(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1325,7 +1325,7 @@ err:
 }
 
 static uint8_t avrcp_handle_get_play_status(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1360,7 +1360,7 @@ static uint8_t avrcp_handle_get_play_status(struct control *control,
 }
 
 static uint8_t avrcp_handle_register_notification(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu,
+						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
@@ -1418,7 +1418,7 @@ static struct pdu_handler {
 	uint8_t pdu_id;
 	uint8_t code;
 	uint8_t (*func) (struct control *control,
-					struct avrcp_spec_avc_pdu *pdu,
+					struct avrcp_header *pdu,
 					uint8_t transaction);
 } handlers[] = {
 		{ AVRCP_GET_CAPABILITIES, CTYPE_STATUS,
@@ -1455,7 +1455,7 @@ static int handle_vendordep_pdu(struct control *control,
 					int operand_count)
 {
 	struct pdu_handler *handler;
-	struct avrcp_spec_avc_pdu *pdu = (void *) avc + AVC_HEADER_LENGTH;
+	struct avrcp_header *pdu = (void *) avc + AVC_HEADER_LENGTH;
 	uint32_t company_id = (pdu->company_id[0] << 16) |
 				(pdu->company_id[1] << 8) |
 				(pdu->company_id[2]);
@@ -1469,7 +1469,7 @@ static int handle_vendordep_pdu(struct control *control,
 	pdu->packet_type = 0;
 	pdu->rsvd = 0;
 
-	if (operand_count + 3 < AVRCP_SPECAVCPDU_HEADER_LENGTH)
+	if (operand_count + 3 < AVRCP_HEADER_LENGTH)
 		goto err_metadata;
 
 	for (handler = handlers; handler; handler++) {
@@ -1489,14 +1489,14 @@ static int handle_vendordep_pdu(struct control *control,
 
 	avc->code = handler->func(control, pdu, avctp->transaction);
 
-	return AVC_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH +
+	return AVC_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
 						ntohs(pdu->params_len);
 
 err_metadata:
 	pdu->params_len = htons(1);
 	avc->code = CTYPE_REJECTED;
 
-	return AVC_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH + 1;
+	return AVC_HEADER_LENGTH + AVRCP_HEADER_LENGTH + 1;
 }
 
 static void avctp_disconnected(struct audio_device *dev)
-- 
1.7.6.1

