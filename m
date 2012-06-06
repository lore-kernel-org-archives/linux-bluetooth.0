Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 08/13] AVRCP: Implement notification AVAILABLE_PLAYERS_CHANGED
Date: Wed, 6 Jun 2012 18:06:06 +0200
Message-ID: <1338998771-18683-8-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Notify remote controller about change in available players
when player is being registered or unregistered.
---
 audio/avrcp.c |    5 ++++-
 audio/media.c |    2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 9ff0700..895001e 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -462,6 +462,7 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
 	case AVRCP_EVENT_TRACK_REACHED_START:
+	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 		size = 1;
 		break;
 	default:
@@ -634,11 +635,12 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
 
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
@@ -985,6 +987,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
 	case AVRCP_EVENT_TRACK_REACHED_START:
+	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 		len = 1;
 		break;
 	default:
diff --git a/audio/media.c b/audio/media.c
index 3455496..6ee8955 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1411,6 +1411,8 @@ static void media_update_players(struct media_adapter *adapter)
 		players[i] = mp->path;
 	}
 
+	avrcp_player_event(adapter->addressed->player, AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
+
 	emit_array_property_changed(adapter->conn, adapter->path,
 					MEDIA_INTERFACE, "Players",
 					DBUS_TYPE_OBJECT_PATH, &players, i);
-- 
on behalf of ST-Ericsson

