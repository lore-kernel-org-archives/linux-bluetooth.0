Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD54C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Feb 2022 19:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiBVTjY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBVTjX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Feb 2022 14:39:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D195FDB
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 11:38:57 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso491696pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 11:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cp+QDR3fwheQRgijbik32GREDCJ19SsZAj+PfY92fj0=;
        b=NFvjAITwhGN+r3y/GPJVqj1xkjbRYc5bkTOafrNgha9vnTdIGQhV28//iCCbm/CFct
         ah7I8Ih9qIJxC0iEfB40kh0skeNfgKxnPxy3vmlGlPQLx3YV6qZ10zctQoqPaSYYNHoJ
         QYmKWqyfSMt0fH8VI9gf26HB1L+Ki/SS3BCGZ1csWj/8ahUbCu/pzK+7IyOkUWQYkYed
         peOoOgx6pYPd9l36LNXjIhL4UupcpaKXtBISw6eSWeILsj/9QO4NSYBjCz+ltpRVSUs6
         rJoRhN1T3FmUOCsIzdsjugxj0to62uYXeAwavNmo+PG4mP1kCXzf9WwJ9kC9SnHgnyH5
         XfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cp+QDR3fwheQRgijbik32GREDCJ19SsZAj+PfY92fj0=;
        b=yU5iW62EjuRyAg5IfTxRZiPjS7vfKsi+dAkwUhIJDQsA3GgRiEALaqVFHUSqUG8STZ
         Et8zeMIMG9pvRaONvE8gQR6JUzRNvig1rZt5PG+ewJETcQSObRzVHxgF0HRDIPRHtAAF
         SSSxoons3wGwjD1L76MY5m2lZUOuGHLeNmH3QpThCqivbdxcl/YTjkxE8vbVUkaIInEo
         CjijCpj5Vfd/rDuwVtix8ZYs+by5bH0uLibskfLJWb7YrDlyRwXzCNA4wgN6/PTPLxXq
         d241ZBfz+B9DajFGHkoBH42XW4/redVgMgfODDR8TN+L4IQqQ9D3BLITbJ3wklEGWlDt
         VODg==
X-Gm-Message-State: AOAM532hP6OXbIvPdZEgYj56LL7kue5F184FWDFmjxZd7wbJc5TaaaZG
        k6GbaNkCd0G4Xr2klhY+8t5J9kd75qg=
X-Google-Smtp-Source: ABdhPJzqRw2wsYyKqZG5AcR2OzPJqsZXEv8E1Cc6EET4OaF6FYpIQKdfxhmidO/ujGNbneoUaWHf/g==
X-Received: by 2002:a17:903:40cc:b0:14d:22d4:f49a with SMTP id t12-20020a17090340cc00b0014d22d4f49amr23940107pld.102.1645558736564;
        Tue, 22 Feb 2022 11:38:56 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g63sm17027745pfb.65.2022.02.22.11.38.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 11:38:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 BlueZ] player: Fix Track being emitted with empty metadata
Date:   Tue, 22 Feb 2022 11:38:55 -0800
Message-Id: <20220222193855.301757-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sometimes causes the Track to be schedule while some metadata are
still pending, also don't remove the Duration from track when updating
its metadata since Duration is typically updated by player status rather
than metadata.

