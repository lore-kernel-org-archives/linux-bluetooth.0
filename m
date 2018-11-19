Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6ECC04EBA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC0D20851
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBnoGQ7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC0D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeKTCHT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:07:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36764 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbeKTCHT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 21:07:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so16537336edb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=zrgwV60N2P0s0/Pe4rsc1h0nfm92Jz9nXksyHUsPt9Q=;
        b=WBnoGQ7xvBwzG+XiNDrz9GEm3kk46yYXdHlzQrnvpVV0+Cy7G+oWqU6fRPwCCkPr8Q
         ucxS9EqRtZTowpaFOF5oNNepEJOXU8BS5jH2q1V5z9iElX8fkNubtCUJZ02vAnYn9qDO
         luW/48teymoZX6o7yGLa4zVclTAXN0eVftjoQRU06G8gGMemxoxC1G9VTBUVZ1sl80G8
         NnqfBonWU9HZzzMatD1ldXb9sAyS3NhUy763H6G2K6bVQR1qBq9WFcNL5i+GZsHtnf2w
         WPt0WmUf7i8dygVRKJ05FvV6IQ6DF6j+pu5Py6KR+qCIM1G++4Pq6p61d2VjmH8ZTKo9
         zZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=zrgwV60N2P0s0/Pe4rsc1h0nfm92Jz9nXksyHUsPt9Q=;
        b=NDME4+/mqdfjMrqGHRC5ZW54cm9Ywj+cd3CjQU8Pcv0nUHOHY0tZTU2GN8A8H5gDZS
         3wRUyRgL+CoH856z4+xhmOprAGlZhft6AIQ6UOYEFUSqCqkqLI1jSEPVEtyjq7srRpA+
         9chIJr+QCJqqfGeQI2Ej14hqrT/TKcTFOmh2oUUZENvck0l9Yym4jnMGcTLlDGhVLIzr
         zw5Mogt4mWR7b9WekQHg6BF3X9t82UeUVqb+l9+v73MdB/rseTIHe5NXD8bFgxErxSl8
         5Ozuo9oDfnBpxTvPaKPnUM2TLMDO7sW1b9+rWcpo3zZZ+9le2VplGcnlbeB8XxKKJSoC
         OTEA==
X-Gm-Message-State: AGRZ1gKLMVH25cGK+T2XGmM35v5bje1lJ41cL9nSxGjqTBwuAKsd6BN9
        wvtyt4VVsBIZLenAK9DydKKKdcI9
X-Google-Smtp-Source: AJdET5dhLRx6Mzz5exj6XxcW7SVLRqS+5wyco6DrNapcerQeH2u4rYZoocRI6NLJ5u25f+DmNEmUtg==
X-Received: by 2002:a50:b3b8:: with SMTP id s53mr12709760edd.122.1542642199218;
        Mon, 19 Nov 2018 07:43:19 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s3sm684448eda.69.2018.11.19.07.43.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 07:43:18 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] client: Switch from write to sendmsg for Acquire*
Date:   Mon, 19 Nov 2018 17:43:10 +0200
Message-Id: <20181119154311.27826-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181119154311.27826-1-luiz.dentz@gmail.com>
References: <20181119154311.27826-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use sendmsg with MSG_NOSIGNAL to prevent crashes involving SIGPIPE.
---
 client/gatt.c | 85 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 25 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index c7dfe42d7..9877c4b47 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -33,6 +33,8 @@
 #include <sys/uio.h>
 #include <fcntl.h>
 #include <string.h>
+#include <sys/types.h>
+#include <sys/socket.h>
 
 #include <glib.h>
 
@@ -99,14 +101,14 @@ static GList *managers;
 static GList *uuids;
 static DBusMessage *pending_message = NULL;
 
