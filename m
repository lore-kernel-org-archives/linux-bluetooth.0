Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB460ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 21:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiH2Vhq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiH2Vho (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 17:37:44 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B2081B28
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 14:37:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v4so8868268pgi.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 14:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=Z83sM+bwrPHkHJxDoTrT4irybJ0TuHYd/Yf/H8pZz3o=;
        b=IDc7lQUW3n8cQ+8scpjwl6Uj6djEue/V5DPg477O6LwfzHAcyuR69qPj1w0lJPdp70
         zjdIWz+q+e1WOhTL/FGlXy/RrRJEafhrLDFRjjZg1n6zxUv9HKNQke/gowWgqU6Fi/4u
         FUHc/onuMlU8aRD37BvGSG+XGZ2xiJgfZahISgtaawrhtTzQoowM0QRu7cmG4Kb28/0p
         CQeJf7IEJoNz21ko6IribJv13FI5fSFuRjAAc9AREQ+ornvyDI93hbHjOZGvwMH8GAj4
         1hwE3ZE5rhNodRRmKzmM5tSY/2q/rR7VKY/Tc61Cw8XouC1+iFgARaz0169bYv9yMfV6
         hapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=Z83sM+bwrPHkHJxDoTrT4irybJ0TuHYd/Yf/H8pZz3o=;
        b=oYOq1EQ5qJJDgt/3CkJ65NcbzEtHl37/IIJ3szkTKacqEVhkU6nBuNcS4l1PWejFhu
         xTbqqrtosVOW2zqcst6FWBygPP5cZB0DGWxc9l3nA6MkIWAmlte+MrNNsyooatwyd2F6
         /YhW1ddmPoqVcExfMM92M+X+cH74LWQk2ir73i5hKq195u4rp+uLaiyNfh3T4ySZ4Z6X
         jr9xzQp7XK1p4LNox2IlAETMhziTwAJ6aSOsBF+EPDarcG91bJDgYJma+gMrBKvRYgSW
         0z5OzsCCo8JSFWjMMw9oidj+te8P3nP7gFdF5sf4r2DHsqzXRu9DhPixDCL9lMBb2y95
         +y+w==
X-Gm-Message-State: ACgBeo1JDEt9uJr5U8yGbMf5ocwz9JuZhCPD6yMXO1IT9U3F3cakwHDj
        A91jXkpYwKgMQLqIganNfk7gSw8i6OKVRw==
X-Google-Smtp-Source: AA6agR4YYaNPicgSe8Y9UcUcY/1JD5LbMoGaj9WKOgxW/kFLf3WIp33Tknfjx6vjtlAZYpNuoE/IOg==
X-Received: by 2002:aa7:92d8:0:b0:537:acbf:5e85 with SMTP id k24-20020aa792d8000000b00537acbf5e85mr18119140pfa.61.1661809062050;
        Mon, 29 Aug 2022 14:37:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p186-20020a62d0c3000000b005367c28fd32sm7722765pfg.185.2022.08.29.14.37.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:37:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] client: Add -e/--endpoint option to auto register endpoints
Date:   Mon, 29 Aug 2022 14:37:38 -0700
Message-Id: <20220829213738.779598-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829213738.779598-1-luiz.dentz@gmail.com>
References: <20220829213738.779598-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds -e/--endpoint option that can be used to auto register
supported endpoints.
---
 client/main.c   |  14 ++++--
 client/player.c | 122 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 98 insertions(+), 38 deletions(-)

