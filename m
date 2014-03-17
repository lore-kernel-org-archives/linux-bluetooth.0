Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 16/17] android/avrcp: Switch to use avrcp_register_player
Date: Mon, 17 Mar 2014 15:08:02 +0200
Message-Id: <1395061683-17206-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes android daemon to start using avrcp_register_player instead
of now deprecated avrcp_set_control_handlers.
---
 android/avrcp.c | 113 +++++++++++++++++---------------------------------------
 1 file changed, 34 insertions(+), 79 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index f0a6d59..437164e 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -599,34 +599,22 @@ static const struct avrcp_passthrough_handler passthrough_handlers[] = {
 		{ },
 };
 
-static ssize_t handle_get_capabilities_cmd(struct avrcp *session,
-						uint8_t transaction,
-						uint16_t params_len,
-						uint8_t *params,
-						void *user_data)
+static int handle_get_capabilities_cmd(struct avrcp *session,
+					uint8_t transaction, void *user_data)
 {
-	DBG("");
+	uint8_t events[] = { AVRCP_EVENT_STATUS_CHANGED,
+					AVRCP_EVENT_TRACK_CHANGED,
+					AVRCP_EVENT_PLAYBACK_POS_CHANGED  };
 
-	if (params_len != 1)
-		return -EINVAL;
+	DBG("");
 
-	switch (params[0]) {
-	case CAP_COMPANY_ID:
-		params[params_len++] = 1;
-		hton24(&params[params_len], IEEEID_BTSIG);
-		return params_len + 3;
-	case CAP_EVENTS_SUPPORTED:
-		/* Android do not provide this info via HAL so the list most
-		 * be hardcoded according to what RegisterNotification can
-		 * actually handle */
-		params[params_len++] = 3;
-		params[params_len++] = AVRCP_EVENT_STATUS_CHANGED;
-		params[params_len++] = AVRCP_EVENT_TRACK_CHANGED;
-		params[params_len++] = AVRCP_EVENT_PLAYBACK_POS_CHANGED;
-		return params_len;
-	}
+	/* Android do not provide this info via HAL so the list most
+	 * be hardcoded according to what RegisterNotification can
+	 * actually handle */
+	avrcp_get_capabilities_rsp(session, transaction, sizeof(events),
+								events);
 
-	return -EINVAL;
+	return -EAGAIN;
 }
 
 static void push_request(struct avrcp_device *dev, uint8_t pdu_id,
@@ -643,19 +631,13 @@ static void push_request(struct avrcp_device *dev, uint8_t pdu_id,
 	g_queue_push_tail(dev->queue, req);
 }
 
-static ssize_t handle_get_play_status_cmd(struct avrcp *session,
-						uint8_t transaction,
-						uint16_t params_len,
-						uint8_t *params,
-						void *user_data)
+static int handle_get_play_status_cmd(struct avrcp *session,
+					uint8_t transaction, void *user_data)
 {
 	struct avrcp_device *dev = user_data;
 
 	DBG("");
 
-	if (params_len != 0)
-		return -EINVAL;
-
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
 					HAL_EV_AVRCP_GET_PLAY_STATUS, 0, NULL);
 
@@ -664,11 +646,10 @@ static ssize_t handle_get_play_status_cmd(struct avrcp *session,
 	return -EAGAIN;
 }
 
-static ssize_t handle_get_element_attrs_cmd(struct avrcp *session,
-						uint8_t transaction,
-						uint16_t params_len,
-						uint8_t *params,
-						void *user_data)
+static int handle_get_element_attrs_cmd(struct avrcp *session,
+					uint8_t transaction, uint64_t uid,
+					uint8_t number, uint32_t *attrs,
+					void *user_data)
 {
 	struct avrcp_device *dev = user_data;
 	uint8_t buf[IPC_MTU];
@@ -677,16 +658,7 @@ static ssize_t handle_get_element_attrs_cmd(struct avrcp *session,
 
 	DBG("");
 
-	if (params_len < 9)
-		return -EINVAL;
-
-	ev->number = params[8];
-
-	if (params_len < ev->number * sizeof(uint32_t) + 1)
-		return -EINVAL;
-
-	params += 9;
-
+	ev->number = number;
 	/* Set everything in case of empty list */
 	if (ev->number == 0) {
 		for (i = 0; i < HAL_AVRCP_MEDIA_ATTR_DURATION; i++) {
@@ -697,10 +669,8 @@ static ssize_t handle_get_element_attrs_cmd(struct avrcp *session,
 		goto done;
 	}
 
-	for (i = 0; i < ev->number; i++) {
-		ev->attrs[i] = bt_get_be32(params);
-		params += 4;
-	}
+	for (i = 0; i < number; i++)
+		ev->attrs[i] = attrs[i];
 
 done:
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
@@ -713,25 +683,19 @@ done:
 
 }
 
-static ssize_t handle_register_notification_cmd(struct avrcp *session,
+static int handle_register_notification_cmd(struct avrcp *session,
 						uint8_t transaction,
-						uint16_t params_len,
-						uint8_t *params,
+						uint8_t event,
+						uint32_t interval,
 						void *user_data)
 {
 	struct avrcp_device *dev = user_data;
 	struct hal_ev_avrcp_register_notification ev;
-	uint8_t event_id;
 
 	DBG("");
 
-	if (params_len != 5)
-		return -EINVAL;
-
-	event_id = params[0];
-
 	/* TODO: Add any missing events supported by Android */
-	switch (event_id) {
+	switch (event) {
 	case AVRCP_EVENT_STATUS_CHANGED:
 	case AVRCP_EVENT_TRACK_CHANGED:
 	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
@@ -740,32 +704,23 @@ static ssize_t handle_register_notification_cmd(struct avrcp *session,
 		return -EINVAL;
 	}
 
-	ev.event = event_id;
-	ev.param = bt_get_be32(&params[1]);
+	ev.event = event;
+	ev.param = interval;
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
 					HAL_EV_AVRCP_REGISTER_NOTIFICATION,
 					sizeof(ev), &ev);
 
-	push_request(dev, AVRCP_REGISTER_NOTIFICATION, event_id, transaction);
+	push_request(dev, AVRCP_REGISTER_NOTIFICATION, event, transaction);
 
 	return -EAGAIN;
 }
 
-static const struct avrcp_control_handler control_handlers[] = {
-		{ AVRCP_GET_CAPABILITIES,
-					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
-					handle_get_capabilities_cmd },
-		{ AVRCP_GET_PLAY_STATUS,
-					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
-					handle_get_play_status_cmd },
-		{ AVRCP_GET_ELEMENT_ATTRIBUTES,
-					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
-					handle_get_element_attrs_cmd },
-		{ AVRCP_REGISTER_NOTIFICATION,
-					AVC_CTYPE_NOTIFY, AVC_CTYPE_INTERIM,
-					handle_register_notification_cmd },
-		{ },
+static const struct avrcp_control_ind control_ind = {
+	.get_capabilities = handle_get_capabilities_cmd,
+	.get_play_status = handle_get_play_status_cmd,
+	.get_element_attributes = handle_get_element_attrs_cmd,
+	.register_notification = handle_register_notification_cmd,
 };
 
 static gboolean register_notification_rsp(struct avctp *conn,
@@ -848,7 +803,7 @@ static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
 	avrcp_set_destroy_cb(dev->session, disconnect_cb, dev);
 	avrcp_set_passthrough_handlers(dev->session, passthrough_handlers,
 									dev);
-	avrcp_set_control_handlers(dev->session, control_handlers, dev);
+	avrcp_register_player(dev->session, &control_ind, NULL, dev);
 
 	dev->queue = g_queue_new();
 
-- 
1.8.5.3

