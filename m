Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/17] SAP: Don't append MaxMsgSize parameter to CONNECT_RESP unconditionaly
Date: Wed, 6 Jun 2012 15:19:14 +0200
Message-ID: <1338988767-19467-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to SAP 1.1 specification MaxMsgSize parameter of CONNECT_RESP
is conditional and should not be added for every status code. Add this
parameter only if status code is  "Error, Server does not support
message size" (see section 4.1.1 of SAP specification).

To avoid confusion maxmsgsize param is removed from sap_connect_rsp and
it is assumed that SAP driver is able to handle messages with size up
to SAP_BUF_SIZE bytes.
---
 sap/sap-dummy.c |   14 +++++---------
 sap/sap-u8500.c |   17 ++++++-----------
 sap/sap.h       |    2 +-
 sap/server.c    |   32 +++++++++++++++++---------------
 4 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index b840946..2ad8af4 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -54,34 +54,30 @@ void sap_connect_req(void *sap_device, uint16_t maxmsgsize)
 	DBG("status: %d", sim_card_conn_status);
 
 	if (sim_card_conn_status != SIM_DISCONNECTED) {
-		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED,
-								maxmsgsize);
+		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED);
 		return;
 	}
 
 	if (max_msg_size_supported > maxmsgsize) {
-		sap_connect_rsp(sap_device, SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL,
-						max_msg_size_supported);
+		sap_connect_rsp(sap_device, SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL);
 		return;
 	}
 
 	if (max_msg_size_supported < maxmsgsize) {
 		sap_connect_rsp(sap_device,
-				SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED,
-				max_msg_size_supported);
+					SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED);
 		return;
 	}
 
 	if (ongoing_call_status) {
-		sap_connect_rsp(sap_device, SAP_STATUS_OK_ONGOING_CALL,
-						max_msg_size_supported);
+		sap_connect_rsp(sap_device, SAP_STATUS_OK_ONGOING_CALL);
 		return;
 	}
 
 	sim_card_conn_status = SIM_CONNECTED;
 	sap_data = sap_device;
 
-	sap_connect_rsp(sap_device, SAP_STATUS_OK, maxmsgsize);
+	sap_connect_rsp(sap_device, SAP_STATUS_OK);
 	sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
 }
 
diff --git a/sap/sap-u8500.c b/sap/sap-u8500.c
index 2920cc7..531dce4 100644
--- a/sap/sap-u8500.c
+++ b/sap/sap-u8500.c
@@ -385,8 +385,7 @@ static void recv_sim_ready(void)
 	sap_info("sim is ready. Try to connect again");
 
 	if (send_request(u8500.io, STE_START_SAP_REQ, NULL) < 0) {
-		sap_connect_rsp(u8500.sap_data, SAP_STATUS_CONNECTION_FAILED,
-								SAP_BUF_SIZE);
+		sap_connect_rsp(u8500.sap_data, SAP_STATUS_CONNECTION_FAILED);
 		simd_close();
 	}
 }
@@ -396,21 +395,18 @@ static void recv_connect_rsp(uint32_t status)
 	switch (status) {
 	case STE_STATUS_OK:
 		if (u8500.state != STE_SIM_BUSY)
-			sap_connect_rsp(u8500.sap_data,
-					SAP_STATUS_OK, 0);
+			sap_connect_rsp(u8500.sap_data, SAP_STATUS_OK);
 		break;
 	case STE_STATUS_BUSY_CALL:
 		if (u8500.state != STE_SIM_BUSY) {
 			sap_connect_rsp(u8500.sap_data,
-				SAP_STATUS_OK_ONGOING_CALL,
-				SAP_BUF_SIZE);
+						SAP_STATUS_OK_ONGOING_CALL);
 
 			u8500.state = STE_SIM_BUSY;
 		}
 		break;
 	default:
-		sap_connect_rsp(u8500.sap_data,
-				SAP_STATUS_CONNECTION_FAILED, 0);
+		sap_connect_rsp(u8500.sap_data, SAP_STATUS_CONNECTION_FAILED);
 		simd_close();
 		break;
 	}
