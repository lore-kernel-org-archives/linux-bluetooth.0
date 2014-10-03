Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/19] android/avrcp-lib: Add GetElementAttributes structs
Date: Fri,  3 Oct 2014 15:32:48 +0300
Message-Id: <1412339579-8292-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 119 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 45 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 2ceb2b1..3a7a81f 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -155,6 +155,24 @@ struct get_value_text_rsp {
 	struct text_value values[0];
 } __attribute__ ((packed));
 
+struct media_item {
+	uint32_t attr;
+	uint16_t charset;
+	uint16_t len;
+	char data[0];
+} __attribute__ ((packed));
+
+struct get_element_attributes_req {
+	uint64_t id;
+	uint8_t number;
+	uint32_t attrs[0];
+} __attribute__ ((packed));
+
+struct get_element_attributes_rsp {
+	uint8_t number;
+	struct media_item items[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -781,6 +799,23 @@ static ssize_t get_play_status(struct avrcp *session, uint8_t transaction,
 							player->user_data);
 }
 
+static bool parse_attributes(uint32_t *params, uint16_t params_len,
+					uint8_t number, uint32_t *attrs)
+{
+	int i;
+
+	for (i = 0; i < number && params_len >= sizeof(*attrs); i++,
+					params_len -= sizeof(*attrs)) {
+		attrs[i] = get_be32(&params[i]);
+
+		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
+				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
+			return false;
+	}
+
+	return true;
+}
+
 static ssize_t get_element_attributes(struct avrcp *session,
 						uint8_t transaction,
 						uint16_t params_len,
@@ -788,32 +823,27 @@ static ssize_t get_element_attributes(struct avrcp *session,
 						void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct get_element_attributes_req *req;
 	uint64_t uid;
-	uint8_t number;
 	uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
-	int i;
 
 	DBG("");
 
-	if (!params || params_len != 9 + params[8] * 4)
-		return -EINVAL;
-
-	uid = get_be64(params);
-	number = params[8];
+	if (!player->ind || !player->ind->get_element_attributes)
+		return -ENOSYS;
 
-	for (i = 0; i < number; i++) {
-		attrs[i] = get_be32(&params[9 + i * 4]);
+	req = (void *) params;
+	if (!params || params_len < sizeof(*req))
+		return -EINVAL;
 
-		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
-				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
-			return -EINVAL;
-	}
+	if (!parse_attributes(req->attrs, params_len - sizeof(*req),
+							req->number, attrs))
+		return -EINVAL;
 
-	if (!player->ind || !player->ind->get_element_attributes)
-		return -ENOSYS;
+	uid = get_be64(params);
 
 	return player->ind->get_element_attributes(session, transaction, uid,
-							number, attrs,
+							req->number, attrs,
 							player->user_data);
 }
 
@@ -2193,33 +2223,29 @@ int avrcp_set_volume(struct avrcp *session, uint8_t volume)
 static int parse_attribute_list(uint8_t *params, uint16_t params_len,
 				uint8_t number, uint32_t *attrs, char **text)
 {
+	struct media_item *item;
 	int i;
 
 	if (number > AVRCP_MEDIA_ATTRIBUTE_LAST)
 		return -EPROTO;
 
-	for (i = 0; number > 0 && params_len > i; number--) {
-		uint16_t charset, len;
+	for (i = 0; i < number && params_len >= sizeof(*item); i++) {
+		item = (void *) params;
 
-		if (params_len < 8)
-			goto fail;
-
-		attrs[i] = get_be32(&params[i]);
-		i += sizeof(uint32_t);
-
-		charset = get_be16(&params[i]);
-		i += sizeof(uint16_t);
+		item->attr = get_be32(&item->attr);
+		item->charset = get_be16(&item->charset);
+		item->len = get_be16(&item->len);
 
-		len = get_be16(&params[i]);
-		i += sizeof(uint16_t);
-
-		if (len > params_len)
+		params_len -= sizeof(*item);
+		params += sizeof(*item);
+		if (item->len > params_len)
 			goto fail;
 
-		if (charset == AVRCP_CHARSET_UTF8)
-			text[i] = g_strndup((const char *) &params[i], len);
-
-		i += len;
+		if (item->len > 0) {
+			text[i] = g_strndup(item->data, item->len);
+			params_len -= item->len;
+			params += item->len;
+		}
 	}
 
 	return 0;
@@ -2234,17 +2260,20 @@ fail:
 static int parse_elements(struct avrcp_header *pdu, uint8_t *number,
 						uint32_t *attrs, char **text)
 {
-	if (pdu->params_len < 1)
+	struct get_element_attributes_rsp *rsp;
+
+	if (pdu->params_len < sizeof(*rsp))
 		return -EPROTO;
 
-	*number = pdu->params[0];
-	if (*number > AVRCP_MEDIA_ATTRIBUTE_LAST) {
-		*number = 0;
+	rsp = (void *) pdu->params;
+	if (rsp->number > AVRCP_MEDIA_ATTRIBUTE_LAST)
 		return -EPROTO;
-	}
 
-	return parse_attribute_list(&pdu->params[1], pdu->params_len - 1,
-							*number, attrs, text);
+	*number = rsp->number;
+
+	return parse_attribute_list(pdu->params + sizeof(*rsp),
+						pdu->params_len - sizeof(*rsp),
+						*number, attrs, text);
 }
 
 static int parse_items(struct avrcp_browsing_header *pdu, uint8_t *number,
@@ -2304,13 +2333,13 @@ done:
 int avrcp_get_element_attributes(struct avrcp *session)
 {
 	struct iovec iov;
-	uint8_t pdu[9];
+	struct get_element_attributes_req req;
 
 	/* This returns all attributes */
-	memset(pdu, 0, sizeof(pdu));
+	memset(&req, 0, sizeof(req));
 
-	iov.iov_base = pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &req;
+	iov.iov_len = sizeof(req);
 
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
 				AVRCP_GET_ELEMENT_ATTRIBUTES, &iov, 1,
-- 
1.9.3

