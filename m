Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/19] android/avrcp-lib: Add SetPlayerApplicationSettingValue structs
Date: Fri,  3 Oct 2014 15:32:45 +0300
Message-Id: <1412339579-8292-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 49 +++++++++++++++++++++++++++++++------------------
 android/avrcp-lib.h |  2 +-
 unit/test-avrcp.c   |  3 ++-
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 15d3d75..2b22c44 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -122,6 +122,11 @@ struct value_rsp {
 	struct attr_value values[0];
 } __attribute__ ((packed));
 
+struct set_value_req {
+	uint8_t number;
+	struct attr_value values[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -693,26 +698,33 @@ static ssize_t set_value(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct set_value_req *req;
+	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
+	uint8_t values[AVRCP_ATTRIBUTE_LAST];
 	int i;
 
 	DBG("");
 
-	if (!params || params_len != params[0] * 2 + 1)
+	if (!player->ind || !player->ind->set_value)
+		return -ENOSYS;
+
+	if (!params || params_len < sizeof(*req))
+		return -EINVAL;
+
+	req = (void *) params;
+	if (params_len < sizeof(*req) + req->number * sizeof(*req->values))
 		return -EINVAL;
 
-	for (i = 0; i < params[0]; i++) {
-		uint8_t attr = params[i * 2 + 1];
-		uint8_t val = params[i * 2 + 2];
+	for (i = 0; i < req->number; i++) {
+		attrs[i] = req->values[i].attr;
+		values[i] = req->values[i].value;
 
-		if (!check_value(attr, 1, &val))
+		if (!check_value(attrs[i], 1, &values[i]))
 			return -EINVAL;
 	}
 
-	if (!player->ind || !player->ind->set_value)
-		return -ENOSYS;
-
-	return player->ind->set_value(session, transaction, params[0],
-					&params[1], player->user_data);
+	return player->ind->set_value(session, transaction, req->number,
+					attrs, values, player->user_data);
 }
 
 static ssize_t get_play_status(struct avrcp *session, uint8_t transaction,
@@ -2009,25 +2021,26 @@ done:
 int avrcp_set_player_value(struct avrcp *session, uint8_t number,
 					uint8_t *attrs, uint8_t *values)
 {
-	struct iovec iov;
-	uint8_t pdu[2 * AVRCP_ATTRIBUTE_LAST + 1];
+	struct iovec iov[2];
+	struct attr_value val[AVRCP_ATTRIBUTE_LAST];
 	int i;
 
 	if (number > AVRCP_ATTRIBUTE_LAST)
 		return -EINVAL;
 
-	pdu[0] = number;
+	iov[0].iov_base = &number;
+	iov[0].iov_len = sizeof(number);
 
 	for (i = 0; i < number; i++) {
-		pdu[i * 2 + 1] = attrs[i];
-		pdu[i * 2 + 2] = values[i];
+		val[i].attr = attrs[i];
+		val[i].value = values[i];
 	}
 
-	iov.iov_base = pdu;
-	iov.iov_len = 1 + number * 2;
+	iov[1].iov_base = val;
+	iov[1].iov_len = sizeof(*val) * number;
 
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
-					AVRCP_SET_PLAYER_VALUE, &iov, 1,
+					AVRCP_SET_PLAYER_VALUE, iov, 2,
 					set_value_rsp, session);
 }
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index ee03958..5af5064 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -147,7 +147,7 @@ struct avrcp_control_ind {
 					void *user_data);
 	int (*set_value) (struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs,
-					void *user_data);
+					uint8_t *values, void *user_data);
 	int (*get_play_status) (struct avrcp *session, uint8_t transaction,
 					void *user_data);
 	int (*get_element_attributes) (struct avrcp *session,
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index e8cf34a..53a54df 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -472,7 +472,8 @@ static int get_value(struct avrcp *session, uint8_t transaction,
 }
 
 static int set_value(struct avrcp *session, uint8_t transaction,
-			uint8_t number, uint8_t *attrs, void *user_data)
+			uint8_t number, uint8_t *attrs, uint8_t *values,
+			void *user_data)
 {
 	DBG("");
 
-- 
1.9.3

