Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6 v2] AVRCP: Register to addressed player changed event if supported
Date: Fri,  1 Feb 2013 15:28:22 -0600
Message-Id: <1359754105-8185-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359754105-8185-1-git-send-email-luiz.dentz@gmail.com>
References: <1359754105-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables registering for addressed player changed event and handle
the interim response setting the player id and uid counter to the current
player.
---
 profiles/audio/avrcp.c | 14 ++++++++++++++
 profiles/audio/avrcp.h | 15 ++++++++-------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 0a173bc..8187ddf 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -176,6 +176,8 @@ struct pending_pdu {
 struct avrcp_player {
 	struct avrcp_server *server;
 	GSList *sessions;
+	uint16_t id;
+	uint16_t uid_counter;
 
 	struct avrcp_player_cb *cb;
 	void *user_data;
@@ -1869,6 +1871,7 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 	uint8_t event;
 	uint8_t value;
 	uint8_t count;
+	uint16_t id;
 	const char *curval, *strval;
 	int i;
 
@@ -1932,6 +1935,16 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 		}
 
 		break;
+
+	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+		id = bt_get_be16(&pdu->params[1]);
+
+		if (player->id == id)
+			break;
+
+		player->id = id;
+		player->uid_counter = bt_get_be16(&pdu->params[3]);
+		break;
 	}
 
 	session->registered_events |= (1 << event);
@@ -2112,6 +2125,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 		case AVRCP_EVENT_STATUS_CHANGED:
 		case AVRCP_EVENT_TRACK_CHANGED:
 		case AVRCP_EVENT_SETTINGS_CHANGED:
+		case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 			avrcp_register_notification(session, event);
 			break;
 		}
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index b2c0d61..3799da1 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -69,13 +69,14 @@
 #define AVRCP_PLAY_STATUS_ERROR		0xFF
 
 /* Notification events */
-#define AVRCP_EVENT_STATUS_CHANGED	0x01
-#define AVRCP_EVENT_TRACK_CHANGED	0x02
-#define AVRCP_EVENT_TRACK_REACHED_END	0x03
-#define AVRCP_EVENT_TRACK_REACHED_START	0x04
-#define AVRCP_EVENT_SETTINGS_CHANGED	0x08
-#define AVRCP_EVENT_VOLUME_CHANGED	0x0d
-#define AVRCP_EVENT_LAST		AVRCP_EVENT_VOLUME_CHANGED
+#define AVRCP_EVENT_STATUS_CHANGED		0x01
+#define AVRCP_EVENT_TRACK_CHANGED		0x02
+#define AVRCP_EVENT_TRACK_REACHED_END		0x03
+#define AVRCP_EVENT_TRACK_REACHED_START		0x04
+#define AVRCP_EVENT_SETTINGS_CHANGED		0x08
+#define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED	0x0b
+#define AVRCP_EVENT_VOLUME_CHANGED		0x0d
+#define AVRCP_EVENT_LAST			AVRCP_EVENT_VOLUME_CHANGED
 
 struct avrcp_player_cb {
 	GList *(*list_settings) (void *user_data);
-- 
1.8.1

