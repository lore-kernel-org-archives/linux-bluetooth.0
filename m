Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C150C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 21:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiDMVTf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbiDMVTP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 17:19:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B489CE2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 14:16:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 2so3234163pjw.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kNnApWt355hV732yLZY/fXafskFMfCujC5QBunvC7bs=;
        b=UGcqzGVuW7GH6QDe3GnZgvjlMWXDi/qIvHfQ2pWth/VSns4GNuEcfajaIwCrxa8RbB
         Iy+xNXEi8znAUq+b02YMfiunN2Hai+lYX9K5qIznKz9YePJgTZs+nVyf88+/AsmNiHVm
         TFxFutGwTYKImzMVWZ1YhLrZNwjb71WXNgQVo4B+elsDwLUm3foYDa3F53zP5yz/UDLS
         vGop56RPUSPgJZrrWSGBT9bYSeZ7+/eEPh4IEHUVm7GlQ51lEqbmC+sbs4WexbnNERSh
         PsIHZBLXCnir8wRZbdV5pdSsGs0I6yJQkmIzyXsje9ZLDONtK3VmjXPXfXnK5JdCSg7X
         d3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNnApWt355hV732yLZY/fXafskFMfCujC5QBunvC7bs=;
        b=qjSHZ+q/G5tTFq45gdzjB+c6m4hJ6HpA6+/96wyS2sW7t56gc7FFE6I4D2CFhe3ut/
         ixEcB8X9noVsuHvVAmWr9LCdq2wNt4HeyCnBpFiHCPwERUz+EKTRwXl4PvEyR+DM4fsy
         +2pyUeVa7l4XebQrz4DhpPBpN05PMdS2K1b2U/46uDb3XYGzrvX4Q/yXvF+mPyOlhzts
         KttGgpSJeSiRTxNhTSzFYYDEqMI9kGNYAUooJgrrax+/o61N8xH+RSRzaW2eH6d+OHNy
         RJ9eaUVFm1vPLAJ2xUSB4t7p+wFwLIf+dTA8ubPbIpLp+0cZDc26qlwJjdFLmHhw3yGZ
         vtOg==
X-Gm-Message-State: AOAM533VrrbTvBkEUaVjr16Q5oSAR6TLyndp9Pk05ax2849Ymy4fkuVi
        1Xe/kfm0tOMaJ8k7wLC7ikwo7FouwhM=
X-Google-Smtp-Source: ABdhPJwWQUvbepq69wcPECiKdJckMEjPGwUU2ElyJXWvABgql4mvEcaY+nmkE5e3VuZ0ONfp5YNECA==
X-Received: by 2002:a17:902:7e0d:b0:156:47a4:a7c4 with SMTP id b13-20020a1709027e0d00b0015647a4a7c4mr45112199plm.141.1649884593229;
        Wed, 13 Apr 2022 14:16:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm7683pfx.81.2022.04.13.14.16.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:16:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 2/2] client/player: Add transport menu
Date:   Wed, 13 Apr 2022 14:16:30 -0700
Message-Id: <20220413211630.171843-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413211630.171843-1-luiz.dentz@gmail.com>
References: <20220413211630.171843-1-luiz.dentz@gmail.com>
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
index 5db35cfeb..bcd12d594 100644
--- a/client/player.c
+++ b/client/player.c
@@ -50,6 +50,7 @@
 #define BLUEZ_MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
 #define BLUEZ_MEDIA_ITEM_INTERFACE "org.bluez.MediaItem1"
 #define BLUEZ_MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+#define BLUEZ_MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
 #define BLUEZ_MEDIA_ENDPOINT_PATH "/local/endpoint"
 
@@ -75,6 +76,16 @@ static GList *folders = NULL;
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
@@ -1639,8 +1650,9 @@ static char *uuid_generator(const char *text, int state)
 	static int index = 0;
 	size_t i;
 
-	if (!state)
+	if (!state) {
 		index = 0;
+	}
 
 	for (i = index; i < ARRAY_SIZE(caps); i++) {
 		const struct capabilities *cap = &caps[i];
@@ -2144,6 +2156,26 @@ static void endpoint_added(GDBusProxy *proxy)
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
@@ -2160,6 +2192,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		item_added(proxy);
 	else if (!strcmp(interface, BLUEZ_MEDIA_ENDPOINT_INTERFACE))
 		endpoint_added(proxy);
+	else if (!strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE))
+		transport_added(proxy);
 }
 
 static void media_removed(GDBusProxy *proxy)
@@ -2200,6 +2234,13 @@ static void endpoint_removed(GDBusProxy *proxy)
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
@@ -2216,6 +2257,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		item_removed(proxy);
 	if (!strcmp(interface, BLUEZ_MEDIA_ENDPOINT_INTERFACE))
 		endpoint_removed(proxy);
+	if (!strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE))
+		transport_removed(proxy);
 }
 
 static void player_property_changed(GDBusProxy *proxy, const char *name,
@@ -2258,6 +2301,134 @@ static void endpoint_property_changed(GDBusProxy *proxy, const char *name,
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
@@ -2273,14 +2444,226 @@ static void property_changed(GDBusProxy *proxy, const char *name,
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

