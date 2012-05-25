Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/10] SAP: Fix some code style issue
Date: Fri, 25 May 2012 16:20:54 +0200
Message-ID: <1337955662-19016-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
References: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/sap-dummy.c |   14 +++++++-------
 sap/server.c    |   13 ++++++-------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index e2032cf..679adbb 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -39,16 +39,16 @@
 #define SAP_DUMMY_PATH "/org/bluez/test"
 
 enum {
-	SIM_DISCONNECTED= 0x00,
-	SIM_CONNECTED	= 0x01,
-	SIM_POWERED_OFF	= 0x02,
-	SIM_MISSING	= 0x03
+	SIM_DISCONNECTED = 0x00,
+	SIM_CONNECTED	 = 0x01,
+	SIM_POWERED_OFF	 = 0x02,
+	SIM_MISSING	 = 0x03
 };
 
 static DBusConnection *connection = NULL;
 
 static int sim_card_conn_status = SIM_DISCONNECTED;
-static void *sap_data = NULL;  /* SAP server private data.*/
+static void *sap_data = NULL; /* SAP server private data. */
 static gboolean ongoing_call_status = FALSE;
 static int max_msg_size_supported = 512;
 
@@ -113,7 +113,7 @@ void sap_transfer_apdu_req(void *sap_device, struct sap_parameter *param)
 			SAP_RESULT_ERROR_NOT_ACCESSIBLE, NULL, 0);
 	else
 		sap_transfer_apdu_rsp(sap_device, SAP_RESULT_OK,
-						(uint8_t*)&apdu, sizeof(apdu));
+						(uint8_t *)&apdu, sizeof(apdu));
 }
 
 void sap_transfer_atr_req(void *sap_device)
@@ -133,7 +133,7 @@ void sap_transfer_atr_req(void *sap_device)
 								NULL, 0);
 	else
 		sap_transfer_atr_rsp(sap_device, SAP_RESULT_OK,
-						(uint8_t*)&atr, sizeof(atr));
+						(uint8_t *)&atr, sizeof(atr));
 }
 
 void sap_power_sim_off_req(void *sap_device)
diff --git a/sap/server.c b/sap/server.c
index 776bf36..85c4b82 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -147,7 +147,7 @@ static int check_msg(struct sap_message *msg)
 			return -EBADMSG;
 
 		if (msg->param->id != SAP_PARAM_ID_COMMAND_APDU)
-			if ( msg->param->id != SAP_PARAM_ID_COMMAND_APDU7816)
+			if (msg->param->id != SAP_PARAM_ID_COMMAND_APDU7816)
 				return -EBADMSG;
 
 		if (msg->param->len == 0x00)
@@ -230,8 +230,7 @@ static sdp_record_t *create_sap_record(uint8_t channel)
 	aproto = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
 
-	sdp_set_info_attr(record, "SIM Access Server",
-			NULL, NULL);
+	sdp_set_info_attr(record, "SIM Access Server", NULL, NULL);
 
 	sdp_data_free(ch);
 	sdp_list_free(proto[0], NULL);
@@ -863,7 +862,7 @@ int sap_reset_sim_rsp(void *sap_device, uint8_t result)
 		return -EINVAL;
 
 	DBG("state %d pr 0x%02x result 0x%02x", conn->state,
-					conn->processing_req, result);
+						conn->processing_req, result);
 
 	if (conn->processing_req != SAP_RESET_SIM_REQ)
 		return 0;
@@ -891,7 +890,7 @@ int sap_transfer_card_reader_status_rsp(void *sap_device, uint8_t result,
 		return -EINVAL;
 
 	DBG("state %d pr 0x%02x result 0x%02x", conn->state,
-					conn->processing_req, result);
+						conn->processing_req, result);
 
 	if (conn->processing_req != SAP_TRANSFER_CARD_READER_STATUS_REQ)
 		return 0;
@@ -927,7 +926,7 @@ int sap_transport_protocol_rsp(void *sap_device, uint8_t result)
 		return -EINVAL;
 
 	DBG("state %d pr 0x%02x result 0x%02x", conn->state,
-					conn->processing_req, result);
+						conn->processing_req, result);
 
 	if (conn->processing_req != SAP_SET_TRANSPORT_PROTOCOL_REQ)
 		return 0;
@@ -968,7 +967,7 @@ int sap_status_ind(void *sap_device, uint8_t status_change)
 		return -EINVAL;
 
 	DBG("state %d pr 0x%02x sc 0x%02x", conn->state, conn->processing_req,
-				status_change);
+								status_change);
 
 	/* Might be need to change state to connected after ongoing call.*/
 	if (conn->state == SAP_STATE_CONNECT_MODEM_BUSY &&
-- 
on behalf of ST-Ericsson

