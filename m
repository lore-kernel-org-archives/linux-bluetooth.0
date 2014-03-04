Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/4] android/avrcp: Fix RegisterNotification response handling
Date: Tue,  4 Mar 2014 21:43:22 +0100
Message-Id: <1393965804-13866-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1393965804-13866-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393965804-13866-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For INTERIM RegisterNotification response we should keep request on
list since it will be needed for CHANGED response.

Requests on lists shall be matched by both pdu_id and event_id since we
can have multiple queued RegisterNotification requests and will need to
reply with proper transaction label.
---
 android/avrcp.c | 67 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index f3427a3..a763b88 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -58,6 +58,7 @@ static struct ipc *hal_ipc = NULL;
 struct avrcp_request {
 	struct avrcp_device *dev;
 	uint8_t pdu_id;
+	uint8_t event_id;
 	uint8_t transaction;
 };
 
@@ -68,7 +69,8 @@ struct avrcp_device {
 	GQueue		*queue;
 };
 
-static struct avrcp_request *pop_request(uint8_t pdu_id)
+static struct avrcp_request *pop_request(uint8_t pdu_id, uint8_t event_id,
+								bool peek)
 {
 	GSList *l;
 
@@ -80,10 +82,13 @@ static struct avrcp_request *pop_request(uint8_t pdu_id)
 		for (i = 0; reqs; reqs = g_list_next(reqs), i++) {
 			struct avrcp_request *req = reqs->data;
 
-			if (req->pdu_id == pdu_id) {
+			if (req->pdu_id != pdu_id || req->event_id != event_id)
+				continue;
+
+			if (!peek)
 				g_queue_pop_nth(dev->queue, i);
-				return req;
-			}
+
+			return req;
 		}
 	}
 
@@ -99,7 +104,7 @@ static void handle_get_play_status(const void *buf, uint16_t len)
 
 	DBG("");
 
-	req = pop_request(AVRCP_GET_PLAY_STATUS);
+	req = pop_request(AVRCP_GET_PLAY_STATUS, 0, false);
 	if (!req) {
 		status = HAL_STATUS_FAILED;
 		goto done;
@@ -214,7 +219,7 @@ static void handle_get_element_attrs_text(const void *buf, uint16_t len)
 
 	DBG("");
 
-	req = pop_request(AVRCP_GET_ELEMENT_ATTRIBUTES);
+	req = pop_request(AVRCP_GET_ELEMENT_ATTRIBUTES, 0, false);
 	if (!req) {
 		status = HAL_STATUS_FAILED;
 		goto done;
@@ -256,11 +261,25 @@ static void handle_register_notification(const void *buf, uint16_t len)
 	uint8_t pdu[IPC_MTU];
 	size_t pdu_len;
 	uint8_t code;
+	bool peek = false;
 	int ret;
 
 	DBG("");
 
-	req = pop_request(AVRCP_REGISTER_NOTIFICATION);
+	switch (cmd->type) {
+	case HAL_AVRCP_EVENT_TYPE_INTERIM:
+		code = AVC_CTYPE_INTERIM;
+		peek = true;
+		break;
+	case HAL_AVRCP_EVENT_TYPE_CHANGED:
+		code = AVC_CTYPE_CHANGED;
+		break;
+	default:
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	req = pop_request(AVRCP_REGISTER_NOTIFICATION, cmd->event, peek);
 	if (!req) {
 		status = HAL_STATUS_FAILED;
 		goto done;
@@ -281,29 +300,19 @@ static void handle_register_notification(const void *buf, uint16_t len)
 		goto done;
 	}
 
-	switch (cmd->type) {
-	case HAL_AVRCP_EVENT_TYPE_INTERIM:
-		code = AVC_CTYPE_INTERIM;
-		break;
-	case HAL_AVRCP_EVENT_TYPE_CHANGED:
-		code = AVC_CTYPE_CHANGED;
-		break;
-	default:
-		status = HAL_STATUS_FAILED;
-		goto done;
-	}
-
 	ret = avrcp_register_notification_rsp(req->dev->session,
 						req->transaction, code,
 						pdu, pdu_len);
 	if (ret < 0) {
 		status = HAL_STATUS_FAILED;
-		g_free(req);
+		if (!peek)
+			g_free(req);
 		goto done;
 	}
 
 	status = HAL_STATUS_SUCCESS;
-	g_free(req);
+	if (!peek)
+		g_free(req);
 
 done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP,
@@ -552,13 +561,14 @@ static ssize_t handle_get_capabilities_cmd(struct avrcp *session,
 }
 
 static void push_request(struct avrcp_device *dev, uint8_t pdu_id,
-							uint8_t transaction)
+					uint8_t event_id, uint8_t transaction)
 {
 	struct avrcp_request *req;
 
 	req = g_new0(struct avrcp_request, 1);
 	req->dev = dev;
 	req->pdu_id = pdu_id;
+	req->event_id = event_id;
 	req->transaction = transaction;
 
 	g_queue_push_tail(dev->queue, req);
@@ -580,7 +590,7 @@ static ssize_t handle_get_play_status_cmd(struct avrcp *session,
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
 					HAL_EV_AVRCP_GET_PLAY_STATUS, 0, NULL);
 
-	push_request(dev, AVRCP_GET_PLAY_STATUS, transaction);
+	push_request(dev, AVRCP_GET_PLAY_STATUS, 0, transaction);
 
 	return -EAGAIN;
 }
@@ -616,7 +626,7 @@ static ssize_t handle_get_element_attrs_cmd(struct avrcp *session,
 					HAL_EV_AVRCP_GET_ELEMENT_ATTRS,
 					sizeof(*ev) + ev->number, ev);
 
-	push_request(dev, AVRCP_GET_ELEMENT_ATTRIBUTES, transaction);
+	push_request(dev, AVRCP_GET_ELEMENT_ATTRIBUTES, 0, transaction);
 
 	return -EAGAIN;
 
@@ -630,14 +640,17 @@ static ssize_t handle_register_notification_cmd(struct avrcp *session,
 {
 	struct avrcp_device *dev = user_data;
 	struct hal_ev_avrcp_register_notification ev;
+	uint8_t event_id;
 
 	DBG("");
 
 	if (params_len != 5)
 		return -EINVAL;
 
+	event_id = params[0];
+
 	/* TODO: Add any missing events supported by Android */
-	switch (params[0]) {
+	switch (event_id) {
 	case AVRCP_EVENT_STATUS_CHANGED:
 	case AVRCP_EVENT_TRACK_CHANGED:
 	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
@@ -646,14 +659,14 @@ static ssize_t handle_register_notification_cmd(struct avrcp *session,
 		return -EINVAL;
 	}
 
-	ev.event = params[0];
+	ev.event = event_id;
 	ev.param = bt_get_be32(&params[1]);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
 					HAL_EV_AVRCP_REGISTER_NOTIFICATION,
 					sizeof(ev), &ev);
 
-	push_request(dev, AVRCP_REGISTER_NOTIFICATION, transaction);
+	push_request(dev, AVRCP_REGISTER_NOTIFICATION, event_id, transaction);
 
 	return -EAGAIN;
 }
-- 
1.9.0

