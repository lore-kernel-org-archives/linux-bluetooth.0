Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 19:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906E6613FB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 19:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbhDVTXz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Apr 2021 15:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbhDVTXu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Apr 2021 15:23:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF7C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Apr 2021 12:23:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j7so17937484eds.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Apr 2021 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JbvQVrrdCw9+SuLAg79QaU4Ql8Z7mCyV9VmeySxr0C8=;
        b=MaL7Byabbw1WZxQjizWDxZ8FcwemyFwmmE77mKUqa0h9//tzPEmAs6+zP02LxIOQtz
         Gu6A08agvubAFW3d5mK47ULf50Wk6wK6XRTdHjzt2/+mIGVmvWQi7CEMpkoVDlrViGSs
         OQN5PU1qSUXfTqFndayY/pPLXucMjHhh1NZdn9RuUQApdn/TF2hsV1FG2moTp3cXz2Bo
         pyDzOuR2RPsA08hrS6BsynolvHtfy2vEzXtjjNf6Tr5Tv7IX08L7hmFu+FI7ZN3OfzpN
         8bmfNPayYZ5etzVFX/6qCUdqwimtcZr4o1FhAyTOqOB/VLERGArx9VPIUES+qsWuppsn
         fFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JbvQVrrdCw9+SuLAg79QaU4Ql8Z7mCyV9VmeySxr0C8=;
        b=fasOGZuZ2rGNnRXr+6FcfUf+gbeK1OgpSJGWU+torYz7BBVpMU7dFYkcR6jIIi3svS
         +FFj6Nqh30uSavodjzy9BDFa0HkSkMHg2hDGdRKDpzWtT0JpwdGZ17Yg0fM/IyGzqJLw
         n64grxeEOQ5iiEVT4e/ewTWVnUbjiPAya0gIy7sviXwZrtV2ni5ogBJspYaT8un5wdeA
         u37Vf2+MoRapWUB+zD8wTfFlfZeinrD37APt4FqGSZdjlVJOPNy+yz9vFEoR+d0Gizwo
         eTYvGEGsdaJpVkkanIDoaAqhAzbqglt24ySq7/mdr7YAB+KSRWv+YrCUY57Z7mKy7yOX
         u/bg==
X-Gm-Message-State: AOAM533xOAOiU2Km2B/O5xcOM+U7OG4SWwhDHzP3TcZ50i7gepYgAf5O
        VJgVXIPJ6QDkLd74HTD2ZZwZnhSJloY=
X-Google-Smtp-Source: ABdhPJwPWnCcSq/w6ku84O6UJDhK08a5hNxSkDkiFdMiRfAJrSUjIkM0aP9QZpBBvSCoYDD238Ot1g==
X-Received: by 2002:aa7:db16:: with SMTP id t22mr48482eds.266.1619119385911;
        Thu, 22 Apr 2021 12:23:05 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id gn6sm2289525ejc.83.2021.04.22.12.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 12:23:05 -0700 (PDT)
From:   Marijn Suijten <marijns95@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marijn Suijten <marijns95@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ] audio/avrcp: Determine Absolute Volume support from feature category 2
Date:   Thu, 22 Apr 2021 21:22:53 +0200
Message-Id: <20210422192253.553048-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.31.1
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

Hi Luiz, Marek,

It's been quite a while since our last mail contact.  As mentioned
Android simply reports a too low version for its CT despite setting
category 2 for absolute volume support.  Using this feature instead of
the version solves being unable to synchronize volume, is that okay with
you?

- Marijn

 profiles/audio/avrcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 05dd791de..bacd1aeb4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4136,13 +4136,16 @@ static void target_init(struct avrcp *session)
 				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
 				(1 << AVRCP_EVENT_SETTINGS_CHANGED);

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
2.31.1

