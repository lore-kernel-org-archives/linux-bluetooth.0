Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FB8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Feb 2022 19:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiBVTO4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVTO4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Feb 2022 14:14:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D13119860
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 11:14:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ci24-20020a17090afc9800b001bc3071f921so466424pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 11:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bTnRUS7CftD2A7lBd7xWFtElKtHYtGtKpOxBHHmMFQ=;
        b=D2Bc4NaUz71tXLeBbdLHbrudojjA8Vbh9Hdq3THi5we95mx109fh+SchSw1FRXpgxh
         i3ZFWSIUY9iJSdCF1kKLLZdgRwzvSCp7FSeyhxqRcVJaE5F0ErvP0YaOzlzzdio2ubMS
         qh0StwzOuRu2Xc73mKS0n7c2oamY+cpb+AUBT6WMPgDpEqCyDUB+THaxkbe7zfMoFlmT
         fdEE0mBRn3NIllGVNFfJZcpmdhjoTj3lrM+P3pXPVH+ApDZBUvDrgJcB6BEmo+Yq6pDK
         taX9Qk4PchjIfvWKnDCsVYy1nSFC/GkDPWKADSB4xktY7/j2vUVfFnIyxDeUUDd/h1pX
         DiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bTnRUS7CftD2A7lBd7xWFtElKtHYtGtKpOxBHHmMFQ=;
        b=WuxnYdYHqbNWomZ8OEnwEe2a7BKf2Pq7YsRzFmf85gofDEyLK0FT95BX0Yee8Lo3F3
         93crT1khzmMxgDle9gI1+I75+g9+tgUmysrUYnYmAXKk2P/cH9pRuezlVN2V2DJpRGGp
         kq+UH92YZnk0v5S7Y6EylHmM9Q+QooeM/wPeCgvTOOoIfrO+w3y1NjPc/7UldtyF39g+
         gZGaei6MIqos702n9E7dORMXS/LV83jiS4vmMHyXZJMOTl4WUNYk3IXnijpUQh2VUPds
         2UeRvuAv7en89QomYZhAi08qPNFPKf3I2jw2lZPnmRDO8OT84KvCas0tRiz0LHB+egFL
         Ys1Q==
X-Gm-Message-State: AOAM532caE7XDLRT25sHt1jZn88PBEka3DgRRdQ4oG+zfsXWJg24IPtB
        90T44lvWeXtdpPoEYcIuDUbcC8kvcOc=
X-Google-Smtp-Source: ABdhPJy+r4LOjdkV5I28XfReoEFwU86FkcpB+SNZGir4fGnFm5/YTcW4l4rp5lM38qUW90SzoXFrsg==
X-Received: by 2002:a17:90a:c252:b0:1bc:52a8:cac8 with SMTP id d18-20020a17090ac25200b001bc52a8cac8mr5517651pjx.61.1645557269550;
        Tue, 22 Feb 2022 11:14:29 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s40sm18822259pfg.145.2022.02.22.11.14.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 11:14:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ] player: Fix Track being emitted with empty metadata
Date:   Tue, 22 Feb 2022 11:14:28 -0800
Message-Id: <20220222191428.294428-1-luiz.dentz@gmail.com>
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
 profiles/audio/player.c | 43 ++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index d34b39168..8ea68e8f8 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1308,9 +1308,14 @@ void media_player_set_duration(struct media_player *mp, uint32_t duration)
 
 	g_hash_table_replace(mp->track, g_strdup("Duration"), value);
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+	/* If metadata is pending wait for it */
+	if (mp->process_id)
+		return;
+
+	g_dbus_emit_property_changed_full(btd_get_dbus_connection(),
 					mp->path, MEDIA_PLAYER_INTERFACE,
-					"Track");
+					"Track",
+					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 }
 
 void media_player_set_position(struct media_player *mp, uint32_t position)
@@ -1417,6 +1422,23 @@ static gboolean process_metadata_changed(void *user_data)
 	return FALSE;
 }
 
+static gboolean remove_metadata(void *key, void *value, void *user_data)
+{
+	if (!strcmp(key, "Duration"))
+		return FALSE;
+
+	return strcmp(key, "Item") ? TRUE : FALSE;
+}
+
+static void metadata_changed(struct media_player *mp)
+{
+	if (mp->process_id)
+		return;
+
+	g_hash_table_foreach_remove(mp->track, remove_metadata, NULL);
+	mp->process_id = g_idle_add(process_metadata_changed, mp);
+}
+
 void media_player_set_metadata(struct media_player *mp,
 				struct media_item *item, const char *key,
 				void *data, size_t len)
@@ -1433,10 +1455,7 @@ void media_player_set_metadata(struct media_player *mp,
 		return;
 	}
 
-	if (mp->process_id == 0) {
-		g_hash_table_remove_all(mp->track);
-		mp->process_id = g_idle_add(process_metadata_changed, mp);
-	}
+	metadata_changed(mp);
 
 	g_hash_table_replace(mp->track, g_strdup(key), value);
 }
@@ -1962,6 +1981,7 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 {
 	struct media_folder *folder = mp->playlist;
 	struct media_item *item;
+	char *path;
 
 	DBG("%" PRIu64 "", uid);
 
@@ -1980,16 +2000,13 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
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
+	metadata_changed(mp);
 
-	g_hash_table_replace(mp->track, g_strdup("Item"),
-						g_strdup(item->path));
+	g_hash_table_replace(mp->track, g_strdup("Item"), g_strdup(item->path));
 
 	return item;
 }
-- 
2.35.1

