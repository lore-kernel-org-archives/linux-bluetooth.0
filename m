Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1F1D935E
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458672; cv=none; b=aVA+FNSDpmQyNY19j96rJtwBvQKLOSHDEWnDHCob4OEWLhSB4v8R5dwcKVf4/w1vfslDfJ/aqhxfTATjBttgUQQYuNhQl/4+OfXK5lXtd7Agcsj3Q8RzPaRUHVWq6wGFxp7IlHYfAkgDbZXWrGTZvPPB7XLO6rkklzVzprcYWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458672; c=relaxed/simple;
	bh=n+/Y4+h5oggY51chav12gXs13/H+ZuvDxF+GkTM8bcE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMeBNv+MNJ5CIaAv9O6Wx3kVUdi5JXHtCHZeMuiOz8A8DL+ZNkFMfTABO3/gEQjue+gM9zo1DCvjdHKNhNFNV1lTvWAWOqN0iHau+TfM6H09MK7p4qV81Ktluu3Xc/l1ccGupLoC4WbNhE8FK9BDFM2RhVtjpF4r6eU5tyWKHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ltXl3DlH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ltXl3DlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725458668;
	bh=n+/Y4+h5oggY51chav12gXs13/H+ZuvDxF+GkTM8bcE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ltXl3DlHiYKApgUL0M9uBigzXVn9pWEbZZarNZnE73m+H2fdiQfURJ0rVYtozE0sr
	 2ZT1TfV4apT5RlDxmuN0VRy+5/jdbQRgBiZ8hEY0aC8CXXP0PNz7GlTnwfPJIdOF+a
	 iFk4GiNFRVhjvCm8mR3doXqPAOD8ZE5OPGi+A4aZ7FUJXQyI3wMudUtmL4dV/6XiWt
	 cNIu2CzHTu3RoqbCenOmDcEMWQJ8ef37B15cDhPZ5X5Ltkdz0M9CmVEmGTBOtmHP6b
	 qho7siAPhaDoBswXzdcBbgHxXLvSL1x54qLpc4e/eNpH7LBHvrUPE9r8Z29iWgE4km
	 BcMPJ6qrb/Wug==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8279517E10D6
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 16:04:28 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] player: Add OBEX PSM port for cover art support
Date: Wed,  4 Sep 2024 16:04:16 +0200
Message-Id: <20240904140421.283166-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904140421.283166-1-frederic.danis@collabora.com>
References: <20240904140421.283166-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This parse the AVRCP Target SDP record for the L2CAP PSM to use with
the OBEX session to get the cover art.
---
 doc/org.bluez.MediaPlayer.rst |  6 +++++
 profiles/audio/avrcp.c        | 51 +++++++++++++++++++++++++++++++----
 profiles/audio/player.c       | 29 ++++++++++++++++++++
 profiles/audio/player.h       |  1 +
 4 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/doc/org.bluez.MediaPlayer.rst b/doc/org.bluez.MediaPlayer.rst
index 60bd679bb..f1e999bdf 100644
--- a/doc/org.bluez.MediaPlayer.rst
+++ b/doc/org.bluez.MediaPlayer.rst
@@ -313,3 +313,9 @@ object Playlist
 ```````````````
 
 	Playlist object path.
+
+uint16 ObexPort [readonly]
+`````````````````````````````
+
+	If present indicates the player can get cover art using BIP over OBEX
+	on this PSM port.
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 752e55be3..61558e492 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -118,8 +118,14 @@
 #define AVRCP_FEATURE_CATEGORY_2	0x0002
 #define AVRCP_FEATURE_CATEGORY_3	0x0004
 #define AVRCP_FEATURE_CATEGORY_4	0x0008
-#define AVRCP_FEATURE_PLAYER_SETTINGS	0x0010
-#define AVRCP_FEATURE_BROWSING			0x0040
+#define AVRCP_FEATURE_TG_PLAYER_SETTINGS	0x0010
+#define AVRCP_FEATURE_TG_GROUP_NAVIGATION	0x0020
+#define AVRCP_FEATURE_BROWSING				0x0040
+#define AVRCP_FEATURE_TG_MULTIPLE_PLAYER	0x0080
+#define AVRCP_FEATURE_TG_COVERT_ART			0x0100
+#define AVRCP_FEATURE_CT_GET_IMAGE_PROP		0x0080
+#define AVRCP_FEATURE_CT_GET_IMAGE			0x0100
+#define AVRCP_FEATURE_CT_GET_THUMBNAIL		0x0200
 
 #define AVRCP_BATTERY_STATUS_NORMAL		0
 #define AVRCP_BATTERY_STATUS_WARNING		1
@@ -254,6 +260,7 @@ struct avrcp_data {
 	struct avrcp_player *player;
 	uint16_t version;
 	int features;
+	uint16_t obex_port;
 	GSList *players;
 };
 
