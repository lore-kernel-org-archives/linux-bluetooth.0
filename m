Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH v3] audio/avrcp: Handle Available Players Changed
Date: Thu, 23 Jul 2015 17:34:21 +0530
Message-id: <1437653061-7007-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support to handle AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED
notification.
- Register notification for "Available Players Changed"
- Send interim and final responses on change in available players.

< ACL data: handle 70 flags 0x00 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 13 pid 0x110e
        AV/C: Changed: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0001
            EventID: 0x0a (EVENT_AVAILABLE_PLAYERS_CHANGED)
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
index ed441d0..83a9a10 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -988,6 +988,9 @@ static void media_player_remove(struct media_player *mp)
 {
 	info("Player unregistered: sender=%s path=%s", mp->sender, mp->path);
 
+	avrcp_player_event(mp->player,
+				AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
+
 	media_player_destroy(mp);
 }
 
@@ -1799,6 +1802,9 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	avrcp_player_event(mp->player,
+				AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
+
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-- 
1.9.1