Fixes: https://github.com/bluez/bluez/issues/291
---
 profiles/audio/avrcp.c  |  4 +++
 profiles/audio/player.c | 74 ++++++++++++++++++++++-------------------
 profiles/audio/player.h |  2 ++
 3 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5eb182b76..80f34c7a7 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2402,6 +2402,8 @@ static void avrcp_parse_attribute_list(struct avrcp_player *player,
 	struct media_item *item;
 	int i;
 
+	media_player_clear_metadata(mp);
+
 	item = media_player_set_playlist_item(mp, player->uid);
 
 	for (i = 0; count > 0; count--) {
@@ -2428,6 +2430,8 @@ static void avrcp_parse_attribute_list(struct avrcp_player *player,
 
 		i += len;
 	}
+
+	media_player_metadata_changed(mp);
 }
 
 static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index d34b39168..c995697fe 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -85,7 +85,6 @@ struct media_player {
 	char			*status;
 	uint32_t		position;
 	GTimer			*progress;
-	guint			process_id;
 	struct player_callback	*cb;
 	GSList			*pending;
 	GSList			*folders;
@@ -1233,9 +1232,6 @@ void media_player_destroy(struct media_player *mp)
 	if (mp->settings)
 		g_hash_table_unref(mp->settings);
 
-	if (mp->process_id > 0)
-		g_source_remove(mp->process_id);
-
 	if (mp->scope)
 		g_dbus_unregister_interface(btd_get_dbus_connection(),
 						mp->path,
@@ -1308,9 +1304,10 @@ void media_player_set_duration(struct media_player *mp, uint32_t duration)
 
 	g_hash_table_replace(mp->track, g_strdup("Duration"), value);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+	g_dbus_emit_property_changed_full(btd_get_dbus_connection(),
 					mp->path, MEDIA_PLAYER_INTERFACE,
-					"Track");
+					"Track",
+					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 }
 
 void media_player_set_position(struct media_player *mp, uint32_t position)
@@ -1395,26 +1392,20 @@ void media_player_set_status(struct media_player *mp, const char *status)
 	g_timer_start(mp->progress);
 }
 
-static gboolean process_metadata_changed(void *user_data)
+static gboolean remove_metadata(void *key, void *value, void *user_data)
 {
-	struct media_player *mp = user_data;
-	const char *item;
-
-	mp->process_id = 0;
-
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-					mp->path, MEDIA_PLAYER_INTERFACE,
-					"Track");
-
-	item = g_hash_table_lookup(mp->track, "Item");
-	if (item == NULL)
+	if (!strcmp(key, "Duration"))
 		return FALSE;
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-					item, MEDIA_ITEM_INTERFACE,
-					"Metadata");
+	return strcmp(key, "Item") ? TRUE : FALSE;
+}
+
+void media_player_clear_metadata(struct media_player *mp)
+{
+	if (!mp)
+		return;
 
-	return FALSE;
+	g_hash_table_foreach_remove(mp->track, remove_metadata, NULL);
 }
 
 void media_player_set_metadata(struct media_player *mp,
@@ -1433,14 +1424,31 @@ void media_player_set_metadata(struct media_player *mp,
 		return;
 	}
 
-	if (mp->process_id == 0) {
-		g_hash_table_remove_all(mp->track);
-		mp->process_id = g_idle_add(process_metadata_changed, mp);
-	}
-
 	g_hash_table_replace(mp->track, g_strdup(key), value);
 }
 
+void media_player_metadata_changed(struct media_player *mp)
+{
+	char *item;
+
+	if (!mp)
+		return;
+
+	g_dbus_emit_property_changed_full(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					"Track",
+					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
+
+	item = g_hash_table_lookup(mp->track, "Item");
+	if (item == NULL)
+		return;
+
+	g_dbus_emit_property_changed_full(btd_get_dbus_connection(),
+					item, MEDIA_ITEM_INTERFACE,
+					"Metadata",
+					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
+}
+
 void media_player_set_type(struct media_player *mp, const char *type)
 {
 	if (g_strcmp0(mp->type, type) == 0)
@@ -1962,6 +1970,7 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 {
 	struct media_folder *folder = mp->playlist;
 	struct media_item *item;
+	char *path;
 
 	DBG("%" PRIu64 "", uid);
 
@@ -1980,16 +1989,11 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 		mp->track = g_hash_table_ref(item->metadata);
 	}
 
-	if (item == g_hash_table_lookup(mp->track, "Item"))
+	path = g_hash_table_lookup(mp->track, "Item");
+	if (path && !strcmp(path, item->path))
 		return item;
 
-	if (mp->process_id == 0) {
-		g_hash_table_remove_all(mp->track);
-		mp->process_id = g_idle_add(process_metadata_changed, mp);
-	}
-
-	g_hash_table_replace(mp->track, g_strdup("Item"),
-						g_strdup(item->path));
+	g_hash_table_replace(mp->track, g_strdup("Item"), g_strdup(item->path));
 
 	return item;
 }
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 69f08735b..74fb7d771 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -70,9 +70,11 @@ void media_player_set_setting(struct media_player *mp, const char *key,
 							const char *value);
 const char *media_player_get_status(struct media_player *mp);
 void media_player_set_status(struct media_player *mp, const char *status);
+void media_player_clear_metadata(struct media_player *mp);
 void media_player_set_metadata(struct media_player *mp,
 				struct media_item *item, const char *key,
 				void *data, size_t len);
+void media_player_metadata_changed(struct media_player *mp);
 void media_player_set_type(struct media_player *mp, const char *type);
 void media_player_set_subtype(struct media_player *mp, const char *subtype);
 void media_player_set_name(struct media_player *mp, const char *name);
-- 
2.35.1

