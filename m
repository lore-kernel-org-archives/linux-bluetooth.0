Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F5AC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C61606A5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhDAK2h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhDAK1w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F7BC0617A7
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 03:25:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f75so5262086yba.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pjLc0GCGeoKt3WMjr9IqnkfrKbYNQrPENY0f+UGyKOs=;
        b=Ix55Ab0zKrENL+X7zErw7gE48EA2Za9+KC2GHXX3LqekqNR3acb3oZePJurhc/mjNk
         68UNoPIt3rSQFq5AbZIT8IGdFIHXm854TBVyidZELm/HrAOlV1jEvROwa9XsrAbuk8GR
         A3XR/e/lZguQBdfTrrMfxxDcRuXWIwU3fYEsNknu/8noHc5uDRYZBzhYnwPeXeOwms9i
         kXBTF+9vizLRnvWaYwkHbXiQHcfsG/55KqE+G8GAUxNV+tILzIqbpJVfbodI3RpoTHav
         LxSQldY58ADU3qia6OyLZ2+FlZXdtTF34dtTs1ftvAgYm5UL0S3un7H73rgl+/gyOLXp
         u+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pjLc0GCGeoKt3WMjr9IqnkfrKbYNQrPENY0f+UGyKOs=;
        b=aqN3v6anLrvITmAbjc1d1DzUQF/M/YcTZfMr4L5nuAIktYMdA4EcZaj4MUYOEvxBgk
         15CkkM40JUHfu9avC8wRHAU0odxf4IdLEg+RbPfppLOa3vGGpONyF9OSkKssoE+FcRgu
         ZA/tXx244rBCWKTih096k02NJ8hOAppyhp/c8Ildh6rEVYTcxqdLIxWx8oOBQ1qOuxj4
         mW6TjMFlAS8nEDegoj1S+B0bs6jtNTCNmRiL/SpoBhRBqTEI2EvqRywwsN9wwu+BJJ27
         2FnlfSgDkj+jYLG6y6+NNn0sf82lc02d/ACoU7mEwZVZmon+CQTBCHhVwGbJaVQVU/ZQ
         yG2A==
X-Gm-Message-State: AOAM5335EHV+nG7n7BbqsjW6Ac1hwHPRu8cpL7UF2keFfMS2v8Iyzu1j
        AjdjiZiJ98LX3fY3GInezzVZ3RMbKj8hUy8EKxZZ4jFj9UC/bn8SeOvv4T3OFV/PZoLtAEl2TPC
        VUhqNsYrnlztprnX+5s+QMKUE6b7ULZRApGqByaaMTw5KLaV/k9Cx9BmTsp937cDBnFcBRAd/gg
        RvfVbeYLAWU9w=
X-Google-Smtp-Source: ABdhPJzbCjkeGeJiJN7Ji4I7RFmD046LopJXicTfSSBqwjLOb3vgD3tUfoE0g6891FnPeHmEi7zOFZZmMC0Pw2jLwQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ad88:abe:9fd5:a5fc])
 (user=howardchung job=sendgmr) by 2002:a25:cf90:: with SMTP id
 f138mr10630786ybg.421.1617272735031; Thu, 01 Apr 2021 03:25:35 -0700 (PDT)
Date:   Thu,  1 Apr 2021 18:24:44 +0800
In-Reply-To: <20210401102447.3958224-1-howardchung@google.com>
Message-Id: <20210401182328.Bluez.5.Ie6faf8aa794d1df17758bd5bd693d13fed68e85d@changeid>
Mime-Version: 1.0
References: <20210401102447.3958224-1-howardchung@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH 5/8] audio: Remove Media1 interface when a2dp source disallowed
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When A2DP source profile is not allowed by policy, we remove the
a2dp_server and everything inside the object, which also release all
MediaEndpoints and MediaPlayer. When admin re-allowed A2DP source
profile, although we recreate the a2dp_server, clients are not able to
know they can register their endpoint and player now.

This patch handle this case by unregistering Media1 interface
when we remove a2dp_server, and register it back when a2dp_source is
allowed.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 profiles/audio/a2dp.c  | 2 ++
 profiles/audio/avrcp.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d31ed845cbe7..26d4f365207e 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -3275,6 +3275,7 @@ static int a2dp_source_server_probe(struct btd_profile *p,
 {
 	struct a2dp_server *server;
 
+	media_register(adapter);
 	DBG("path %s", adapter_get_path(adapter));
 
 	server = find_server(servers, adapter);
@@ -3315,6 +3316,7 @@ static void a2dp_source_server_remove(struct btd_profile *p,
 		return;
 
 	a2dp_server_unregister(server);
+	media_unregister(adapter);
 }
 
 static int a2dp_sink_server_probe(struct btd_profile *p,
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 05dd791ded7c..c25495f19492 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4735,6 +4735,8 @@ static void avrcp_controller_server_remove(struct btd_profile *p,
 
 	if (server->tg_record_id == 0)
 		avrcp_server_unregister(server);
+
+	media_unregister(adapter);
 }
 
 static int avrcp_controller_server_probe(struct btd_profile *p,
@@ -4745,6 +4747,7 @@ static int avrcp_controller_server_probe(struct btd_profile *p,
 
 	DBG("path %s", adapter_get_path(adapter));
 
+	media_register(adapter);
 	server = find_server(servers, adapter);
 	if (server != NULL)
 		goto done;
-- 
2.31.0.291.g576ba9dcdaf-goog

