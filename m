Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C441C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 23:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiBRXlC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 18:41:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbiBRXlB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 18:41:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97C027B489
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 15:40:43 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gf13-20020a17090ac7cd00b001bbfb9d760eso37128pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 15:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hF4WxHzhzMcbT/AQS/gMCJbxshddKkAHU609UNHMFio=;
        b=Ak4B76HO8cH6/b+ff4bcWV+nSCoce05+LKFRoGN8kububxWlzxTymH8i1tYZUrD0Z4
         fKyqzizvDh1EAMj2MHmkyejeEDx+Rid4rRWZpq7QDNjIu6rlmkEY1Gs0EArdl/gG3mb3
         aJN2nNbpnzBYURV9Y25P88swxqsX58xHerHUG2M56YbwE0HhJODggO2iTf/nZw+oFsyu
         t2wZJOyqhnv/Hf3aUbFS1t9lSMlDKDg5ZLmm5A74eVRTjhBu4weba2ReGG4YjkaAXwBK
         TeZo6o26hyLJY8qQczG7apNcsE1Y03U7IL4gK0l/IpbPmdLgPjSYq73gCI/wy5lt+2aS
         34Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hF4WxHzhzMcbT/AQS/gMCJbxshddKkAHU609UNHMFio=;
        b=pqkR4+4uuuxUMKi66vTkAY5gA5v9AEoqmUrKniNsrvccaWRNzw1oKwa1meaPwF/Qjl
         AldVj5jHeIx1rqoxx+L+G5CLa9WX5hd9g6pKKYihTV7+35y/acofIA2KFByGTx13koyt
         7zXtUVpa7BkwJASqNBV1b3FqIzTlArIffsZ8t122I34GN5JNCsUtfyDLGQEvyY2eR4vP
         ancAtnMHiGYKwgAMPVtu+XrCCn6W3rSoIn5uI7hCr7ksDRxck36pASYVBETOjSMT7uUY
         9rdp9FCRDEtBrRZ339k9z4K9E4H0mXyuBxvpQqVOcm/Vdkb14m/zGrgWuDs6qpcSU78k
         sRKQ==
X-Gm-Message-State: AOAM5326gENfsGCRivP7pUA6DyiUmbHjg0PDE7sM8MB5jezyTkPaRYDW
        PxSS3KwGkryI59WibLk1sym51cY1wx4=
X-Google-Smtp-Source: ABdhPJyic6zt7B+W6X2072Hw7PybwLLP9YrG04jFnR72wrTmILrbh522kaFFniC5HWvl0txB6CPEnw==
X-Received: by 2002:a17:902:ba96:b0:14c:8407:8e4b with SMTP id k22-20020a170902ba9600b0014c84078e4bmr9269631pls.135.1645227642571;
        Fri, 18 Feb 2022 15:40:42 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k18sm4170114pfi.10.2022.02.18.15.40.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 15:40:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] player: Fix Track being emitted with empty metadata
Date:   Fri, 18 Feb 2022 15:40:41 -0800
Message-Id: <20220218234041.3460546-1-luiz.dentz@gmail.com>
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
 profiles/audio/player.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index d34b39168..ae9c5456a 100644
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
@@ -1417,6 +1422,11 @@ static gboolean process_metadata_changed(void *user_data)
 	return FALSE;
 }
 
+static gboolean remove_metadata(void *key, void *value, void *user_data)
+{
+	return strcmp(key, "Duration") ? TRUE : FALSE;
+}
+
 void media_player_set_metadata(struct media_player *mp,
 				struct media_item *item, const char *key,
 				void *data, size_t len)
@@ -1434,7 +1444,7 @@ void media_player_set_metadata(struct media_player *mp,
 	}
 
 	if (mp->process_id == 0) {
-		g_hash_table_remove_all(mp->track);
+		g_hash_table_foreach_remove(mp->track, remove_metadata, NULL);
 		mp->process_id = g_idle_add(process_metadata_changed, mp);
 	}
 
-- 
2.35.1

