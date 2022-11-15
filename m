Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C365C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 00:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiKOAay (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 19:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiKOAax (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 19:30:53 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8643ED11D
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:52 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 130so11764941pgc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHrC1F4+KBRIi+HxhoVrcBzerWPZKq0dFT3HGWGGLfA=;
        b=EfehzetrgJb3bXqNWZIPZsh3Wck0iKDlzNkHmqqy7bgHyVg4+YjTCVnCWyWVNoRHxr
         LZsGiQya/PFdhw9H5Sr1ruXBrNnw75WEWPYDl0LWGqq2j7ccKoOPd7Srvh+XfXZkuw61
         HvWUATUfXgbs50axDf0W+n2kO9bNCieUgs6373DABC2b4EyWBcuN5dScHo2pxZ6HyaOJ
         vzwSfRWYYQulqyrDUI+CKFeTsnl/SyDQidikCOtTnMMdfi/XD4DNXEmAyLkafrEMlOPq
         O84Vuenee1Gj9svRyU++GOjW5Demubgorl51rnVdBi4CCFgm2/0jnQPKefRWdJ3mzmBm
         cj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHrC1F4+KBRIi+HxhoVrcBzerWPZKq0dFT3HGWGGLfA=;
        b=PhY0WeBpug2xukWxyVwhEOcVHaFPFIojncH73SpytaiA6b3mQx8Lfv62QRUjUPJC9m
         Y1hbNNPAU9IuONivgZuz9alUfB8MVw/XbVkGal36RoVp6QDdVppDX7G3c3k0h1qpLvJM
         jYLBJjdmMCPLxIUXZLnCnOyDiak3otPjzDdqwDVyKHp+lQSQ0pgYBVo8U7BeXTUEwWmW
         //CLuiXsHrFcSQiVmbwaGlXnqXJUtnjZcMuynBdONlodNgzX5dJLJ/nVOHyi8lxoIfA6
         64g4kJMESGDizl1d75wL2+5UjHqc/eZjgNgD//XrP7f4eyt1XgR6egC5d0EsZ5u00880
         +8nw==
X-Gm-Message-State: ANoB5pkfdUTLR7XtDPnfxON8sbP2Ffh7qhEfxnBfsIyijMNTQnieS8rA
        rzNVh+eLZuOuH/CupvZpI61a/9hYOes=
X-Google-Smtp-Source: AA0mqf626L8alM7Im4VmsmTy1x5fvBzBaNTCzQfxeypFasiU0BV8KP2cHtUXKKPucfAtfxCVWvblXw==
X-Received: by 2002:a63:310a:0:b0:46f:3a91:361c with SMTP id x10-20020a63310a000000b0046f3a91361cmr173755pgx.261.1668472245113;
        Mon, 14 Nov 2022 16:30:45 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a3d0300b0020a28156e11sm10307888pjc.26.2022.11.14.16.30.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:30:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] shared/tester: Add tester_io_set_complete_func
Date:   Mon, 14 Nov 2022 16:30:36 -0800
Message-Id: <20221115003038.2134340-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221115003038.2134340-1-luiz.dentz@gmail.com>
References: <20221115003038.2134340-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tester_io_set_complete_func which can be used to set a
callback when all iovec has been sent/received.
---
 src/shared/tester.c | 16 ++++++++++++++++
 src/shared/tester.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index e88dfabdc37c..1feaba48335c 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -89,6 +89,7 @@ struct test_case {
 	tester_data_func_t test_func;
 	tester_data_func_t teardown_func;
 	tester_data_func_t post_teardown_func;
+	tester_data_func_t io_complete_func;
 	gdouble start_time;
 	gdouble end_time;
 	unsigned int timeout;
@@ -913,6 +914,9 @@ static bool test_io_send(struct io *io, void *user_data)
 
 	g_assert_cmpint(len, ==, iov->iov_len);
 
+	if (!test->iovcnt && test->io_complete_func)
+		test->io_complete_func(test->test_data);
+
 	return false;
 }
 
@@ -937,10 +941,15 @@ static bool test_io_recv(struct io *io, void *user_data)
 
 	g_assert_cmpint(len, ==, iov->iov_len);
 
+	if (memcmp(buf, iov->iov_base, len))
+		tester_monitor('!', 0x0004, 0x0000, iov->iov_base, len);
+
 	g_assert(memcmp(buf, iov->iov_base, len) == 0);
 
 	if (test->iovcnt)
 		io_set_write_handler(io, test_io_send, NULL, NULL);
+	else if (test->io_complete_func)
+		test->io_complete_func(test->test_data);
 
 	return true;
 }
@@ -1004,6 +1013,13 @@ void tester_io_send(void)
 		io_set_write_handler(ios[1], test_io_send, NULL, NULL);
 }
 
+void tester_io_set_complete_func(tester_data_func_t func)
+{
+	struct test_case *test = tester_get_test();
+
+	test->io_complete_func = func;
+}
+
 int tester_run(void)
 {
 	int ret;
diff --git a/src/shared/tester.h b/src/shared/tester.h
index c28f61e7fd6b..49610185a444 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -78,3 +78,4 @@ void tester_wait(unsigned int seconds, tester_wait_func_t func,
 
 struct io *tester_setup_io(const struct iovec *iov, int iovcnt);
 void tester_io_send(void);
+void tester_io_set_complete_func(tester_data_func_t func);
-- 
2.37.3

