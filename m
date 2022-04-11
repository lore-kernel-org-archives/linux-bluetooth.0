Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541BBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 23:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiDLAA2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 20:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiDLAAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 20:00:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70DC2C114
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 16:58:08 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 125so15531205pgc.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Zl/eKCt34cLSDlX2p1cKFA1em+/N1xFmKfzS4kxVsYI=;
        b=JGkEBcnlKpEq3e4k68a8e3QgmunJpwiumQsp6ZmUDG1gd9ci1ZF8Bii4r8+1xOYA0P
         MRXYY4FstJ8YGOjIPLlAuNkgVhrnpplLbAagV4zibWRT+EujHazJ8n+RXNAKShRoGJQ1
         ax1PkFhGup5NwN37SsrzvQQ/u320w5lbzMOMLc/iXN4kXSM5hNIMmXu9JfgG9tQ/sWpf
         9MBiuds7Vitpt7I/yt/0S3eOgUHAnB1Zm98dufQrHqoivaVatOQcRuGuzN6OH6SwwXyq
         7B3VPKzaVtLMb0WPXqHyY1qRmWkr3yG3rLzSFvkQeIVyeG05c+FeSwaqpofrVUILN8lk
         JJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zl/eKCt34cLSDlX2p1cKFA1em+/N1xFmKfzS4kxVsYI=;
        b=2cEi4hx4CsPayHOOJOKVLS0CKHwfSipYsD2y72gjZOq9TPu09BmaXr7Ze1Mgk5BRN8
         1G+LH4ZywboU0TxugGGApC5qQ4NGtG3ZN+y17l4ejPE8gGrNYyruMu5KEcGByhjGdyyB
         +JVSLZEaSeeXTV6GR5p1ryJVhLctSui2AMqeRl7g8Xi8afaLwqDzR2fQtwbesfmjL9BG
         LWnNisehFwMmsHY9aCqDMC4dGD5dIE5vZPsoPr1XwAM+SyxwNlkA5E41AauJuv3U7Qze
         N60m9YP+HjxV1aPnxSpATZLu4gIllG7BDULQh6ArT833NFjUlGFdZaxZGzGY/f6WsSMD
         cy2Q==
X-Gm-Message-State: AOAM531UTT3+FwLGqig4vWfttGz/d1hqMe6QUtj/QTH7kGZkY5mKi4cj
        jPoATQw+T1KtAvtbfNxMj9XyjCFQuvA=
X-Google-Smtp-Source: ABdhPJysBbdpSUulFp3O3Tk+1Cn7oAwci2HhnDAUy3P+xPglQYmK0PRTykJQOOSoOVIWUyX+1gW5HA==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id l15-20020a056a00140f00b004e069959c48mr35136170pfu.59.1649721487852;
        Mon, 11 Apr 2022 16:58:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w92-20020a17090a6be500b001cb9ff8dfbcsm572515pjj.33.2022.04.11.16.58.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 16:58:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] client/player: Add transport menu
Date:   Mon, 11 Apr 2022 16:58:04 -0700
Message-Id: <20220411235804.3776702-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411235804.3776702-1-luiz.dentz@gmail.com>
References: <20220411235804.3776702-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds transport menu:

[bluetooth]# menu transport
Menu transport:
Available commands:
-------------------
list                                              List available transports
show <transport>                                  Transport information
acquire <transport>                               Acquire Transport
release <transport>                               Release Transport
send <filename>                                   Send contents of a file
---
 client/player.c | 385 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 384 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index b0a8b2c56..9212f31ac 100644
--- a/client/player.c
+++ b/client/player.c
@@ -49,6 +49,7 @@
 #define BLUEZ_MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
 #define BLUEZ_MEDIA_ITEM_INTERFACE "org.bluez.MediaItem1"
 #define BLUEZ_MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+#define BLUEZ_MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
 #define BLUEZ_MEDIA_ENDPOINT_PATH "/local/endpoint"
 
@@ -73,6 +74,16 @@ static GList *folders = NULL;
 static GList *items = NULL;
 static GList *endpoints = NULL;
 static GList *local_endpoints = NULL;
