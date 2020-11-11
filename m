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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00B1C388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A034C205ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA5C5TAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgKLBdQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgKKXG3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 18:06:29 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3437AC061A4A
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:35 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k7so1769632plk.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=83p4V2mr5pRBnhwAKvGaj5JJU8zNRKrOY+gpm6vhs1c=;
        b=ZA5C5TAJA6I+ikGjRKPBEnIT/b23oToZRItTUcJ7mHTo9h8Qjhe71lznltYqjkbhB9
         JkZ/vYqdvArMgOpCaFn8b/ouu5jQov6DkOruh87NgPg77Z6l+xvEOjuPsneGiaN4H/xS
         7VOSYljEZ+/PjuEa8fhotQpVQ6BCJvavI6/dLWJLZ0tR8VNS1u41CAN3dccSk272gC+Z
         VJCSvbdDhZxFUISS6mkyhEnVf6HTN4Q7pMqv8sGO3vl8djevnH6tWeHkdoU9JG1DDrzS
         CRAox9tAlxDxRi733lKn7TfZzJ3Um+54wNUHChu8yLi9sWXNAgru65rWocJFk4ZYrjxQ
         wMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83p4V2mr5pRBnhwAKvGaj5JJU8zNRKrOY+gpm6vhs1c=;
        b=B3mhj0Gtb08g9ionVsr7cFJAsvurdPEvf0cseojgA45WASh5SVTe27tnfRRbxOW5te
         1cT+7jtIUBys04OgZccGaUzj7Aa6CjXTeHhazH/Lp1mNu50ZHUqzsmjH1LZ9M+OXj522
         vmcYE+O4z5oaToQHjWVec4Jamsd+AIaP1kw4ewFH+VgJ/v6Fp669P9N8mIKbmqhNrXfX
         VP5joKU8r5qlAbX3kiZd57qDLNA7M7VBoWQkLl0kom1lrNSBV1YLGKBi2DvvF49Y0qpP
         CDjamTRHYauIz0UZBzyAFgU2bC6BMM9E0DHgt9S5OTGf4BNW1CJ53YuO3FwSv9LJZcWW
         QY7Q==
X-Gm-Message-State: AOAM532qPgn4kjgApjM/kGo9MlWSbiGga91IfjL2oez5ArHQjgQg/alH
        TwTa7mej6etKB3w+816ZkuTgn/21eCp+wA==
X-Google-Smtp-Source: ABdhPJzf1L1UHYYgSeZHtS2cS0QjebiNNC4P5zIyMYnERjASN7C+wA6ZoJJ6LEtN00c+l3kvrleePw==
X-Received: by 2002:a17:902:b688:b029:d6:ad52:ffab with SMTP id c8-20020a170902b688b02900d6ad52ffabmr12647461pls.61.1605135874525;
        Wed, 11 Nov 2020 15:04:34 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n27sm3867767pfq.59.2020.11.11.15.04.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:04:33 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] hciemu: Fix crash when test is aborted during pre setup
Date:   Wed, 11 Nov 2020 15:04:20 -0800
Message-Id: <20201111230421.3364932-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111230421.3364932-1-luiz.dentz@gmail.com>
References: <20201111230421.3364932-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the tester_pre_setup_failed is called all timeout related to the
test must be cancelled as the test should have been freed by the
application and the next test is about to start.
---
 emulator/hciemu.c   | 8 +++++++-
 src/shared/tester.c | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index fd6029deb..961de6359 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -43,6 +43,7 @@ struct hciemu {
 	guint host_source;
 	guint master_source;
 	guint client_source;
+	guint start_source;
 	struct queue *post_command_hooks;
 	char bdaddr_str[18];
 
@@ -297,6 +298,8 @@ static gboolean start_stack(gpointer user_data)
 {
 	struct hciemu *hciemu = user_data;
 
+	hciemu->start_source = 0;
+
 	bthost_start(hciemu->host_stack);
 
 	return FALSE;
@@ -353,7 +356,7 @@ struct hciemu *hciemu_new(enum hciemu_type type)
 		return NULL;
 	}
 
-	g_idle_add(start_stack, hciemu);
+	hciemu->start_source = g_idle_add(start_stack, hciemu);
 
 	return hciemu_ref(hciemu);
 }
@@ -378,6 +381,9 @@ void hciemu_unref(struct hciemu *hciemu)
 
 	queue_destroy(hciemu->post_command_hooks, destroy_command_hook);
 
+	if (hciemu->start_source)
+		g_source_remove(hciemu->start_source);
+
 	g_source_remove(hciemu->host_source);
 	g_source_remove(hciemu->client_source);
 	g_source_remove(hciemu->master_source);
diff --git a/src/shared/tester.c b/src/shared/tester.c
index 0c31e8b1c..af33a79cd 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -541,6 +541,11 @@ void tester_pre_setup_failed(void)
 	if (test->stage != TEST_STAGE_PRE_SETUP)
 		return;
 
+	if (test->timeout_id > 0) {
+		g_source_remove(test->timeout_id);
+		test->timeout_id = 0;
+	}
+
 	print_progress(test->name, COLOR_RED, "pre setup failed");
 
 	g_idle_add(done_callback, test);
-- 
2.26.2

