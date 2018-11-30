Return-Path: <SRS0=rlJ7=OJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF352C64EB4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F1D2145D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXF4KS0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F1D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeK3V3R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:29:17 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:45833 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeK3V3R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 16:29:17 -0500
Received: by mail-lj1-f177.google.com with SMTP id s5-v6so4481807ljd.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Nov 2018 02:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=1z8hfeoTImE2ZD8ctUfhbY1Zqwa/HlWdZkr0u4aC2uM=;
        b=EXF4KS0baNxXYBMXFfSMXQitXC88C4WiJolriJFB2KqShg1lDRH5Q42AJnXpTQ/pU4
         pyWKNG5iEuPeUcqVxZIEiqByEH7KAJTFFl19AyXPdHUypo11uIIYoKfW/DVM08nyxDG+
         grxd9UlGqQZ6chbXjDkLGv0MrZh+U8vuxPHqiyPRDmax4581A0qznH91OSuNIRi3v5dp
         yWKKVAfgSjNO9LuMj5KNwOEGC1woyOBd1A7NRm0Qtd1tqBeoV71YJch0MNYPqjD9PWem
         6bGfFOL1lnpUMND5fE4ZEBe1VSays0GhcczRpNSCI8nktsjav1CmDTGCDJtMjE0D+1L4
         kZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=1z8hfeoTImE2ZD8ctUfhbY1Zqwa/HlWdZkr0u4aC2uM=;
        b=GTX1fvXHK4r6BqsxV2znHSawkA5I1ZbyDPvaWMI6rtCVSBxRuLwnkseuKeqH2tHlOw
         rMkmXYroOrArlWK7jNxhOPU5p4rOscjAmu/7cee6ZsTX63dTBuDJTHady3E6+rQoD7Qm
         9O6kk/24Yszso2xbx5pMXWSgLIXKFLEiHq4lOJLathYrDBl+wnhorS+B7GAHzJsJUM/X
         RKpDhRMxWY5KHPVmi9Sm0Ub0Sm+rVWLk2HBw8fU9ku518LLKcep3Vvewy/3/1rlulsrz
         BYzL4Ojo1kuKj2veTYjBbeDBy2q/vFtFwctjDRxXc+e1JZCrgYlZFKf0wsUDlQRlzNK0
         3b9Q==
X-Gm-Message-State: AA+aEWaFc1M+hB6L7OMjWLCPQNzfrfSVfCj63hPOP4N2+FI5Zojzan/q
        b3WzAbgRVHQVjmDWQS67Nn9imTBsdWk=
X-Google-Smtp-Source: AFSGD/WOR+2nd+oxuWFDySqoQmP+qKumuTJZhhduFOkN/gsDWYcbcbUcqajE0e+NH7WhjYc70OGhdA==
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr1828629ljc.147.1543573226593;
        Fri, 30 Nov 2018 02:20:26 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id i127-v6sm707708lji.3.2018.11.30.02.20.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:20:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 09/10] core: Make use of mainloop_run_with_signal
Date:   Fri, 30 Nov 2018 12:20:12 +0200
Message-Id: <20181130102013.29023-9-luiz.dentz@gmail.com>
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

