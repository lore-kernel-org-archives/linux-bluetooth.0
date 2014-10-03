Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/19] android/avrcp-lib: Add RegisterNotification structs
Date: Fri,  3 Oct 2014 15:32:50 +0300
Message-Id: <1412339579-8292-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 104 +++++++++++++++++++++++++++++++++++++++-------------
 android/avrcp-lib.h |   4 +-
 android/avrcp.c     |  20 +---------
 unit/test-avrcp.c   |  30 ++++++++-------
 4 files changed, 99 insertions(+), 59 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 371294a..72cb087 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -179,6 +179,16 @@ struct get_play_status_rsp {
 	uint8_t status;
 } __attribute__ ((packed));
 
+struct register_notification_req {
+	uint8_t event;
+	uint32_t interval;
+} __attribute__ ((packed));
+
+struct register_notification_rsp {
+	uint8_t event;
+	uint8_t data[0];
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -858,20 +868,23 @@ static ssize_t register_notification(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
+	struct register_notification_req *req;
 	uint32_t interval;
 
 	DBG("");
 
-	if (!params || params_len != 5)
-		return -EINVAL;
-
 	if (!player->ind || !player->ind->register_notification)
 		return -ENOSYS;
 
-	interval = get_be32(&params[1]);
+	if (!params || params_len != sizeof(*req))
+		return -EINVAL;
+
+	req = (void *) params;
+
+	interval = get_be32(&req->interval);
 
 	return player->ind->register_notification(session, transaction,
-							params[0], interval,
+							req->event, interval,
 							player->user_data);
 }
 
@@ -1584,6 +1597,7 @@ static gboolean register_notification_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu;
+	struct register_notification_rsp *rsp;
 	uint8_t event = 0;
 	uint16_t value16;
 	uint32_t value32;
@@ -1607,12 +1621,13 @@ static gboolean register_notification_rsp(struct avctp *conn,
 		goto done;
 	}
 
-	if (pdu->params_len < 1) {
+	if (pdu->params_len < sizeof(rsp)) {
 		err = -EPROTO;
 		goto done;
 	}
 
-	event = pdu->params[0];
+	rsp = (void *) pdu->params;
+	event = rsp->event;
 
 	switch (event) {
 	case AVRCP_EVENT_STATUS_CHANGED:
@@ -1621,14 +1636,14 @@ static gboolean register_notification_rsp(struct avctp *conn,
 			err = -EPROTO;
 			goto done;
 		}
-		params = &pdu->params[1];
+		params = rsp->data;
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
 		if (pdu->params_len != 9) {
 			err = -EPROTO;
 			goto done;
 		}
-		value64 = get_be64(&pdu->params[1]);
+		value64 = get_be64(rsp->data);
 		params = (uint8_t *) &value64;
 		break;
 	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
@@ -1636,7 +1651,7 @@ static gboolean register_notification_rsp(struct avctp *conn,
 			err = -EPROTO;
 			goto done;
 		}
-		value32 = get_be32(&pdu->params[1]);
+		value32 = get_be32(rsp->data);
 		params = (uint8_t *) &value32;
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
@@ -1645,14 +1660,14 @@ static gboolean register_notification_rsp(struct avctp *conn,
 			err = -EPROTO;
 			goto done;
 		}
-		params = &pdu->params[1];
+		params = rsp->data;
 		break;
 	case AVRCP_EVENT_UIDS_CHANGED:
 		if (pdu->params_len != 3) {
 			err = -EPROTO;
 			goto done;
 		}
-		value16 = get_be16(&pdu->params[1]);
+		value16 = get_be16(rsp->data);
 		params = (uint8_t *) &value16;
 		break;
 	}
@@ -1668,13 +1683,13 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 							uint32_t interval)
 {
 	struct iovec iov;
-	uint8_t pdu[5];
+	struct register_notification_req req;
 
-	pdu[0] = event;
-	put_be32(interval, &pdu[1]);
+	req.event = event;
+	put_be32(interval, &req.interval);
 
-	iov.iov_base = pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &req;
+	iov.iov_len = sizeof(req);
 
 	return avrcp_send_req(session, AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
 				AVRCP_REGISTER_NOTIFICATION, &iov, 1,
@@ -3053,17 +3068,56 @@ int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 }
 
 int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
-					uint8_t code, uint8_t *params,
-					size_t params_len)
+					uint8_t code, uint8_t event,
+					void *data, size_t len)
 {
-	struct iovec iov;
+	struct iovec iov[2];
 
-	iov.iov_base = params;
-	iov.iov_len = params_len;
+	if (event > AVRCP_EVENT_LAST)
+		return -EINVAL;
 
-	return avrcp_send(session, transaction, code,
-				AVC_SUBUNIT_PANEL, AVRCP_REGISTER_NOTIFICATION,
-				&iov, 1);
+	iov[0].iov_base = &event;
+	iov[0].iov_len = sizeof(event);
+
+	switch (event) {
+	case AVRCP_EVENT_STATUS_CHANGED:
+	case AVRCP_EVENT_VOLUME_CHANGED:
+		if (len != sizeof(uint8_t))
+			return -EINVAL;
+		break;
+	case AVRCP_EVENT_TRACK_CHANGED:
+		if (len != sizeof(uint64_t))
+			return -EINVAL;
+
+		put_be64(*(uint64_t *) data, data);
+		break;
+	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
+		if (len != sizeof(uint32_t))
+			return -EINVAL;
+
+		put_be32(*(uint32_t *) data, data);
+		break;
+	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+	case AVRCP_EVENT_SETTINGS_CHANGED:
+		if (len < sizeof(uint8_t))
+			return -EINVAL;
+		break;
+	case AVRCP_EVENT_UIDS_CHANGED:
+		if (len != sizeof(uint16_t))
+			return -EINVAL;
+
+		put_be16(*(uint16_t *) data, data);
+		break;
+	default:
+		return avrcp_send(session, transaction, code, AVC_SUBUNIT_PANEL,
+					AVRCP_REGISTER_NOTIFICATION, iov, 1);
+	}
+
+	iov[1].iov_base = data;
+	iov[1].iov_len = len;
+
+	return avrcp_send(session, transaction, code, AVC_SUBUNIT_PANEL,
+					AVRCP_REGISTER_NOTIFICATION, iov, 2);
 }
 
 int avrcp_set_volume_rsp(struct avrcp *session, uint8_t transaction,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 5af5064..2b6eccb 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -313,8 +313,8 @@ int avrcp_set_player_value_rsp(struct avrcp *session, uint8_t transaction);
 int avrcp_get_element_attrs_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t *params, size_t params_len);
 int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
