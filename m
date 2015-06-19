Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] audio/avrcp: Handle "Available Players Changed"
Date: Fri, 19 Jun 2015 15:21:13 +0530
Message-id: <1434707473-16294-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED notification.

- Register notification for "Avalable Players Changed"
- Send interim and final response on change in available players.
As per AVRCP 1.5 specification,
The interim and final responses of available players changed
notification shall not contain any parameters.
---
 profiles/audio/avrcp.c | 7 +++++++
 profiles/audio/media.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 60f8cbf..b22f2fe 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -673,6 +673,9 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		pdu->params[size++] = attr;
 		pdu->params[size++] = val;
 		break;
+	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
+		size = 1;
+		break;
 	default:
 		error("Unknown event %u", id);
 		return;
@@ -1490,6 +1493,9 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		}
 
 		break;
+	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
+		len = 1;
+		break;
 	case AVRCP_EVENT_VOLUME_CHANGED:
 		pdu->params[1] = media_transport_get_device_volume(dev);
 		if (pdu->params[1] > 127)
@@ -3435,6 +3441,7 @@ static void target_init(struct avrcp *session)
 				(1 << AVRCP_EVENT_TRACK_CHANGED) |
 				(1 << AVRCP_EVENT_TRACK_REACHED_START) |
 				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
+				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
 				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
 
 	if (target->version < 0x0104)
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index f12569e..8150948 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -987,6 +987,9 @@ static void media_player_remove(struct media_player *mp)
 {
 	info("Player unregistered: sender=%s path=%s", mp->sender, mp->path);
 
+	avrcp_player_event(mp->player,
+				AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
+
 	media_player_destroy(mp);
 }
 
@@ -1793,6 +1796,9 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 			return btd_error_invalid_args(msg);
 	}
 
+	avrcp_player_event(mp->player,
+				AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
+
 	if (parse_player_properties(mp, &args) == FALSE) {
 		media_player_destroy(mp);
 		return btd_error_invalid_args(msg);
-- 
1.9.1

