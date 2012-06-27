Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 09/14] AVRCP: Implement notification AVAILABLE_PLAYERS_CHANGED
Date: Wed, 27 Jun 2012 15:27:43 +0200
Message-ID: <1340803668-31686-9-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Notify remote controller about change in available players
when player is being registered or unregistered.
---
 audio/avrcp.c |    5 ++++-
 audio/media.c |    3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 430f216..d011b2e 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -429,6 +429,7 @@ int avrcp_event(struct avrcp_session *session, uint8_t id, void *data)
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
 	case AVRCP_EVENT_TRACK_REACHED_START:
+	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 		size = 1;
 		break;
 	default:
@@ -600,11 +601,12 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
 
 		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
-		pdu->params[1] = 4;
+		pdu->params[1] = 5;
 		pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
 		pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
 		pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
 		pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
+		pdu->params[6] = AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED;
 
 		pdu->params_len = htons(2 + pdu->params[1]);
 		return AVC_CTYPE_STABLE;
@@ -953,6 +955,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
 	case AVRCP_EVENT_TRACK_REACHED_START:
+	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 		len = 1;
 		break;
 	default:
diff --git a/audio/media.c b/audio/media.c
index 5c958c6..f3cca25 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1795,6 +1795,8 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	avrcp_event(avrcp_get_session(mp->player), AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
+
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
@@ -1816,6 +1818,7 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	if (player == NULL)
 		return btd_error_does_not_exist(msg);
 
+	avrcp_event(avrcp_get_session(player->player), AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
 	media_player_remove(player);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-- 
on behalf of ST-Ericsson

