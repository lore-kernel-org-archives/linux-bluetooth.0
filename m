Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/19] android/avrcp-lib: Add GetPlayerAttributeText structs
Date: Fri,  3 Oct 2014 15:32:46 +0300
Message-Id: <1412339579-8292-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 68 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 2b22c44..f2cd137 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -127,6 +127,23 @@ struct set_value_req {
 	struct attr_value values[0];
 } __attribute__ ((packed));
 
+struct get_attribute_text_req {
+	uint8_t number;
+	uint8_t attrs[0];
+} __attribute__ ((packed));
+
+struct text_value {
+	uint8_t attr;
+	uint16_t charset;
+	uint8_t len;
+	char data[0];
+} __attribute__ ((packed));
+
+struct get_attribute_text_rsp {
+	uint8_t number;
+	struct text_value values[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -568,20 +585,26 @@ static ssize_t get_attribute_text(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct get_attribute_text_req *req;
 
 	DBG("");
 
-	if (!params || params_len != 1 + params[0])
+	if (!player->ind || !player->ind->get_attribute_text)
+		return -ENOSYS;
+
+	if (!params || params_len < sizeof(*req))
 		return -EINVAL;
 
-	if (!check_attributes(params[0], &params[1]))
+	req = (void *) params;
+	if (params_len != sizeof(*req) + req->number)
 		return -EINVAL;
 
-	if (!player->ind || !player->ind->get_attribute_text)
-		return -ENOSYS;
+	if (!check_attributes(req->number, req->attrs))
+		return -EINVAL;
 
-	return player->ind->get_attribute_text(session, transaction, params[0],
-						&params[1], player->user_data);
+	return player->ind->get_attribute_text(session, transaction,
+						req->number, req->attrs,
+						player->user_data);
 }
 
 static ssize_t list_values(struct avrcp *session, uint8_t transaction,
@@ -1680,24 +1703,25 @@ static int parse_text_rsp(struct avrcp_header *pdu, uint8_t *number,
 
 	params_len = pdu->params_len - 1;
 	for (i = 0, ptr = &pdu->params[1]; i < *number && params_len > 0; i++) {
-		uint8_t len;
+		struct text_value *val;
 
-		if (params_len < 4)
+		if (params_len < sizeof(*val))
 			goto fail;
 
-		attrs[i] = ptr[0];
-		len = ptr[3];
+		val = (void *) ptr;
 
-		params_len -= 4;
-		ptr += 4;
+		attrs[i] = val->attr;
 
-		if (len > params_len)
+		params_len -= sizeof(*val);
+		ptr += sizeof(*val);
+
+		if (val->len > params_len)
 			goto fail;
 
-		if (len > 0) {
-			text[i] = g_strndup((const char *) &ptr[4], len);
-			params_len -= len;
-			ptr += len;
+		if (val->len > 0) {
+			text[i] = g_strndup(val->data, val->len);
+			params_len -= val->len;
+			ptr += val->len;
 		}
 	}
 
@@ -2819,7 +2843,7 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 					uint8_t *attrs, const char **text)
 {
 	struct iovec iov[1 + AVRCP_ATTRIBUTE_LAST * 2];
-	uint8_t val[AVRCP_ATTRIBUTE_LAST][4];
+	struct text_value val[AVRCP_ATTRIBUTE_LAST];
 	int i;
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
@@ -2838,11 +2862,11 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 		if (text[i])
 			len = strlen(text[i]);
 
-		val[i][0] = attrs[i];
-		put_be16(AVRCP_CHARSET_UTF8, &val[i][1]);
-		val[i][3] = len;
+		val[i].attr = attrs[i];
+		put_be16(AVRCP_CHARSET_UTF8, &val[i].charset);
+		val[i].len = len;
 
-		iov[i + 1].iov_base = val[i];
+		iov[i + 1].iov_base = &val[i];
 		iov[i + 1].iov_len = sizeof(val[i]);
 
 		iov[i + 2].iov_base = (void *) text[i];
-- 
1.9.3

