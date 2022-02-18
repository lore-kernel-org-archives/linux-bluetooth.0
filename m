Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7761CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 23:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiBRXTJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 18:19:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiBRXTI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 18:19:08 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6975914A6CC
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 15:18:48 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f14so1656137ioz.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 15:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hF4WxHzhzMcbT/AQS/gMCJbxshddKkAHU609UNHMFio=;
        b=c5defT5JvMghXSg0g4V5D6K2PYEOPlMc9nwuJfFMGoVUKeFF6S+1gOkBkQ/sM3m7Ub
         EFsFf6mOeF6q8opuQHyJXNFGl5IU/AMiLZE0+F45G6Nj+D8p4aGCuP8MHfY/4suTqC1a
         JuDwIMqqr1rvsfWQrwk+hIJe7FCCLQ3/I852GH7yksJZ4QDUuSolPMABnCEvGSc9EDik
         r8Ouu+LnePokx2ZTaIEcroWZqzenwxgDa/jDFaFFEJii5WfJ1pDj9u5lJWsdZ9H/Bsae
         QDIk1C6pk7YuuJCvYtM0GiU8WzUbPU9FWLLR70UZ0Xj0pjemeaccmtro/v7at8eWemdK
         DBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hF4WxHzhzMcbT/AQS/gMCJbxshddKkAHU609UNHMFio=;
        b=RRzrYvom5OJFp6wa5vRf49i8A6opG8CNfefrzHVWg9GAv9VHFJKCMsbK91B1kWxyHz
         Ro5HxCqb6CNQltiQiQIv+2ePosRAUIgtB8HehtmQmJETImqgVaMZv/RZ5tepjFnpnK2I
         XO9KffXF7qF9/Zm2Y3NmophFX7OTPn+grfte+s4ns0ADjjXDwWSo0wquOAqVCE/VhIWg
         +z/gPEyqTqLOeFckauh2nHzhzIufQ5wgkt3RlfJ/4hCipkLxIu2ilJeEupxrodGnRws0
         AbBUwAxChpkQuDBpIFNtAuzJnVxFnVB6A7FGt7cNv4zbpJM7yhU3BSOrep2Y5OjZNSuZ
         9kcw==
X-Gm-Message-State: AOAM533rXL1KUnRwTObs4tb4KQPb0szrT5Gnd+BBkQ5lXlTo6cEuPb6r
        IKTyhe/rk+kmmoKQ3v8zhcYBqTzLFlg=
X-Google-Smtp-Source: ABdhPJyOJIu9nhsREVUXBbA5Jn/M6LwUr+vKt4IIIFGOc/ktNwdiXKTqjMllAjUKDHVbxU9xBSvrig==
X-Received: by 2002:a05:6602:2d53:b0:63d:7080:92b6 with SMTP id d19-20020a0566022d5300b0063d708092b6mr7216714iow.107.1645226327494;
        Fri, 18 Feb 2022 15:18:47 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d9sm4225443ilc.30.2022.02.18.15.18.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 15:18:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] player: Fix Track being emitted with empty metadata
Date:   Fri, 18 Feb 2022 15:18:46 -0800
Message-Id: <20220218231846.3455223-1-luiz.dentz@gmail.com>
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

