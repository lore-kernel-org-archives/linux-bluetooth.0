Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] AVRCP: implement TRACK-REACHED-END event
Date: Thu,  3 Nov 2011 14:28:08 -0200
Message-Id: <1320337688-6678-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <CABBYNZ+bn6UAqDLayPfShBZXSO5YBCRmdx2u64+8rq_JBGxoWw@mail.gmail.com>
References: <CABBYNZ+bn6UAqDLayPfShBZXSO5YBCRmdx2u64+8rq_JBGxoWw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c     |    2 ++
 audio/avrcp.h     |    1 +
 audio/media.c     |   15 +++++++++++++++
 doc/media-api.txt |    9 ++++++++-
 4 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 879e959..c9ec314 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -383,6 +383,7 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 		memcpy(&pdu->params[1], data, sizeof(uint64_t));
 
 		break;
+	case AVRCP_EVENT_TRACK_REACHED_END:
 	case AVRCP_EVENT_TRACK_REACHED_START:
 		size = 1;
 		break;
@@ -904,6 +905,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 		memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
 
 		break;
+	case AVRCP_EVENT_TRACK_REACHED_END:
 	case AVRCP_EVENT_TRACK_REACHED_START:
 		len = 1;
 		break;
diff --git a/audio/avrcp.h b/audio/avrcp.h
index c798658..fb64f3b 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -71,6 +71,7 @@
 /* Notification events */
 #define AVRCP_EVENT_STATUS_CHANGED	0x01
 #define AVRCP_EVENT_TRACK_CHANGED	0x02
+#define AVRCP_EVENT_TRACK_REACHED_END	0x03
 #define AVRCP_EVENT_TRACK_REACHED_START	0x04
 #define AVRCP_EVENT_LAST		AVRCP_EVENT_TRACK_REACHED_START
 
diff --git a/audio/media.c b/audio/media.c
index cf157d7..9ee3be5 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1304,6 +1304,7 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
 static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 {
 	uint32_t value;
+	struct metadata_value *duration;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
 			return FALSE;
@@ -1317,6 +1318,20 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	if (!mp->position) {
 		avrcp_player_event(mp->player,
 					AVRCP_EVENT_TRACK_REACHED_START, NULL);
+		return TRUE;
+	}
+
+	duration = g_hash_table_lookup(mp->track, GUINT_TO_POINTER(
+					AVRCP_MEDIA_ATTRIBUTE_DURATION));
+
+	/*
+	 * If position is the maximum value allowed or greater than track's
+	 * duration, we send a track-reached-end event.
+	 */
+	if (mp->position == UINT32_MAX ||
+			(duration && mp->position >= duration->value.num)) {
+		avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_END,
+									NULL);
 	}
 
 	return TRUE;
diff --git a/doc/media-api.txt b/doc/media-api.txt
index 690f373..c53ab7b 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -213,7 +213,14 @@ Properties	string Equalizer [readwrite]
 
 		uint32 Position [readonly]
 
-			Playback position in milliseconds
+			Playback position in milliseconds. Changing the
+			position may generate additional events that will be
+			sent to the remote device. When position is 0 it means
+			the track is starting and when it's greater than or
+			equal to track's duration the track has ended. Note
+			that even if duration is not available in metadata it's
+			possible to signal its end by setting position to the
+			maximum uint32 value.
 
 MediaEndpoint hierarchy
 =======================
-- 
1.7.7.1

