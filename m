Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747DDCCA473
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 21:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356197AbiFUVW7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356016AbiFUVWh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 17:22:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2721BB
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 14:12:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso11506567pjn.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSRdjVi09M+H3mpg3kD9IZ9UH4scsX3eZLOrwrtSzBA=;
        b=K8z+s2FIhp+lqi3AGQHnqkpk1IkTwNBiwpEsZciLew6D/EyMJNyd3zGFHugl2RYA+K
         JcKytfX5B5YPaLux+MTfxqmM6F8slQDSCZBecNA8xNVr4TkbD04gmSLoNMFatGj6kNjv
         zaGonxWXYvD1+N7Q9OvgePxHHlkOp32goWc0JV7Uv+cOQKriqZxMA4sWuYLmwzmKpHJg
         pV9YCMkHYyrFyq2sIbAuBhs3AjSfEVsYBO8jrtRHoT2fClUnV8XUpDVVWdVud9hsBEVp
         QDWNQyhnuA2aahi5NMMohvsQ2gIES4ngQ5skHtwJwCAubt8zpRMxRF9+uYVMRUuvMtWV
         n9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSRdjVi09M+H3mpg3kD9IZ9UH4scsX3eZLOrwrtSzBA=;
        b=nlDW9P6kCukIfEjpb74qJEddM8ugINwW2sG3gKTKk7r/EuuRjjHJCSs7kRhUcjgboN
         6b0LCmaj8WcdUQiAIOPACb01e3S+RyHG5PVRDsF20R1TezTYQm5yhEovTmyG1jV2+ncW
         B9IclfwU6dpnmoxg0gGaidYu1ujhNJpGtO8kzPsN2sk3zapy478u5IsuogP/B8pZxL5w
         1KkU0Bph8LSI8i559wUwI0Q0UHChiFiJyWX9uhV9iobxzkIZw0G2/gzOsTMwYkQG2CaA
         JVyNPTpk84zWNs7y5NAAIidjVuN9aHcFudg4BJzdu2slw4fcwHEUwRUlFNsVhjaxpGqG
         HrYQ==
X-Gm-Message-State: AJIora9ZfhBgZViltXrnZ8DutknXfHoGo1MpN04/ljnF8ndpMy4dirjZ
        mqS8RbzR8VRODVzg8Gzz7BStRIT7bCuvnQ==
X-Google-Smtp-Source: AGRyM1shz0YKnNEiL0cIRZmPE4t27xKltE292KAE/EUnZn/pPpw74qxb8yBgn2fmOZcm+GQq46/aXQ==
X-Received: by 2002:a17:902:e141:b0:16a:46c:dd3b with SMTP id d1-20020a170902e14100b0016a046cdd3bmr24501147pla.113.1655845942753;
        Tue, 21 Jun 2022 14:12:22 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w75-20020a62824e000000b0052523f7050bsm4712866pfd.118.2022.06.21.14.12.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 14:12:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/player: Enable acquiring multiple transports
Date:   Tue, 21 Jun 2022 14:12:21 -0700
Message-Id: <20220621211221.2382613-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables acquiring multiple transports simultaneously.
---
 client/player.c | 216 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 145 insertions(+), 71 deletions(-)

diff --git a/client/player.c b/client/player.c
index c2c10e7e2..2ba05c43c 100644
--- a/client/player.c
+++ b/client/player.c
@@ -77,17 +77,16 @@ static GList *items = NULL;
 static GList *endpoints = NULL;
 static GList *local_endpoints = NULL;
 static GList *transports = NULL;
+static struct queue *ios = NULL;
 
 struct transport {
+	GDBusProxy *proxy;
 	int sk;
-	int mtu[2];
+	uint16_t mtu[2];
 	char *filename;
 	int fd;
 	struct io *io;
 	uint32_t seq;
-} transport = {
-	.sk = -1,
-	.fd = -1,
 };
 
 static void endpoint_unregister(void *data)
