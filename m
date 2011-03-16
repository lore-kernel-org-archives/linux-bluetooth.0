Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v5 2/4] Add support for SAP protocol
Date: Wed, 16 Mar 2011 13:10:19 +0100
Message-ID: <1300277421-8053-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add new protocol features:
	* transfer APDu request/response
	* get ATR request/response
	* power sim of/on request/response
	* card reader status
	* set transport protocol
---
 sap/server.c |  415 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 399 insertions(+), 16 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 8337fe1..35abffb 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -89,6 +89,44 @@ static void start_guard_timer(struct sap_connection *conn, guint interval);
 static void stop_guard_timer(struct sap_connection *conn);
 static gboolean guard_timeout(gpointer data);
 
+static size_t add_result_parameter(uint8_t result,
+					struct sap_parameter *param)
+{
+	param->id = SAP_PARAM_ID_RESULT_CODE;
+	param->len = htons(SAP_PARAM_ID_RESULT_CODE_LEN);
+	*param->val = result;
+
+	return PARAMETER_SIZE(SAP_PARAM_ID_RESULT_CODE_LEN);
+}
+
+static int is_power_sim_off_req_allowed(uint8_t processing_req)
+{
+	switch (processing_req) {
+	case SAP_NO_REQ:
+	case SAP_TRANSFER_APDU_REQ:
+	case SAP_TRANSFER_ATR_REQ:
+	case SAP_POWER_SIM_ON_REQ:
+	case SAP_RESET_SIM_REQ:
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int is_reset_sim_req_allowed(uint8_t processing_req)
+{
+	switch (processing_req) {
+	case SAP_NO_REQ:
+	case SAP_TRANSFER_APDU_REQ:
+	case SAP_TRANSFER_ATR_REQ:
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static int check_msg(struct sap_message *msg)
 {
 	if (!msg)
@@ -375,38 +413,159 @@ error_req:
 static void transfer_apdu_req(struct sap_connection *conn,
 					struct sap_parameter *param)
 {
-	DBG("SAP_APDU_REQUEST");
+	DBG("conn %p state %d", conn, conn->state);
+
+	if (!param)
+		goto error_rsp;
+
+	param->len = ntohs(param->len);
+
+	if (conn->state != SAP_STATE_CONNECTED &&
+			conn->state != SAP_STATE_GRACEFUL_DISCONNECT)
+		goto error_rsp;
+
+	if (conn->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	conn->processing_req = SAP_TRANSFER_APDU_REQ;
+	sap_transfer_apdu_req(conn, param);
+
+	return;
+
+error_rsp:
+	error("Processing error (param %p state %d pr 0x%02x)", param,
+					conn->state, conn->processing_req);
+	sap_error_rsp(conn);
 }
 
 static void transfer_atr_req(struct sap_connection *conn)
 {
-	DBG("SAP_ATR_REQUEST");
+	DBG("conn %p state %d", conn, conn->state);
+
+	if (conn->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (conn->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	conn->processing_req = SAP_TRANSFER_ATR_REQ;
+	sap_transfer_atr_req(conn);
+
+	return;
+
+error_rsp:
+	error("Processing error (state %d pr 0x%02x)", conn->state,
+						conn->processing_req);
+	sap_error_rsp(conn);
 }
 
 static void power_sim_off_req(struct sap_connection *conn)
 {
-	DBG("SAP_SIM_OFF_REQUEST");
+	DBG("conn %p state %d", conn, conn->state);
+
+	if (conn->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (!is_power_sim_off_req_allowed(conn->processing_req))
+		goto error_rsp;
+
+	conn->processing_req = SAP_POWER_SIM_OFF_REQ;
+	sap_power_sim_off_req(conn);
+
+	return;
+
+error_rsp:
+	error("Processing error (state %d pr 0x%02x)", conn->state,
+						conn->processing_req);
+	sap_error_rsp(conn);
 }
 
 static void power_sim_on_req(struct sap_connection *conn)
 {
-	DBG("SAP_SIM_ON_REQUEST");
+	DBG("conn %p state %d", conn, conn->state);
+
+	if (conn->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (conn->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	conn->processing_req = SAP_POWER_SIM_ON_REQ;
+	sap_power_sim_on_req(conn);
+
+	return;
+
+error_rsp:
+	error("Processing error (state %d pr 0x%02x)", conn->state,
+						conn->processing_req);
+	sap_error_rsp(conn);
 }
 
 static void reset_sim_req(struct sap_connection *conn)
 {
-	DBG("SAP_RESET_SIM_REQUEST");
+	DBG("conn %p state %d", conn, conn->state);
+
+	if (conn->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (!is_reset_sim_req_allowed(conn->processing_req))
+		goto error_rsp;
+
+	conn->processing_req = SAP_RESET_SIM_REQ;
+	sap_reset_sim_req(conn);
+
+	return;
+
+error_rsp:
+	error("Processing error (state %d pr 0x%02x param)", conn->state,
+						conn->processing_req);
+	sap_error_rsp(conn);
 }
 
 static void transfer_card_reader_status_req(struct sap_connection *conn)
 {
-	DBG("SAP_TRANSFER_CARD_READER_STATUS_REQUEST");
+	DBG("conn %p state %d", conn, conn->state);
+
+	if (conn->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (conn->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	conn->processing_req = SAP_TRANSFER_CARD_READER_STATUS_REQ;
+	sap_transfer_card_reader_status_req(conn);
+
+	return;
+
+error_rsp:
+	error("Processing error (state %d pr 0x%02x)", conn->state,
+						conn->processing_req);
+	sap_error_rsp(conn);
 }
 
 static void set_transport_protocol_req(struct sap_connection *conn,
 					struct sap_parameter *param)
 {
-	DBG("SAP_SET_TRANSPORT_PROTOCOL_REQUEST");
+	if (!param)
+		goto error_rsp;
+
+	DBG("conn %p state %d param %p", conn, conn->state, param);
+
+	if (conn->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (conn->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	conn->processing_req = SAP_SET_TRANSPORT_PROTOCOL_REQ;
+	sap_set_transport_protocol_req(conn, param);
+
+	return;
+
+error_rsp:
+	error("Processing error (param %p state %d pr 0x%02x)", param,
+					conn->state, conn->processing_req);
+	sap_error_rsp(conn);
 }
 
 static void start_guard_timer(struct sap_connection *conn, guint interval)
@@ -572,49 +731,273 @@ int sap_disconnect_rsp(void *sap_device)
 int sap_transfer_apdu_rsp(void *sap_device, uint8_t result, uint8_t *apdu,
 					uint16_t length)
 {
-	return 0;
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	struct sap_parameter *param = (struct sap_parameter *) msg->param;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("state %d pr 0x%02x", conn->state, conn->processing_req);
+
+	if (conn->processing_req != SAP_TRANSFER_APDU_REQ)
+		return 0;
+
+	if (result == SAP_RESULT_OK && (!apdu || (apdu && length == 0x00)))
+		return -EINVAL;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_TRANSFER_APDU_RESP;
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, param);
+
+	/* Add APDU response. */
+	if (result == SAP_RESULT_OK) {
+		msg->nparam++;
+		param = (struct sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_RESPONSE_APDU;
+		param->len = htons(length);
+
+		size += PARAMETER_SIZE(length);
+
+		if (size > SAP_BUF_SIZE)
+			return -EOVERFLOW;
+
+		memcpy(param->val, apdu, length);
+	}
+
+	conn->processing_req = SAP_NO_REQ;
+
+	return send_message(sap_device, buf, size);
 }
 
 int sap_transfer_atr_rsp(void *sap_device, uint8_t result, uint8_t *atr,
 					uint16_t length)
 {
-	return 0;
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	struct sap_parameter *param = (struct sap_parameter *) msg->param;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("result 0x%02x state %d pr 0x%02x len %d", result, conn->state,
+			conn->processing_req, length);
+
+	if (conn->processing_req != SAP_TRANSFER_ATR_REQ)
+		return 0;
+
+	if (result == SAP_RESULT_OK && (!atr || (atr && length == 0x00)))
+		return -EINVAL;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_TRANSFER_ATR_RESP;
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, param);
+
+	/* Add ATR response */
+	if (result == SAP_RESULT_OK) {
+		msg->nparam++;
+		param = (struct sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_ATR;
+		param->len = htons(length);
+		size += PARAMETER_SIZE(length);
+
+		if (size > SAP_BUF_SIZE)
+			return -EOVERFLOW;
+
+		memcpy(param->val, atr, length);
+	}
+
+	conn->processing_req = SAP_NO_REQ;
+
+	return send_message(sap_device, buf, size);
 }
 
 int sap_power_sim_off_rsp(void *sap_device, uint8_t result)
 {
-	return 0;
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("state %d pr 0x%02x", conn->state, conn->processing_req);
+
+	if (conn->processing_req != SAP_POWER_SIM_OFF_REQ)
+		return 0;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_POWER_SIM_OFF_RESP;
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	conn->processing_req = SAP_NO_REQ;
+
+	return send_message(sap_device, buf, size);
 }
 
 int sap_power_sim_on_rsp(void *sap_device, uint8_t result)
 {
-	return 0;
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("state %d pr 0x%02x", conn->state, conn->processing_req);
+
+	if (conn->processing_req != SAP_POWER_SIM_ON_REQ)
+		return 0;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_POWER_SIM_ON_RESP;
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	conn->processing_req = SAP_NO_REQ;
+
+	return send_message(sap_device, buf, size);
 }
 
 int sap_reset_sim_rsp(void *sap_device, uint8_t result)
 {
-	return 0;
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("state %d pr 0x%02x result 0x%02x", conn->state,
+					conn->processing_req, result);
+
+	if (conn->processing_req != SAP_RESET_SIM_REQ)
+		return 0;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_RESET_SIM_RESP;
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	conn->processing_req = SAP_NO_REQ;
+
+	return send_message(sap_device, buf, size);
 }
 
 int sap_transfer_card_reader_status_rsp(void *sap_device, uint8_t result,
 						uint8_t status)
 {
-	return 0;
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	struct sap_parameter *param = (struct sap_parameter *) msg->param;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("state %d pr 0x%02x result 0x%02x", conn->state,
+					conn->processing_req, result);
+
+	if (conn->processing_req != SAP_TRANSFER_CARD_READER_STATUS_REQ)
+		return 0;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_TRANSFER_CARD_READER_STATUS_RESP;
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, param);
+
+	/* Add card reader status. */
+	if (result == SAP_RESULT_OK) {
+		msg->nparam++;
+		param = (struct sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_CARD_READER_STATUS;
+		param->len = htons(SAP_PARAM_ID_CARD_READER_STATUS_LEN);
+		*param->val = status;
+		size += PARAMETER_SIZE(SAP_PARAM_ID_CARD_READER_STATUS_LEN);
+	}
+
+	conn->processing_req = SAP_NO_REQ;
+
+	return send_message(sap_device, buf, size);
 }
 
 int sap_transport_protocol_rsp(void *sap_device, uint8_t result)
 {
-	return 0;
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("state %d pr 0x%02x result 0x%02x", conn->state,
+					conn->processing_req, result);
+
+	if (conn->processing_req != SAP_SET_TRANSPORT_PROTOCOL_REQ)
+		return 0;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_SET_TRANSPORT_PROTOCOL_RESP;
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	conn->processing_req = SAP_NO_REQ;
+
+	return send_message(sap_device, buf, size);
 }
 
 int sap_error_rsp(void *sap_device)
 {
-	return 0;
+	struct sap_message msg;
+	struct sap_connection *conn = sap_device;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.id = SAP_ERROR_RESP;
+
+	return send_message(conn, &msg, sizeof(msg));
 }
 
 int sap_status_ind(void *sap_device, uint8_t status_change)
 {
-	return 0;
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	struct sap_parameter *param = (struct sap_parameter *) msg->param;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("state %d pr 0x%02x sc 0x%02x", conn->state, conn->processing_req,
+				status_change);
+
+	if (conn->state != SAP_STATE_CONNECTED &&
+			conn->state != SAP_STATE_GRACEFUL_DISCONNECT)
+		return 0;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_STATUS_IND;
+	msg->nparam = 0x01;
+
+	/* Add status change. */
+	param->id  = SAP_PARAM_ID_STATUS_CHANGE;
+	param->len = htons(SAP_PARAM_ID_STATUS_CHANGE_LEN);
+	*param->val = status_change;
+	size += PARAMETER_SIZE(SAP_PARAM_ID_STATUS_CHANGE_LEN);
+
+	return send_message(sap_device, buf, size);
 }
 
 static int handle_cmd(void *data, void *buf, size_t size)
-- 
1.7.1

