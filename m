Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] AVRCP: Get track duration using GetPlayStatus command
Date: Thu, 31 Jan 2013 11:12:43 -0600
Message-Id: <1359652363-25602-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359652363-25602-1-git-send-email-luiz.dentz@gmail.com>
References: <1359652363-25602-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some stacks, notably broadcom, don't send track duration together with
other metadata so it has to be set using GetPlayStatus.
---
 profiles/audio/avrcp.c  |  6 ++++--
 profiles/audio/player.c | 21 +++++++++++++++++++++
 profiles/audio/player.h |  1 +
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index f83c3db..728ba91 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1632,6 +1632,7 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
 
 	memcpy(&duration, pdu->params, sizeof(uint32_t));
 	duration = ntohl(duration);
+	media_player_set_duration(mp, duration);
 
 	memcpy(&position, pdu->params + 4, sizeof(uint32_t));
 	position = ntohl(position);
@@ -1900,11 +1901,12 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
 		mp = player->user_data;
-		if (code == AVC_CTYPE_CHANGED)
-			media_player_set_position(mp, 0);
 
 		avrcp_get_element_attributes(session);
 
+		if (code == AVC_CTYPE_CHANGED)
+			avrcp_get_play_status(session);
+
 		break;
 
 	case AVRCP_EVENT_SETTINGS_CHANGED:
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 841a577..fb750fd 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -483,6 +483,27 @@ struct media_player *media_player_controller_create(const char *path)
 	return mp;
 }
 
+void media_player_set_duration(struct media_player *mp, uint32_t duration)
+{
+	char *value, *curval;
+
+	DBG("%u", duration);
+
+	value = g_strdup_printf("%u", duration);
+
+	curval = g_hash_table_lookup(mp->track, "Duration");
+	if (g_strcmp0(curval, value) == 0) {
+		g_free(value);
+		return;
+	}
+
+	g_hash_table_replace(mp->track, g_strdup("Duration"), value);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					"Track");
+}
+
 void media_player_set_position(struct media_player *mp, uint32_t position)
 {
 	DBG("%u", position);
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 212a5a6..fec1d06 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -39,6 +39,7 @@ struct media_player_callback {
 
 struct media_player *media_player_controller_create(const char *path);
 void media_player_destroy(struct media_player *mp);
+void media_player_set_duration(struct media_player *mp, uint32_t duration);
 void media_player_set_position(struct media_player *mp, uint32_t position);
 void media_player_set_setting(struct media_player *mp, const char *key,
 							const char *value);
-- 
1.8.1

