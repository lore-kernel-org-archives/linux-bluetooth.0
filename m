Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C449C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 23:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiDVX0n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDVX03 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 19:26:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D484E81199
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 16:02:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x80so9316452pfc.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwXztr1Qvr5PubM1CiKYb4IekDbtGYFCPUSjoXnS6NQ=;
        b=W9yX9OmAEBA6BP7lApI4u+rax2bGXZ8gaKsj8d4DHQfb08lWKXXq8oz3L034iDmITP
         Ou2h/cexc/0bJtTz6G+VPfQAvIE5OHud4NbeBfUozQXzqTlxdOPc09jvKSQPqTjd95QK
         Kf7oswybsmGS7kgs4Y8iNmmMEvPAjAkzdjYtFd8j+XD3Z1pzt+OzwKWv6rNlfxXfppHn
         S1AAppRou5yw2ovqsFjnLR6MR8y6Sq1k3uduihC6wmYapdJywWB1ubHHK65jlbknQ+X3
         Ryqb7utc7KXtHz30sAi9fKqnO+IfOXJCkWOpJl4HWgUgLDGppjQHM0XZEPdB+ysafhhd
         gjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwXztr1Qvr5PubM1CiKYb4IekDbtGYFCPUSjoXnS6NQ=;
        b=nF/0Ap9G1ji5s4EGxc7zdLDE5f29VACNRj3sPCAj1kwDoMy0qqqdnnXY4dT4y+EaeS
         0zYQyRq7qVylldXWam59C89TtsqSZYhi8pHhi+y/zusu3yBs7iDylV3157tM9rqx5zTn
         q02iPOVxnRabQMI0flReajG1Y3uiA48rPwOHsdEhhWhIW/DY/+LSss0dMU+wO8mwDEJ0
         ihReqTQJE9nYZwnrQTqj8bk3PyqByRlwlLe7l3FMsOH7P9ZbC+pbj1sJijAJawUVz7sV
         UNkW8K5VleePvMwOGbmnIpncQbVgrq/MdmzwcYI6W0ijaBpmG81BRvVAKELu6Bc+Tf1v
         m+Sg==
X-Gm-Message-State: AOAM532P6pDQ0nmQNXfFacAY4Z8zoNXdyiMFfLhqm2EOgdWxEe84pGV5
        Rgmj4EO0hhzXUb/GLW6v5ufEFKz89d0=
X-Google-Smtp-Source: ABdhPJyG7shbs6OiuhKMYYabDmuG2dtWypXQhdYTx60H5O6XdhRX68f+cdlud1nvM5LDp8TN7gsZ4g==
X-Received: by 2002:a05:6a00:1895:b0:50a:6a91:e833 with SMTP id x21-20020a056a00189500b0050a6a91e833mr7373793pfh.26.1650668559966;
        Fri, 22 Apr 2022 16:02:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004fe1a045e97sm3679497pfj.118.2022.04.22.16.02.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 16:02:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/player: Add transport.volume command
Date:   Fri, 22 Apr 2022 16:02:38 -0700
Message-Id: <20220422230238.3836087-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds transport.volume command:

Get/Set transport volume
Usage:
	 volume <transport> [value]
---
 client/player.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 127b55c1f..315cde712 100644
--- a/client/player.c
+++ b/client/player.c
@@ -572,11 +572,13 @@ static void print_iter(const char *label, const char *name,
 		break;
 	case DBUS_TYPE_UINT32:
 		dbus_message_iter_get_basic(iter, &valu32);
-		bt_shell_printf("%s%s: 0x%06x\n", label, name, valu32);
+		bt_shell_printf("%s%s: 0x%08x (%u)\n", label, name, valu32,
+								valu32);
 		break;
 	case DBUS_TYPE_UINT16:
 		dbus_message_iter_get_basic(iter, &valu16);
-		bt_shell_printf("%s%s: 0x%04x\n", label, name, valu16);
+		bt_shell_printf("%s%s: 0x%04x (%u)\n", label, name, valu16,
+								valu16);
 		break;
 	case DBUS_TYPE_INT16:
 		dbus_message_iter_get_basic(iter, &vals16);
@@ -2525,6 +2527,51 @@ static void cmd_send_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void volume_callback(const DBusError *error, void *user_data)
+{
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to set Volume: %s\n", error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Changing Volume succeeded\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_volume_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	char *endptr = NULL;
+	int volume;
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+
+	if (argc == 2) {
+		print_property(proxy, "Volume");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	volume = strtol(argv[2], &endptr, 0);
+	if (!endptr || *endptr != '\0' || volume > UINT16_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", argv[2]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!g_dbus_proxy_set_property_basic(proxy, "Volume", DBUS_TYPE_UINT16,
+						&volume, volume_callback,
+						NULL, NULL)) {
+		bt_shell_printf("Failed release transport\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static const struct bt_shell_menu transport_menu = {
 	.name = "transport",
 	.desc = "Media Transport Submenu",
@@ -2542,6 +2589,9 @@ static const struct bt_shell_menu transport_menu = {
 						transport_generator },
 	{ "send",        "<filename>",	cmd_send_transport,
 						"Send contents of a file" },
+	{ "volume",      "<transport> [value]",	cmd_volume_transport,
+						"Get/Set transport volume",
+						transport_generator },
 	{} },
 };
 
-- 
2.35.1

