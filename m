Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C31C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Sep 2021 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B1060FDC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Sep 2021 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbhILUuO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Sep 2021 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhILUuL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Sep 2021 16:50:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34681C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Sep 2021 13:48:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d6so11386803wrc.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Sep 2021 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZOUrRkmvwBUoZmO3CLNms/hwkn8p+DZ2ZalDsTC0uo=;
        b=CRX/X2f/2DUewgJ6l36+yiuWvgwnoesI7pIQ5pSj301N1Q/XQHI9fsgRdCBvWXaVLj
         P2UXjyQKMBA6It7DNqkV15YmTAHCZmABG/SCe+hjvr3bJoqFiUiNojQH1b7aqeYmI1nd
         zOb9JVmNe37eLi8VYqlO2Ql1m5zqWY0uhAs3wrnVqz9lmjhsLz6t+17GmR6pc0hJ923/
         iUQElAMISDjtuXwWz1o6lZ/GwZa+PQRrTywOM/D5UucywCAdRxUyd4TWG16ZUuCl0rQt
         UNDAqTC3UTixR0LDt4npCIu4e5czK0MGUvwRoAeN86YJtLOPLn0tDddrBhcn4YIbfjN9
         Scjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZOUrRkmvwBUoZmO3CLNms/hwkn8p+DZ2ZalDsTC0uo=;
        b=D7+Qu7lmUN27H+Ii5o5tCbQWvVq1e90hNDrbQDUSyi0FNrc7pRiBMYDRMsrYNe9i4L
         Uzib5WlrYOjnzlfXg1sFYDYvBCPxHEQjHyq+QmjPbtPmwdtfKGUdn7/5Ck+evA8MrXdm
         VNii8dw8CSA90jf+vFfFC0JBtXXWSv/jRIfvfkqHxJOxi52Dm5sqhdR+5nOjQ3eQuiM4
         mfJYP09w8828yGhacpf/iBP5AamZUdG7qRKarvJaOA7p7m3TxvICjg4bSYxYv5/mKE+O
         mXHZniyKRhcxLrl/raa+5t86OwpaGlq8aJb/acW1mZhchb2HXDSGaryD+SvPyJn4KPej
         iTMg==
X-Gm-Message-State: AOAM533Gme/lzX9aShfUb8s7g9H1atrBWhFhn3JpGDw+hW7zn6Juh5Sk
        8XGebr67gjni9OMN94bGeg6S5jCaXME=
X-Google-Smtp-Source: ABdhPJwe9ppS9fAzcPsprDm73JQqDXQyBFckldeiZOOsvorhAafN6eOtkPuCbpFg2wmCg0zNZ7XVgg==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr6684890wri.55.1631479735500;
        Sun, 12 Sep 2021 13:48:55 -0700 (PDT)
Received: from kali.home (lfbn-ren-1-2139-166.w92-167.abo.wanadoo.fr. [92.167.218.166])
        by smtp.gmail.com with ESMTPSA id z5sm5076266wmf.33.2021.09.12.13.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:48:55 -0700 (PDT)
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>,
        "Yann E . MORIN" <yann.morin.1998@free.fr>
Subject: [PATCH] profiles/audio/media.c: fix build with glibc >= 2.34
Date:   Sun, 12 Sep 2021 22:48:39 +0200
Message-Id: <20210912204839.3018089-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

pause() is defined in glibc since the very early times; it appears in
upstream commit 28f540f45bba (initial import) in 1995 [0].

Bluez has been defining a function named pause() for ages too, since
commit caab74c97542 (media: Implement new callbacks for pass-through
operations) in 2013 [1]

With the recent bump to glibc 2.34.xxx, the build now fails because the
two pause() clash:

profiles/audio/media.c:1284:13: error: conflicting types for 'pause'
 1284 | static bool pause(void *user_data)
      |             ^~~~~
In file included from /tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/bits/sigstksz.h:24,
                 from /tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/signal.h:328,
                 from /tmp/instance-0/output-1/per-package/bluez5_utils/host/bin/../s390x-buildroot-linux-gnu/sysroot/usr/include/glib-2.0/glib/gbacktrace.h:36,
                 from /tmp/instance-0/output-1/per-package/bluez5_utils/host/bin/../s390x-buildroot-linux-gnu/sysroot/usr/include/glib-2.0/glib.h:34,
                 from profiles/audio/media.c:21:
/tmp/instance-0/output-1/per-package/bluez5_utils/host/s390x-buildroot-linux-gnu/sysroot/usr/include/unistd.h:489:12: note: previous declaration of 'pause' was here
  489 | extern int pause (void);
      |            ^~~~~

The culprit is indeed glibc 2.34, as can be seen in this result matrix:

         \   bluez5_utils
    glibc \  5.60  |  5.61
    -------\-------+--------
    2.33   |  OK   |   OK
    -------+-------+--------
    2.34   |  KO   |   KO

The underlying reason that pause() is now causing issues with glibc 2.34
is not obvious: glibc is a big beast, and finding such issues is not
easy. However, we can see that the pause() provided by NPTL has been
dropped in favour of the generic one, so maybe this is causing symbol
visibility or weakness to change or something...

We fix that by renaming the local pause() in bluez5_utils with a
namespace-prefix, like some other functions there already have.

Fixes:
  - http://autobuild.buildroot.org/results/c4fbface34be8815838fd7201621d7a8fddd32c5
  - http://autobuild.buildroot.org/results/62b88740f19fbe4a1ad7959dc141d539eb88c1f8

[0] https://sourceware.org/git/?p=glibc.git;a=commit;h=28f540f45bbacd939bfd07f213bcad2bf730b1bf
[1] https://github.com/bluez/bluez/commit/caab74c97542a56b591f0b16b44ab6ba4b40f0f5

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Signed-off-by: Yann E. MORIN <yann.morin.1998@free.fr>
---
 profiles/audio/media.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 267722542..f93b74e67 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1281,7 +1281,7 @@ static bool stop(void *user_data)
 	return media_player_send(mp, "Stop");
 }
 
-static bool pause(void *user_data)
+static bool media_player_pause(void *user_data)
 {
 	struct media_player *mp = user_data;
 
@@ -1331,7 +1331,7 @@ static struct avrcp_player_cb player_cb = {
 	.set_volume = set_volume,
 	.play = play,
 	.stop = stop,
-	.pause = pause,
+	.pause = media_player_pause,
 	.next = next,
 	.previous = previous,
 };
-- 
2.33.0

