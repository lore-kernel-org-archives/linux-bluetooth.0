Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31DFC4332E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C438260C3E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358970AbhCCNTt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 08:19:49 -0500
Received: from kawka.in.waw.pl ([178.62.225.244]:41612 "EHLO kawka.in.waw.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240050AbhCCK1Q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Mar 2021 05:27:16 -0500
X-Greylist: delayed 7548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 05:27:15 EST
Received: from zbyszek by kawka.in.waw.pl with local (Exim 4.84_2)
        (envelope-from <zbyszek@in.waw.pl>)
        id 1lHMjO-00046x-2n
        for linux-bluetooth@vger.kernel.org; Wed, 03 Mar 2021 08:19:42 +0000
Date:   Wed, 3 Mar 2021 08:19:42 +0000
From:   Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To:     linux-bluetooth@vger.kernel.org
Subject: patch to fix conflict with unistd.h
Message-ID: <20210303081942.GH7348@in.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FmwJltL8yKUx7YXQ"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--FmwJltL8yKUx7YXQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



--FmwJltL8yKUx7YXQ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0005-media-rename-local-function-conflicting-with-pause-2.patch"

From 124dee151746b4a8a2e8a7194af78f2c82f75d79 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Date: Wed, 3 Mar 2021 08:57:36 +0100
Subject: [PATCH] media: rename local function conflicting with pause(2)

profiles/audio/media.c:1284:13: error: conflicting types for 'pause'; have '_Bool(void *)'
 1284 | static bool pause(void *user_data)
      |             ^~~~~
In file included from /usr/include/bits/sigstksz.h:24,
                 from /usr/include/signal.h:315,
                 from /usr/include/glib-2.0/glib/gbacktrace.h:36,
                 from /usr/include/glib-2.0/glib.h:34,
                 from profiles/audio/media.c:21:
/usr/include/unistd.h:478:12: note: previous declaration of 'pause' with type 'int(void)'
  478 | extern int pause (void);
      |            ^~~~~
---
 profiles/audio/media.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index c84bbe22dc..3d8c4b69c3 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1281,7 +1281,7 @@ static bool stop(void *user_data)
 	return media_player_send(mp, "Stop");
 }
 
-static bool pause(void *user_data)
+static bool pause_play(void *user_data)
 {
 	struct media_player *mp = user_data;
 
@@ -1331,7 +1331,7 @@ static struct avrcp_player_cb player_cb = {
 	.set_volume = set_volume,
 	.play = play,
 	.stop = stop,
-	.pause = pause,
+	.pause = pause_play,
 	.next = next,
 	.previous = previous,
 };

--FmwJltL8yKUx7YXQ--