@@ -487,7 +494,7 @@ static sdp_record_t *avrcp_tg_record(bool browsing)
 					AVRCP_FEATURE_CATEGORY_2 |
 					AVRCP_FEATURE_CATEGORY_3 |
 					AVRCP_FEATURE_CATEGORY_4 |
-					AVRCP_FEATURE_PLAYER_SETTINGS );
+					AVRCP_FEATURE_TG_PLAYER_SETTINGS);
 
 	record = sdp_record_alloc();
 	if (!record)
@@ -3522,6 +3529,7 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
 		return NULL;
 	}
 
+	media_player_set_obex_port(mp, session->controller->obex_port);
 	media_player_set_callbacks(mp, &ct_cbs, player);
 	player->user_data = mp;
 	player->destroy = (GDestroyNotify) media_player_destroy;
@@ -4006,7 +4014,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 	if (events == (1 << AVRCP_EVENT_VOLUME_CHANGED))
 		return FALSE;
 
-	if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
+	if ((session->controller->features &
+			AVRCP_FEATURE_TG_PLAYER_SETTINGS) &&
 			!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
 		avrcp_list_player_attributes(session);
 
@@ -4075,8 +4084,9 @@ static struct avrcp_data *data_init(struct avrcp *session, const char *uuid)
 {
 	struct avrcp_data *data;
 	const sdp_record_t *rec;
-	sdp_list_t *list;
+	sdp_list_t *list, *protos;
 	sdp_profile_desc_t *desc;
+	int port = 0;
 
 	data = g_new0(struct avrcp_data, 1);
 
@@ -4092,6 +4102,35 @@ static struct avrcp_data *data_init(struct avrcp *session, const char *uuid)
 	sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES, &data->features);
 	sdp_list_free(list, free);
 
+	if ((g_strcmp0(uuid, AVRCP_TARGET_UUID) != 0) ||
+			!(data->features & AVRCP_FEATURE_TG_COVERT_ART) ||
+			(sdp_get_add_access_protos(rec, &protos) != 0))
+		return data;
+
+	/* Get the PSM port from the Additional Protocol Descriptor list
+	 * entry containing OBEX UUID
+	 */
+	for (list = protos; list; list = list->next) {
+		sdp_list_t *p;
+
+		for (p = list->data; p; p = p->next) {
+			sdp_data_t *seq = p->data;
+
+			if ((sdp_uuid_to_proto(&seq->val.uuid) == OBEX_UUID) &&
+					SDP_IS_UUID(seq->dtd)) {
+				port = sdp_get_proto_port(list, L2CAP_UUID);
+				goto done;
+			}
+		}
+	}
+
+done:
+	if (port > 0)
+		data->obex_port = port;
+
+	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(protos, NULL);
+
 	return data;
 }
 
@@ -4189,6 +4228,8 @@ static void controller_init(struct avrcp *session)
 	session->controller = controller;
 
 	DBG("%p version 0x%04x", controller, controller->version);
+	if (controller->obex_port)
+		DBG("%p OBEX PSM 0x%04x", controller, controller->obex_port);
 
 	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
 	btd_service_connecting_complete(service, 0);
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index c995697fe..4e3de8047 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -88,6 +88,7 @@ struct media_player {
 	struct player_callback	*cb;
 	GSList			*pending;
 	GSList			*folders;
+	uint16_t		obex_port;
 };
 
 static void append_track(void *key, void *value, void *user_data)
@@ -437,6 +438,28 @@ static gboolean get_playlist(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean obexport_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct media_player *mp = data;
+
+	return mp->obex_port != 0;
+}
+
+static gboolean get_obexport(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->obex_port == 0)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&mp->obex_port);
+
+	return TRUE;
+}
+
 static DBusMessage *media_player_play(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -778,6 +801,7 @@ static const GDBusPropertyTable media_player_properties[] = {
 	{ "Browsable", "b", get_browsable, NULL, browsable_exists },
 	{ "Searchable", "b", get_searchable, NULL, searchable_exists },
 	{ "Playlist", "o", get_playlist, NULL, playlist_exists },
+	{ "ObexPort", "q", get_obexport, NULL, obexport_exists },
 	{ }
 };
 
@@ -1997,3 +2021,8 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 
 	return item;
 }
+
+void media_player_set_obex_port(struct media_player *mp, uint16_t port)
+{
+	mp->obex_port = port;
+}
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 74fb7d771..0076c4641 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -86,6 +86,7 @@ void media_player_set_folder(struct media_player *mp, const char *path,
 void media_player_set_playlist(struct media_player *mp, const char *name);
 struct media_item *media_player_set_playlist_item(struct media_player *mp,
 								uint64_t uid);
+void media_player_set_obex_port(struct media_player *mp, uint16_t port);
 
 struct media_item *media_player_create_folder(struct media_player *mp,
 						const char *name,
-- 
2.34.1

