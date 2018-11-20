Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EB0C41538
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFFB206BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlPnmcSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFFB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeKTVIh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:08:37 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34036 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeKTVIh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 16:08:37 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so1494371ede.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 02:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=zrgwV60N2P0s0/Pe4rsc1h0nfm92Jz9nXksyHUsPt9Q=;
        b=XlPnmcSIwNSHHayNA+wqWD7Gcx2ED3qv200rVL8HmtykMHN3DI5LwFcqm2UoJSR9DU
         qUfcb9vgMOjx6lumfc9QeEGZzBDiG0e2ss/+1EQj7P5QQv90BrvHhZL4RSBTAMDn9Ku3
         RTE+fjtz/QfqbsDmrMrNqZ4GekKi1Xe9Yv4BeJARMuwU0jdF2rdBn8BZZ+HfORf1VZhf
         tPml3idkjbiSjwJFx3chEsorKNOX6SGvEZP8nQXcaH8SoJdlWuydOs+3yb1BcmQ5Pix0
         O2xLZd1AKjyGvYCgprGtJwQktEBUfn8rU/IYFvqUCkpk7I1npqFW0LH++tjUCPHR/BrX
         qY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=zrgwV60N2P0s0/Pe4rsc1h0nfm92Jz9nXksyHUsPt9Q=;
        b=CJIWZfdeOhpofCsCjs6V3LeakMH4WK3/VrCovIBDHR2UYqHOXzQ69CK6m//Lm90L7F
         MGIyWORyGxaBcNEQ9Pm8wah8rk5hpLBty+OXGgOagMPNogcmn5HlvZ175F1IDDf5rCVY
         zRcoGk4QdejL992gYDSNsy+IsogSkVCAWGJyE8c2RGKegDZ8Pm9Sd23LKRILHJza8JI9
         gV9dCYxcQMnOLO2q2Le08oecobwIkQTu3tOPvGV7txpXl6z+Ivuhkn2RY0k2OeYR7yQo
         Ksi/N8rweShkeziLGu2s5FYI+LKRqtAf1RHaLlr23Zlx6Xbo9r5wN8Cw4mRzOemSKoEw
         aBEQ==
X-Gm-Message-State: AGRZ1gLU8ngu4q4yfxfoVj4B3gNzwQphSZOedBMl6bfxrPPMFyCH6/Of
        xWWXlEWWKDq1Z4j0Io+3lsUO8GJs
X-Google-Smtp-Source: AJdET5d5xpjAvr7L3cMICdN9WohUEHQjmd5gNcM3zK0znl+nRYecDUh+oFJd4GG+cqWSPCqRWUcGgw==
X-Received: by 2002:a17:906:1915:: with SMTP id a21-v6mr1590933eje.101.1542710406689;
        Tue, 20 Nov 2018 02:40:06 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id b42-v6sm14020900edd.81.2018.11.20.02.40.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 02:40:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] client: Switch from write to sendmsg for Acquire*
Date:   Tue, 20 Nov 2018 12:39:58 +0200
Message-Id: <20181120103959.23502-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181120103959.23502-1-luiz.dentz@gmail.com>
References: <20181120103959.23502-1-luiz.dentz@gmail.com>
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

