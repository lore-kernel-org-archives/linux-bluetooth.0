Return-Path: <SRS0=rlJ7=OJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B5DC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB85C2146D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWJ6cveF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB85C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeK3V3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:29:11 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:35586 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeK3V3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 16:29:11 -0500
Received: by mail-lf1-f51.google.com with SMTP id e26so3732285lfc.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Nov 2018 02:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=D7xxoRm11/BVHccNo+bINx21570pi/iHXf+bl9fsSeo=;
        b=VWJ6cveF5olYxlzj7BgZA45/aB/XMmVLlyDX6amNvtniGzTx39zjdA5O7Z4RrqS4uy
         kzif8vpRZN89P0Z0LkDh8V6coCWGXjNT6Vo/AQetZ9IsVGj7Lg/4LyN6UXhpadAhOi+Z
         1RsZ8mWXq6muQkTRz7AH2WWEAaECBna1INZgaQRv/HwE6P7FqKxizldrFZgT6hEC4QNs
         mVqB11HrPESKovYlXub61zeLssTfx9NSMbQhr2K19XEv0BAQu1Do0njXSaAWcIqPaHGS
         fnJ3MyIyKilCMmY8F22qhjsMDyvbMEaKcOApPYttohJI8rqZ2/XfzsgH8NU52mpOxkSS
         Sl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=D7xxoRm11/BVHccNo+bINx21570pi/iHXf+bl9fsSeo=;
        b=ftYHK6Lo5XwLMew1XNWj2AB4IUWpEEhetDPTS1QGPeWDvJkmDGnOD7eAQqP/VTtyvb
         Kz+f+ZLpWgIP0KfnFotNVNT0ZY8wZMhj2JQKfFRwWr6nJ/uvd/CaPtvLRrbv/mE5ItaZ
         nwio9UUHATvReaokqDjwF9+G5Xj+6ya022qUcQGP38cO71HLlwx48hoBZSvFEPL0j2oA
         h84ftA+ae7Oyae9MWQCA1xBvGLya5YVHhhtvf3IlvJIDUzAR8/LNa2RlU2iMHkPKK4zt
         TnNb/7RSXg/TDuy271s+UZjQ59nM1N1xYCR2mVNotqQqXlTZ/iv9F2reWUXFQSB+TjVO
         sh4A==
X-Gm-Message-State: AA+aEWbp+XgIPVQFw9UPeX5Cu12kM/iMvpQmnlT0cf2w3p0SFWrpPTtC
        r2oJTNCFV9RrAv+DB2AQMnLgbBodAdo=
X-Google-Smtp-Source: AFSGD/W3e3qdeXAmPZ6NHQ2H3xkVjV03A1VKTdKPjSxhNegjf1SZcIKnnXePiJjdje7/Lddn7hwBGg==
X-Received: by 2002:a19:94d5:: with SMTP id o82mr3086092lfk.155.1543573220300;
        Fri, 30 Nov 2018 02:20:20 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id i127-v6sm707708lji.3.2018.11.30.02.20.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:20:19 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 04/10] core: Use mainloop_sd_notify instead of sd_notify
Date:   Fri, 30 Nov 2018 12:20:07 +0200
Message-Id: <20181130102013.29023-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130102013.29023-1-luiz.dentz@gmail.com>
References: <20181130102013.29023-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

mainloop_sd_notify takes care of sending the messages to NOTIFY_SOCKET
and includes the handling of WATCHDOG_USEC as well.
---
 src/main.c | 51 +++++++++++----------------------------------------
 1 file changed, 11 insertions(+), 40 deletions(-)

diff --git a/src/main.c b/src/main.c
index 4716f5388..7ab1349cc 100644
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
+			mainloop_sd_notify("STATUS=Powering down");
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
+	mainloop_sd_notify("STATUS=Starting up");
 
 	if (option_configfile)
 		main_conf_file_path = option_configfile;
@@ -788,26 +778,12 @@ int main(int argc, char *argv[])
 
 	DBG("Entering main loop");
 
-	sd_notify(0, "STATUS=Running");
-	sd_notify(0, "READY=1");
+	mainloop_sd_notify("STATUS=Running");
+	mainloop_sd_notify("READY=1");
 
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
+	mainloop_sd_notify("STATUS=Quitting");
 
 	g_source_remove(signal);
 
@@ -824,8 +800,6 @@ int main(int argc, char *argv[])
 	if (main_opts.mode != BT_MODE_LE)
 		stop_sdp_server();
 
-	g_main_loop_unref(event_loop);
-
 	if (main_conf)
 		g_key_file_free(main_conf);
 
@@ -833,9 +807,6 @@ int main(int argc, char *argv[])
 
 	info("Exit");
 
-	if (watchdog > 0)
-		g_source_remove(watchdog);
-
 	__btd_log_cleanup();
 
 	return 0;
-- 
2.17.2

