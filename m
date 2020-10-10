Return-Path: <SRS0=53yU=DR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F3C433E7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Oct 2020 23:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2552075E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Oct 2020 23:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=simko.xyz header.i=@simko.xyz header.b="QHxk2my8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgJJXFH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Oct 2020 19:05:07 -0400
Received: from xtrwsqzp.outbound-mail.sendgrid.net ([167.89.100.227]:47123
        "EHLO xtrwsqzp.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbgJJXEo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Oct 2020 19:04:44 -0400
X-Greylist: delayed 1561 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Oct 2020 19:04:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simko.xyz;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=s1; bh=XV5QsdCC39iZ2ICU0c9axvg5IcFTPNI/9RcdR2RsPyU=;
        b=QHxk2my8Dw9tVqdn+97ZLFxQq5m6GeYyq+QthwM0aSgp9P7g5rXdAyCc5SZESK1vtwhJ
        7THrZAI+thkFz0sTY47YUBz1fylmPAzwnMLobxV4tJRZPLuku+F65nhsGfBYjnnoBMMCXD
        MhF2vtCdFkF6joOwyU9WAQtma67bz+ATc=
Received: by filterdrecv-p3mdw1-6685f47d68-78qj6 with SMTP id filterdrecv-p3mdw1-6685f47d68-78qj6-18-5F823550-11
        2020-10-10 22:27:28.209801416 +0000 UTC m=+258684.658973014
Received: from mail.simko.xyz (unknown)
        by ismtpd0089p1iad2.sendgrid.net (SG) with ESMTP id 9m770onmSl6g1XQlfrzHTA
        for <linux-bluetooth@vger.kernel.org>;
        Sat, 10 Oct 2020 22:27:28.137 +0000 (UTC)
Received: from localhost.localdomain (d01-0316a.kn.vutbr.cz [147.229.206.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.simko.xyz (Postfix) with ESMTPSA id 073F64001B;
        Sat, 10 Oct 2020 22:27:26 +0000 (UTC)
From:   =?utf-8?q?Daniel_=C5=A0imko?= <daniel@simko.xyz>
Subject: [PATCH BlueZ] profiles: Fix segfault when using headset controls
Date:   Sat, 10 Oct 2020 22:27:28 +0000 (UTC)
Message-Id: <20201010222719.439956-1-daniel@simko.xyz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?Q0J120W4ZU2dvxvzBhStZdG+rm2wlg3B=2FGgVYVk6RjFkhGd+OCWLLV9qz+=2FCrg?=
 =?us-ascii?Q?eDN2ZBxWYMNf0SMk2W+KW5c2+Ng28QAa+b9R1K+?=
 =?us-ascii?Q?dJeDGJVfArq8j7I9nc6GIpUXojP1iN10ebMt6mT?=
 =?us-ascii?Q?WGuzFQkfNeHkn+NwPZWbOZAlKO5fn3KqJuICpQm?=
 =?us-ascii?Q?11bphz32ebs3EXn=2Fg=2FRVP7Jef4nOk5BTKamcFFr?=
 =?us-ascii?Q?RSmCq4JlQSMevxdtFEQvOkpYiGAS97tefrOeH1u?=
 =?us-ascii?Q?tufot9y4WPZI2pMWfk8Rg=3D=3D?=
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniel =?iso-8859-2?b?qWlta28=?= <daniel@simko.xyz>
X-Entity-ID: OBdE83deZemUHEPHEgiyMA==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a segmentation fault caused by controls trying to notify an
unregistered player.

When an unregistered player is replaced by another valid player from the
list, the session is not referenced in the sessions list of the player
and when this player is unregistered, its reference is not removed from
the session.
---
 profiles/audio/avrcp.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ed436de3b..70f52efe8 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4441,8 +4441,19 @@ void avrcp_unregister_player(struct avrcp_player *player)
 		if (target == NULL)
 			continue;
 
-		if (target->player == player)
-			target->player = g_slist_nth_data(server->players, 0);
+		if (target->player == player) {
+			struct avrcp_player *next_player = g_slist_nth_data(
+								server->players,
+								0);
+
+			target->player = next_player;
+
+			if (next_player) {
+				next_player->sessions = g_slist_append(
+							next_player->sessions,
+							session);
+			}
+		}
 	}
 
 	avrcp_player_event(player,
-- 
2.28.0