@@ -2208,19 +2207,38 @@ static struct endpoint *find_ep_by_transport(const char *path)
 	return NULL;
 }
 
+static void transport_close(struct transport *transport)
+{
+	if (transport->fd < 0)
+		return;
+
+	close(transport->fd);
+	free(transport->filename);
+}
+
+static void transport_free(void *data)
+{
+	struct transport *transport = data;
+
+	io_destroy(transport->io);
+	free(transport);
+}
+
 static bool transport_disconnected(struct io *io, void *user_data)
 {
+	struct transport *transport = user_data;
+
 	bt_shell_printf("Transport fd disconnected\n");
 
-	io_destroy(transport.io);
-	transport.io = NULL;
-	transport.sk = -1;
+	if (queue_remove(ios, transport))
+		transport_free(transport);
 
 	return false;
 }
 
 static bool transport_recv(struct io *io, void *user_data)
 {
+	struct transport *transport = user_data;
 	uint8_t buf[1024];
 	int ret, len;
 
@@ -2231,12 +2249,12 @@ static bool transport_recv(struct io *io, void *user_data)
 		return true;
 	}
 
-	bt_shell_printf("[seq %d] recv: %u bytes\n", transport.seq, ret);
+	bt_shell_printf("[seq %d] recv: %u bytes\n", transport->seq, ret);
 
-	transport.seq++;
+	transport->seq++;
 
-	if (transport.fd) {
-		len = write(transport.fd, buf, ret);
+	if (transport->fd) {
+		len = write(transport->fd, buf, ret);
 		if (len < 0)
 			bt_shell_printf("Unable to write: %s (%d)",
 						strerror(errno), -errno);
@@ -2245,9 +2263,34 @@ static bool transport_recv(struct io *io, void *user_data)
 	return true;
 }
 
+static void transport_new(GDBusProxy *proxy, int sk, uint16_t mtu[2])
+{
+	struct transport *transport;
+
+	transport = new0(struct transport, 1);
+	transport->proxy = proxy;
+	transport->sk = sk;
+	transport->mtu[0] = mtu[0];
+	transport->mtu[1] = mtu[1];
+	transport->io = io_new(sk);
+	transport->fd = -1;
+
+	io_set_disconnect_handler(transport->io, transport_disconnected,
+							transport, NULL);
+	io_set_read_handler(transport->io, transport_recv, transport, NULL);
+
+	if (!ios)
+		ios = queue_new();
+
+	queue_push_tail(ios, transport);
+}
+
 static void acquire_reply(DBusMessage *message, void *user_data)
 {
+	GDBusProxy *proxy = user_data;
 	DBusError error;
+	int sk;
+	uint16_t mtu[2];
 
 	dbus_error_init(&error);
 
@@ -2258,9 +2301,9 @@ static void acquire_reply(DBusMessage *message, void *user_data)
 	}
 
 	if (!dbus_message_get_args(message, &error,
-				   DBUS_TYPE_UNIX_FD, &transport.sk,
-				   DBUS_TYPE_UINT16, &transport.mtu[0],
-				   DBUS_TYPE_UINT16, &transport.mtu[1],
+				   DBUS_TYPE_UNIX_FD, &sk,
+				   DBUS_TYPE_UINT16, &mtu[0],
+				   DBUS_TYPE_UINT16, &mtu[1],
 				   DBUS_TYPE_INVALID)) {
 		bt_shell_printf("Failed to parse Acquire() reply: %s",
 							error.name);
@@ -2268,15 +2311,10 @@ static void acquire_reply(DBusMessage *message, void *user_data)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Acquire successful: fd %d MTU %d:%d\n", transport.sk,
-					transport.mtu[0], transport.mtu[1]);
+	bt_shell_printf("Acquire successful: fd %d MTU %u:%u\n", sk, mtu[0],
+								mtu[1]);
 
-	io_destroy(transport.io);
-	transport.io = io_new(transport.sk);
-
-	io_set_disconnect_handler(transport.io, transport_disconnected, NULL,
-								NULL);
-	io_set_read_handler(transport.io, transport_recv, NULL, NULL);
+	transport_new(proxy, sk, mtu);
 
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
@@ -2287,7 +2325,7 @@ static void transport_acquire(const char *input, void *user_data)
 
 	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
 		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
-						acquire_reply, NULL, NULL))
+						acquire_reply, proxy, NULL))
 			bt_shell_printf("Failed acquire transport\n");
 	}
 }
