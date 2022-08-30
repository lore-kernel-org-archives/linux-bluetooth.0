Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA485ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 21:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiH3VmW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiH3VmV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 17:42:21 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC580F62
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:42:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x5so9645129qtv.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=T3NmbLxusyZY9erq7XxjXaUg4XPa55xhL+hJTWCI1r4=;
        b=B2i3n7GdaTrP6UOwv4lydKtJFaktCIu1zu1ZTfbzcRIjVIEuNrBCSu0pR6vgvhf/wP
         TdXbpC5UgdTQxib00OujFVsIMv+mMdoXm2mxg5ZBksotEigQAz3+7BAsI/TqHw9s6y4d
         CA/3ZImdiAgGAPKWzqeQa8KWpDPju/ASNqzxsTDiyj2gsP8Gu7HzAICaVzGU/LL+ZL3J
         Id/OabR81HHoosr7xK0/bHEgUakta90bA+cjd8c50O8A/Y4DyCP3NaLxKdOu+85kKi+Y
         mP8nGhvGIddtWPbSr2wAZ3cfIkwzO5uKBo6+AMQBLra4h1lGab5rkKIM9PK+CZh1js/3
         JW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=T3NmbLxusyZY9erq7XxjXaUg4XPa55xhL+hJTWCI1r4=;
        b=17AOTYBuy5zXpEU3gkLOsQkclvzjwKcc/0ZtgGiSoOKk3bMGLTQHwrMcQqYozChCvt
         RwCKbv0up0IilETCp5L1eqB5Z/zgRT09e4mIwfaW2C5/KjGxbjoupTxFT53Xo1pzTalK
         wabcHYfzSaRx6lgh1W5Mxz5HQMyFWqSWe/digRybrJLf6M4/AYuXZ86JBQgoYceOftVR
         c4xKCaTVoCEEMpHG9GkMQEP0L/EqJPSObZ+Sz7ZAXfRvoI/7tU12lP3HX8cdXiuLwFSh
         4pF0vxzYHKyCzQbSxIZcfpgZ5BBAm6Y6+r9izttIGiOp00g0i0tUArWG/WfU1F3GQlqQ
         xH6w==
X-Gm-Message-State: ACgBeo0EEiQXV4gOgSlFf9jJOzXc6YYSFASLavpkfXS2tA4KgneMQQGw
        n3NxIBXawWhvJenqB80O7bvSwZMmT2s=
X-Google-Smtp-Source: AA6agR4CtVvu0DtesxwHJsbXv4Ik2JsqgGriqHfPQ2HlugsxQ32oZFJPsZkppDe/MOR3JzG82TWhXQ==
X-Received: by 2002:a05:622a:c6:b0:344:9c4b:1b23 with SMTP id p6-20020a05622a00c600b003449c4b1b23mr16329292qtw.567.1661895738485;
        Tue, 30 Aug 2022 14:42:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fz18-20020a05622a5a9200b0031eb393aa45sm7529050qtb.40.2022.08.30.14.42.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:42:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] client/player: Fix checkpatch warning
Date:   Tue, 30 Aug 2022 14:42:14 -0700
Message-Id: <20220830214215.1137276-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following checkpatch warning:

WARNING:LINE_SPACING: Missing a blank line after declarations
216: FILE: client/player.c:625:
+               GDBusProxy *proxy = l->data;
+               print_player(proxy, NULL);
---
 client/player.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 3d2f41cb3666..0daacabf3c27 100644
--- a/client/player.c
+++ b/client/player.c
@@ -604,8 +604,10 @@ static void print_media(GDBusProxy *proxy, const char *description)
 	g_free(str);
 }
 
-static void print_player(GDBusProxy *proxy, const char *description)
+static void print_player(void *data, void *user_data)
 {
+	GDBusProxy *proxy = data;
+	const char *description = user_data;
 	char *str;
 
 	str = proxy_description(proxy, "Player", description);
@@ -618,12 +620,7 @@ static void print_player(GDBusProxy *proxy, const char *description)
 
 static void cmd_list(int argc, char *arg[])
 {
-	GList *l;
-
-	for (l = players; l; l = g_list_next(l)) {
-		GDBusProxy *proxy = l->data;
-		print_player(proxy, NULL);
-	}
+	g_list_foreach(players, print_player, NULL);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
-- 
2.37.2

