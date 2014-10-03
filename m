Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/19] android/avrcp-lib: Add GetPlayerValueText structs
Date: Fri,  3 Oct 2014 15:32:47 +0300
Message-Id: <1412339579-8292-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index f2cd137..2ceb2b1 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -144,6 +144,17 @@ struct get_attribute_text_rsp {
 	struct text_value values[0];
 } __attribute__ ((packed));
 
+struct get_value_text_req {
+	uint8_t attr;
+	uint8_t number;
+	uint8_t values[0];
+} __attribute__ ((packed));
+
+struct get_value_text_rsp {
+	uint8_t number;
+	struct text_value values[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -669,21 +680,26 @@ static ssize_t get_value_text(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct get_value_text_req *req;
 
 	DBG("");
 
-	if (params_len != 2 + params[1])
+	if (!player->ind || !player->ind->get_value_text)
+		return -ENOSYS;
+
+	if (!params || params_len < sizeof(*req))
 		return -EINVAL;
 
-	if (params[0] > AVRCP_ATTRIBUTE_LAST ||
-					params[0] == AVRCP_ATTRIBUTE_ILEGAL)
+	req = (void *) params;
+	if (params_len != sizeof(*req) + req->number)
 		return -EINVAL;
 
-	if (!check_value(params[0], params[1], &params[2]))
+	if (req->number > AVRCP_ATTRIBUTE_LAST ||
+					req->number == AVRCP_ATTRIBUTE_ILEGAL)
 		return -EINVAL;
 
-	if (!player->ind || !player->ind->get_value_text)
-		return -ENOSYS;
+	if (!check_value(req->attr, req->number, req->values))
+		return -EINVAL;
 
 	return player->ind->get_value_text(session, transaction, params[0],
 						params[1], &params[2],
@@ -1900,16 +1916,16 @@ int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
 					uint8_t number, uint8_t *values)
 {
 	struct iovec iov[2];
-	uint8_t pdu[2];
+	struct get_value_text_req req;
 
 	if (!number)
 		return -EINVAL;
 
-	pdu[0] = attr;
-	pdu[1] = number;
+	req.attr = attr;
+	req.number = number;
 
-	iov[0].iov_base = pdu;
-	iov[0].iov_len = sizeof(pdu);
+	iov[0].iov_base = &req;
+	iov[0].iov_len = sizeof(req);
 
 	iov[1].iov_base = values;
 	iov[1].iov_len = number;
@@ -2921,7 +2937,7 @@ int avrcp_get_player_values_text_rsp(struct avrcp *session,
 					uint8_t *values, const char **text)
 {
 	struct iovec iov[1 + AVRCP_ATTRIBUTE_LAST * 2];
-	uint8_t val[AVRCP_ATTRIBUTE_LAST][4];
+	struct text_value val[AVRCP_ATTRIBUTE_LAST];
 	int i;
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
@@ -2936,11 +2952,11 @@ int avrcp_get_player_values_text_rsp(struct avrcp *session,
 		if (text[i])
 			len = strlen(text[i]);
 
-		val[i][0] = values[i];
-		put_be16(AVRCP_CHARSET_UTF8, &val[i][1]);
-		val[i][3] = len;
+		val[i].attr = values[i];
+		put_be16(AVRCP_CHARSET_UTF8, &val[i].charset);
+		val[i].len = len;
 
-		iov[i + 1].iov_base = val[i];
+		iov[i + 1].iov_base = &val[i];
 		iov[i + 1].iov_len = sizeof(val[i]);
 
 		iov[i + 2].iov_base = (void *) text[i];
-- 
1.9.3

