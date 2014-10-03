Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/19] android/avrcp-lib: Add GetCapabilities structs
Date: Fri,  3 Oct 2014 15:32:41 +0300
Message-Id: <1412339579-8292-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 54 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 3d318e7..d93addd 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -82,6 +82,17 @@ struct avrcp_browsing_header {
 } __attribute__ ((packed));
 #define AVRCP_BROWSING_HEADER_LENGTH 3
 
+struct get_capabilities_req {
+	uint8_t cap;
+	uint8_t params[0];
+} __attribute__ ((packed));
+
+struct get_capabilities_rsp {
+	uint8_t cap;
+	uint8_t number;
+	uint8_t params[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -468,14 +479,17 @@ static ssize_t get_capabilities(struct avrcp *session, uint8_t transaction,
 				void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct get_capabilities_req *req;
 
-	if (!params || params_len != 1)
+	if (!params || params_len != sizeof(*req))
 		return -EINVAL;
 
-	switch (params[0]) {
+	req = (void *) params;
+
+	switch (req->cap) {
 	case CAP_COMPANY_ID:
-		params[1] = 1;
-		hton24(&params[2], IEEEID_BTSIG);
+		req->params[0] = 1;
+		hton24(&req->params[1], IEEEID_BTSIG);
 		return 5;
 	case CAP_EVENTS_SUPPORTED:
 		if (!player->ind || !player->ind->get_capabilities)
@@ -1372,6 +1386,7 @@ static gboolean get_capabilities_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu;
+	struct get_capabilities_rsp *rsp;
 	uint8_t number = 0;
 	uint8_t *params = NULL;
 	int err;
@@ -1392,12 +1407,14 @@ static gboolean get_capabilities_rsp(struct avctp *conn,
 		goto done;
 	}
 
-	if (pdu->params_len < 2) {
+	if (pdu->params_len < sizeof(*rsp)) {
 		err = -EPROTO;
 		goto done;
 	}
 
-	switch (pdu->params[0]) {
+	rsp = (void *) pdu->params;
+
+	switch (rsp->cap) {
 	case CAP_COMPANY_ID:
 	case CAP_EVENTS_SUPPORTED:
 		break;
@@ -1406,10 +1423,10 @@ static gboolean get_capabilities_rsp(struct avctp *conn,
 		goto done;
 	}
 
-	number = pdu->params[1];
-
-	if (number > 0)
-		params = &pdu->params[2];
+	if (rsp->number > 0) {
+		number = rsp->number;
+		params = rsp->params;
+	}
 
 	err = 0;
 
@@ -1424,9 +1441,12 @@ done:
 int avrcp_get_capabilities(struct avrcp *session, uint8_t param)
 {
 	struct iovec iov;
+	struct get_capabilities_req req;
+
+	req.cap = param;
 
-	iov.iov_base = &param;
-	iov.iov_len = sizeof(param);
+	iov.iov_base = &req;
+	iov.iov_len = sizeof(req);
 
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
 					AVRCP_GET_CAPABILITIES, &iov, 1,
@@ -2678,17 +2698,17 @@ int avrcp_add_to_now_playing(struct avrcp *session, uint8_t scope, uint64_t uid,
 int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
 						uint8_t number, uint8_t *events)
 {
-	uint8_t pdu[2];
 	struct iovec iov[2];
+	struct get_capabilities_rsp rsp;
 
 	if (number > AVRCP_EVENT_LAST)
 		return -EINVAL;
 
-	pdu[0] = CAP_EVENTS_SUPPORTED;
-	pdu[1] = number;
+	rsp.cap = CAP_EVENTS_SUPPORTED;
+	rsp.number = number;
 
-	iov[0].iov_base = pdu;
-	iov[0].iov_len = sizeof(pdu);
+	iov[0].iov_base = &rsp;
+	iov[0].iov_len = sizeof(rsp);
 
 	iov[1].iov_base = events;
 	iov[1].iov_len = number;
-- 
1.9.3

