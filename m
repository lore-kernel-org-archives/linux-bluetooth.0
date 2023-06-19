Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6C7EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 20:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFSUao (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFSUan (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 16:30:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4E19A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b51414b080so22042185ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206640; x=1689798640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St3BaXvP4+jvWaz6Hdrms1AOT/AAru1J6W/zrvOf/+I=;
        b=jYxo6fZif5BQqUbJGu5IB1GSjq2uywLxWz5PnddBRxpAwSG+1jL+xzHCUj5cFUNjnX
         jwB2bncmjs5+iCZpbjv7FuO5SLLrzYK8y6q2D15470rFKzsuH3w7rh0J5trmq2tQMjDK
         xiCcxdfJrqeKVqCe5VbD4MGb1Nmu0CQuDm/kUN0A7c9r0/EWH6xK+5M1gRgjXZ0YG+Ib
         lgnQlZEoFeHcUch6ONUOgouo6baj63v6YXQiz935eNGR4+r6ZmBSdUvHMNc2BvUElhno
         KsX0PJomtpFCuObyQteDpVTqs0DeofTm50b3vVEHGt/Jo7fyFUikh9ALJewG7WLVyuLy
         PApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206640; x=1689798640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=St3BaXvP4+jvWaz6Hdrms1AOT/AAru1J6W/zrvOf/+I=;
        b=f436bOS8kbPLYUbNUE2OYPsu6GSSSLCDsNpjymSGnXOAGVuQyK5u0KrzSYCcpYsjkd
         JqdD6F7Ew25DeZ9MIp8toH7PLlrxARijK9STtgahiELJQ306Raq9NCTrRcbGhy++LZ9e
         zbpq6zJH+MCwTRyj0FFGWWA8CWU+1FDbvohNLI/QQBbNvd1HJXv6wIqbPh4f6bkTabs0
         NkVny1CttyvlLiru+oYld3gpdwogTWuJTZUanlg1wV1gC0Q0sCOzC5mTkQcE1aNPoz/y
         e9oGbmxstEQqeSN4G0HM6VzR6kXyguBwxycBvjzaMcF6dQZOcj1Py9U6K8mrGB4fPUya
         3lgA==
X-Gm-Message-State: AC+VfDzt5FO/YYw1KvLTOV10ckg/e+LZ/LVQXiWbnBOalRIMfVptm4yy
        FyP62xOWeFEGsF0TMynYg3iPMYhfW8p4bw==
X-Google-Smtp-Source: ACHHUZ7zaMNXhZXnF5np6KYr3+VLtcRYYW+wAKlzoPb9P96brDWFzbPXSv7SVlSoj1Ycc86koZqbtQ==
X-Received: by 2002:a17:902:e543:b0:1b1:d51c:f3f6 with SMTP id n3-20020a170902e54300b001b1d51cf3f6mr10857522plf.57.1687206639756;
        Mon, 19 Jun 2023 13:30:39 -0700 (PDT)
Received: from lvondent-mobl3.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001b045c9ababsm202714plb.264.2023.06.19.13.30.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:30:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] client/player: Fix transport.acquire for linked transports
Date:   Mon, 19 Jun 2023 13:30:31 -0700
Message-Id: <20230619203032.6812-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619203032.6812-1-luiz.dentz@gmail.com>
References: <20230619203032.6812-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Linked (bi-directional) transports can be acquired on single D-Bus
method call which was not being handled properly by the current code
causing unexpected errors.
---
 client/player.c | 202 +++++++++++++++++++++++++-----------------------
 1 file changed, 107 insertions(+), 95 deletions(-)

diff --git a/client/player.c b/client/player.c
index a399d82ec..d8d632f84 100644
--- a/client/player.c
+++ b/client/player.c
@@ -72,11 +72,11 @@ struct endpoint {
 	struct iovec *caps;
 	struct iovec *meta;
 	bool auto_accept;
-	bool acquiring;
 	uint8_t max_transports;
 	uint8_t iso_group;
 	uint8_t iso_stream;
-	char *transport;
+	struct queue *acquiring;
+	struct queue *transports;
 	DBusMessage *msg;
 	struct preset *preset;
 	bool broadcast;
@@ -1075,8 +1075,6 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 	bt_shell_printf("\tTransport %s\n", path);
 	print_iter("\t", "Properties", &props);
 
-	free(ep->transport);
-
 	if (!ep->max_transports) {
 		bt_shell_printf("Maximum transports reached: rejecting\n");
 		return g_dbus_create_error(msg,
@@ -1086,7 +1084,10 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 
 	ep->max_transports--;
 
-	ep->transport = strdup(path);
+	if (!ep->transports)
+		ep->transports = queue_new();
+
+	queue_push_tail(ep->transports, strdup(path));
 
 	if (ep->auto_accept) {
 		bt_shell_printf("Auto Accepting...\n");
@@ -2030,16 +2031,26 @@ static DBusMessage *endpoint_select_properties(DBusConnection *conn,
 	return reply;
 }
 
+static bool match_str(const void *data, const void *user_data)
+{
+	return !strcmp(data, user_data);
+}
+
 static DBusMessage *endpoint_clear_configuration(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct endpoint *ep = user_data;
+	DBusMessageIter args;
+	const char *path;
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &path);
 
 	if (ep->max_transports != UINT8_MAX)
 		ep->max_transports++;
 
-	free(ep->transport);
-	ep->transport = NULL;
+	queue_remove_if(ep->transports, match_str, (void *)path);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
@@ -2128,6 +2139,9 @@ static void endpoint_free(void *data)
 		free(ep->preset);
 	}
 
+	queue_destroy(ep->acquiring, NULL);
+	queue_destroy(ep->transports, free);
+
 	g_free(ep->path);
 	g_free(ep->uuid);
 	g_free(ep);
@@ -3431,14 +3445,14 @@ static struct endpoint *find_ep_by_transport(const char *path)
 	for (l = local_endpoints; l; l = g_list_next(l)) {
 		struct endpoint *ep = l->data;
 
-		if (ep->transport && !strcmp(ep->transport, path))
+		if (queue_find(ep->transports, match_str, path))
 			return ep;
 	}
 
 	return NULL;
 }
 
-static struct endpoint *find_link_by_proxy(GDBusProxy *proxy)
+static GDBusProxy *find_link_by_proxy(GDBusProxy *proxy)
 {
 	DBusMessageIter iter, array;
 
@@ -3450,13 +3464,13 @@ static struct endpoint *find_link_by_proxy(GDBusProxy *proxy)
 	while (dbus_message_iter_get_arg_type(&array) ==
 				DBUS_TYPE_OBJECT_PATH) {
 		const char *transport;
-		struct endpoint *link;
 
 		dbus_message_iter_get_basic(&array, &transport);
 
-		link = find_ep_by_transport(transport);
-		if (link)
-			return link;
+		proxy = g_dbus_proxy_lookup(transports, NULL, transport,
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+		if (proxy)
+			return proxy;
 	}
 
 	return NULL;
@@ -3543,21 +3557,49 @@ static void transport_new(GDBusProxy *proxy, int sk, uint16_t mtu[2])
 	queue_push_tail(ios, transport);
 }
 
+static void ep_set_acquiring(struct endpoint *ep, GDBusProxy *proxy, bool value)
+{
+	bt_shell_printf("Transport %s %s\n", g_dbus_proxy_get_path(proxy),
+			value ? "acquiring" : "acquiring complete");
+
+	if (value && !ep->acquiring)
+		ep->acquiring = queue_new();
+
+	if (value)
+		queue_push_tail(ep->acquiring, proxy);
+	else
+		queue_remove(ep->acquiring, proxy);
+}
+
+static void transport_set_acquiring(GDBusProxy *proxy, bool value)
+{
+	struct endpoint *ep;
+	GDBusProxy *link;
+
+	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
+	if (!ep)
+		return;
+
+	ep_set_acquiring(ep, proxy, value);
+
+	link = find_link_by_proxy(proxy);
+	if (link) {
+		ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
+		if (!ep)
+			return;
+
+		ep_set_acquiring(ep, link, value);
+	}
+}
+
 static void acquire_reply(DBusMessage *message, void *user_data)
 {
 	GDBusProxy *proxy = user_data;
-	struct endpoint *ep, *link;
 	DBusError error;
 	int sk;
 	uint16_t mtu[2];
 
-	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
-	if (ep) {
-		ep->acquiring = false;
-		link = find_link_by_proxy(proxy);
-		if (link)
-			link->acquiring = false;
-	}
+	transport_set_acquiring(proxy, false);
 
 	dbus_error_init(&error);
 
@@ -3586,33 +3628,61 @@ static void acquire_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
-static void transport_acquire(const char *input, void *user_data)
+static void prompt_acquire(const char *input, void *user_data)
 {
 	GDBusProxy *proxy = user_data;
-	struct endpoint *ep, *link;
 
 	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
 		if (g_dbus_proxy_method_call(proxy, "Acquire", NULL,
-						acquire_reply, proxy, NULL))
+						acquire_reply, proxy, NULL)) {
+			transport_set_acquiring(proxy, true);
 			return;
+		}
 		bt_shell_printf("Failed acquire transport\n");
 	}
+}
 
-	/* Reset acquiring */
+static void transport_acquire(GDBusProxy *proxy, bool prompt)
+{
+	struct endpoint *ep;
+	GDBusProxy *link;
+
+	/* only attempt to acquire if transport is configured with a local
+	 * endpoint.
+	 */
 	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
-	if (ep) {
-		ep->acquiring = false;
-		link = find_link_by_proxy(proxy);
-		if (link)
-			link->acquiring = false;
+	if (!ep || queue_find(ep->acquiring, NULL, proxy))
+		return;
+
+	link = find_link_by_proxy(proxy);
+	if (link) {
+		ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
+		/* if link already acquiring wait it to be complete */
+		if (!ep && queue_find(ep->acquiring, NULL, link))
+			return;
+	}
+
+	if (ep->auto_accept || !prompt) {
+		if (!prompt)
+			bt_shell_printf("auto acquiring...\n");
+		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
+						acquire_reply, proxy, NULL)) {
+			bt_shell_printf("failed acquire transport\n");
+			return;
+		}
+
+		transport_set_acquiring(proxy, true);
+		return;
 	}
+
+	bt_shell_prompt_input(g_dbus_proxy_get_path(proxy), "acquire (yes/no):",
+					prompt_acquire, proxy);
 }
 
 static void transport_property_changed(GDBusProxy *proxy, const char *name,
 						DBusMessageIter *iter)
 {
 	char *str;
-	struct endpoint *ep, *link;
 
 	str = proxy_description(proxy, "Transport", COLORED_CHG);
 	print_iter(str, name, iter);
@@ -3626,38 +3696,7 @@ static void transport_property_changed(GDBusProxy *proxy, const char *name,
 	if (strcmp(str, "pending"))
 		return;
 
-	/* Only attempt to acquire if transport is configured with a local
-	 * endpoint.
-	 */
-	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
-	if (!ep || ep->acquiring)
-		return;
-
-	ep->acquiring = true;
-
-	link = find_link_by_proxy(proxy);
-	if (link) {
-		bt_shell_printf("Link %s found\n", link->transport);
-		/* If link already acquiring wait it to be complete */
-		if (link->acquiring)
-			return;
-		link->acquiring = true;
-	}
-
-	if (ep->auto_accept) {
-		bt_shell_printf("Auto Acquiring...\n");
-		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
-						acquire_reply, proxy, NULL)) {
-			bt_shell_printf("Failed acquire transport\n");
-			ep->acquiring = false;
-			if (link)
-				link->acquiring = false;
-		}
-		return;
-	}
-
-	bt_shell_prompt_input(g_dbus_proxy_get_path(proxy), "Acquire (yes/no):",
-					transport_acquire, proxy);
+	transport_acquire(proxy, true);
 }
 
 static void property_changed(GDBusProxy *proxy, const char *name,
@@ -3747,7 +3786,6 @@ static void cmd_acquire_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	int i;
-	struct endpoint *ep, *link;
 
 	for (i = 1; i < argc; i++) {
 		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
@@ -3763,35 +3801,7 @@ static void cmd_acquire_transport(int argc, char *argv[])
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
-		ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
-		if (!ep || ep->acquiring) {
-			bt_shell_printf(
-				"Transport %s already in acquiring process\n",
-				argv[i]);
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-		}
-
-		ep->acquiring = true;
-
-		link = find_link_by_proxy(proxy);
-		if (link) {
-			bt_shell_printf("Link %s found\n", link->transport);
-			/* If link already acquiring wait it to be complete */
-			if (link->acquiring) {
-				bt_shell_printf(
-					"Link %s is in acquiring process\n",
-					argv[i]);
-				return bt_shell_noninteractive_quit(
-								EXIT_FAILURE);
-			}
-			link->acquiring = true;
-		}
-
-		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
-						acquire_reply, proxy, NULL)) {
-			bt_shell_printf("Failed acquire transport\n");
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-		}
+		transport_acquire(proxy, false);
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -4076,9 +4086,11 @@ static void cmd_send_transport(int argc, char *argv[])
 		memset(&qos, 0, sizeof(qos));
 		len = sizeof(qos);
 		if (getsockopt(transport->sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
-							&len) < 0)
+							&len) < 0) {
+			bt_shell_printf("Unable to getsockopt(BT_ISO_QOS): %s",
+							strerror(errno));
 			err = transport_send(transport, fd, NULL);
-		else
+		} else
 			err = transport_send(transport, fd, &qos);
 
 		if (err < 0) {
-- 
2.40.1

