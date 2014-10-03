Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 18/19] android/avrcp-lib: Add Search structs
Date: Fri,  3 Oct 2014 15:32:58 +0300
Message-Id: <1412339579-8292-19-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index ab227da..ccaefc4 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -267,6 +267,18 @@ struct play_item_rsp {
 	uint8_t status;
 } __attribute__ ((packed));
 
+struct search_req {
+	uint16_t charset;
+	uint16_t len;
+	char string[0];
+} __attribute__ ((packed));
+
+struct search_rsp {
+	uint8_t status;
+	uint16_t counter;
+	uint32_t items;
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -1363,6 +1375,7 @@ static ssize_t search(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct search_req *req;
 	char *string;
 	uint16_t len;
 	int ret;
@@ -1372,14 +1385,16 @@ static ssize_t search(struct avrcp *session, uint8_t transaction,
 	if (!player->ind || !player->ind->search)
 		return -ENOSYS;
 
-	if (!params || params_len < 4)
+	if (!params || params_len < sizeof(*req))
 		return -EINVAL;
 
-	len = get_be16(&params[2]);
+	req = (void *) params;
+
+	len = get_be16(&req->len);
 	if (!len)
 		return -EINVAL;
 
-	string = strndup((void *) &params[4], len);
+	string = strndup(req->string, len);
 
 	ret = player->ind->search(session, transaction, string,
 							player->user_data);
@@ -2851,6 +2866,7 @@ static gboolean search_rsp(struct avctp *conn, uint8_t *operands,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_browsing_header *pdu;
+	struct search_rsp *rsp;
 	uint16_t counter = 0;
 	uint32_t items = 0;
 	int err;
@@ -2870,13 +2886,15 @@ static gboolean search_rsp(struct avctp *conn, uint8_t *operands,
 	if (err < 0)
 		goto done;
 
-	if (pdu->params_len < 7) {
+	if (pdu->params_len < sizeof(*rsp)) {
 		err = -EPROTO;
 		goto done;
 	}
 
-	counter = get_be16(&pdu->params[1]);
-	items = get_be32(&pdu->params[3]);
+	rsp = (void *) pdu->params;
+
+	counter = get_be16(&rsp->counter);
+	items = get_be32(&rsp->items);
 
 	err = 0;
 
@@ -2889,7 +2907,7 @@ done:
 int avrcp_search(struct avrcp *session, const char *string)
 {
 	struct iovec iov[2];
-	uint8_t pdu[4];
+	struct search_req req;
 	size_t len;
 
 	if (!string)
@@ -2897,11 +2915,11 @@ int avrcp_search(struct avrcp *session, const char *string)
 
 	len = strnlen(string, UINT8_MAX);
 
-	put_be16(AVRCP_CHARSET_UTF8, &pdu[0]);
-	put_be16(len, &pdu[2]);
+	put_be16(AVRCP_CHARSET_UTF8, &req.charset);
+	put_be16(len, &req.len);
 
-	iov[0].iov_base = pdu;
-	iov[0].iov_len = sizeof(pdu);
+	iov[0].iov_base = &req;
+	iov[0].iov_len = sizeof(req);
 
 	iov[1].iov_base = (void *) string;
 	iov[1].iov_len = len;
@@ -3370,14 +3388,14 @@ int avrcp_search_rsp(struct avrcp *session, uint8_t transaction,
 					uint16_t counter, uint32_t items)
 {
 	struct iovec iov;
-	uint8_t pdu[7];
+	struct search_rsp rsp;
 
-	pdu[0] = AVRCP_STATUS_SUCCESS;
-	put_be16(counter, &pdu[1]);
-	put_be32(items, &pdu[3]);
+	rsp.status = AVRCP_STATUS_SUCCESS;
+	put_be16(counter, &rsp.counter);
+	put_be32(items, &rsp.items);
 
-	iov.iov_base = pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &rsp;
+	iov.iov_len = sizeof(rsp);
 
 	return avrcp_send_browsing(session, transaction, AVRCP_SEARCH,
 								&iov, 1);
-- 
1.9.3