-struct pipe_io {
+struct sock_io {
 	GDBusProxy *proxy;
 	struct io *io;
 	uint16_t mtu;
 };
 
-static struct pipe_io write_io;
-static struct pipe_io notify_io;
+static struct sock_io write_io;
+static struct sock_io notify_io;
 
 static void print_service(struct service *service, const char *description)
 {
@@ -635,6 +637,24 @@ static void write_setup(DBusMessageIter *iter, void *user_data)
 	dbus_message_iter_close_container(iter, &dict);
 }
 
+static int sock_send(struct io *io, struct iovec *iov, size_t iovlen)
+{
+	struct msghdr msg;
+	int ret;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = iov;
+	msg.msg_iovlen = iovlen;
+
+	ret = sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
+	if (ret < 0) {
+		ret = -errno;
+		bt_shell_printf("sendmsg: %s", strerror(-ret));
+	}
+
+	return ret;
+}
+
 static void write_attribute(GDBusProxy *proxy, char *val_str, uint16_t offset)
 {
 	struct iovec iov;
@@ -671,7 +691,7 @@ static void write_attribute(GDBusProxy *proxy, char *val_str, uint16_t offset)
 	if (proxy == write_io.proxy && (write_io.io && write_io.mtu >= i)) {
 		bt_shell_printf("Attempting to write fd %d\n",
 						io_get_fd(write_io.io));
-		if (io_send(write_io.io, &iov, 1) < 0) {
+		if (sock_send(write_io.io, &iov, 1) < 0) {
 			bt_shell_printf("Failed to write: %s", strerror(errno));
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
@@ -713,9 +733,11 @@ void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
-static bool pipe_read(struct io *io, void *user_data)
+static bool sock_read(struct io *io, void *user_data)
 {
 	struct chrc *chrc = user_data;
+	struct msghdr msg;
+	struct iovec iov;
 	uint8_t buf[MAX_ATTR_VAL_LEN];
 	int fd = io_get_fd(io);
 	ssize_t bytes_read;
@@ -723,8 +745,20 @@ static bool pipe_read(struct io *io, void *user_data)
 	if (io != notify_io.io && !chrc)
 		return true;
 
-	bytes_read = read(fd, buf, sizeof(buf));
-	if (bytes_read < 0)
+	iov.iov_base = buf;
+	iov.iov_len = sizeof(buf);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	bytes_read = recvmsg(fd, &msg, MSG_DONTWAIT);
+	if (bytes_read < 0) {
+		bt_shell_printf("recvmsg: %s", strerror(errno));
+		return false;
+	}
+
+	if (!bytes_read)
 		return false;
 
 	if (chrc)
@@ -739,12 +773,12 @@ static bool pipe_read(struct io *io, void *user_data)
 	return true;
 }
 
-static bool pipe_hup(struct io *io, void *user_data)
+static bool sock_hup(struct io *io, void *user_data)
 {
 	struct chrc *chrc = user_data;
 
 	if (chrc) {
-		bt_shell_printf("Attribute %s %s pipe closed\n", chrc->path,
+		bt_shell_printf("Attribute %s %s sock closed\n", chrc->path,
 				io == chrc->write_io ? "Write" : "Notify");
 
 		if (io == chrc->write_io) {
@@ -768,7 +802,7 @@ static bool pipe_hup(struct io *io, void *user_data)
 	return false;
 }
 
-static struct io *pipe_io_new(int fd, void *user_data)
+static struct io *sock_io_new(int fd, void *user_data)
 {
 	struct io *io;
 
@@ -776,9 +810,9 @@ static struct io *pipe_io_new(int fd, void *user_data)
 
 	io_set_close_on_destroy(io, true);
 
-	io_set_read_handler(io, pipe_read, user_data, NULL);
+	io_set_read_handler(io, sock_read, user_data, NULL);
 
-	io_set_disconnect_handler(io, pipe_hup, user_data, NULL);
+	io_set_disconnect_handler(io, sock_hup, user_data, NULL);
 
 	return io;
 }
@@ -810,7 +844,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 	bt_shell_printf("AcquireWrite success: fd %d MTU %u\n", fd,
 								write_io.mtu);
 
-	write_io.io = pipe_io_new(fd, NULL);
+	write_io.io = sock_io_new(fd, NULL);
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
@@ -892,7 +926,7 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 	bt_shell_printf("AcquireNotify success: fd %d MTU %u\n", fd,
 								notify_io.mtu);
 
-	notify_io.io = pipe_io_new(fd, NULL);
+	notify_io.io = sock_io_new(fd, NULL);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -1932,39 +1966,40 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static DBusMessage *chrc_create_pipe(struct chrc *chrc, DBusMessage *msg)
+static DBusMessage *create_sock(struct chrc *chrc, DBusMessage *msg)
 {
-	int pipefd[2];
+	int fds[2];
 	struct io *io;
 	bool dir;
 	DBusMessage *reply;
 
-	if (pipe2(pipefd, O_DIRECT | O_NONBLOCK | O_CLOEXEC) < 0)
+	if (socketpair(AF_LOCAL, SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC,
+								0, fds) < 0)
 		return g_dbus_create_error(msg, "org.bluez.Error.Failed", "%s",
 							strerror(errno));
 
 	dir = dbus_message_has_member(msg, "AcquireWrite");
 
-	io = pipe_io_new(pipefd[!dir], chrc);
+	io = sock_io_new(fds[!dir], chrc);
 	if (!io) {
-		close(pipefd[0]);
-		close(pipefd[1]);
+		close(fds[0]);
+		close(fds[1]);
 		return g_dbus_create_error(msg, "org.bluez.Error.Failed", "%s",
 							strerror(errno));
 	}
 
-	reply = g_dbus_create_reply(msg, DBUS_TYPE_UNIX_FD, &pipefd[dir],
+	reply = g_dbus_create_reply(msg, DBUS_TYPE_UNIX_FD, &fds[dir],
 					DBUS_TYPE_UINT16, &chrc->mtu,
 					DBUS_TYPE_INVALID);
 
-	close(pipefd[dir]);
+	close(fds[dir]);
 
 	if (dir)
 		chrc->write_io = io;
 	else
 		chrc->notify_io = io;
 
-	bt_shell_printf("[" COLORED_CHG "] Attribute %s %s pipe acquired\n",
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s %s sock acquired\n",
 					chrc->path, dir ? "Write" : "Notify");
 
 	return reply;
@@ -1993,7 +2028,7 @@ static DBusMessage *chrc_acquire_write(DBusConnection *conn, DBusMessage *msg,
 	bt_shell_printf("AcquireWrite: %s link %s\n", path_to_address(device),
 									link);
 
-	reply = chrc_create_pipe(chrc, msg);
+	reply = create_sock(chrc, msg);
 
 	if (chrc->write_io)
 		g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
@@ -2025,7 +2060,7 @@ static DBusMessage *chrc_acquire_notify(DBusConnection *conn, DBusMessage *msg,
 	bt_shell_printf("AcquireNotify: %s link %s\n", path_to_address(device),
 									link);
 
-	reply = chrc_create_pipe(chrc, msg);
+	reply = create_sock(chrc, msg);
 
 	if (chrc->notify_io)
 		g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
-- 
2.17.2

