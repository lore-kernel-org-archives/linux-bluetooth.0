Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/5] AVRCP: implement TRACK-REACHED-START event
Date: Fri, 14 Oct 2011 18:28:29 -0300
Message-Id: <1318627712-9725-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318627712-9725-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318627712-9725-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |   13 ++++++++++---
 audio/avrcp.h |    2 ++
 audio/media.c |    5 +++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 076fdf4..8b48e83 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -136,7 +136,7 @@ struct avrcp_player {
 
 	unsigned int handler;
 	uint16_t registered_events;
-	uint8_t transaction_events[AVRCP_EVENT_TRACK_CHANGED + 1];
+	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 
 	struct avrcp_player_cb *cb;
 	void *user_data;
@@ -368,6 +368,9 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 		memcpy(&pdu->params[1], data, sizeof(uint64_t));
 
 		break;
+	case AVRCP_EVENT_TRACK_REACHED_START:
+		size = 1;
+		break;
 	default:
 		error("Unknown event %u", id);
 		return -EINVAL;
@@ -504,10 +507,11 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
 
 		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
-		pdu->params_len = htons(4);
-		pdu->params[1] = 2;
+		pdu->params_len = htons(5);
+		pdu->params[1] = 3;
 		pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
 		pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
+		pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
 
 		return AVC_CTYPE_STABLE;
 	}
@@ -843,6 +847,9 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 		memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
 
 		break;
+	case AVRCP_EVENT_TRACK_REACHED_START:
+		len =1;
+		break;
 	default:
 		/* All other events are not supported yet */
 		goto err;
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 8cf95a4..c798658 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -71,6 +71,8 @@
 /* Notification events */
 #define AVRCP_EVENT_STATUS_CHANGED	0x01
 #define AVRCP_EVENT_TRACK_CHANGED	0x02
+#define AVRCP_EVENT_TRACK_REACHED_START	0x04
+#define AVRCP_EVENT_LAST		AVRCP_EVENT_TRACK_REACHED_START
 
 struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
diff --git a/audio/media.c b/audio/media.c
index 9ef393b..a7647ea 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1289,6 +1289,11 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	mp->position = value;
 	g_timer_start(mp->timer);
 
+	if (!mp->position) {
+		avrcp_player_event(mp->player,
+					AVRCP_EVENT_TRACK_REACHED_START, NULL);
+	}
+
 	return TRUE;
 }
 
-- 
1.7.7