diff --git a/client/main.c b/client/main.c
index 54f21fbdf9a0..6773d52627db 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3109,23 +3109,27 @@ static const struct bt_shell_menu main_menu = {
 
 static const struct option options[] = {
 	{ "agent",	required_argument, 0, 'a' },
+	{ "endpoints",	no_argument, 0, 'e' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *agent_option;
+static const char *endpoint_option;
 
 static const char **optargs[] = {
-	&agent_option
+	&agent_option,
+	&endpoint_option
 };
 
 static const char *help[] = {
-	"Register agent handler: <capability>"
+	"Register agent handler: <capability>",
+	"Register Media endpoints"
 };
 
 static const struct bt_shell_opt opt = {
 	.options = options,
 	.optno = sizeof(options) / sizeof(struct option),
-	.optstr = "a:",
+	.optstr = "a:e",
 	.optarg = optargs,
 	.help = help,
 };
@@ -3158,6 +3162,10 @@ int main(int argc, char *argv[])
 
 	bt_shell_set_env("DBUS_CONNECTION", dbus_conn);
 
+	if (endpoint_option)
+		bt_shell_set_env("AUTO_REGISTER_ENDPOINT",
+					(void *)endpoint_option);
+
 	admin_add_submenu();
 	player_add_submenu();
 
diff --git a/client/player.c b/client/player.c
index 99b036b8c3ec..3d2f41cb3666 100644
--- a/client/player.c
+++ b/client/player.c
@@ -510,41 +510,6 @@ static char *proxy_description(GDBusProxy *proxy, const char *title,
 					title, path);
 }
 
-static void print_media(GDBusProxy *proxy, const char *description)
-{
-	char *str;
-
-	str = proxy_description(proxy, "Media", description);
-
-	bt_shell_printf("%s\n", str);
-
-	g_free(str);
-}
-
-static void print_player(GDBusProxy *proxy, const char *description)
-{
-	char *str;
-
-	str = proxy_description(proxy, "Player", description);
-
-	bt_shell_printf("%s%s\n", str,
-			default_player == proxy ? "[default]" : "");
-
-	g_free(str);
-}
-
-static void cmd_list(int argc, char *arg[])
-{
-	GList *l;
-
-	for (l = players; l; l = g_list_next(l)) {
-		GDBusProxy *proxy = l->data;
-		print_player(proxy, NULL);
-	}
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-}
-
 static void print_iter(const char *label, const char *name,
 						DBusMessageIter *iter)
 {
@@ -627,6 +592,42 @@ static void print_property(GDBusProxy *proxy, const char *name)
 	print_iter("\t", name, &iter);
 }
 
+static void print_media(GDBusProxy *proxy, const char *description)
+{
+	char *str;
+
+	str = proxy_description(proxy, "Media", description);
+
+	bt_shell_printf("%s\n", str);
+	print_property(proxy, "SupportedUUIDs");
+
+	g_free(str);
+}
+
+static void print_player(GDBusProxy *proxy, const char *description)
+{
+	char *str;
+
+	str = proxy_description(proxy, "Player", description);
+
+	bt_shell_printf("%s%s\n", str,
+			default_player == proxy ? "[default]" : "");
+
+	g_free(str);
+}
+
+static void cmd_list(int argc, char *arg[])
+{
+	GList *l;
+
+	for (l = players; l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+		print_player(proxy, NULL);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_show_item(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -2412,11 +2413,62 @@ static const struct bt_shell_menu endpoint_menu = {
 	{} },
 };
 
+static struct endpoint *endpoint_new(const struct capabilities *cap)
+{
+	struct endpoint *ep;
+
+	ep = new0(struct endpoint, 1);
+	ep->uuid = g_strdup(cap->uuid);
+	ep->codec = cap->codec_id;
+	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
+					g_list_length(local_endpoints));
+	/* Copy capabilities */
+	iov_append(&ep->caps, cap->data.iov_base, cap->data.iov_len);
+	local_endpoints = g_list_append(local_endpoints, ep);
+
+	return ep;
+}
+
+static void register_endpoints(GDBusProxy *proxy)
+{
+	struct endpoint *ep;
+	DBusMessageIter iter, array;
+
+	if (!g_dbus_proxy_get_property(proxy, "SupportedUUIDs", &iter))
+		return;
+
+	dbus_message_iter_recurse(&iter, &array);
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
+		const char *uuid;
+		size_t i;
+
+		dbus_message_iter_get_basic(&array, &uuid);
+
+		for (i = 0; i < ARRAY_SIZE(caps); i++) {
+			const struct capabilities *cap = &caps[i];
+
+			if (strcasecmp(cap->uuid, uuid))
+				continue;
+
+			ep = endpoint_new(cap);
+			ep->auto_accept = true;
+			ep->cig = BT_ISO_QOS_CIG_UNSET;
+			ep->cis = BT_ISO_QOS_CIS_UNSET;
+			endpoint_register(ep);
+		}
+
+		dbus_message_iter_next(&array);
+	}
+}
+
 static void media_added(GDBusProxy *proxy)
 {
 	medias = g_list_append(medias, proxy);
 
 	print_media(proxy, COLORED_NEW);
+
+	if (bt_shell_get_env("AUTO_REGISTER_ENDPOINT"))
+		register_endpoints(proxy);
 }
 
 static void player_added(GDBusProxy *proxy)
-- 
2.37.2

