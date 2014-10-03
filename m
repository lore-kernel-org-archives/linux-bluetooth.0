Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/19] android/avrcp-lib: Add GetCurrentPlayerValue structs
Date: Fri,  3 Oct 2014 15:32:44 +0300
Message-Id: <1412339579-8292-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 55 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 29b2935..15d3d75 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -107,6 +107,21 @@ struct list_values_rsp {
 	uint8_t params[0];
 } __attribute__ ((packed));
 
+struct get_value_req {
+	uint8_t number;
+	uint8_t attrs[0];
+} __attribute__ ((packed));
+
+struct attr_value {
+	uint8_t attr;
+	uint8_t value;
+} __attribute__ ((packed));
+
+struct value_rsp {
+	uint8_t number;
+	struct attr_value values[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -652,17 +667,22 @@ static ssize_t get_value(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct get_value_req *req;
 
 	DBG("");
 
-	if (!params || params_len < 1 + params[0])
+	if (!player->ind || !player->ind->get_value)
+		return -ENOSYS;
+
+	if (!params || params_len < sizeof(*req))
 		return -EINVAL;
 
-	if (!check_attributes(params[0], &params[1]))
+	req = (void *) params;
+	if (params_len < sizeof(*req) + req->number)
 		return -EINVAL;
 
-	if (!player->ind || !player->ind->get_value)
-		return -ENOSYS;
+	if (!check_attributes(req->number, req->attrs))
+		return -EINVAL;
 
 	return player->ind->get_value(session, transaction, params[0],
 					&params[1], player->user_data);
@@ -1867,27 +1887,30 @@ static int parse_value(struct avrcp_header *pdu, uint8_t *number,
 					uint8_t *attrs, uint8_t *values)
 {
 	int i;
+	struct value_rsp *rsp;
 
-	if (pdu->params_len < 1)
+	if (pdu->params_len < sizeof(*rsp))
 		return -EPROTO;
 
-	*number = pdu->params[0];
+	rsp = (void *) pdu->params;
 
 	/*
 	 * Check if PDU is big enough to hold the number of (attribute, value)
 	 * tuples.
 	 */
-	if (*number > AVRCP_ATTRIBUTE_LAST ||
-					1 + *number * 2 != pdu->params_len) {
+	if (rsp->number > AVRCP_ATTRIBUTE_LAST ||
+			sizeof(*rsp) + rsp->number * 2 != pdu->params_len) {
 		*number = 0;
 		return -EPROTO;
 	}
 
-	for (i = 0; i < *number; i++) {
-		attrs[i] = pdu->params[i * 2 + 1];
-		values[i] = pdu->params[i * 2 + 2];
+	for (i = 0; i < rsp->number; i++) {
+		attrs[i] = rsp->values[i].attr;
+		values[i] = rsp->values[i].value;
 	}
 
+	*number = rsp->number;
+
 	return 0;
 }
 
@@ -1898,7 +1921,7 @@ static gboolean get_value_rsp(struct avctp *conn,
 {
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
-	struct avrcp_header *pdu = (void *) operands;
+	struct avrcp_header *pdu;
 	uint8_t number = 0;
 	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
 	uint8_t values[AVRCP_ATTRIBUTE_LAST];
@@ -2897,7 +2920,7 @@ int avrcp_get_current_player_value_rsp(struct avrcp *session,
 					uint8_t *attrs, uint8_t *values)
 {
 	struct iovec iov[1 + AVRCP_ATTRIBUTE_LAST];
-	uint8_t val[AVRCP_ATTRIBUTE_LAST][2];
+	struct attr_value val[AVRCP_ATTRIBUTE_LAST];
 	int i;
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
@@ -2907,10 +2930,10 @@ int avrcp_get_current_player_value_rsp(struct avrcp *session,
 	iov[0].iov_len = sizeof(number);
 
 	for (i = 0; i < number; i++) {
-		val[i][0] = attrs[i];
-		val[i][1] = values[i];
+		val[i].attr = attrs[i];
+		val[i].value = values[i];
 
-		iov[i + 1].iov_base = val[i];
+		iov[i + 1].iov_base = &val[i];
 		iov[i + 1].iov_len = sizeof(val[i]);
 	}
 
-- 
1.9.3

