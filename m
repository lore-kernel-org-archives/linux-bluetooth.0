Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/19] android/avrcp-lib: Add ListPlayerValues structs
Date: Fri,  3 Oct 2014 15:32:43 +0300
Message-Id: <1412339579-8292-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 587c6ee..29b2935 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -98,6 +98,15 @@ struct list_attributes_rsp {
 	uint8_t params[0];
 } __attribute__ ((packed));
 
+struct list_values_req {
+	uint8_t attr;
+} __attribute__ ((packed));
+
+struct list_values_rsp {
+	uint8_t number;
+	uint8_t params[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -560,20 +569,22 @@ static ssize_t list_values(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct list_values_req *req;
 
 	DBG("");
 
-	if (!params || params_len != 1)
+	if (!params || params_len != sizeof(*req))
 		return -EINVAL;
 
-	if (params[0] > AVRCP_ATTRIBUTE_LAST ||
-					params[0] == AVRCP_ATTRIBUTE_ILEGAL)
+	req = (void *) params;
+	if (req->attr > AVRCP_ATTRIBUTE_LAST ||
+					req->attr == AVRCP_ATTRIBUTE_ILEGAL)
 		return -EINVAL;
 
 	if (!player->ind || !player->ind->list_values)
 		return -ENOSYS;
 
-	return player->ind->list_values(session, transaction, params[0],
+	return player->ind->list_values(session, transaction, req->attr,
 							player->user_data);
 }
 
@@ -1737,6 +1748,7 @@ static gboolean list_values_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu;
+	struct list_values_rsp *rsp;
 	uint8_t number = 0;
 	uint8_t *values = NULL;
 	int err;
@@ -1757,9 +1769,17 @@ static gboolean list_values_rsp(struct avctp *conn,
 		goto done;
 	}
 
-	number = pdu->params[0];
-	if (number > 0)
-		values = &pdu->params[1];
+	if (pdu->params_len < sizeof(*rsp)) {
+		err = -EPROTO;
+		goto done;
+	}
+
+	rsp = (void *) pdu->params;
+
+	if (rsp->number > 0) {
+		number = rsp->number;
+		values = rsp->params;
+	}
 
 	err = 0;
 
-- 
1.9.3

