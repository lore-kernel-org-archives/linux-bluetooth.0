Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 15/19] android/avrcp-lib: Add ChangePath structs
Date: Fri,  3 Oct 2014 15:32:55 +0300
Message-Id: <1412339579-8292-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 53 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index cf6637f..179ca86 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -232,6 +232,17 @@ struct get_folder_items_rsp {
 	uint8_t data[0];
 } __attribute__ ((packed));
 
+struct change_path_req {
+	uint16_t counter;
+	uint8_t direction;
+	uint64_t uid;
+} __attribute__ ((packed));
+
+struct change_path_rsp {
+	uint8_t status;
+	uint32_t items;
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -1232,7 +1243,7 @@ static ssize_t change_path(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
-	uint8_t direction;
+	struct change_path_req *req;
 	uint16_t counter;
 	uint64_t uid;
 
@@ -1241,15 +1252,16 @@ static ssize_t change_path(struct avrcp *session, uint8_t transaction,
 	if (!player->ind || !player->ind->change_path)
 		return -ENOSYS;
 
-	if (!params || params_len < 11)
+	if (!params || params_len < sizeof(*req))
 		return -EINVAL;
 
-	counter = get_be16(&params[0]);
-	direction = params[2];
-	uid = get_be64(&params[3]);
+	req = (void *) params;
+
+	counter = get_be16(&req->counter);
+	uid = get_be64(&req->uid);
 
 	return player->ind->change_path(session, transaction, counter,
-					direction, uid, player->user_data);
+					req->direction, uid, player->user_data);
 }
 
 static ssize_t get_item_attributes(struct avrcp *session, uint8_t transaction,
@@ -2631,6 +2643,7 @@ static gboolean change_path_rsp(struct avctp *conn, uint8_t *operands,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_browsing_header *pdu;
+	struct change_path_rsp *rsp;
 	uint32_t items = 0;
 	int err;
 
@@ -2649,12 +2662,14 @@ static gboolean change_path_rsp(struct avctp *conn, uint8_t *operands,
 	if (err < 0)
 		goto done;
 
-	if (pdu->params_len < 5) {
+	if (pdu->params_len < sizeof(*rsp)) {
 		err = -EPROTO;
 		goto done;
 	}
 
-	items = get_be32(&pdu->params[1]);
+	rsp = (void *) pdu->params;
+
+	items = get_be32(&rsp->items);
 
 done:
 	player->cfm->change_path(session, err, items, player->user_data);
@@ -2666,14 +2681,14 @@ int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t uid,
 							uint16_t counter)
 {
 	struct iovec iov;
-	uint8_t pdu[11];
+	struct change_path_req req;
 
-	put_be16(counter, &pdu[0]);
-	pdu[2] = direction;
-	put_be64(uid, &pdu[3]);
+	put_be16(counter, &req.counter);
+	req.direction = direction;
+	put_be64(uid, &req.uid);
 
-	iov.iov_base = pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &req;
+	iov.iov_len = sizeof(req);
 
 	return avrcp_send_browsing_req(session, AVRCP_CHANGE_PATH,
 					&iov, 1, change_path_rsp, session);
@@ -3242,13 +3257,13 @@ int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
 								uint32_t items)
 {
 	struct iovec iov;
-	uint8_t pdu[5];
+	struct change_path_rsp rsp;
 
-	pdu[0] = AVRCP_STATUS_SUCCESS;
-	put_be32(items, &pdu[1]);
+	rsp.status = AVRCP_STATUS_SUCCESS;
+	put_be32(items, &rsp.items);
 
-	iov.iov_base = pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &rsp;
+	iov.iov_len = sizeof(rsp);
 
 	return avrcp_send_browsing(session, transaction, AVRCP_CHANGE_PATH,
 								&iov, 1);
-- 
1.9.3

