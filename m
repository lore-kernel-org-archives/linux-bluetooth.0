Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 19/19] android/avrcp-lib: Add AddToNowPlaying structs
Date: Fri,  3 Oct 2014 15:32:59 +0300
Message-Id: <1412339579-8292-20-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index ccaefc4..362d6e0 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -279,6 +279,16 @@ struct search_rsp {
 	uint32_t items;
 } __attribute__ ((packed));
 
+struct add_to_now_playing_req {
+	uint8_t scope;
+	uint64_t uid;
+	uint16_t counter;
+} __attribute__ ((packed));
+
+struct add_to_now_playing_rsp {
+	uint8_t status;
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -1409,7 +1419,7 @@ static ssize_t add_to_now_playing(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
-	uint8_t scope;
+	struct add_to_now_playing_req *req;
 	uint64_t uid;
 	uint16_t counter;
 
@@ -1418,18 +1428,20 @@ static ssize_t add_to_now_playing(struct avrcp *session, uint8_t transaction,
 	if (!player->ind || !player->ind->add_to_now_playing)
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
 
-	uid = get_be64(&params[1]);
-	counter = get_be16(&params[9]);
+	uid = get_be64(&req->uid);
+	counter = get_be16(&req->counter);
 
-	return player->ind->add_to_now_playing(session, transaction, scope, uid,
-						counter, player->user_data);
+	return player->ind->add_to_now_playing(session, transaction, req->scope,
+							uid, counter,
+							player->user_data);
 }
 
 static const struct avrcp_browsing_handler browsing_handlers[] = {
@@ -2959,17 +2971,17 @@ int avrcp_add_to_now_playing(struct avrcp *session, uint8_t scope, uint64_t uid,
 							uint16_t counter)
 {
 	struct iovec iov;
-	uint8_t pdu[11];
+	struct add_to_now_playing_req req;
 
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
 
 	return avrcp_send_browsing_req(session, AVRCP_ADD_TO_NOW_PLAYING,
 					&iov, 1, add_to_now_playing_rsp,
@@ -3404,12 +3416,12 @@ int avrcp_search_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_add_to_now_playing_rsp(struct avrcp *session, uint8_t transaction)
 {
 	struct iovec iov;
-	uint8_t pdu;
+	struct add_to_now_playing_rsp rsp;
 
-	pdu = AVRCP_STATUS_SUCCESS;
+	rsp.status = AVRCP_STATUS_SUCCESS;
 
-	iov.iov_base = &pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &rsp;
+	iov.iov_len = sizeof(rsp);
 
 	return avrcp_send_browsing(session, transaction,
 					AVRCP_ADD_TO_NOW_PLAYING, &iov, 1);
-- 
1.9.3

