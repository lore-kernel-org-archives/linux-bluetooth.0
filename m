Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BBAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 18:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiBNScY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:32:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiBNScY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 13:32:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359F652E4
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 10:32:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y9so15409362pjf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZts8J8jzOgLeko+neaE00HhRhjGfFjCdh46fUAWPQc=;
        b=Zu5KaaKcm6siIGHjnCiE37PtDRuVsY7cZ0GJtsEi3dDxw9uddEqC2BlRg7svvIES9A
         eyizpP39nNSZ/JSCzjZ+5Q5bx2AA/pl95ExPU3YPHMFRsS+UucBOuVLXKDcruH9jhlKY
         XzMD5ouU9FtOchqiDa6C+eaz4omyA3z9a1RpOY8iKFLKlBHDXwqwJhfEQkModkWkj88+
         QD9kEVuwyCLmZJmixeGQoQbEZ1nP/e+P9iUuX2I3zKK2IsZ/0+r8O0EsCE3jpin1vQyK
         Z2iRFduTW0X5YnaAiUDPMDjsDynKSob4jT8dTAouQClhrrsgPM2VuMAXmbaUiojtKMiV
         Asvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZts8J8jzOgLeko+neaE00HhRhjGfFjCdh46fUAWPQc=;
        b=Ai22ItLO1MpVtE91xC/rBsSn6IKFj/YxMqGW5yIAuAjNm+57+HZODmGm2Fl/R43zet
         /T8B+A8LMivCVBDMwGG1N1vkTX6g+XkJgpzCzjMYEGFWrVMcEyWERLJSjKyI0us8KKES
         RcV8r82XNXjeNci+G+HyPPZ3GIpNvazrs0d5x0XxA+0dKXVJXzXfrDjN8dj0lsx6lDJz
         uEMaIMlUz4qoUVufnx7MxBRnvPN3gQXa61eu62/Pgj0Qbj8QlhFjxxDfcsOA2mA0OhsQ
         S6KxM7ewdD5WOoyDMkAXm1qk4GZORLielHqL8n/huIuL9hMMobuYk7M9HUWbycodiOrf
         MZNQ==
X-Gm-Message-State: AOAM530drQJ4j7rNDPYIoCvxG/anuAmeeou+wonspQdoVHZs7E7I9HXf
        3h3lEU4P6nrUBvXgQNtKGdRApFbINj6www==
X-Google-Smtp-Source: ABdhPJwrwBh9JyPMGvGlKU1TREseXB4FHyLSZa3UJ27lYbr/fDr2CbBGbHDFWUaDfAKPwKBYjPgqfg==
X-Received: by 2002:a17:902:b498:: with SMTP id y24mr55668plr.29.1644863535251;
        Mon, 14 Feb 2022 10:32:15 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id on14sm15249873pjb.34.2022.02.14.10.32.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:32:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexctl: Add optional argument channel to connect command
Date:   Mon, 14 Feb 2022 10:32:14 -0800
Message-Id: <20220214183214.1803894-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a third argument to connect command so a channel can be passed
to CreateSession which is useful since it possible to force a specific
RFCOMM channel.
---
 tools/obexctl.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index e671d253b..41f9401f5 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -114,6 +114,7 @@ static void connect_reply(DBusMessage *message, void *user_data)
 struct connect_args {
 	char *dev;
 	char *target;
+	uint16_t channel;
 };
 
 static void connect_args_free(void *data)
@@ -139,13 +140,14 @@ static void connect_setup(DBusMessageIter *iter, void *user_data)
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&dict);
 
-	if (args->target == NULL)
-		goto done;
-
-	g_dbus_dict_append_entry(&dict, "Target",
+	if (args->target)
+		g_dbus_dict_append_entry(&dict, "Target",
 					DBUS_TYPE_STRING, &args->target);
 
-done:
+	if (args->channel)
+		g_dbus_dict_append_entry(&dict, "Channel",
+					DBUS_TYPE_UINT16, &args->channel);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -153,6 +155,7 @@ static void cmd_connect(int argc, char *argv[])
 {
 	struct connect_args *args;
 	const char *target = "opp";
+	int channel = 0;
 
 	if (!client) {
 		bt_shell_printf("Client proxy not available\n");
@@ -162,9 +165,20 @@ static void cmd_connect(int argc, char *argv[])
 	if (argc > 2)
 		target = argv[2];
 
+	if (argc > 3) {
+		char *endptr = NULL;
+
+		channel = strtol(argv[3], &endptr, 0);
+		if (!endptr || *endptr != '\0' || channel > UINT16_MAX) {
+			bt_shell_printf("Invalid channel\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
 	args = g_new0(struct connect_args, 1);
 	args->dev = g_strdup(argv[1]);
 	args->target = g_strdup(target);
+	args->channel = channel;
 
 	if (g_dbus_proxy_method_call(client, "CreateSession", connect_setup,
 			connect_reply, args, connect_args_free) == FALSE) {
@@ -1832,7 +1846,8 @@ static void cmd_mkdir(int argc, char *argv[])
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
-	{ "connect",      "<dev> [uuid]", cmd_connect, "Connect session" },
+	{ "connect",      "<dev> [uuid] [channel]", cmd_connect,
+						"Connect session" },
 	{ "disconnect",   "[session]", cmd_disconnect, "Disconnect session",
 						session_generator },
 	{ "list",         NULL,       cmd_list, "List available sessions" },
-- 
2.34.1

