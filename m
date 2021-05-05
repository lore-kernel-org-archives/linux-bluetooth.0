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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2725CC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 09:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1024613BA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 09:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhEEJEk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 05:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhEEJEj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 05:04:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93022C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 02:03:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l9-20020a5b0b890000b02904f7fb53ca12so1610056ybq.15
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v4sIB7CW7eNqeHRknNb8xK7/J/zKawxOJQD/udkqmgA=;
        b=cYChisl7CcWE/0SLjnyVgBHCAuAdt9JaMNHSrQ53nqmA1Qkag/t35Pruer/gHmsBF5
         8NKecFvATSWATTJjYxK4XTu43IjZkmHW42X4K9dUu2ZwzoTR9uDl2wjKuuUtdoB/fH5c
         c+Eg/xD7dvGp317dBEilL82LKoLM8e8jfATTnR+A5v45h7YEhVzm2OGivR+kAFQFsSZG
         A8Cm1DDbwQlA8CJMfySiaimKhuwsMEZF9haj9vYA7iVf6UytBgS/orpsyym3eHrbyjMF
         YEUIsTGRKDdzsmUo7DZfkz0zR3in2RNhyqazsapqvgBrYcgOCIdpAa8imP/kNKcwSG50
         2fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v4sIB7CW7eNqeHRknNb8xK7/J/zKawxOJQD/udkqmgA=;
        b=GWXxRxpnsSU8OWWB2F/MTsQUxhASrut4AWFbZX1gCsPdx0JfjjFolfcZNKb3Sp8zX+
         D72KIcDpIXM8QhUy78pgFFzJRh7dgvisPsrVQn3OJ7zrdfLW4qXL40jFFJkIWk/EYFd/
         0Iguiziknc3mCGfPsLl6BLSMhHEt2Sz4RArNo6872HtBv7TuJYUgPqNaP42j5dOUqP8n
         22oWNArGEUaOKuDDH3OWnDdFoq9csS+EhejIFjXVwF321BOuVJmLZ6hqUYFqUDqA4pqg
         Z4g5s79xJg3jo1b1z3x6FzsbGdEYNqg3Ngn6pG8TIY2JoT6fcLurQnQxyMjnaH+2l9L9
         9Cxg==
X-Gm-Message-State: AOAM531NMHxQ/P9fMH4T/jRAksqjWyN1AYEUbWxtpgG6xWXi5GFY1h1Z
        PwINHZ82XfSBft4T7U3cexrzSlSumKaki3ENyAh5BcDSIcLJDS1ZrCp9etlwIXbW2cq5wpQ9B8G
        +I+nrfVzu9EmGvnpIuto3Cs5z/eM3KmEhkoQ7sDZYS5SqZq0MB7pgQqngl2VVw73wmvNQNqH+BH
        +m
X-Google-Smtp-Source: ABdhPJx+hzPHX+JlbNcQ9ggPRddzgM6Dnwpan8j9yZMK0Mxd95IqXPXVKqRUUYhkONcMZw/goMWFdh76Y1qB
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:7d20:5af0:80ac:f978])
 (user=apusaka job=sendgmr) by 2002:a25:ce51:: with SMTP id
 x78mr32152415ybe.87.1620205420779; Wed, 05 May 2021 02:03:40 -0700 (PDT)
Date:   Wed,  5 May 2021 17:03:30 +0800
In-Reply-To: <20210505170318.Bluez.v2.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
Message-Id: <20210505170318.Bluez.v2.2.Ifd899edb45d3800750c6d04d6bde30a0115c007f@changeid>
Mime-Version: 1.0
References: <20210505170318.Bluez.v2.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [Bluez PATCH v2 2/2] PRE-UPSTREAM: Makefile.am: Hide test-gobex*
 behind OBEX flag
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

If obex is disabled in the config, running gobex test is unnecessary.
This patch skips gobex tests if obex is disabled.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 2a222167f7..add80dde9e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -492,6 +492,7 @@ unit_test_gdbus_client_SOURCES = unit/test-gdbus-client.c
 unit_test_gdbus_client_LDADD = gdbus/libgdbus-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS) $(DBUS_LIBS)
 
+if OBEX
 unit_tests += unit/test-gobex-header unit/test-gobex-packet unit/test-gobex \
 			unit/test-gobex-transfer unit/test-gobex-apparam
 
@@ -514,6 +515,7 @@ unit_test_gobex_transfer_LDADD = $(GLIB_LIBS)
 unit_test_gobex_apparam_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
 						unit/test-gobex-apparam.c
 unit_test_gobex_apparam_LDADD = $(GLIB_LIBS)
+endif
 
 unit_tests += unit/test-lib
 
-- 
2.31.1.527.g47e6f16901-goog

