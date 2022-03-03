Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203D8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 00:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiCCAcX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiCCAcW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 19:32:22 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A601EC5E
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 16:31:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id w37so3070612pga.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 16:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69NrXL/f97Lbx7xvFjPeoQIHtRoBoSQCFCoJcL7jwqE=;
        b=ASPa+E0AIgbSOcJbXmMuO72CCd5cQWWZpIwLXO7YTqIUP5f9dCeTfaBwZwyjz0Bs17
         RwDyazl5h3LNVyQN4M2kYz5+x4Aj2QsYNps399JNw8jnHA14BehXNdES/hCM02ZuFxiW
         0o15vflsEQp/c1+k0JiMBtegN8RAFIsGOap6QJioa9/Y31jbx9CinKHUFaVSGEAp+TY4
         QEyoWs3WvDXsF4ltcwVbLhIdZHPg/s9jZdBu+Ir2Lyt6lm0qEkBAzgrzcZsNz/kvHz3I
         mCMeZ7VeRk+7dW0dpV6UK6d/xDeIUjliFw5DQdfO0+7/d5zefRQZ6eU+rXRzQj/pDvI9
         FLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69NrXL/f97Lbx7xvFjPeoQIHtRoBoSQCFCoJcL7jwqE=;
        b=ViruSTV4KTfd52xaBQYqLKDWaTr3cmcFFqXF8c2xNUKiWF0vwtNeEtDNTgF6AktGnk
         r0o26f9IIBpPbicB0YX0JuRbjth8NRFRY8b4lLEK/fCfvCVoDyxs7dWbVK5NZ5KwgXC5
         R1Ja7GOWKb6w3+zYNgl5w/UCHkdtyJ3d90b7bVOZVTMHFss2fJNxn9YlHZqQaT5Wvcqa
         c/cXa1y+yHWS97U5KTw/BmszMgYuqccEFjyuvn7N3CveNkjhMRvmVpxaYPpF670iMNTk
         tQXopc7byGerzei9pqrFdmD5UAsUf7IRvi/ttss5R0QgwwD6FtEjjrcOU8Ag2LOsf8J9
         QY1Q==
X-Gm-Message-State: AOAM533RxM7hcE3NBov2o59puAAezi9wNVn7mMbZuVboqb7sgAb3MG7c
        vIi03h3SnYVNhQRR93GVV5PKkQ4JQDQ=
X-Google-Smtp-Source: ABdhPJw/Cnr8VVj4aS9Y1No8KM48NHDQv46zrlM2aVwShJXOvjksY+9vYO25Z+uK8zu1mVh7BsjynQ==
X-Received: by 2002:a63:9845:0:b0:375:5cc8:7d34 with SMTP id l5-20020a639845000000b003755cc87d34mr28340685pgo.124.1646267498222;
        Wed, 02 Mar 2022 16:31:38 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k20-20020a056a00135400b004ecc81067b8sm356283pfu.144.2022.03.02.16.31.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:31:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Add support for scan <le/bredr>
Date:   Wed,  2 Mar 2022 16:31:36 -0800
Message-Id: <20220303003136.4882-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for entering the transport directly as an scan
argument rather than having to first set it scan.transport.
---
 client/main.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index 719cbefe0..6bb11b1ad 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1294,6 +1294,7 @@ static struct set_discovery_filter_args {
 	dbus_bool_t discoverable;
 	bool set;
 	bool active;
+	unsigned int timeout;
 } filter = {
 	.rssi = DISTANCE_VAL_INVALID,
 	.pathloss = DISTANCE_VAL_INVALID,
@@ -1415,18 +1416,33 @@ static void set_discovery_filter(bool cleared)
 	filter.set = true;
 }
 
+static const char *scan_arguments[] = {
+	"on",
+	"off",
+	"bredr",
+	"le",
+	NULL
+};
+
 static void cmd_scan(int argc, char *argv[])
 {
 	dbus_bool_t enable;
 	const char *method;
+	const char *mode;
 
-	if (!parse_argument(argc, argv, NULL, NULL, &enable, NULL))
+	if (!parse_argument(argc, argv, scan_arguments, "Mode", &enable,
+								&mode))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	if (check_default_ctrl() == FALSE)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	if (enable == TRUE) {
+		if (strcmp(mode, "")) {
+			g_free(filter.transport);
+			filter.transport = g_strdup(mode);
+		}
+
 		set_discovery_filter(false);
 		method = "StartDiscovery";
 	} else
@@ -2514,6 +2530,11 @@ static char *capability_generator(const char *text, int state)
 	return argument_generator(text, state, agent_arguments);
 }
 
+static char *scan_generator(const char *text, int state)
+{
+	return argument_generator(text, state, scan_arguments);
+}
+
 static void cmd_advertise(int argc, char *argv[])
 {
 	dbus_bool_t enable;
@@ -3117,7 +3138,8 @@ static const struct bt_shell_menu main_menu = {
 				"Enable/disable advertising with given type",
 							ad_generator},
 	{ "set-alias",    "<alias>",  cmd_set_alias, "Set device alias" },
-	{ "scan",         "<on/off>", cmd_scan, "Scan for devices", NULL },
+	{ "scan",         "<on/off/bredr/le>", cmd_scan,
+				"Scan for devices", scan_generator },
 	{ "info",         "[dev]",    cmd_info, "Device information",
 							dev_generator },
 	{ "pair",         "[dev]",    cmd_pair, "Pair with device",
-- 
2.35.1

