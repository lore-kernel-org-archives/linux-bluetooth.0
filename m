Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5624C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55A5611AB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 10:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhECKFA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 May 2021 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhECKE7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 May 2021 06:04:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF3C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 03:04:05 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m12-20020a170902db0cb02900eede9a042cso518195plx.20
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 03:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zJfC0G3Lz/5UGJXANbR7NBMfeIBJYHLXlTbAaZMoNWc=;
        b=FBGQONzGO0WU8n4RfBUK2B7fGCLXbOLdn4ZMSWOBtXjcvDqXZsg5m0wYxsaZoeDx++
         +ns17QGkkqMPfJdoM5a5K1HqlTSRhhdUAjdvufkCNtDo9aUr0qkEO8kMbHgp1gCLZ9jg
         5tE3VF479d18i2Jij30obd4u/wcGydjKif5SwBaaMC8u7nrGSexhqJCH5zDSp6PQlqB2
         fLTyPooYwAVQColRO0djo/q85AZC28H7LodJ7182IYo8aluxjs22EaLu7N1wVvUtfvBo
         oef6IduBxcFEa44dzFi5be+7BKl+y5wLaERsscbf+IzzYcpwehUpNRBT13x0an0Qcn9M
         yWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zJfC0G3Lz/5UGJXANbR7NBMfeIBJYHLXlTbAaZMoNWc=;
        b=aICXKjIjYqWynm0+FICvQ2t5thyRBPuLNpygzVQB7ZIEdqfrntmHysMEiVTk/DK+ZA
         82t3OsSGzgQDwp2T/Iwa786Lu6sL3jAKE7JOghOZzjVyaCNQVTUL2WjXWaPDvwXQ7KOy
         oKK7wqxJu1ctf3Hm6mJZ7XElpBNH7NzzBY5pNzziIFK9iZZCKS4R2qSEQCyVU0TY++BJ
         VYqjb5o8MQk2dtBERM2kywHrWxex3cdl5qC8Fp8EkAFP1GgNbDDQ9RoTbSTIMn/YhuGd
         qjJEB7SdPxMH6L7dLPxNyUx3Z0avGHwlXwoNmQpCzGt/WEXGernkCaWo7GzzfJmSAbFE
         w6Rg==
X-Gm-Message-State: AOAM533QJR4SKWAVMiz7d3OAJakYeUUTJYUeq0a8GjTbyDowM5K8vi7d
        yDdrnvlPC3n9MMuJ/5YDPPl9KQCLPUg51AI+BoEnfQxPcjRg5sqkYclqjwaMmiH7q9rxEEBfhn1
        /8UlJFlm5phpiu8ts9I48bt3SXvnrb84iTYt+O0ZNSCpZg4YbrtZooJskNuoNCC/BFJYakv192d
        in
X-Google-Smtp-Source: ABdhPJwSh9L4kFMCDZK++2k1ZoET63Agbz4M5ZaCkfa9m1M6teIC0RnSLmnzzoPfuf6F/OsLoML8rNTEShHf
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:5010:35e5:ebd5:76d7])
 (user=apusaka job=sendgmr) by 2002:a17:90a:4593:: with SMTP id
 v19mr29906418pjg.207.1620036244950; Mon, 03 May 2021 03:04:04 -0700 (PDT)
Date:   Mon,  3 May 2021 18:03:44 +0800
Message-Id: <20210503180321.Bluez.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [Bluez PATCH 1/2] unit/gobex: remove timer only when it's not removed yet
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

There are instances where timer is removed because timeout has
occurred, yet we still remove it again by the end of the test. This
causes double removal and prints ugly messages which obscures the
real culprit.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
---

 unit/test-gobex.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 6fbfa183ec..25a3646630 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -266,7 +266,8 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
 	g_main_loop_unref(mainloop);
 	mainloop = NULL;
 
-	g_source_remove(timer_id);
+	if (!g_error_matches(gerr, TEST_ERROR, TEST_ERROR_TIMEOUT))
+		g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_obex_unref(obex);
 
@@ -450,7 +451,8 @@ static void test_cancel_req_delay(int transport_type)
 
 	g_assert_no_error(r.err);
 
-	g_source_remove(timer_id);
+	if (!g_error_matches(r.err, TEST_ERROR, TEST_ERROR_TIMEOUT))
+		g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_source_remove(io_id);
 	g_obex_unref(r.obex);
@@ -551,7 +553,8 @@ static void test_send_connect(int transport_type)
 	g_main_loop_unref(mainloop);
 	mainloop = NULL;
 
-	g_source_remove(timer_id);
+	if (!g_error_matches(r.err, TEST_ERROR, TEST_ERROR_TIMEOUT))
+		g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	if (!r.completed)
 		g_source_remove(io_id);
@@ -612,7 +615,8 @@ static void test_recv_unexpected(void)
 	g_main_loop_unref(mainloop);
 	mainloop = NULL;
 
-	g_source_remove(timer_id);
+	if (!g_error_matches(err, TEST_ERROR, TEST_ERROR_TIMEOUT))
+		g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_obex_unref(obex);
 
@@ -667,7 +671,8 @@ static void test_send_on_demand(int transport_type, GObexDataProducer func)
 	g_main_loop_unref(mainloop);
 	mainloop = NULL;
 
-	g_source_remove(timer_id);
+	if (!g_error_matches(r.err, TEST_ERROR, TEST_ERROR_TIMEOUT))
+		g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	if (!r.completed)
 		g_source_remove(io_id);
@@ -748,7 +753,8 @@ static void recv_connect(int transport_type)
 
 	g_main_loop_run(mainloop);
 
-	g_source_remove(timer_id);
+	if (!g_error_matches(gerr, TEST_ERROR, TEST_ERROR_TIMEOUT))
+		g_source_remove(timer_id);
 	g_obex_unref(obex);
 	g_io_channel_unref(io);
 
@@ -800,7 +806,8 @@ static void test_disconnect(void)
 
 	g_assert_no_error(gerr);
 
-	g_source_remove(timer_id);
+	if (!g_error_matches(gerr, TEST_ERROR, TEST_ERROR_TIMEOUT))
+		g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_obex_unref(obex);
 
-- 
2.31.1.527.g47e6f16901-goog