+static GList *transports = NULL;
+
+struct transport {
+	int sk;
+	int mtu[2];
+	struct io *io;
+	uint32_t seq;
+} transport = {
+	.sk = -1,
+};
 
 static void endpoint_unregister(void *data)
 {
@@ -1400,8 +1411,9 @@ static char *uuid_generator(const char *text, int state)
 	static int index = 0;
 	size_t i;
 
-	if (!state)
+	if (!state) {
 		index = 0;
+	}
 
 	for (i = index; i < ARRAY_SIZE(caps); i++) {
 		const struct capabilities *cap = &caps[i];
@@ -1946,6 +1958,26 @@ static void endpoint_added(GDBusProxy *proxy)
 	print_endpoint(proxy, COLORED_NEW);
 }
 
+static void print_transport(void *data, void *user_data)
+{
+	GDBusProxy *proxy = data;
+	const char *description = user_data;
+	char *str;
+
+	str = proxy_description(proxy, "Transport", description);
+
+	bt_shell_printf("%s\n", str);
+
+	g_free(str);
+}
+
+static void transport_added(GDBusProxy *proxy)
+{
+	transports = g_list_append(transports, proxy);
+
+	print_transport(proxy, COLORED_NEW);
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -1962,6 +1994,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		item_added(proxy);
 	else if (!strcmp(interface, BLUEZ_MEDIA_ENDPOINT_INTERFACE))
 		endpoint_added(proxy);
+	else if (!strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE))
+		transport_added(proxy);
 }
 
 static void media_removed(GDBusProxy *proxy)
@@ -2002,6 +2036,13 @@ static void endpoint_removed(GDBusProxy *proxy)
 	print_endpoint(proxy, COLORED_DEL);
 }
 
+static void transport_removed(GDBusProxy *proxy)
+{
+	transports = g_list_remove(transports, proxy);
+
+	print_transport(proxy, COLORED_DEL);
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -2018,6 +2059,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		item_removed(proxy);
 	if (!strcmp(interface, BLUEZ_MEDIA_ENDPOINT_INTERFACE))
 		endpoint_removed(proxy);
+	if (!strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE))
+		transport_removed(proxy);
 }
 
 static void player_property_changed(GDBusProxy *proxy, const char *name,
@@ -2060,6 +2103,134 @@ static void endpoint_property_changed(GDBusProxy *proxy, const char *name,
 	g_free(str);
 }
 
+static struct endpoint *find_ep_by_transport(const char *path)
+{
+	GList *l;
+
+	for (l = local_endpoints; l; l = g_list_next(l)) {
+		struct endpoint *ep = l->data;
+
+		if (ep->transport && !strcmp(ep->transport, path))
+			return ep;
+	}
+
+	return NULL;
+}
+
+static bool transport_disconnected(struct io *io, void *user_data)
+{
+	bt_shell_printf("Transport fd disconnected\n");
+
+	io_destroy(transport.io);
+	transport.io = NULL;
+	transport.sk = -1;
+
+	return false;
+}
+
+static bool transport_recv(struct io *io, void *user_data)
+{
+	uint8_t buf[1024];
+	int ret;
+
+	ret = read(io_get_fd(io), buf, sizeof(buf));
+	if (ret < 0) {
+		bt_shell_printf("Failed to read: %s (%d)\n", strerror(errno),
+								-errno);
+		return true;
+	}
+
+	bt_shell_printf("[seq %d] recv: %u bytes\n", transport.seq, ret);
+
+	transport.seq++;
+
+	return true;
+}
+
+static void acquire_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to acquire: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!dbus_message_get_args(message, &error,
+				   DBUS_TYPE_UNIX_FD, &transport.sk,
+				   DBUS_TYPE_UINT16, &transport.mtu[0],
+				   DBUS_TYPE_UINT16, &transport.mtu[1],
+				   DBUS_TYPE_INVALID)) {
+		bt_shell_printf("Failed to parse Acquire() reply: %s",
+							error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Acquire successful: fd %d MTU %d:%d\n", transport.sk,
+					transport.mtu[0], transport.mtu[1]);
+
+	io_destroy(transport.io);
+	transport.io = io_new(transport.sk);
+
+	io_set_disconnect_handler(transport.io, transport_disconnected, NULL,
+								NULL);
+	io_set_read_handler(transport.io, transport_recv, NULL, NULL);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void transport_acquire(const char *input, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+
+	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
+		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
+						acquire_reply, NULL, NULL))
+			bt_shell_printf("Failed acquire transport\n");
+	}
+}
+
+static void transport_property_changed(GDBusProxy *proxy, const char *name,
+						DBusMessageIter *iter)
+{
+	char *str;
+	struct endpoint *ep;
+
+	str = proxy_description(proxy, "Transport", COLORED_CHG);
+	print_iter(str, name, iter);
+	g_free(str);
+
+	if (strcmp(name, "State"))
+		return;
+
+	dbus_message_iter_get_basic(iter, &str);
+
+	if (strcmp(str, "pending"))
+		return;
+
+	/* Only attempt to acquire if transport is configured with a local
+	 * endpoint.
+	 */
+	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
+	if (!ep)
+		return;
+
+	if (ep->auto_accept) {
+		bt_shell_printf("Auto Accepting...\n");
+		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
+						acquire_reply, NULL, NULL))
+			bt_shell_printf("Failed acquire transport\n");
+		return;
+	}
+
+	bt_shell_prompt_input(g_dbus_proxy_get_path(proxy), "Acquire (yes/no):",
+					transport_acquire, proxy);
+}
+
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -2075,14 +2246,226 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		item_property_changed(proxy, name, iter);
 	else if (!strcmp(interface, BLUEZ_MEDIA_ENDPOINT_INTERFACE))
 		endpoint_property_changed(proxy, name, iter);
