Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android/avrcp-lib: Rework callback return
Date: Mon, 13 Oct 2014 12:55:48 +0300
Message-Id: <1413194150-21751-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1413194150-21751-1-git-send-email-luiz.dentz@gmail.com>
References: <1413194150-21751-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allow callbacks to return 0 instead of -EAGAIN when responding
asynchronously which is more consistent since it is not an error.
---
 android/avrcp-lib.c | 12 +++++++++++-
 android/avrcp.c     |  8 ++++----
 unit/test-avrcp.c   | 42 +++++++++++++++++++++---------------------
 3 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index f3cdab9..60d6e97 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -496,6 +496,9 @@ static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 
 	ret = handler->func(session, transaction, pdu->params_len, pdu->params,
 							session->control_data);
+	if (ret == 0)
+		return -EAGAIN;
+
 	if (ret < 0) {
 		if (ret == -EAGAIN)
 			return ret;
@@ -622,6 +625,9 @@ static ssize_t handle_browsing_pdu(struct avctp *conn,
 
 	ret = handler->func(session, transaction, pdu->params_len, pdu->params,
 							session->control_data);
+	if (ret == 0)
+		return -EAGAIN;
+
 	if (ret < 0) {
 		if (ret == -EAGAIN)
 			return ret;
@@ -1171,7 +1177,7 @@ static ssize_t request_continuing(struct avrcp *session, uint8_t transaction,
 	if (err < 0)
 		return -EINVAL;
 
-	return -EAGAIN;
+	return 0;
 }
 
 static ssize_t abort_continuing(struct avrcp *session, uint8_t transaction,
@@ -1186,6 +1192,10 @@ static ssize_t abort_continuing(struct avrcp *session, uint8_t transaction,
 	continuing_free(session->continuing);
 	session->continuing = NULL;
 
+	avrcp_send_internal(session, transaction, AVC_CTYPE_ACCEPTED,
+				AVC_SUBUNIT_PANEL, AVRCP_ABORT_CONTINUING,
+				AVRCP_PACKET_TYPE_SINGLE, NULL, 0);
+
 	return 0;
 }
 
diff --git a/android/avrcp.c b/android/avrcp.c
index 940de0b..a0d412d 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -642,7 +642,7 @@ static int handle_get_capabilities_cmd(struct avrcp *session,
 	avrcp_get_capabilities_rsp(session, transaction, sizeof(events),
 								events);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static void push_request(struct avrcp_device *dev, uint8_t pdu_id,
@@ -671,7 +671,7 @@ static int handle_get_play_status_cmd(struct avrcp *session,
 
 	push_request(dev, AVRCP_GET_PLAY_STATUS, 0, transaction);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int handle_get_element_attrs_cmd(struct avrcp *session,
@@ -707,7 +707,7 @@ done:
 
 	push_request(dev, AVRCP_GET_ELEMENT_ATTRIBUTES, 0, transaction);
 
-	return -EAGAIN;
+	return 0;
 
 }
 
@@ -741,7 +741,7 @@ static int handle_register_notification_cmd(struct avrcp *session,
 
 	push_request(dev, AVRCP_REGISTER_NOTIFICATION, event, transaction);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static const struct avrcp_control_ind control_ind = {
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index a6a1872..4f6526c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -409,7 +409,7 @@ static int list_attributes(struct avrcp *session, uint8_t transaction,
 
 	avrcp_list_player_attributes_rsp(session, transaction, 0, NULL);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int get_attribute_text(struct avrcp *session, uint8_t transaction,
@@ -428,7 +428,7 @@ static int get_attribute_text(struct avrcp *session, uint8_t transaction,
 	avrcp_get_player_attribute_text_rsp(session, transaction, number, attrs,
 									text);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int list_values(struct avrcp *session, uint8_t transaction,
@@ -472,7 +472,7 @@ static int get_value(struct avrcp *session, uint8_t transaction,
 	avrcp_get_current_player_value_rsp(session, transaction, number, attrs,
 									values);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int set_value(struct avrcp *session, uint8_t transaction,
@@ -483,7 +483,7 @@ static int set_value(struct avrcp *session, uint8_t transaction,
 
 	avrcp_set_player_value_rsp(session, transaction);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int get_play_status(struct avrcp *session, uint8_t transaction,
@@ -494,7 +494,7 @@ static int get_play_status(struct avrcp *session, uint8_t transaction,
 	avrcp_get_play_status_rsp(session, transaction, 0xaaaaaaaa, 0xbbbbbbbb,
 									0x00);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int get_element_attributes(struct avrcp *session, uint8_t transaction,
@@ -516,7 +516,7 @@ static int get_element_attributes(struct avrcp *session, uint8_t transaction,
 	} else
 		avrcp_get_element_attrs_rsp(session, transaction, NULL, 0);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int track_changed(struct avrcp *session, uint8_t transaction,
@@ -541,7 +541,7 @@ static int track_changed(struct avrcp *session, uint8_t transaction,
 						AVRCP_EVENT_TRACK_CHANGED,
 						&track, sizeof(track));
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int settings_changed(struct avrcp *session, uint8_t transaction,
@@ -563,7 +563,7 @@ static int settings_changed(struct avrcp *session, uint8_t transaction,
 						AVRCP_EVENT_SETTINGS_CHANGED,
 						settings, sizeof(settings));
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int available_players_changed(struct avrcp *session, uint8_t transaction,
@@ -579,7 +579,7 @@ static int available_players_changed(struct avrcp *session, uint8_t transaction,
 					AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED,
 					NULL, 0);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int addressed_player_changed(struct avrcp *session, uint8_t transaction,
@@ -600,7 +600,7 @@ static int addressed_player_changed(struct avrcp *session, uint8_t transaction,
 					AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED,
 					player, sizeof(player));
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int uids_changed(struct avrcp *session, uint8_t transaction,
@@ -622,13 +622,13 @@ static int uids_changed(struct avrcp *session, uint8_t transaction,
 
 	if (!g_str_equal(context->data->test_name, "/TP/MCN/CB/BV-11-C") &&
 		!g_str_equal(context->data->test_name, "/TP/MCN/CB/BI-05-C"))
-		return -EAGAIN;
+		return 0;
 
 	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_CHANGED,
 						AVRCP_EVENT_UIDS_CHANGED,
 						&counter, sizeof(counter));
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int register_notification(struct avrcp *session, uint8_t transaction,
@@ -663,7 +663,7 @@ static int set_volume(struct avrcp *session, uint8_t transaction,
 
 	avrcp_set_volume_rsp(session, transaction, volume);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int set_addressed(struct avrcp *session, uint8_t transaction,
@@ -681,7 +681,7 @@ static int set_addressed(struct avrcp *session, uint8_t transaction,
 
 	avrcp_set_addressed_player_rsp(session, transaction, status);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int set_browsed(struct avrcp *session, uint8_t transaction,
@@ -701,7 +701,7 @@ static int set_browsed(struct avrcp *session, uint8_t transaction,
 						AVRCP_STATUS_SUCCESS,
 						0xabcd, 0, 1, folders);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int get_folder_items(struct avrcp *session, uint8_t transaction,
@@ -722,7 +722,7 @@ static int get_folder_items(struct avrcp *session, uint8_t transaction,
 	avrcp_get_folder_items_rsp(session, transaction, AVRCP_STATUS_SUCCESS,
 						0xabcd, 0, NULL, NULL, NULL);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int change_path(struct avrcp *session, uint8_t transaction,
@@ -736,7 +736,7 @@ static int change_path(struct avrcp *session, uint8_t transaction,
 
 	avrcp_change_path_rsp(session, transaction, AVRCP_STATUS_SUCCESS, 0);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int get_item_attributes(struct avrcp *session, uint8_t transaction,
@@ -757,7 +757,7 @@ static int get_item_attributes(struct avrcp *session, uint8_t transaction,
 	avrcp_get_item_attributes_rsp(session, transaction, status, 0, NULL,
 									NULL);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int play_item(struct avrcp *session, uint8_t transaction, uint8_t scope,
@@ -770,7 +770,7 @@ static int play_item(struct avrcp *session, uint8_t transaction, uint8_t scope,
 
 	avrcp_play_item_rsp(session, transaction, AVRCP_STATUS_SUCCESS);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int search(struct avrcp *session, uint8_t transaction,
@@ -780,7 +780,7 @@ static int search(struct avrcp *session, uint8_t transaction,
 
 	avrcp_search_rsp(session, transaction, AVRCP_STATUS_SUCCESS, 0xaabb, 0);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static int add_to_now_playing(struct avrcp *session, uint8_t transaction,
@@ -795,7 +795,7 @@ static int add_to_now_playing(struct avrcp *session, uint8_t transaction,
 	avrcp_add_to_now_playing_rsp(session, transaction,
 							AVRCP_STATUS_SUCCESS);
 
-	return -EAGAIN;
+	return 0;
 }
 
 static const struct avrcp_control_ind control_ind = {
-- 
1.9.3

