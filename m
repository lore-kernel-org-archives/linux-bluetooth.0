Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <lukasz.rymanowski@tieto.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCHv2 hcidump 2/3] Add parameters parsing support for SAP PDU
Date: Fri, 30 Mar 2012 14:24:37 +0200
Message-ID: <1333110278-9230-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1333110278-9230-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1333110278-9230-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/sap.c |  214 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 1 deletion(-)

diff --git a/parser/sap.c b/parser/sap.c
index d463719..0c87c36 100644
--- a/parser/sap.c
+++ b/parser/sap.c
@@ -33,6 +33,8 @@
 
 #include "parser.h"
 
+#define PADDING4(x) ((4 - ((x) & 0x03)) & 0x03)
+
 #define SAP_CONNECT_REQ				0x00
 #define SAP_CONNECT_RESP			0x01
 #define SAP_DISCONNECT_REQ			0x02
@@ -55,6 +57,47 @@
 #define SAP_SET_TRANSPORT_PROTOCOL_REQ		0x13
 #define SAP_SET_TRANSPORT_PROTOCOL_RESP		0x14
 
+#define SAP_PARAM_ID_MAX_MSG_SIZE	0x00
+#define SAP_PARAM_ID_CONN_STATUS	0x01
+#define SAP_PARAM_ID_RESULT_CODE	0x02
+#define SAP_PARAM_ID_DISCONNECT_IND	0x03
+#define SAP_PARAM_ID_COMMAND_APDU	0x04
+#define SAP_PARAM_ID_COMMAND_APDU7816	0x10
+#define SAP_PARAM_ID_RESPONSE_APDU	0x05
+#define SAP_PARAM_ID_ATR		0x06
+#define SAP_PARAM_ID_CARD_READER_STATUS	0x07
+#define SAP_PARAM_ID_STATUS_CHANGE	0x08
+#define SAP_PARAM_ID_TRANSPORT_PROTOCOL	0x09
+
+#define SAP_STATUS_OK				0x00
+#define SAP_STATUS_CONNECTION_FAILED		0x01
+#define SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED	0x02
+#define SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL	0x03
+#define SAP_STATUS_OK_ONGOING_CALL		0x04
+
+#define SAP_DISCONNECTION_TYPE_GRACEFUL		0x00
+#define SAP_DISCONNECTION_TYPE_IMMEDIATE	0x01
+#define SAP_DISCONNECTION_TYPE_CLIENT		0xFF
+
+#define SAP_RESULT_OK			0x00
+#define SAP_RESULT_ERROR_NO_REASON	0x01
+#define SAP_RESULT_ERROR_NOT_ACCESSIBLE	0x02
+#define SAP_RESULT_ERROR_POWERED_OFF	0x03
+#define SAP_RESULT_ERROR_CARD_REMOVED	0x04
+#define SAP_RESULT_ERROR_POWERED_ON	0x05
+#define SAP_RESULT_ERROR_NO_DATA	0x06
+#define SAP_RESULT_NOT_SUPPORTED	0x07
+
+#define SAP_STATUS_CHANGE_UNKNOWN_ERROR		0x00
+#define SAP_STATUS_CHANGE_CARD_RESET		0x01
+#define SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE	0x02
+#define SAP_STATUS_CHANGE_CARD_REMOVED		0x03
+#define SAP_STATUS_CHANGE_CARD_INSERTED		0x04
+#define SAP_STATUS_CHANGE_CARD_RECOVERED	0x05
+
+#define SAP_TRANSPORT_PROTOCOL_T0	0x00
+#define SAP_TRANSPORT_PROTOCOL_T1	0x01
+
 static const char *msg2str(uint8_t msg)
 {
 	switch (msg) {
@@ -105,6 +148,175 @@ static const char *msg2str(uint8_t msg)
 	}
 }
 
