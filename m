Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Hsin-Yu Chao <hychao@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH] audio/avrcp: Synchronize volume between player and transport
Date: Tue, 29 Mar 2016 21:06:01 +0800
Message-Id: <1459256761-30554-1-git-send-email-hychao@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Application replies on volume_exists() function to know if
a2dp transport has volume property. However this check function
reports incorrect value often because a2dp->volume is not
synchronized with the existence of avrcp session.
Fix this by implementing additional rules:
1. When avrcp target is destroyed, reset the media player's volume
to indicate the volume property is no longer available.
2. If transport is created when an associated media_player exists,
update the volume value.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
---
 profiles/audio/avrcp.c | 18 +++++++++++++++++-
 profiles/audio/avrcp.h |  4 +++-
 profiles/audio/media.c | 14 ++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 0c6279a..25e39ac 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -763,6 +763,20 @@ done:
 	return;
 }
 
+int avrcp_player_has_device(struct avrcp_player *player,
+				struct btd_device *dev)
+{
+	GSList *l;
+	struct avrcp *session;
+
+	for (l = player->sessions; l; l = l->next) {
+		session = l->data;
+		if (dev == session->dev)
+			return TRUE;
+	}
+	return FALSE;
+}
+
 static const char *metadata_to_str(uint32_t id)
 {
 	switch (id) {
@@ -3903,8 +3917,10 @@ static void target_destroy(struct avrcp *session)
 
 	DBG("%p", target);
 
-	if (player != NULL)
+	if (player != NULL) {
+		player->cb->set_volume(-1, session->dev, player->user_data);
 		player->sessions = g_slist_remove(player->sessions, session);
+	}
 
 	g_free(target);
 }
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 86d310c..6377c4e 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -113,7 +113,9 @@ void avrcp_unregister_player(struct avrcp_player *player);
 
 void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 							const void *data);
-
+/* Checks if an avrcp_player has session associated with given device. */
+int avrcp_player_has_device(struct avrcp_player *player,
+						struct btd_device *dev);
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
 size_t avrcp_browsing_general_reject(uint8_t *operands);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 69070bf..d265b3f 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -423,6 +423,8 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	const char *path;
 	DBusMessageIter iter;
 	struct media_transport *transport;
+	GSList *l;
+	struct media_player *mp;
 
 	transport = find_device_transport(endpoint, device);
 
@@ -434,6 +436,18 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	if (transport == NULL)
 		return FALSE;
 
+	/* Look up if there's associated avrcp_player and set its volume
+	 * value to transport. */
+	for (l = endpoint->adapter->players; l; l = l->next) {
+		mp = l->data;
+		if (g_strcmp0(mp->sender, endpoint->sender))
+			continue;
+		if (avrcp_player_has_device(mp->player, device)) {
+			media_transport_update_volume(transport, mp->volume);
+			break;
+		}
+	}
+
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
 						MEDIA_ENDPOINT_INTERFACE,
 						"SetConfiguration");
-- 
2.1.2