+	else if (!strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE))
+		transport_property_changed(proxy, name, iter);
 }
 
+static char *transport_generator(const char *text, int state)
+{
+	return generic_generator(text, state, transports);
+}
+
+static void cmd_list_transport(int argc, char *argv[])
+{
+	GList *l;
+
+	for (l = transports; l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+		print_transport(proxy, NULL);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_show_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Transport %s\n", g_dbus_proxy_get_path(proxy));
+
+	print_property(proxy, "UUID");
+	print_property(proxy, "Codec");
+	print_property(proxy, "Configuration");
+	print_property(proxy, "Device");
+	print_property(proxy, "State");
+	print_property(proxy, "Delay");
+	print_property(proxy, "Volume");
+	print_property(proxy, "Endpoint");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_acquire_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (transport.sk >= 0) {
+		bt_shell_printf("Transport socked %d already acquired\n",
+							transport.sk);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
+					acquire_reply, NULL, NULL)) {
+		bt_shell_printf("Failed acquire transport\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void release_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to release: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	close(transport.sk);
+	transport.sk = -1;
+
+	bt_shell_printf("Release successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_release_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (transport.sk < 0) {
+		bt_shell_printf("No Transport Socked found\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!g_dbus_proxy_method_call(proxy, "Release", NULL,
+					release_reply, NULL, NULL)) {
+		bt_shell_printf("Failed release transport\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static int open_file(const char *filename)
+{
+	int fd = -1;
+
+	bt_shell_printf("Opening %s ...\n", filename);
+
+	fd = open(filename, O_RDONLY);
+	if (fd <= 0)
+		bt_shell_printf("Can't open file %s: %s\n", filename,
+						strerror(errno));
+
+	return fd;
+}
+
+static int transport_send(int fd)
+{
+	uint8_t *buf;
+
+	buf = malloc(transport.mtu[1]);
+	if (!buf) {
+		bt_shell_printf("malloc: %s (%d)", strerror(errno), errno);
+		return -ENOMEM;
+	}
+
+	for (transport.seq = 0; ; transport.seq++) {
+		ssize_t ret;
+		int queued;
+
+		ret = read(fd, buf, transport.mtu[1]);
+		if (ret <= 0) {
+			if (ret < 0)
+				bt_shell_printf("read failed: %s (%d)",
+						strerror(errno), errno);
+			close(fd);
+			return ret;
+		}
+
+		ret = send(transport.sk, buf, ret, 0);
+		if (ret <= 0) {
+			bt_shell_printf("Send failed: %s (%d)",
+							strerror(errno), errno);
+			return -errno;
+		}
+
+		ioctl(transport.sk, TIOCOUTQ, &queued);
+
+		bt_shell_printf("[seq %d] send: %zd bytes "
+				"(TIOCOUTQ %d bytes)\n",
+				transport.seq, ret, queued);
+	}
+
+	free(buf);
+}
+
+static void cmd_send_transport(int argc, char *argv[])
+{
+	int fd, err;
+
+	if (transport.sk < 0) {
+		bt_shell_printf("No Transport Socked found\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	fd = open_file(argv[1]);
+
+	bt_shell_printf("Sending ...\n");
+	err = transport_send(fd);
+
+	close(fd);
+
+	if (err < 0)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static const struct bt_shell_menu transport_menu = {
+	.name = "transport",
+	.desc = "Media Transport Submenu",
+	.entries = {
+	{ "list",         NULL,    cmd_list_transport,
+						"List available transports" },
+	{ "show",        "<transport>", cmd_show_transport,
+						"Transport information",
+						transport_generator },
+	{ "acquire",     "<transport>",	cmd_acquire_transport,
+						"Acquire Transport",
+						transport_generator },
+	{ "release",     "<transport>",	cmd_release_transport,
+						"Release Transport",
+						transport_generator },
+	{ "send",        "<filename>",	cmd_send_transport,
+						"Send contents of a file" },
+	{} },
+};
+
 static GDBusClient *client;
 
 void player_add_submenu(void)
 {
 	bt_shell_add_submenu(&player_menu);
 	bt_shell_add_submenu(&endpoint_menu);
+	bt_shell_add_submenu(&transport_menu);
 
 	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
 	if (!dbus_conn || client)
-- 
2.35.1

