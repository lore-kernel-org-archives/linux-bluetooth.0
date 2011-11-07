Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <henrik.possung@stericsson.com>, <ulrik.lauren@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/4] SAP: Add support for handle ongoing call
Date: Mon, 7 Nov 2011 15:56:43 +0100
Message-ID: <1320677803-32223-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch support for handling connect request
during ongoing call is added.

Change-Id: I7bd25273a33e5a14cc3698cfc560a5df47cd8f5a
---
 sap/sap-u8500.c |   53 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/sap/sap-u8500.c b/sap/sap-u8500.c
index dadea29..f804ca8 100644
--- a/sap/sap-u8500.c
+++ b/sap/sap-u8500.c
@@ -78,7 +78,8 @@ enum ste_protocol {
 	STE_GET_ATR_RSP		= 0x2E07,
 	STE_GET_STATUS_REQ	= 0x2D08,
 	STE_GET_STATUS_RSP	= 0x2E08,
-	STE_STATUS_IND		= 0x2F02
+	STE_STATUS_IND		= 0x2F02,
+	STE_SIM_READY_IND	= 0x2F03,
 };
 
 enum ste_msg {
@@ -94,6 +95,7 @@ enum ste_msg {
 enum ste_status {
 	STE_STATUS_OK		= 0x00000000,
 	STE_STATUS_FAILURE	= 0x00000001,
+	STE_STATUS_BUSY_CALL	= 0x00000002,
 };
 
 enum ste_card_status {
@@ -118,6 +120,7 @@ enum ste_state {
 	STE_POWERED_OFF,	/* Card in the reader but powered off */
 	STE_NO_CARD,		/* No card in the reader */
 	STE_ENABLED,		/* Card in the reader and powered on */
+	STE_SIM_BUSY,		/* Modem is busy with ongoing call.*/
 	STE_STATE_MAX
 };
 
@@ -377,6 +380,42 @@ static void simd_close(void)
 	u8500.sap_data = NULL;
 }
 
+static void recv_sim_ready()
+{
+	sap_info("sim is ready. Try to connect again");
+
+	if (send_request(u8500.io, STE_START_SAP_REQ, NULL) < 0) {
+		sap_connect_rsp(u8500.sap_data, SAP_STATUS_CONNECTION_FAILED,
+								SAP_BUF_SIZE);
+		simd_close();
+	}
+}
+
+static void recv_connect_rsp(uint32_t status)
+{
+	switch (status) {
+	case STE_STATUS_OK:
+		if (u8500.state != STE_SIM_BUSY)
+			sap_connect_rsp(u8500.sap_data,
+					SAP_STATUS_OK, 0);
+		break;
+	case STE_STATUS_BUSY_CALL:
+		if (u8500.state != STE_SIM_BUSY) {
+			sap_connect_rsp(u8500.sap_data,
+				SAP_STATUS_OK_ONGOING_CALL,
+				SAP_BUF_SIZE);
+
+			u8500.state = STE_SIM_BUSY;
+		}
+		break;
+	default:
+		sap_connect_rsp(u8500.sap_data,
+				SAP_STATUS_CONNECTION_FAILED, 0);
+		simd_close();
+		break;
+	}
+}
+
 static void recv_response(struct ste_message *msg)
 {
 	uint32_t status;
@@ -398,15 +437,8 @@ static void recv_response(struct ste_message *msg)
 
 	switch (msg->id) {
 	case STE_START_SAP_RSP:
-		if (status == STE_STATUS_OK) {
-			sap_connect_rsp(u8500.sap_data, SAP_STATUS_OK, 0);
-		} else {
-			sap_connect_rsp(u8500.sap_data,
-					SAP_STATUS_CONNECTION_FAILED, 0);
-			simd_close();
-		}
+		recv_connect_rsp(status);
 		break;
-
 	case STE_SEND_APDU_RSP:
 		recv_pdu(STE_SEND_APDU_MSG, msg, status, param,
 							sap_transfer_apdu_rsp);
@@ -439,6 +471,9 @@ static void recv_response(struct ste_message *msg)
 	case STE_STATUS_IND:
 		recv_status(status);
 		break;
+	case STE_SIM_READY_IND:
+		recv_sim_ready();
+		break;
 
 	default:
 		sap_error("unsupported message received (id 0x%x)", msg->id);
-- 
on behalf of ST-Ericsson