+static const char *param2str(uint8_t param)
+{
+	switch (param) {
+	case SAP_PARAM_ID_MAX_MSG_SIZE:
+		return "MaxMsgSize";
+	case SAP_PARAM_ID_CONN_STATUS:
+		return "ConnectionStatus";
+	case SAP_PARAM_ID_RESULT_CODE:
+		return "ResultCode";
+	case SAP_PARAM_ID_DISCONNECT_IND:
+		return "DisconnectionType";
+	case SAP_PARAM_ID_COMMAND_APDU:
+		return "CommandAPDU";
+	case SAP_PARAM_ID_COMMAND_APDU7816:
+		return "CommandAPDU7816";
+	case SAP_PARAM_ID_RESPONSE_APDU:
+		return "ResponseAPDU";
+	case SAP_PARAM_ID_ATR:
+		return "ATR";
+	case SAP_PARAM_ID_CARD_READER_STATUS:
+		return "CardReaderStatus";
+	case SAP_PARAM_ID_STATUS_CHANGE:
+		return "StatusChange";
+	case SAP_PARAM_ID_TRANSPORT_PROTOCOL:
+		return "TransportProtocol";
+	default:
+		return "Reserved";
+	}
+}
+
+static const char *status2str(uint8_t status)
+{
+	switch (status) {
+	case  SAP_STATUS_OK:
+		return "OK, Server can fulfill requirements";
+	case  SAP_STATUS_CONNECTION_FAILED:
+		return "Error, Server unable to establish connection";
+	case  SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED:
+		return "Error, Server does not support maximum message size";
+	case  SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL:
+		return "Error, maximum message size by Client is too small";
+	case  SAP_STATUS_OK_ONGOING_CALL:
+		return "OK, ongoing call";
+	default:
+		return "Reserved";
+	}
+}
+
+static const char *disctype2str(uint8_t disctype)
+{
+	switch (disctype) {
+	case  SAP_DISCONNECTION_TYPE_GRACEFUL:
+		return "Graceful";
+	case  SAP_DISCONNECTION_TYPE_IMMEDIATE:
+		return "Immediate";
+	default:
+		return "Reserved";
+	}
+}
+
+static const char *result2str(uint8_t result)
+{
+	switch (result) {
+	case  SAP_RESULT_OK:
+		return "OK, request processed correctly";
+	case  SAP_RESULT_ERROR_NO_REASON:
+		return "Error, no reason defined";
+	case SAP_RESULT_ERROR_NOT_ACCESSIBLE:
+		return "Error, card not accessible";
+	case  SAP_RESULT_ERROR_POWERED_OFF:
+		return "Error, card (already) powered off";
+	case  SAP_RESULT_ERROR_CARD_REMOVED:
+		return "Error, card removed";
+	case  SAP_RESULT_ERROR_POWERED_ON:
+		return "Error, card already powered on";
+	case  SAP_RESULT_ERROR_NO_DATA:
+		return "Error, data not available";
+	case  SAP_RESULT_NOT_SUPPORTED:
+		return "Error, not supported";
+	default:
+		return "Reserved";
+	}
+}
+
+static const char *statuschg2str(uint8_t statuschg)
+{
+	switch (statuschg) {
+	case  SAP_STATUS_CHANGE_UNKNOWN_ERROR:
+		return "Unknown Error";
+	case  SAP_STATUS_CHANGE_CARD_RESET:
+		return "Card reset";
+	case  SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE:
+		return "Card not accessible";
+	case  SAP_STATUS_CHANGE_CARD_REMOVED:
+		return "Card removed";
+	case  SAP_STATUS_CHANGE_CARD_INSERTED:
+		return "Card inserted";
+	case  SAP_STATUS_CHANGE_CARD_RECOVERED:
+		return "Card recovered";
+	default:
+		return "Reserved";
+	}
+}
+
+static const char *prot2str(uint8_t prot)
+{
+	switch (prot) {
+	case SAP_TRANSPORT_PROTOCOL_T0:
+		return "T=0";
+	case SAP_TRANSPORT_PROTOCOL_T1:
+		return "T=1";
+	default:
+		return "Reserved";
+	}
+}
+
+static void parse_parameters(int level, struct frame *frm)
+{
+	uint8_t param;
+	uint16_t len;
+	uint8_t pv8;
+
+	while (frm->len > 3) {
+		p_indent(level, frm);
+
+		param = get_u8(frm);
+		get_u8(frm);
+		len = get_u16(frm);
+
+		printf("%s (0x%02x) len %d = ", param2str(param), param, len);
+
+		switch (param) {
+		case SAP_PARAM_ID_MAX_MSG_SIZE:
+			printf("%d\n", get_u16(frm));
+			break;
+		case SAP_PARAM_ID_CONN_STATUS:
+			pv8 = get_u8(frm);
+			printf("0x%02x (%s)\n", pv8, status2str(pv8));
+			break;
+		case SAP_PARAM_ID_RESULT_CODE:
+		case SAP_PARAM_ID_CARD_READER_STATUS:
+			pv8 = get_u8(frm);
+			printf("0x%02x (%s)\n", pv8, result2str(pv8));
+			break;
+		case SAP_PARAM_ID_DISCONNECT_IND:
+			pv8 = get_u8(frm);
+			printf("0x%02x (%s)\n", pv8, disctype2str(pv8));
+			break;
+		case SAP_PARAM_ID_STATUS_CHANGE:
+			pv8 = get_u8(frm);
+			printf("0x%02x (%s)\n", pv8, statuschg2str(pv8));
+			break;
+		case SAP_PARAM_ID_TRANSPORT_PROTOCOL:
+			pv8 = get_u8(frm);
+			printf("0x%02x (%s)\n", pv8, prot2str(pv8));
+			break;
+		default:
+			printf("\n");
+			raw_ndump(level + 1, frm, len);
+			frm->ptr += len;
+			frm->len -= len;
+		}
+
+		/* Skip padding */
+		frm->ptr += PADDING4(len);
+		frm->len -= PADDING4(len);
+	}
+}
+
 void sap_dump(int level, struct frame *frm)
 {
 	uint8_t msg, params;
@@ -119,5 +331,5 @@ void sap_dump(int level, struct frame *frm)
 
 	printf("SAP: %s: params %d\n", msg2str(msg), params);
 
-	raw_dump(level, frm);
+	parse_parameters(level, frm);
 }
-- 
1.7.9.4

