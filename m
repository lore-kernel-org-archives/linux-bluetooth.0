Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] audio/avrcp: Use position changed event to resync
Date: Wed,  6 May 2015 17:08:53 +0300
Message-Id: <1430921334-16124-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some player do not change state when backward is pressed only once,
instead it will just start the track from the beginning.

To fix this subscribe to playback position changed event since it is
mandatory to be sent in the following conditions:

 - TG has reached the registered playback Interval time.
 - Changed PLAY STATUS.
 - Changed Current Track.
 - Reached end or beginning of track.
---
 profiles/audio/avrcp.c | 23 +++++++++++++++++++++++
 profiles/audio/avrcp.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index cc26eed..245b3fc 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3084,6 +3084,17 @@ static void avrcp_track_changed(struct avrcp *session,
 		avrcp_get_element_attributes(session);
 }
 
+static void avrcp_playback_pos_changed(struct avrcp *session,
+						struct avrcp_header *pdu)
+{
+	struct avrcp_player *player = session->controller->player;
+	struct media_player *mp = player->user_data;
+	uint32_t position;
+
+	position = get_be32(&pdu->params[1]);
+	media_player_set_position(mp, position);
+}
+
 static void avrcp_setting_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
@@ -3177,6 +3188,9 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 	case AVRCP_EVENT_TRACK_CHANGED:
 		avrcp_track_changed(session, pdu);
 		break;
+	case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
+		avrcp_playback_pos_changed(session, pdu);
+		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
 		avrcp_setting_changed(session, pdu);
 		break;
@@ -3208,6 +3222,14 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event)
 	pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
 	pdu->params[0] = event;
+
+	/*
+	 * Set maximum interval possible for position changed as we only
+	 * use it to resync.
+	 */
+	if (event == AVRCP_EVENT_PLAYBACK_POS_CHANGED)
+		bt_put_be32(UINT32_MAX, &pdu->params[1]);
+
 	pdu->params_len = htons(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
 
 	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
@@ -3248,6 +3270,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 		switch (event) {
 		case AVRCP_EVENT_STATUS_CHANGED:
 		case AVRCP_EVENT_TRACK_CHANGED:
+		case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
 		case AVRCP_EVENT_SETTINGS_CHANGED:
 		case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		case AVRCP_EVENT_UIDS_CHANGED:
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 6ac5294..a9aeb1a 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -74,6 +74,7 @@
 #define AVRCP_EVENT_TRACK_CHANGED		0x02
 #define AVRCP_EVENT_TRACK_REACHED_END		0x03
 #define AVRCP_EVENT_TRACK_REACHED_START		0x04
+#define AVRCP_EVENT_PLAYBACK_POS_CHANGED	0x05
 #define AVRCP_EVENT_SETTINGS_CHANGED		0x08
 #define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED	0x0a
 #define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED	0x0b
-- 
2.1.0