@@ -2320,7 +2358,7 @@ static void transport_property_changed(GDBusProxy *proxy, const char *name,
 	if (ep->auto_accept) {
 		bt_shell_printf("Auto Accepting...\n");
 		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
-						acquire_reply, NULL, NULL))
+						acquire_reply, proxy, NULL))
 			bt_shell_printf("Failed acquire transport\n");
 		return;
 	}
@@ -2390,16 +2428,23 @@ static void cmd_show_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static bool match_proxy(const void *data, const void *user_data)
+{
+	const struct transport *transport = data;
+	const GDBusProxy *proxy = user_data;
+
+	return transport->proxy == proxy;
+}
+
+static struct transport *find_transport(GDBusProxy *proxy)
+{
+	return queue_find(ios, match_proxy, proxy);
+}
+
 static void cmd_acquire_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (transport.sk >= 0) {
-		bt_shell_printf("Transport socked %d already acquired\n",
-							transport.sk);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
-
 	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
 	if (!proxy) {
@@ -2407,8 +2452,13 @@ static void cmd_acquire_transport(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if (find_transport(proxy)) {
+		bt_shell_printf("Transport %s already acquired\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
-					acquire_reply, NULL, NULL)) {
+					acquire_reply, proxy, NULL)) {
 		bt_shell_printf("Failed acquire transport\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
@@ -2418,6 +2468,7 @@ static void cmd_acquire_transport(int argc, char *argv[])
 
 static void release_reply(DBusMessage *message, void *user_data)
 {
+	struct transport *transport = user_data;
 	DBusError error;
 
 	dbus_error_init(&error);
@@ -2428,8 +2479,8 @@ static void release_reply(DBusMessage *message, void *user_data)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	close(transport.sk);
-	transport.sk = -1;
+	if (queue_remove(ios, transport))
+		transport_free(transport);
 
 	bt_shell_printf("Release successful\n");
 
@@ -2439,11 +2490,7 @@ static void release_reply(DBusMessage *message, void *user_data)
 static void cmd_release_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
-
-	if (transport.sk < 0) {
-		bt_shell_printf("No Transport Socked found\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
+	struct transport *transport;
 
 	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
@@ -2452,8 +2499,14 @@ static void cmd_release_transport(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	transport = find_transport(proxy);
+	if (!transport) {
+		bt_shell_printf("Transport %s not acquired\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	if (!g_dbus_proxy_method_call(proxy, "Release", NULL,
-					release_reply, NULL, NULL)) {
+					release_reply, transport, NULL)) {
 		bt_shell_printf("Failed release transport\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
@@ -2479,21 +2532,21 @@ static int open_file(const char *filename, int flags)
 	return fd;
 }
 
-static int transport_send(int fd)
+static int transport_send(struct transport *transport, int fd)
 {
 	uint8_t *buf;
 
-	buf = malloc(transport.mtu[1]);
+	buf = malloc(transport->mtu[1]);
 	if (!buf) {
 		bt_shell_printf("malloc: %s (%d)", strerror(errno), errno);
 		return -ENOMEM;
 	}
 
-	for (transport.seq = 0; ; transport.seq++) {
+	for (transport->seq = 0; ; transport->seq++) {
 		ssize_t ret;
 		int queued;
 
-		ret = read(fd, buf, transport.mtu[1]);
+		ret = read(fd, buf, transport->mtu[1]);
 		if (ret <= 0) {
 			if (ret < 0)
 				bt_shell_printf("read failed: %s (%d)",
@@ -2502,18 +2555,18 @@ static int transport_send(int fd)
 			return ret;
 		}
 
-		ret = send(transport.sk, buf, ret, 0);
+		ret = send(transport->sk, buf, ret, 0);
 		if (ret <= 0) {
 			bt_shell_printf("Send failed: %s (%d)",
 							strerror(errno), errno);
 			return -errno;
 		}
 
-		ioctl(transport.sk, TIOCOUTQ, &queued);
+		ioctl(transport->sk, TIOCOUTQ, &queued);
 
 		bt_shell_printf("[seq %d] send: %zd bytes "
 				"(TIOCOUTQ %d bytes)\n",
-				transport.seq, ret, queued);
+				transport->seq, ret, queued);
 	}
 
 	free(buf);
@@ -2521,17 +2574,33 @@ static int transport_send(int fd)
 
 static void cmd_send_transport(int argc, char *argv[])
 {
+	GDBusProxy *proxy;
+	struct transport *transport;
 	int fd, err;
 
-	if (transport.sk < 0) {
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	transport = find_transport(proxy);
+	if (!transport) {
+		bt_shell_printf("Transport %s not acquired\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (transport->sk < 0) {
 		bt_shell_printf("No Transport Socked found\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	fd = open_file(argv[1], O_RDONLY);
+	fd = open_file(argv[2], O_RDONLY);
 
 	bt_shell_printf("Sending ...\n");
-	err = transport_send(fd);
+
+	err = transport_send(transport, fd);
 
 	close(fd);
 
@@ -2541,34 +2610,39 @@ static void cmd_send_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void transport_close(void)
-{
-	if (transport.fd < 0)
-		return;
-
-	close(transport.fd);
-	transport.fd = -1;
-
-	free(transport.filename);
-	transport.filename = NULL;
-}
 
 static void cmd_receive_transport(int argc, char *argv[])
 {
-	if (argc == 1) {
-		bt_shell_printf("Filename: %s\n", transport.filename);
-		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	GDBusProxy *proxy;
+	struct transport *transport;
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	transport_close();
+	transport = find_transport(proxy);
+	if (!transport) {
+		bt_shell_printf("Transport %s not acquired\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
-	transport.fd = open_file(argv[1], O_RDWR | O_CREAT);
-	if (transport.fd < 0)
+	if (transport->sk < 0) {
+		bt_shell_printf("No Transport Socked found\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	transport_close(transport);
+
+	transport->fd = open_file(argv[2], O_RDWR | O_CREAT);
+	if (transport->fd < 0)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	transport.filename = strdup(argv[1]);
+	transport->filename = strdup(argv[2]);
 
-	bt_shell_printf("Filename: %s\n", transport.filename);
+	bt_shell_printf("Filename: %s\n", transport->filename);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -2633,9 +2707,9 @@ static const struct bt_shell_menu transport_menu = {
 	{ "release",     "<transport>",	cmd_release_transport,
 						"Release Transport",
 						transport_generator },
-	{ "send",        "<filename>",	cmd_send_transport,
+	{ "send",        "<transport> <filename>", cmd_send_transport,
 						"Send contents of a file" },
-	{ "receive",     "[filename]",	cmd_receive_transport,
+	{ "receive",     "<transport> [filename]", cmd_receive_transport,
 						"Get/Set file to receive" },
 	{ "volume",      "<transport> [value]",	cmd_volume_transport,
 						"Get/Set transport volume",
@@ -2665,5 +2739,5 @@ void player_add_submenu(void)
 void player_remove_submenu(void)
 {
 	g_dbus_client_unref(client);
-	transport_close();
+	queue_destroy(ios, transport_free);
 }
-- 
2.35.3

