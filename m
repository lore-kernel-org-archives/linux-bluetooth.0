Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 16/19] android/avrcp-lib: Add GetItemAttributes structs
Date: Fri,  3 Oct 2014 15:32:56 +0300
Message-Id: <1412339579-8292-17-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 126 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 49 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 179ca86..79d72ac 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -243,6 +243,20 @@ struct change_path_rsp {
 	uint32_t items;
 } __attribute__ ((packed));
 
+struct get_item_attributes_req {
+	uint8_t scope;
+	uint64_t uid;
+	uint16_t counter;
+	uint8_t number;
+	uint32_t attrs[0];
+} __attribute__ ((packed));
+
+struct get_item_attributes_rsp {
+	uint8_t status;
+	uint8_t number;
+	struct media_item items[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -1269,10 +1283,9 @@ static ssize_t get_item_attributes(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
-	uint8_t scope;
+	struct get_item_attributes_req *req;
 	uint64_t uid;
 	uint16_t counter;
-	uint8_t number;
 	uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
 	int i;
 
@@ -1281,27 +1294,28 @@ static ssize_t get_item_attributes(struct avrcp *session, uint8_t transaction,
 	if (!player->ind || !player->ind->get_item_attributes)
 		return -ENOSYS;
 
-	if (!params || params_len < 12)
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
-	number = params[11];
+	uid = get_be64(&req->uid);
+	counter = get_be16(&req->counter);
 
-	for (i = 0; i < number; i++) {
-		attrs[i] = get_be32(&params[12 + i * 4]);
+	for (i = 0; i < req->number; i++) {
+		attrs[i] = get_be32(&req->attrs[i]);
 
 		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
 				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
 			return -EINVAL;
 	}
 
-	return player->ind->get_item_attributes(session, transaction, scope,
-						uid, counter, number, attrs,
+	return player->ind->get_item_attributes(session, transaction,
+						req->scope, uid, counter,
+						req->number, attrs,
 						player->user_data);
 }
 
@@ -2365,17 +2379,21 @@ static int parse_elements(struct avrcp_header *pdu, uint8_t *number,
 static int parse_items(struct avrcp_browsing_header *pdu, uint8_t *number,
 						uint32_t *attrs, char **text)
 {
-	if (pdu->params_len < 2)
+	struct get_item_attributes_rsp *rsp;
+
+	if (pdu->params_len < sizeof(*rsp))
 		return -EPROTO;
 
-	*number = pdu->params[1];
-	if (*number > AVRCP_MEDIA_ATTRIBUTE_LAST) {
-		*number = 0;
+	rsp = (void *) pdu->params;
+
+	if (rsp->number > AVRCP_MEDIA_ATTRIBUTE_LAST)
 		return -EPROTO;
-	}
 
-	return parse_attribute_list(&pdu->params[2], pdu->params_len - 2,
-							*number, attrs, text);
+	*number = rsp->number;
+
+	return parse_attribute_list(pdu->params + sizeof(*rsp),
+						pdu->params_len - sizeof(*rsp),
+						*number, attrs, text);
 }
 
 static gboolean get_element_attributes_rsp(struct avctp *conn,
@@ -2734,16 +2752,16 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 				uint32_t *attrs)
 {
 	struct iovec iov[2];
-	uint8_t pdu[12];
+	struct get_item_attributes_req req;
 	int i;
 
-	pdu[0] = scope;
-	put_be64(uid, &pdu[1]);
-	put_be16(counter, &pdu[9]);
-	pdu[11] = number;
+	req.scope = scope;
+	put_be64(uid, &req.uid);
+	put_be16(counter, &req.counter);
+	req.number = number;
 
-	iov[0].iov_base = pdu;
-	iov[0].iov_len = sizeof(pdu);
+	iov[0].iov_base = &req;
+	iov[0].iov_len = sizeof(req);
 
 	if (!number)
 		return avrcp_send_browsing_req(session,
@@ -3269,45 +3287,55 @@ int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
 								&iov, 1);
 }
 
-int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
-					uint8_t number, uint32_t *attrs,
-					const char **text)
+static bool pack_attribute_list(struct iovec *iov, uint8_t number,
+					uint32_t *attrs, const char **text)
 {
-	struct iovec iov[AVRCP_MEDIA_ATTRIBUTE_LAST * 2 + 1];
-	uint8_t val[AVRCP_MEDIA_ATTRIBUTE_LAST][8];
-	uint8_t pdu[2];
 	int i;
-
-	if (number > AVRCP_MEDIA_ATTRIBUTE_LAST)
-		return -EINVAL;
-
-	pdu[0] = AVRCP_STATUS_SUCCESS;
-	pdu[1] = number;
-
-	iov[0].iov_base = pdu;
-	iov[0].iov_len = sizeof(pdu);
+	struct media_item val[AVRCP_MEDIA_ATTRIBUTE_LAST];
 
 	for (i = 0; i < number; i++) {
 		uint16_t len = 0;
 
 		if (attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST ||
 				attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL)
-			return -EINVAL;
+			return false;
 
 		if (text[i])
 			len = strlen(text[i]);
 
-		put_be32(attrs[i], &val[i][0]);
-		put_be16(AVRCP_CHARSET_UTF8, &val[i][4]);
-		put_be16(len, &val[i][6]);
+		put_be32(attrs[i], &val[i].attr);
+		put_be16(AVRCP_CHARSET_UTF8, &val[i].charset);
+		put_be16(len, &val[i].len);
 
-		iov[i + 1].iov_base = val[i];
-		iov[i + 1].iov_len = sizeof(val[i]);
+		iov[i].iov_base = &val[i];
+		iov[i].iov_len = sizeof(val[i]);
 
-		iov[i + 2].iov_base = (void *) text[i];
-		iov[i + 2].iov_len = len;
+		iov[i + 1].iov_base = (void *) text[i];
+		iov[i + 1].iov_len = len;
 	}
 
+	return true;
+}
+
+int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint32_t *attrs,
+					const char **text)
+{
+	struct iovec iov[AVRCP_MEDIA_ATTRIBUTE_LAST * 2 + 1];
+	struct get_item_attributes_rsp rsp;
+
+	if (number > AVRCP_MEDIA_ATTRIBUTE_LAST)
+		return -EINVAL;
+
+	rsp.status = AVRCP_STATUS_SUCCESS;
+	rsp.number = number;
+
+	iov[0].iov_base = &rsp;
+	iov[0].iov_len = sizeof(rsp);
+
+	if (!pack_attribute_list(&iov[1], number, attrs, text))
+		return -EINVAL;
+
 	return avrcp_send_browsing(session, transaction,
 					AVRCP_GET_ITEM_ATTRIBUTES, iov,
 					number * 2 + 1);
-- 
1.9.3