@@ -608,13 +604,12 @@ void sap_connect_req(void *sap_device, uint16_t maxmsgsize)
 	sap_info("connect request");
 
 	if (simd_connect(sap_device) < 0) {
-		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED, 0);
+		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED);
 		return;
 	}
 
 	if (send_request(u8500.io, STE_START_SAP_REQ, NULL) < 0) {
-		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED,
-								SAP_BUF_SIZE);
+		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED);
 		simd_close();
 	}
 }
diff --git a/sap/sap.h b/sap/sap.h
index 30301bd..a4d084e 100644
--- a/sap/sap.h
+++ b/sap/sap.h
@@ -156,7 +156,7 @@ void sap_set_transport_protocol_req(void *sap_device,
 					struct sap_parameter *param);
 
 /*SAP responses to SAP requests. Implemented by server.c */
-int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize);
+int sap_connect_rsp(void *sap_device, uint8_t status);
 int sap_disconnect_rsp(void *sap_device);
 int sap_transfer_apdu_rsp(void *sap_device, uint8_t result,
 				uint8_t *sap_apdu_resp, uint16_t length);
diff --git a/sap/server.c b/sap/server.c
index b37a8e2..ec97b39 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -316,8 +316,7 @@ static void connect_req(struct sap_connection *conn,
 		conn->processing_req = SAP_CONNECT_REQ;
 		sap_connect_req(conn, maxmsgsize);
 	} else {
-		sap_connect_rsp(conn, SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED,
-								SAP_BUF_SIZE);
+		sap_connect_rsp(conn, SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED);
 	}
 
 	return;
@@ -599,13 +598,14 @@ static void sap_set_connected(struct sap_connection *conn)
 	conn->state = SAP_STATE_CONNECTED;
 }
 
-int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize)
+int sap_connect_rsp(void *sap_device, uint8_t status)
 {
 	struct sap_connection *conn = sap_device;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	struct sap_parameter *param = (struct sap_parameter *) msg->param;
 	size_t size = sizeof(struct sap_message);
+	uint16_t *maxmsgsize;
 
 	if (!conn)
 		return -EINVAL;
@@ -626,30 +626,32 @@ int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize)
 	*param->val = status;
 	size += PARAMETER_SIZE(SAP_PARAM_ID_CONN_STATUS_LEN);
 
-	/* Add MaxMsgSize */
-	if (maxmsgsize) {
-		uint16_t *len;
 
+	switch (status) {
+	case SAP_STATUS_OK:
+		sap_set_connected(conn);
+		break;
+	case SAP_STATUS_OK_ONGOING_CALL:
+		DBG("ongoing call. Wait for reset indication!");
+		conn->state = SAP_STATE_CONNECT_MODEM_BUSY;
+		break;
+	case SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED: /* Add MaxMsgSize */
 		msg->nparam++;
 		param = (struct sap_parameter *) &buf[size];
 		param->id = SAP_PARAM_ID_MAX_MSG_SIZE;
 		param->len = htons(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
-		len = (uint16_t *) &param->val;
-		*len = htons(maxmsgsize);
+		maxmsgsize = (uint16_t *) &param->val;
+		*maxmsgsize = htons(SAP_BUF_SIZE);
 		size += PARAMETER_SIZE(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
-	}
 
-	if (status == SAP_STATUS_OK) {
-		sap_set_connected(conn);
-	} else if (status == SAP_STATUS_OK_ONGOING_CALL) {
-		DBG("ongoing call. Wait for reset indication!");
-		conn->state = SAP_STATE_CONNECT_MODEM_BUSY;
-	} else {
+		/* fall */
+	default:
 		conn->state = SAP_STATE_DISCONNECTED;
 
 		/* Timer will shutdown channel if client doesn't send
 		 * CONNECT_REQ or doesn't shutdown channel itself.*/
 		start_guard_timer(conn, SAP_TIMER_NO_ACTIVITY);
+		break;
 	}
 
 	conn->processing_req = SAP_NO_REQ;
-- 
on behalf of ST-Ericsson

