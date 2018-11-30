Return-Path: <SRS0=rlJ7=OJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717ECC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387642145D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTlwTMsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387642145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeK3V3T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:29:19 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:36521 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeK3V3S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 16:29:18 -0500
Received: by mail-lj1-f170.google.com with SMTP id g11-v6so4510535ljk.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Nov 2018 02:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=JXXjmIgavMvtFtRUv6OwGMZ86tpCdnE6J55gHO7BG9M=;
        b=rTlwTMsVGxQuFMKnVf/lsrbuOd51AvgjuGRZiRBMhE9FrTTIB3Ee4AtYB2awaNP+Rs
         jmLnYIGVbkOyAKlEgL333z1bLC8663WouvyudhcGZ39ieYhF7pUMdJ8r8XmqvVD2/aP8
         FN4mNDmo/C2KFQ3cFZCnnwYX+Ff51VQOlZk9RP8on0tgi2y6/J3mPirKCsAOXxTKZL4a
         gyENjSaMV2aBEBYzFmDH/RzQNOYxXsSa8xoGVOE3IccibO5IDWndS2/8Q8A4eIvPksHA
         JaMMVLGaGrX5Ee6xO3DNwv7bluoSoA6bS9pSC84NqUgQ5czSCNHM6TPW9b4e9gHE7lyo
         IimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=JXXjmIgavMvtFtRUv6OwGMZ86tpCdnE6J55gHO7BG9M=;
        b=V9lpdv6TlsnE9cMHdHcdkJOJoZSfl4Q3tXcLiYQVtd5Sskgti7ZwtkOLRHLIl8Hohl
         Fkvu3mjRi2/3UWdLKM+sfj4pWXhDvjx3a1G9BFEqUfq5/WzBOgKbU2OsEUDq3t+/Ua5k
         wacK6oqVwpM0CS6V8CsVaL6Zw8/fL3IhRYsATEDWdZifCgZLhjM52eZ/rrsQceIwaasx
         F4vl5ygRaJBB5fGzKUONdBpsp/O76sI9gFdS0cOQHU/O4/VNmMcp56FSsCM3aK3M2OfK
         FR29e0ADtUs90gQ35sVJ21yXsx4kIJfBUnNGNU6OnQ/s+qyqUsFFdB0VYrwdwx7XsCpb
         GbNQ==
X-Gm-Message-State: AA+aEWZCiPhHWkdY0M8PuyAqQNS5uWudziglLensK3PUYFe3JE1Vb7gp
        Lpa/SHQT5x71jKeoCl49UIitLuTx16I=
X-Google-Smtp-Source: AFSGD/UIGzGlSd9ot0N+MGPAngYJW7grlJdq9Wds4V1wm6VsslV0X3DVstR4mg/qfaycTICjVgCLPQ==
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr3461745lji.57.1543573227868;
        Fri, 30 Nov 2018 02:20:27 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id i127-v6sm707708lji.3.2018.11.30.02.20.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:20:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 10/10] shared/tester: Make use of mainloop_run_with_signal
Date:   Fri, 30 Nov 2018 12:20:13 +0200
Message-Id: <20181130102013.29023-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130102013.29023-1-luiz.dentz@gmail.com>
References: <20181130102013.29023-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This don't require setting up signalfd.
---
 src/shared/tester.c | 79 +++++----------------------------------------
 1 file changed, 8 insertions(+), 71 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 168d0de91..3d79e411d 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -44,6 +44,7 @@
 #include <valgrind/memcheck.h>
 #endif
 
+#include "src/shared/mainloop.h"
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
 #include "src/shared/log.h"
@@ -105,7 +106,6 @@ struct test_case {
 	void *user_data;
 };
 
-static GMainLoop *main_loop;
 static char *tester_name;
 
 static GList *test_list;
@@ -463,7 +463,7 @@ static void next_test_case(void)
 	if (!test_current) {
 		g_timer_stop(test_timer);
 
-		g_main_loop_quit(main_loop);
+		mainloop_quit();
 		return;
 	}
 
@@ -778,73 +778,19 @@ void tester_wait(unsigned int seconds, tester_wait_func_t func,
 	print_progress(test->name, COLOR_BLACK, "waiting %u seconds", seconds);
 }
 
-static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
+static void signal_callback(int signum, void *user_data)
 {
 	static bool terminated = false;
-	struct signalfd_siginfo si;
-	ssize_t result;
-	int fd;
 
-	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	fd = g_io_channel_unix_get_fd(channel);
-
-	result = read(fd, &si, sizeof(si));
-	if (result != sizeof(si))
-		return FALSE;
-
-	switch (si.ssi_signo) {
+	switch (signum) {
 	case SIGINT:
 	case SIGTERM:
 		if (!terminated)
-			g_main_loop_quit(main_loop);
+			mainloop_quit();
 
 		terminated = true;
 		break;
 	}
-
-	return TRUE;
-}
-
-static guint setup_signalfd(void)
-{
-	GIOChannel *channel;
-	guint source;
-	sigset_t mask;
-	int fd;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
-		perror("Failed to set signal mask");
-		return 0;
-	}
-
-	fd = signalfd(-1, &mask, 0);
-	if (fd < 0) {
-		perror("Failed to create signal descriptor");
-		return 0;
-	}
-
-	channel = g_io_channel_unix_new(fd);
-
-	g_io_channel_set_close_on_unref(channel, TRUE);
-	g_io_channel_set_encoding(channel, NULL, NULL);
-	g_io_channel_set_buffered(channel, FALSE);
-
-	source = g_io_add_watch(channel,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				signal_handler, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
 }
 
 bool tester_use_quiet(void)
@@ -897,7 +843,7 @@ void tester_init(int *argc, char ***argv)
 		exit(EXIT_SUCCESS);
 	}
 
-	main_loop = g_main_loop_new(NULL, FALSE);
+	mainloop_init();
 
 	tester_name = strrchr(*argv[0], '/');
 	if (!tester_name)
@@ -911,25 +857,16 @@ void tester_init(int *argc, char ***argv)
 
 int tester_run(void)
 {
-	guint signal;
 	int ret;
 
-	if (!main_loop)
-		return EXIT_FAILURE;
-
 	if (option_list) {
-		g_main_loop_unref(main_loop);
+		mainloop_quit();
 		return EXIT_SUCCESS;
 	}
 
-	signal = setup_signalfd();
-
 	g_idle_add(start_tester, NULL);
-	g_main_loop_run(main_loop);
-
-	g_source_remove(signal);
 
-	g_main_loop_unref(main_loop);
+	mainloop_run_with_signal(signal_callback, NULL);
 
 	ret = tester_summarize();
 
-- 
2.17.2

