Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE2FC61DD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B34320809
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKAfaeBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgKLBdK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgKKXG1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 18:06:27 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4DC061A04
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z3so2675421pfb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DUsmgDMGWi0gwJpZndlTa8QMK8I/mdJWRyhl7CRKULU=;
        b=pKAfaeBmAUJaaz9jLXeL/KXps8oTLQAcvDlfoebETtKjOjyR0K/KmKIUm2Ic0NJ8/m
         mkPi/863S1yHVdTOwgDvSB8T8yrZQdvZYzGpSdLExPQUaH/hyUQddfe4ehL6E277rKRZ
         boLlqKxBOPuG0kRsJXk7zbCzW83JNnKiiGUBumYEM6f6QvszYR5egNxxr3dPoH3tYYeJ
         //6BS1XSX/bxF0scl2UNgnte0hBQqEg6JQt8hvN175mGXJBQ3URAPflRPvHnV8dh3ZXy
         y7jngWvgYjLafRoQPZSgRdxpAriMiOm16DeKvEhISZ58mFiUc3VJQhlkPG0diwO6NImd
         qLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUsmgDMGWi0gwJpZndlTa8QMK8I/mdJWRyhl7CRKULU=;
        b=pWulaQ+Fov1dnSoHdvQaYvdDGwM4Q0k8LHmZkFNojxCrYBqmOQ4D6ILMnmpkEMuZM7
         YT+jPAc6N/o8ZPeZhw2yhyXbFtiFyc+VyaVnmi7OuphPjfWM9B6G53AeTn8B9y8+U13X
         U5XL1CeO4vUoXqORFMws9aQZnGtOkq0cqzcMulK5ekAb2sQo9o+l4bZQhlUhF2g+KvQg
         8kqQshD25yYtWzhb8VawWrgCRuKhTz+yrTViBmI373/scuU18MLInL3Kf1PmX+d8MQOo
         IrZ3YD1DgnZYJ4v6M7Ph4uWj/R+ILqQSmaB1X/ZOVn9ZavxEt5FDauy6EF5q6I1KIPds
         4HlQ==
X-Gm-Message-State: AOAM532jkTdJSQlb4syrunYg7UXqfEP/2bLdiCHZc6VrWmZlZ+0oLJTh
        A32Ok+2E8m2v4Uo6CeaxBVaatj2/yrEpdg==
X-Google-Smtp-Source: ABdhPJy4rkP9hIA+ymodNYAIRjyZONNDZ9IuiYfgRUk9WXYqmbOSpZFyAUrYFK0xGTGAks25LZl8fw==
X-Received: by 2002:aa7:808a:0:b029:160:167d:d332 with SMTP id v10-20020aa7808a0000b0290160167dd332mr13965929pff.1.1605135870596;
        Wed, 11 Nov 2020 15:04:30 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n27sm3867767pfq.59.2020.11.11.15.04.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:04:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] shared/tester: Add option to filter by string
Date:   Wed, 11 Nov 2020 15:04:16 -0800
Message-Id: <20201111230421.3364932-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111230421.3364932-1-luiz.dentz@gmail.com>
References: <20201111230421.3364932-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds option to filter by string which does not require to enter
the entire prefix.
---
 src/shared/tester.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index bd42c8bad..0c31e8b1c 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -106,6 +106,7 @@ static gboolean option_debug = FALSE;
 static gboolean option_monitor = FALSE;
 static gboolean option_list = FALSE;
 static const char *option_prefix = NULL;
+static const char *option_string = NULL;
 
 struct monitor_hdr {
 	uint16_t opcode;
@@ -285,6 +286,12 @@ void tester_add_full(const char *name, const void *test_data,
 		return;
 	}
 
+	if (option_string && !strstr(name, option_string)) {
+		if (destroy)
+			destroy(user_data);
+		return;
+	}
+
 	if (option_list) {
 		tester_log("%s", name);
 		if (destroy)
@@ -804,6 +811,8 @@ static GOptionEntry options[] = {
 				"Only list the tests to be run" },
 	{ "prefix", 'p', 0, G_OPTION_ARG_STRING, &option_prefix,
 				"Run tests matching provided prefix" },
+	{ "string", 's', 0, G_OPTION_ARG_STRING, &option_string,
+				"Run tests matching provided string" },
 	{ NULL },
 };
 
-- 
2.26.2

