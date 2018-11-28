Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF564C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8473420832
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1Dp/NK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8473420832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeK2CCh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:02:37 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:38198 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbeK2CCh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:02:37 -0500
Received: by mail-ed1-f46.google.com with SMTP id h50so22360655ede.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=JXXjmIgavMvtFtRUv6OwGMZ86tpCdnE6J55gHO7BG9M=;
        b=F1Dp/NK+a7IokUVEQRDx31PQgyRYjPr5RJPb2pH4cvcdc/emf9+X+ySx6xXZCfg5NY
         7BvbFPXAlINtJ6/0LrlIWrzBhoP/4g/xteLaqs6dmN1Eq6SjUXFYI6dlEeir3wKN9kkK
         RDKanWGK7yzzW8Lwl2R35+hCjAf/cBk7YSDYazEvY8iD1EhE7oBt+qDlMsSVHa3OJsa+
         wtiT11NRIh00STGDPqU2qNZoF0Poo4AjAO6F6ADRSVBKBZGEcMM53en6bGcrE+CFrput
         rJZYAmqt2gm5bovjb+6T+8LvW5Wy0Ux8EvNaZ7xkI8ufjt7ZR2c1GmRM25hGB+haGN+f
         FoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=JXXjmIgavMvtFtRUv6OwGMZ86tpCdnE6J55gHO7BG9M=;
        b=gJf6gmgXLgLdZviGStNd6PLuUOXZWaJTr/swBKL3G/hNIy9I7oA66Ru9Kw7k/DP/9I
         htlQe/bIgSB1sJq8WNhM8qJfBBYVIh7ZtG7J9/aGIRNRXU6c1aiL6vUSX4Kx3Iow851s
         0rQXuvKmTtwNhMW7EKkrr+4j9nXBvck1U68l37qdtrO69uo/o86Q+XMjQeB97Bbo9mCv
         0Bt5S5rmKqZ5MVntKYoa/bbBep2IB/50EciUfv79yh4ZqtqCBMJObMCrryQm6qudpCNf
         leIUgdqDUwRqhn5+AcNC71t7kRjlntv/L6D5iHdJh2StJmNZxrwpOg9ZAv+WdWGn3QD5
         3lzA==
X-Gm-Message-State: AGRZ1gIaHdD393CllkuMV9jmVZ9QjbgU7PW9Jp6cynh+5lZvfc47Kfdm
        SXybjKPMuNdtz4BhwXbZwXQWPtQj
X-Google-Smtp-Source: AJdET5cNIhFIwPQfHGwEQ8/3HLSKRx9cN6jZVEcJRPw28+AENe1JshF3cqt8yN4sJce/NnqCu+eIlQ==
X-Received: by 2002:a17:906:590a:: with SMTP id h10-v6mr27747723ejq.102.1543417238638;
        Wed, 28 Nov 2018 07:00:38 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z2sm1869327edd.4.2018.11.28.07.00.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 07:00:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/10] shared/tester: Make use of mainloop_run_with_signal
Date:   Wed, 28 Nov 2018 17:00:23 +0200
Message-Id: <20181128150023.1576-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181128150023.1576-1-luiz.dentz@gmail.com>
References: <20181128150023.1576-1-luiz.dentz@gmail.com>
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

