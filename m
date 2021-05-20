Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE33C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 04:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2893161040
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 04:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhETENg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 00:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhETENg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 00:13:36 -0400
X-Greylist: delayed 3499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 May 2021 21:12:15 PDT
Received: from mail.eh5.me (mail.eh5.me [IPv6:2001:19f0:7001:2deb:5400:2ff:fef8:7fd6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D561C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 21:12:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED7E234A3FBE;
        Thu, 20 May 2021 12:12:12 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sokka.cn; s=dkim;
        t=1621483933; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=XpOypR01yOfMGqJ7s6N44z8VlDUQXNkwRGue0a3f98Y=;
        b=HNZa3sIcLoAKHlINFlNXqvhCc4tTUfmsyz4gfFIGvCkEkS3vEvJeaD15HLARJMjOvi4Ww2
        Je42DrzzUOk1NpXB+rAw8IZs3zVAIlpn/iqIoUiaMVxDmK1Q74nhChUIbRX480LR20k6cy
        06qV/OkFJ76sRD38bZz60icDrrQTTDQ=
From:   Huang-Huang Bao <eh5@sokka.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Huang-Huang Bao <eh5@sokka.cn>
Subject: [PATCH BlueZ v2] avrcp: Fix unregister AVRCP player
Date:   Thu, 20 May 2021 12:11:42 +0800
Message-Id: <20210520041142.332534-1-eh5@sokka.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v2: fix commit message & code styles

'notify_addressed_player_changed()' expected to be called with
'player->changed_id' set to what 'g_idle_add()' returns.

    player->changed_id = g_idle_add(notify_addressed_player_changed,
                                    player);

And 'avrcp_player_event()' relies on 'player->changed_id' to perform
Addressed Player Changed notification. However,
'avrcp_unregister_player()' calls 'notify_addressed_player_changed()'
without adding it to the main loop and set 'player->changed_id'. To
make 'notify_addressed_player_changed()' can be called without set
'player->changed_id' flag. We add antoher flag
'player->addressed_changing' to indicate addressed player changing.

Fixes https://github.com/bluez/bluez/issues/142
---
 profiles/audio/avrcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 58d30b24d..5058a6848 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -239,6 +239,7 @@ struct avrcp_player {
 	uint8_t *features;
 	char *path;
 	guint changed_id;
+	bool addressed_changing;

 	struct pending_list_items *p;
 	char *change_path;
@@ -792,7 +793,8 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,

 	DBG("id=%u", id);

-	if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED && player->changed_id) {
+	if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED &&
+			player->addressed_changing) {
 		code = AVC_CTYPE_REJECTED;
 		size = 1;
 		pdu->params[0] = AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED;
@@ -1794,6 +1796,8 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
 				};
 	uint8_t i;

+	player->addressed_changing = true;
+
 	avrcp_player_event(player, AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);

 	/*
@@ -1804,6 +1808,7 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
 	for (i = 0; i < sizeof(events); i++)
 		avrcp_player_event(player, events[i], NULL);

+	player->addressed_changing = false;
 	player->changed_id = 0;

 	return FALSE;
--
2.31.1
