Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9101CC43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5422A20832
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAzvYuhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5422A20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeK2CC3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:02:29 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39116 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CC3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:02:29 -0500
Received: by mail-ed1-f44.google.com with SMTP id b14so22328260edt.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=D7xxoRm11/BVHccNo+bINx21570pi/iHXf+bl9fsSeo=;
        b=IAzvYuhKq3Na8IIT5d1TFVgrodv/d8jMJnjcb8IPd4koqoTiiBcGS88879aBVEAkAT
         g6TShYmhoHDFCldNSpFISmDsCFpl/TtRq+ydK/ii+fa3skcdUHJPhg32PskP0tVCKsMW
         dLyzFZxqBYAz6PAbb2CEaS2hb7KdFVaVmks681xqFcpgSCz0oxXl4tbTjHCMu0+ZQGPT
         1bcKUP0xyl4su5vvWNIohxQGLCfQ4i3jppLS40YiL+2l3qBUSZ3yk5iUAagr+wA+eHrP
         l1w//dxKhZXazWE4SoIB9H13uUQFS6KRMSH2zIjcrx9zEkhqQi4Vdl0PgZTbSTt5mL2M
         QTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=D7xxoRm11/BVHccNo+bINx21570pi/iHXf+bl9fsSeo=;
        b=tADy6/e/2zOpG+6hsTKDhHusczN9V9K9G0EdV274FRWJdLBUkR6if4EdTRowHE+CGW
         KeFTYFBrfz2EFJHyDjElZgOZex/8ZK4icPp9xwS2tD50gaj+b66kGRTWz2qUpRYhuJPv
         ZOsw5g6io1PAhtSYqbBzalTKBCywb6G4U/eClaCX7j5Og/lKLx9g7lKNM2tfjwk7tDJ7
         fBqE/F1oS8hvQXUa4VwnB9a151y34OZU3hS/UZdRkYDrdBtC4ViEZt1sKxV0r3wySPeR
         bHCCTTpQTr/8b+8eEIMamLg7y6AOEDQvLDEDuAbInhClJzA5RzVLVeV34FYxenTm4P6Q
         B2yA==
X-Gm-Message-State: AA+aEWbmJexBYaIcy1P0SnVxXPXGEG+fsJgtBuQAPXcDO9LgClIE7cby
        jn/E541G6Ryst3z6ImixTcS+DNAj
X-Google-Smtp-Source: AFSGD/X2RfQ1bdedkJf3TwnUAOylxJ7PR4bJP5Ctwaqo+Zfd1cXg87n87pNX8nLbABX4CYKvO2MNGA==
X-Received: by 2002:a50:8a03:: with SMTP id i3mr16600464edi.164.1543417230466;
        Wed, 28 Nov 2018 07:00:30 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id z2sm1869327edd.4.2018.11.28.07.00.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 07:00:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] core: Use mainloop_sd_notify instead of sd_notify
Date:   Wed, 28 Nov 2018 17:00:17 +0200
Message-Id: <20181128150023.1576-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181128150023.1576-1-luiz.dentz@gmail.com>
References: <20181128150023.1576-1-luiz.dentz@gmail.com>
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

