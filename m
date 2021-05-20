Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 03:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E8A961163
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 03:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETDUo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 23:20:44 -0400
Received: from mail.eh5.me ([45.76.212.85]:33400 "EHLO mail.eh5.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhETDUn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 23:20:43 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 23:20:43 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4076834A3FBE;
        Thu, 20 May 2021 11:13:53 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sokka.cn; s=dkim;
        t=1621480433; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=N19l707bijlmauj5FzZ90bon9G3xhU7M+skeA8s21pY=;
        b=g7ZvyEeO+lClnBRxOZq2VlOuKH8a7N0I4koA2hMba22ONKjgd7+ga8oxic8JjpgM24Ej1s
        jJ7pRzMS6pFlzJ8stDZ5Cyrn1m8PDXM8MPNmnVzQFxmOGu5Gv1eTIs1VO+e9ApBUHO3vdW
        t8YlgCQBVG8NpzkMZRddUdgJFnaXBhQ=
From:   Huang-Huang Bao <eh5@sokka.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Huang-Huang Bao <eh5@sokka.cn>
Subject: [PATCH BlueZ] avrcp: Fix unregister AVRCP player
Date:   Thu, 20 May 2021 11:13:34 +0800
Message-Id: <20210520031334.304688-1-eh5@sokka.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

'notify_addressed_player_changed()' expected to be called with
'player->changed_id' set to what 'g_idle_add()' returns.

    player->changed_id = g_idle_add(notify_addressed_player_changed, player);

And 'avrcp_player_event()' relies on 'player->changed_id' to perform
Addressed Player Changed notification. However,
'avrcp_unregister_player()' calls 'notify_addressed_player_changed()'
without adding it to the main loop and set 'player->changed_id'. To
make 'notify_addressed_player_changed()' can be called without set
'player->changed_id' flag. We add antoher flag
'player->addressed_changing' to indicate addressed player changing.

Fixes https://github.com/bluez/bluez/issues/142
---
 profiles/audio/avrcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 58d30b24d..039ac8924 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -239,6 +239,7 @@ struct avrcp_player {
 	uint8_t *features;
 	char *path;
 	guint changed_id;
+	bool addressed_changing;
 
 	struct pending_list_items *p;
 	char *change_path;
@@ -792,7 +793,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 
 	DBG("id=%u", id);
 
-	if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED && player->changed_id) {
+	if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED && player->addressed_changing) {
 		code = AVC_CTYPE_REJECTED;
 		size = 1;
 		pdu->params[0] = AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED;
@@ -1794,6 +1795,8 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
 				};
 	uint8_t i;
 
+	player->addressed_changing = true;
+
 	avrcp_player_event(player, AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);
 
 	/*
@@ -1804,6 +1807,7 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
 	for (i = 0; i < sizeof(events); i++)
 		avrcp_player_event(player, events[i], NULL);
 
+	player->addressed_changing = false;
 	player->changed_id = 0;
 
 	return FALSE;
-- 
2.31.1

