Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3A3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 09:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3FD61074
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 09:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhJSJTW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 05:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhJSJTW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 05:19:22 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CEC06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 02:17:09 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 17E633EBD7;
        Tue, 19 Oct 2021 11:17:06 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ v2] audio/avrcp: Determine Absolute Volume support from feature category 2
Date:   Tue, 19 Oct 2021 11:16:48 +0200
Message-Id: <20211019091648.120910-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The AVRCP spec (1.6.2) does not mention anything about a version
requirement for Absolute Volume, despite this feature only existing
since spec version 1.4.  Android reports a version of 1.3 [1] for its
"AVRCP remote" (CT) service and mentions in the comment above it itself
relies on feature bits rather than the exposed version.  As it stands
BlueZ requires at least version 1.4 making it unable to communicate
absolute volume levels with even the most recent Android phones running
Fluoride (have not checked the version on Gabeldorsche).

The spec states that supporting SetAbsoluteVolume and
EVENT_VOLUME_CHANGED are mandatory when feature level 2 is declared,
excluded otherwise.  This feature bit is set on Android and, when used
by this patch, allows for successfully communicating volume back and
forth despite the version theoretically being too low.

[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761
---

Changes since v1:
- Use block comment intead of single-line comment.

 profiles/audio/avrcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d3c9cb795..e530eeab4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4175,13 +4175,17 @@ static void target_init(struct avrcp *session)
 				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
 				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
 
+	/* Remote device supports receiving volume notifications */
+	if (target->features & AVRCP_FEATURE_CATEGORY_2)
+		session->supported_events |=
+				(1 << AVRCP_EVENT_VOLUME_CHANGED);
+
 	if (target->version < 0x0104)
 		return;
 
 	session->supported_events |=
 				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
-				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
-				(1 << AVRCP_EVENT_VOLUME_CHANGED);
+				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
 
 	/* Only check capabilities if controller is not supported */
 	if (session->controller == NULL)
-- 
2.33.1

