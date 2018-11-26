Return-Path: <SRS0=1eqz=OF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD29C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AD920664
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3VlXixg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AD920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeK0DTW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:19:22 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:38764 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0DTW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Nov 2018 22:19:22 -0500
Received: by mail-lf1-f48.google.com with SMTP id p86so14025822lfg.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Nov 2018 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Oju3sZhHflUNHmOIfKSo/6Y5jVeL2uuXI404Ntq2JO0=;
        b=A3VlXixgrOlQn3aOfn4c00AlMoBh9YfoLnwXZ9lG8gPGZWzulQQDpEQ4Ftp3TalZ4T
         NA94iIXRnYooZFj+cSszKjzNG/h+zedxFRYU+kzUwb60ndUbtHRyNPWWwRft5KrANeki
         73vLKnDHDvxOvBj2T8upAtMioHMqMmz/lv3NeCEABmAKLXCpQ20GDORUIvaIM01a/eaj
         9ZCIEvgeFRw6Md9cymwXRiZvJkbKnwfMnbLqraQMJBuDNhSm+vlAaZpqVUL4qauOQQVO
         7tptyIdzr1qGZiYuGiuNdzT+AGa6kioZvZ3Ku7QwftPllhBa68s9L2tX7YMNQjdZU1rd
         n20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Oju3sZhHflUNHmOIfKSo/6Y5jVeL2uuXI404Ntq2JO0=;
        b=qTJQRkr8KHEobwy3PgHqPWJBfY8H/c3LUhB0JDe63pFWO8nHLgzBW7TUc7kk+HUqsF
         VoMAux0sj2e9VxQ8+o9VJRmuorEGdqhOdfeHyezMdug/0Fz7GdYtH+A8cIGvfSHYa4WU
         0NcBQ4Pe/nCt+b5aXUUvSSDlBFVFd5A3+ZBsoFToCw1skVQTC3akplKliM2nxbbg5Epr
         CkBax/vkiF4ncSp4iUxHcZ+yURmQkdVOe1wghRqlT8QPWKVaKJVKeRN3gC1g3/L2YZKv
         92Yx/pN/jfi2yuy99pLMdLhE12A+0Tgm9caLwCC5MFiZX8tfPFB6Jt0KGnu5tCHE7aZH
         jQwA==
X-Gm-Message-State: AGRZ1gJQWrubyWL9hvgkePyVF/TjR7x8Ai8OqEImNcabJG/cWFiEFnVH
        3VsSuoXyAguosO82Tmzlp1LxjgAx
X-Google-Smtp-Source: AJdET5e3EPwOJtE/QrQ6fTotif3hKMPtbZwHfdLGOuR9czdsICk7vx825Pzd/ZYMb0BKWd7aItc0YQ==
X-Received: by 2002:a19:c995:: with SMTP id z143mr14359475lff.79.1543249484729;
        Mon, 26 Nov 2018 08:24:44 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id g70-v6sm120787ljg.92.2018.11.26.08.24.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:24:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] core: Use mainloop_notify instead of sd_notify
Date:   Mon, 26 Nov 2018 18:24:36 +0200
Message-Id: <20181126162438.27872-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126162438.27872-1-luiz.dentz@gmail.com>
References: <20181126162438.27872-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

mainloop_notify takes care of sending the messages to NOTIFY_SOCKET
and includes the handling of WATCHDOG_USEC as well.
---
 src/main.c | 50 ++++++++++----------------------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/src/main.c b/src/main.c
index 4716f5388..f2e0dd050 100644
--- a/src/main.c
+++ b/src/main.c
@@ -51,6 +51,7 @@
 #include "backtrace.h"
 
 #include "shared/att-types.h"
+#include "shared/mainloop.h"
 #include "lib/uuid.h"
 #include "hcid.h"
 #include "sdpd.h"
@@ -59,7 +60,6 @@
 #include "dbus-common.h"
 #include "agent.h"
 #include "profile.h"
