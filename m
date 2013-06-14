Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/16] audio/player: Add function media_item_set_playable
Date: Fri, 14 Jun 2013 15:41:40 +0300
Message-Id: <1371213710-16607-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
References: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avrcp.c  |  9 ++++++++-
 profiles/audio/player.c | 11 +++++++++++
 profiles/audio/player.h |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 539684d..d46e598 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2096,6 +2096,7 @@ static struct media_item *parse_media_element(struct avrcp *session,
 {
 	struct avrcp_player *player;
 	struct media_player *mp;
+	struct media_item *item;
 	uint16_t namelen;
 	char name[255];
 	uint64_t uid;
@@ -2114,7 +2115,13 @@ static struct media_item *parse_media_element(struct avrcp *session,
 	player = session->player;
 	mp = player->user_data;
 
-	return media_player_create_item(mp, name, PLAYER_ITEM_TYPE_AUDIO, uid);
+	item = media_player_create_item(mp, name, PLAYER_ITEM_TYPE_AUDIO, uid);
+	if (item == NULL)
+		return NULL;
+
+	media_item_set_playable(item, true);
+
+	return item;
 }
 
 static struct media_item *parse_media_folder(struct avrcp *session,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index c151560..69e8cd5 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1466,6 +1466,17 @@ static const GDBusPropertyTable media_item_properties[] = {
 	{ }
 };
 
+void media_item_set_playable(struct media_item *item, bool value)
+{
+	if (item->playable == value)
+		return;
+
+	item->playable = value;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), item->path,
+					MEDIA_ITEM_INTERFACE, "Playable");
+}
+
 struct media_item *media_player_create_item(struct media_player *mp,
 						const char *name,
 						player_item_type_t type,
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 3a388d2..20de0b8 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -88,6 +88,7 @@ struct media_item *media_player_create_item(struct media_player *mp,
 						player_item_type_t type,
 						uint64_t uid);
 
+void media_item_set_playable(struct media_item *item, bool value);
 void media_player_list_complete(struct media_player *mp, GSList *items,
 								int err);
 
-- 
1.8.1.4

