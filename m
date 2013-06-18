Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio/media: Fix notifying settings changed incorrectly
Date: Tue, 18 Jun 2013 11:09:52 +0300
Message-Id: <1371542994-24510-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

We should notify only the setting that has changed not all of them.
---
 profiles/audio/avrcp.c | 30 +++++++++++++-----------------
 profiles/audio/avrcp.h |  3 ++-
 profiles/audio/media.c |  7 +------
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 730f061..f0554fe 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -612,13 +612,15 @@ static int play_status_to_val(const char *status)
 	return -EINVAL;
 }
 
-void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
+void avrcp_player_event(struct avrcp_player *player, uint8_t id,
+							const void *data)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + 9];
 	struct avrcp_header *pdu = (void *) buf;
 	uint16_t size;
 	GSList *l;
-	GList *settings;
+	int attr;
+	int val;
 
 	if (player->sessions == NULL)
 		return;
@@ -649,24 +651,18 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
 		size = 2;
-		settings = data;
-		pdu->params[1] = g_list_length(settings);
-		for (; settings; settings = settings->next) {
-			const char *key = settings->data;
-			int attr;
-			int val;
+		pdu->params[1] = 1;
 
-			attr = attr_to_val(key);
-			if (attr < 0)
-				continue;
+		attr = attr_to_val(data);
+		if (attr < 0)
+			return;
 
-			val = player_get_setting(player, attr);
-			if (val < 0)
-				continue;
+		val = player_get_setting(player, attr);
+		if (val < 0)
+			return;
 
-			pdu->params[++size] = attr;
-			pdu->params[++size] = val;
-		}
+		pdu->params[++size] = attr;
+		pdu->params[++size] = val;
 		break;
 	default:
 		error("Unknown event %u", id);
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 3b1963f..6a435e6 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -115,7 +115,8 @@ struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 						GDestroyNotify destroy);
 void avrcp_unregister_player(struct avrcp_player *player);
 
-void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
+void avrcp_player_event(struct avrcp_player *player, uint8_t id,
+							const void *data);
 
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index eb5ea81..45dfe53 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1470,7 +1470,6 @@ static gboolean set_property(struct media_player *mp, const char *key,
 							const char *value)
 {
 	const char *curval;
-	GList *settings;
 
 	curval = g_hash_table_lookup(mp->settings, key);
 	if (g_strcmp0(curval, value) == 0)
@@ -1480,11 +1479,7 @@ static gboolean set_property(struct media_player *mp, const char *key,
 
 	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
 
-	settings = list_settings(mp);
-
-	avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED, settings);
-
-	g_list_free(settings);
+	avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED, key);
 
 	return TRUE;
 }
-- 
1.8.1.4

