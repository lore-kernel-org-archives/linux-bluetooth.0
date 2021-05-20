Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB30C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 09:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A1A61244
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 09:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhETJX6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhETJX6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 05:23:58 -0400
Received: from mail.eh5.me (mail.eh5.me [IPv6:2001:19f0:7001:2deb:5400:2ff:fef8:7fd6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27B9C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 02:22:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4EBD34A3FBE;
        Thu, 20 May 2021 17:22:34 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sokka.cn; s=dkim;
        t=1621502555; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=BkSvvYRLjrpIDr2H0kxZo3j7ie6dI/O8BRdEHO3wMLs=;
        b=pIGPWomFN48FagU4qJED0kYgEpYdBj396vFJ3RV84VZKIAYaRADffGufBURiuuaJNx4YIO
        OzI2k94Q8zzEdFcssYjSK9znxChezrMu5MKjLV4+bEzh1yKHOEt2uRCduZcx63lRHNAfSg
        BXxZCT2R4fvsKASDS3JkHKbijmU405U=
From:   Huang-Huang Bao <eh5@sokka.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Huang-Huang Bao <eh5@sokka.cn>
Subject: [PATCH BlueZ v3] avrcp: Fix unregister AVRCP player
Date:   Thu, 20 May 2021 17:22:00 +0800
Message-Id: <20210520092200.14937-1-eh5@sokka.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

'notify_addressed_player_changed()' expected to be called with
'player->changed_id' set to a non-zero value.

    player->changed_id = g_idle_add(notify_addressed_player_changed,
                                    player);

And 'avrcp_player_event()' relies on 'player->changed_id' to perform
Addressed Player Changed notification. However,
'avrcp_unregister_player()' calls 'notify_addressed_player_changed()'
without adding it to the main loop and set 'player->changed_id'. To
indicate addreddsed player changed for both scenarios, we set
'player->changed_id' to 1 at the head of
'notify_addressed_player_changed()'.

Fixes https://github.com/bluez/bluez/issues/142
---
 profiles/audio/avrcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 58d30b24d..ef721e17b 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1794,6 +1794,12 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
 				};
 	uint8_t i;

+	/*
+	 * Set changed_id to an non-zero value to indicate addreddsed player
+	 * changed.
+	 */
+	player->changed_id = 1;
+
 	avrcp_player_event(player, AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);

 	/*
--
2.31.1
