Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC449C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23942086B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR8YUe3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23942086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeK2CCf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:02:35 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34696 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbeK2CCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:02:35 -0500
Received: by mail-ed1-f51.google.com with SMTP id b3so22362651ede.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=1z8hfeoTImE2ZD8ctUfhbY1Zqwa/HlWdZkr0u4aC2uM=;
        b=gR8YUe3zAHH8MQ9c/mOqhNmfEeWQiv3FngT1RnvVIoYPqXRTz/liI7+lmKQcAGs+3P
         ciwoVl3kJs6ijeRHJ4DMESna4RHuhq5LGzhJ5ivkiLOZ29vw7ZUlH1LjwHbHhzuPBVAz
         IMbJNKQclC6kIXfKOi+tq2LurBoyr7OnGZuo8LnSkRXK+6oWOpPtoIIfY+hym10y9V+D
         LcIN/XDNVkgdDWCJEWMNSgWhnIGtXWcO3fBvJ2x49tT3GvgM7KdfDkNjQszljncUTbGR
         EjdLoLgeQzTfLwFEvElnV7wtNoNoB+TVI2rr8dvXaMUWqqQdoKh/n6rFvho60zdAikFV
         LJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=1z8hfeoTImE2ZD8ctUfhbY1Zqwa/HlWdZkr0u4aC2uM=;
        b=JIIQbY71cXSwFgLZZ1SVNeYqIgcvAizhO5RX+xelQBzqW+DT3Ggqy0QL2eS3YsU9dN
         9kDOphuXo9k30uVbbHqZtduv3xqybF9rOFQjxP8c+LtgqMLmgW2CVORrS8tdv9MBphjh
         GbZbm59/om1w38bh5dJ7yOZQc4KN+mYyv/gcXU+LV2icOBf7zA03zH3H2qyXEUdYKjJw
         /rDEpcmwyX3ZhD7yskfaYOtxbHpH+8nXrqSQQzhuRqjCqSvmfP2Ov/UmOzCEnGotWZPg
         x59s715/1IsUgw38Y+fXN5dHwPYh63yhWldKyZGDIkpgNytmLkKBt7YTbp+WT0vCPbLM
         awSg==
X-Gm-Message-State: AGRZ1gIijWokOQMf8bztjVgumQ7JXVaoC+o0gg4H3PvutHlnn3ji/D8S
        JYb9zY+8c488SDVadyyZuLmsafQL
X-Google-Smtp-Source: AJdET5eJJIocoVWEStYKjuzVrI2usYew9U2VQRLcyxZfVnQqtef2KpZCO10f1xC7rzd0Foh4DCPZFw==
X-Received: by 2002:a17:906:228d:: with SMTP id p13-v6mr27125325eja.159.1543417237010;
        Wed, 28 Nov 2018 07:00:37 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z2sm1869327edd.4.2018.11.28.07.00.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 07:00:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] core: Make use of mainloop_run_with_signal
Date:   Wed, 28 Nov 2018 17:00:22 +0200
Message-Id: <20181128150023.1576-9-luiz.dentz@gmail.com>
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
 src/main.c | 64 +++---------------------------------------------------
 1 file changed, 3 insertions(+), 61 deletions(-)

diff --git a/src/main.c b/src/main.c
index 7ab1349cc..67eb6ac59 100644
--- a/src/main.c
+++ b/src/main.c
@@ -497,24 +497,11 @@ static gboolean quit_eventloop(gpointer user_data)
 	return FALSE;
 }
 
-static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
-							gpointer user_data)
+static void signal_callback(int signum, void *user_data)
 {
 	static bool terminated = false;
-	struct signalfd_siginfo si;
-	ssize_t result;
-	int fd;
 
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
-		return FALSE;
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
 		if (!terminated) {
@@ -532,46 +519,6 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 		__btd_toggle_debug();
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
-	sigaddset(&mask, SIGUSR2);
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
 
 static char *option_debug = NULL;
@@ -682,7 +629,6 @@ int main(int argc, char *argv[])
 	uint16_t sdp_mtu = 0;
 	uint32_t sdp_flags = 0;
 	int gdbus_flags = 0;
-	guint signal;
 
 	init_defaults();
 
@@ -711,8 +657,6 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	signal = setup_signalfd();
-
 	__btd_log_init(option_debug, option_detach);
 
 	g_log_set_handler("GLib", G_LOG_LEVEL_MASK | G_LOG_FLAG_FATAL |
@@ -781,12 +725,10 @@ int main(int argc, char *argv[])
 	mainloop_sd_notify("STATUS=Running");
 	mainloop_sd_notify("READY=1");
 
-	mainloop_run();
+	mainloop_run_with_signal(signal_callback, NULL);
 
 	mainloop_sd_notify("STATUS=Quitting");
 
-	g_source_remove(signal);
-
 	plugin_cleanup();
 
 	btd_profile_cleanup();
-- 
2.17.2