-#include "systemd.h"
 
 #define BLUEZ_NAME "org.bluez"
 
@@ -486,11 +486,9 @@ static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
 	btd_backtrace(0xffff);
 }
 
-static GMainLoop *event_loop;
-
 void btd_exit(void)
 {
-	g_main_loop_quit(event_loop);
+	mainloop_quit();
 }
 
 static gboolean quit_eventloop(gpointer user_data)
@@ -524,7 +522,7 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 			g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
 							quit_eventloop, NULL);
 
-			sd_notify(0, "STATUS=Powering down");
+			mainloop_notify("STATUS=Powering down");
 			adapter_shutdown();
 		}
 
@@ -616,7 +614,7 @@ static void disconnect_dbus(void)
 static void disconnected_dbus(DBusConnection *conn, void *data)
 {
 	info("Disconnected from D-Bus. Exiting.");
-	g_main_loop_quit(event_loop);
+	mainloop_quit();
 }
 
 static int connect_dbus(void)
@@ -644,13 +642,6 @@ static int connect_dbus(void)
 	return 0;
 }
 
-static gboolean watchdog_callback(gpointer user_data)
-{
-	sd_notify(0, "WATCHDOG=1");
-
-	return TRUE;
-}
-
 static gboolean parse_debug(const char *key, const char *value,
 				gpointer user_data, GError **error)
 {
@@ -691,8 +682,7 @@ int main(int argc, char *argv[])
 	uint16_t sdp_mtu = 0;
 	uint32_t sdp_flags = 0;
 	int gdbus_flags = 0;
-	guint signal, watchdog;
-	const char *watchdog_usec;
+	guint signal;
 
 	init_defaults();
 
@@ -719,7 +709,7 @@ int main(int argc, char *argv[])
 
 	btd_backtrace_init();
 
-	event_loop = g_main_loop_new(NULL, FALSE);
+	mainloop_init();
 
 	signal = setup_signalfd();
 
@@ -729,7 +719,7 @@ int main(int argc, char *argv[])
 							G_LOG_FLAG_RECURSION,
 							log_handler, NULL);
 
-	sd_notify(0, "STATUS=Starting up");
+	mainloop_notify("STATUS=Starting up");
 
 	if (option_configfile)
 		main_conf_file_path = option_configfile;
@@ -788,26 +778,11 @@ int main(int argc, char *argv[])
 
 	DBG("Entering main loop");
 
-	sd_notify(0, "STATUS=Running");
-	sd_notify(0, "READY=1");
+	mainloop_notify("STATUS=Running");
 
-	watchdog_usec = getenv("WATCHDOG_USEC");
-	if (watchdog_usec) {
-		unsigned int seconds;
+	mainloop_run();
 
-		seconds = atoi(watchdog_usec) / (1000 * 1000);
-		info("Watchdog timeout is %d seconds", seconds);
-
-		watchdog = g_timeout_add_seconds_full(G_PRIORITY_HIGH,
-							seconds / 2,
-							watchdog_callback,
-							NULL, NULL);
-	} else
-		watchdog = 0;
-
-	g_main_loop_run(event_loop);
-
-	sd_notify(0, "STATUS=Quitting");
+	mainloop_notify("STATUS=Quitting");
 
 	g_source_remove(signal);
 
@@ -824,8 +799,6 @@ int main(int argc, char *argv[])
 	if (main_opts.mode != BT_MODE_LE)
 		stop_sdp_server();
 
-	g_main_loop_unref(event_loop);
-
 	if (main_conf)
 		g_key_file_free(main_conf);
 
@@ -833,9 +806,6 @@ int main(int argc, char *argv[])
 
 	info("Exit");
 
-	if (watchdog > 0)
-		g_source_remove(watchdog);
-
 	__btd_log_cleanup();
 
 	return 0;
-- 
2.17.2

