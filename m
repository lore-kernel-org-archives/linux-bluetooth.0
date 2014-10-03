Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 17/19] android/avrcp-lib: Add PlayItem structs
Date: Fri,  3 Oct 2014 15:32:57 +0300
Message-Id: <1412339579-8292-18-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 79d72ac..ab227da 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -257,6 +257,16 @@ struct get_item_attributes_rsp {
 	struct media_item items[0];
 } __attribute__ ((packed));
 
+struct play_item_req {
+	uint8_t scope;
+	uint64_t uid;
+	uint16_t counter;
+} __attribute__ ((packed));
+
+struct play_item_rsp {
+	uint8_t status;
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -1324,7 +1334,7 @@ static ssize_t play_item(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
-	uint8_t scope;
+	struct play_item_req *req;
 	uint64_t uid;
 	uint16_t counter;
 
@@ -1333,17 +1343,18 @@ static ssize_t play_item(struct avrcp *session, uint8_t transaction,
 	if (!player->ind || !player->ind->play_item)
 		return -ENOSYS;
 
-	if (!params || params_len < 11)
+	if (!params || params_len < sizeof(*req))
 		return -EINVAL;
 
-	scope = params[0];
-	if (scope > AVRCP_MEDIA_NOW_PLAYING)
+	req = (void *) params;
+
+	if (req->scope > AVRCP_MEDIA_NOW_PLAYING)
 		return -EBADRQC;
 
 	uid = get_be64(&params[1]);
 	counter = get_be16(&params[9]);
 
-	return player->ind->play_item(session, transaction, scope, uid,
+	return player->ind->play_item(session, transaction, req->scope, uid,
 						counter, player->user_data);
 }
 
@@ -2818,17 +2829,17 @@ int avrcp_play_item(struct avrcp *session, uint8_t scope, uint64_t uid,
 							uint16_t counter)
 {
 	struct iovec iov;
-	uint8_t pdu[11];
+	struct play_item_req req;
 
 	if (scope > AVRCP_MEDIA_NOW_PLAYING)
 		return -EINVAL;
 
-	pdu[0] = scope;
-	put_be64(uid, &pdu[1]);
-	put_be16(counter, &pdu[9]);
+	req.scope = scope;
+	put_be64(uid, &req.uid);
+	put_be16(counter, &req.counter);
 
-	iov.iov_base = pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &req;
+	iov.iov_len = sizeof(req);
 
 	return avrcp_send_browsing_req(session, AVRCP_PLAY_ITEM, &iov, 1,
 						play_item_rsp, session);
@@ -3344,12 +3355,12 @@ int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction)
 {
 	struct iovec iov;
-	uint8_t pdu;
+	struct play_item_rsp rsp;
 
-	pdu = AVRCP_STATUS_SUCCESS;
+	rsp.status = AVRCP_STATUS_SUCCESS;
 
-	iov.iov_base = &pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &rsp;
+	iov.iov_len = sizeof(rsp);
 
 	return avrcp_send_browsing(session, transaction, AVRCP_PLAY_ITEM,
 								&iov, 1);
-- 
1.9.3