-					uint8_t code, uint8_t *params,
-					size_t params_len);
+					uint8_t code, uint8_t event,
+					void *data, size_t len);
 int avrcp_set_volume_rsp(struct avrcp *session, uint8_t transaction,
 							uint8_t volume);
 int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
diff --git a/android/avrcp.c b/android/avrcp.c
index 5f93c3c..940de0b 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -271,8 +271,6 @@ static void handle_register_notification(const void *buf, uint16_t len)
 	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
 	uint8_t status;
 	struct avrcp_request *req;
-	uint8_t pdu[IPC_MTU];
-	size_t pdu_len;
 	uint8_t code;
 	bool peek = false;
 	int ret;
@@ -298,24 +296,10 @@ static void handle_register_notification(const void *buf, uint16_t len)
 		goto done;
 	}
 
-	pdu[0] = cmd->event;
-	pdu_len = 1;
-
-	switch (cmd->event) {
-	case AVRCP_EVENT_STATUS_CHANGED:
-	case AVRCP_EVENT_TRACK_CHANGED:
-	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
-		memcpy(&pdu[1], cmd->data, cmd->len);
-		pdu_len += cmd->len;
-		break;
-	default:
-		status = HAL_STATUS_FAILED;
-		goto done;
-	}
-
 	ret = avrcp_register_notification_rsp(req->dev->session,
 						req->transaction, code,
-						pdu, pdu_len);
+						cmd->event, cmd->data,
+						cmd->len);
 	if (ret < 0) {
 		status = HAL_STATUS_FAILED;
 		if (!peek)
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 53a54df..f5758ed 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -520,40 +520,42 @@ static int register_notification(struct avrcp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct context *context = user_data;
-	uint8_t pdu[9];
-	size_t pdu_len;
+	uint64_t track;
+	uint8_t settings[3];
+	void *data;
+	size_t len;
 
 	DBG("");
 
-	pdu[0] = event;
-	pdu_len = 1;
-
 	switch (event) {
 	case AVRCP_EVENT_TRACK_CHANGED:
 		if (g_str_equal(context->data->test_name, "/TP/NFY/BV-05-C") ||
 			g_str_equal(context->data->test_name,
 							"/TP/NFY/BV-08-C"))
-			memset(&pdu[1], 0, 8);
+			memset(&track, 0, sizeof(track));
 		else
-			memset(&pdu[1], 0xff, 8);
+			memset(&track, 0xff, sizeof(track));
 
-		pdu_len += 8;
+		data = &track;
+		len = sizeof(track);
 		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
-		pdu[1] = 0x01;
-		pdu[2] = 0x01;
-		pdu[3] = 0x02;
-		pdu_len = 4;
+		settings[0] = 0x01;
+		settings[1] = 0x01;
+		settings[2] = 0x02;
+
+		data = settings;
+		len = sizeof(settings);
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_INTERIM,
-						pdu, pdu_len);
+							event, data, len);
 
 	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_CHANGED,
-						pdu, pdu_len);
+							event, data, len);
 
 	return -EAGAIN;
 }
-- 
1.9.3

