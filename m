Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/19] android/avrcp-lib: Add GetFolderItems structs
Date: Fri,  3 Oct 2014 15:32:54 +0300
Message-Id: <1412339579-8292-15-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 79 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 57c491a..cf6637f 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -217,6 +217,21 @@ struct set_browsed_rsp {
 	uint8_t depth;
 } __attribute__ ((packed));
 
+struct get_folder_items_req {
+	uint8_t scope;
+	uint32_t start;
+	uint32_t end;
+	uint8_t number;
+	uint32_t attrs[0];
+} __attribute__ ((packed));
+
+struct get_folder_items_rsp {
+	uint8_t status;
+	uint16_t counter;
+	uint16_t number;
+	uint8_t data[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -1172,7 +1187,7 @@ static ssize_t get_folder_items(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
-	uint8_t scope;
+	struct get_folder_items_req *req;
 	uint32_t start, end;
 	uint16_t number;
 	uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
@@ -1183,32 +1198,33 @@ static ssize_t get_folder_items(struct avrcp *session, uint8_t transaction,
 	if (!player->ind || !player->ind->get_folder_items)
 		return -ENOSYS;
 
-	if (!params || params_len < 10)
+	if (!params || params_len < sizeof(*req))
 		return -EINVAL;
 
-	scope = params[0];
-	if (scope > AVRCP_MEDIA_NOW_PLAYING)
+	req = (void *) params;
+
+	if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
 		return -EBADRQC;
 
-	start = get_be32(&params[1]);
-	end = get_be32(&params[5]);
+	start = get_be32(&req->start);
+	end = get_be32(&req->end);
 
 	if (start > end)
 		return -ERANGE;
 
-	number = get_be16(&params[9]);
+	number = get_be16(&req->number);
 
 	for (i = 0; i < number; i++) {
-		attrs[i] = get_be32(&params[11 + i * 4]);
+		attrs[i] = get_be32(&req->attrs[i]);
 
 		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
 				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
 			return -EINVAL;
 	}
 
-	return player->ind->get_folder_items(session, transaction, scope, start,
-							end, number, attrs,
-							player->user_data);
+	return player->ind->get_folder_items(session, transaction, req->scope,
+						start, end, number, attrs,
+						player->user_data);
 }
 
 static ssize_t change_path(struct avrcp *session, uint8_t transaction,
@@ -2537,7 +2553,9 @@ static gboolean get_folder_items_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_browsing_header *pdu;
+	struct get_folder_items_rsp *rsp;
 	uint16_t counter = 0, number = 0;
+	uint8_t *params = NULL;
 	int err;
 
 	DBG("");
@@ -2555,19 +2573,22 @@ static gboolean get_folder_items_rsp(struct avctp *conn,
 	if (err < 0)
 		goto done;
 
-	if (pdu->params_len < 5) {
+	if (pdu->params_len < sizeof(*rsp)) {
 		err = -EPROTO;
 		goto done;
 	}
 
-	counter = get_be16(&pdu->params[1]);
-	number = get_be16(&pdu->params[3]);
+	rsp = (void *) pdu->params;
+
+	counter = get_be16(&rsp->counter);
+	number = get_be16(&rsp->number);
+	params = rsp->data;
 
 	/* FIXME: Add proper parsing for each item type */
 
 done:
-	player->cfm->get_folder_items(session, err, counter, number,
-					&pdu->params[5], player->user_data);
+	player->cfm->get_folder_items(session, err, counter, number, params,
+							player->user_data);
 
 	return FALSE;
 }
@@ -2578,16 +2599,16 @@ int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
 {
 
 	struct iovec iov[2];
-	uint8_t pdu[10];
+	struct get_folder_items_req req;
 	int i;
 
-	pdu[0] = scope;
-	put_be32(start, &pdu[1]);
-	put_be32(end, &pdu[5]);
-	pdu[9] = number;
+	req.scope = scope;
+	put_be32(start, &req.start);
+	put_be32(end, &req.end);
+	req.number = number;
 
-	iov[0].iov_base = pdu;
-	iov[0].iov_len = sizeof(pdu);
+	iov[0].iov_base = &req;
+	iov[0].iov_len = sizeof(req);
 
 	if (!number)
 		return avrcp_send_browsing_req(session, AVRCP_GET_FOLDER_ITEMS,
@@ -3191,16 +3212,16 @@ int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t **params)
 {
 	struct iovec iov[UINT8_MAX * 2 + 1];
-	uint8_t pdu[5];
+	struct get_folder_items_rsp rsp;
 	uint8_t item[UINT8_MAX][3];
 	int i;
 
-	pdu[0] = AVRCP_STATUS_SUCCESS;
-	put_be16(counter, &pdu[1]);
-	put_be16(number, &pdu[3]);
+	rsp.status = AVRCP_STATUS_SUCCESS;
+	put_be16(counter, &rsp.counter);
+	put_be16(number, &rsp.number);
 
-	iov[0].iov_base = pdu;
-	iov[0].iov_len = sizeof(pdu);
+	iov[0].iov_base = &rsp;
+	iov[0].iov_len = sizeof(rsp);
 
 	for (i = 0; i < number; i++) {
 		item[i][0] = type[i];
-- 
1.9.3

