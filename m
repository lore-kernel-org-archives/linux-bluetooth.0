Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4525DC00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7E420728
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTndDfsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgKEGaN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgKEGaM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 01:30:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C3C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 22:30:12 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z125so745492pfc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 22:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AiMlLJgHixAXDnCP8ZY72ZbeqLVurDL36FqDlebGM/8=;
        b=tTndDfsyZKEguKJQxnALqnG9KJjuoGXlHY5KFCfuoJ+XTVg+OWf46kBK+AwVXXWnOO
         BL0O8lpoRwJ2UjhXQpR4etHyMel2QOHlW3l+lj54PiUO1WmzTb9Oce08wTbY2cjpTxab
         LNDSUVfBqLRNuYIeojrKeD25nbrgA5F7VftXMIi/ykw5BsDrz1C1hOOMjeJ02XIimPFS
         HbgEQzxwU9Fr2bl3EAyYpEwt4Ab71blIcDnS1gGr0jfBqvlIzV/0HYFWTtdT+glKRipX
         1EY42lzxDyD1DgCkYqtTZBOT1UEhe2LsrUMMYoVAwPL0H65YEU7icJGUPPnpsyYNL0H/
         8G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AiMlLJgHixAXDnCP8ZY72ZbeqLVurDL36FqDlebGM/8=;
        b=GtfYpXN008u4HYjBmgHymUo/0J6L80JbMNh7mtxMj6XTg2jlligPIiz/orMSBtPcPK
         xk6CI2hi1MIZvwqDnUYSIhpg3Vva6JjiVJbv4A1SvuBx9IWsF+cgxVJjZDx3W2oEGLw4
         g1AO3KBTg5iv5jJ3Vd6/nYLql7pBYnK5KXhtf3b2XcDe8YTFGw/+wS/DjHegQm7RCWfC
         jPckN0Nr5fwEABRYA9oxc96iC3o4Bb8IxP1leY8iANSJsp/87mOl6+LVI8vpqsznytcJ
         xz0hTaQ91soGjCroAlYxnbkcPe8EgjNjqfufqFITmOX6SkhFU5LuOkFAjH+RJ1+n5WYE
         zB4w==
X-Gm-Message-State: AOAM531cdogfcCEeWapMxynw3Y7Gc62pZjsZqeN8UnVNGt0Bu0Cx54cB
        oIE8UalOCVavFhN/5eiXIEtx8OKr0x8zC0j/1dG/aSZEcN4fSpv66PrYWzVMmxaApxQ9Fap+7Yu
        UJmg7wz6XEzqjsYDUMNao2P27Xgwo6DCX+mwVasatk9JvPYoZaqWLqcRnngZHmiGTBJhVBl9lt1
        PU
X-Google-Smtp-Source: ABdhPJw0s1uOovkKt/nW0FF42M9I+DtmEj4TkGxeYO3QYBJgCVLhhQEZHKEdWQmcy5mLYPQMKXnd1xO0IqSS
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:aa7:8616:0:b029:18b:421b:9168 with SMTP id
 p22-20020aa786160000b029018b421b9168mr661665pfn.33.1604557811679; Wed, 04 Nov
 2020 22:30:11 -0800 (PST)
Date:   Thu,  5 Nov 2020 14:29:52 +0800
In-Reply-To: <20201105142838.Bluez.v2.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Message-Id: <20201105142838.Bluez.v2.2.I4c872b9b8fdee53a335db41acbb6e59fe9692cc5@changeid>
Mime-Version: 1.0
References: <20201105142838.Bluez.v2.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v2 2/3] audio: unref session when failed to setup
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

There is a possibility to miss unref-ing when source/sink fails at
setup.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

(no changes since v1)

 profiles/audio/sink.c   | 5 ++++-
 profiles/audio/source.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 134d157bc6..d672670e25 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -258,8 +258,11 @@ gboolean sink_setup_stream(struct btd_service *service, struct avdtp *session)
 
 	sink->connect_id = a2dp_discover(sink->session, discovery_complete,
 								sink);
-	if (sink->connect_id == 0)
+	if (sink->connect_id == 0) {
+		avdtp_unref(sink->session);
+		sink->session = NULL;
 		return FALSE;
+	}
 
 	return TRUE;
 }
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index fca85d4cb3..c706c928a7 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -259,8 +259,11 @@ gboolean source_setup_stream(struct btd_service *service,
 
 	source->connect_id = a2dp_discover(source->session, discovery_complete,
 								source);
-	if (source->connect_id == 0)
+	if (source->connect_id == 0) {
+		avdtp_unref(source->session);
+		source->session = NULL;
 		return FALSE;
+	}
 
 	return TRUE;
 }
-- 
2.29.1.341.ge80a0c044ae-goog

