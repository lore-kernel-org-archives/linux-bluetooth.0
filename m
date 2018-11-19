Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19CFC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DD220851
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHBH367h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DD220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeKTCHS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:07:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35343 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729839AbeKTCHS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 21:07:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so21048363edx.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 07:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9MrL1/h2qBn8JW0bt20JseyEvgazYlN1tC1x65mag0o=;
        b=XHBH367hmncEKSlrqRVhbyCCwxt2D6WZnlwIkcvLzcf2cTRM3rL+HrRdJKVD98vB7j
         8nPImVFUqw+lOH5VYfG9Xnd+h/RJoKUA0LDyT/2kAAF1SHYjqne5iNsAEGdbWg/IkTx7
         RoUP1IUepkHoLMo8We0/BQdvOnJFI9pq+PHuYcbkdHbR9tlv2GGUNKp/8Uah3ZEslpg7
         +dyE74/HNxhxgsDDHQcIZrNHIkol0hXggDU9tnDMsw7YVY2Ov7TjWpoL2DOdywI58qQK
         63ERpk+BYqRSeKpBLUoxljmm7N227q/RSYSoO9hoNbLMQ6oqLSRypC4Fw/Ke1S5fZ98x
         r5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9MrL1/h2qBn8JW0bt20JseyEvgazYlN1tC1x65mag0o=;
        b=VdC8zI8OSAoep4Dd5IvgLj9I/rI7hk+SufTH1m3VPnQKJxeDMSz9vrHltZSnKEbIxl
         CUvs82jGu94/b7uO50HaCdYhnq/lX7VyLMHo62Je1O6T5rMPyVP/yoS5u8R7/wPSshDf
         sCNIgfYwI7d+Y5Kzh8OMJOXjWd/SWbBQlLhEJ5qr3bsO1XmhZPhld5bjh44Zt7qUdR2q
         WbJ6qDtbX4F/aSFiwaBLN4affaIfgYqaG98GCV1OeObkV8zGoNtpk90WqvXDdkzgvb88
         NpNSC5JmqWlNCSbOH8I1hUVEOvklBiVVylGhqmrlr1mz9RCMacIxMp9wRimATSD01cRm
         rZSA==
X-Gm-Message-State: AA+aEWaDvV47zaagT5mE76EIpaMj0WfObaE3LVWl4PigA6QiECn7LApn
        OSNvMcTKEuNQawmRFJ5YIrDxDVvr
X-Google-Smtp-Source: AFSGD/WNkMzb/amKTHh6uz96IfmJbm+cG7nRI9/GIOFl1xbT8K9GJDNoRLCSciEyxmiaT4IRI+vXnw==
X-Received: by 2002:a50:ae64:: with SMTP id c91mr1679451edd.222.1542642197913;
        Mon, 19 Nov 2018 07:43:17 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s3sm684448eda.69.2018.11.19.07.43.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 07:43:17 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] gatt: Switch from pipe2 to sockepair for Acquire*
Date:   Mon, 19 Nov 2018 17:43:09 +0200
Message-Id: <20181119154311.27826-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181119154311.27826-1-luiz.dentz@gmail.com>
References: <20181119154311.27826-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables to use sendmsg with MSG_NOSIGNAL.
---
 src/gatt-client.c   | 99 ++++++++++++++++++++++++++-------------------
 src/gatt-database.c | 26 +++++++-----
 2 files changed, 72 insertions(+), 53 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 55aa5e423..45ed3b170 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -90,7 +90,7 @@ struct async_dbus_op {
 	async_dbus_op_complete_t complete;
 };
 
-struct pipe_io {
+struct sock_io {
 	DBusMessage *msg;
 	struct io *io;
 	void (*destroy)(void *data);
@@ -109,8 +109,8 @@ struct characteristic {
 	char *path;
 
 	unsigned int ready_id;
-	struct pipe_io *write_io;
-	struct pipe_io *notify_io;
+	struct sock_io *write_io;
+	struct sock_io *notify_io;
 
 	struct async_dbus_op *read_op;
 	struct async_dbus_op *write_op;
@@ -1054,19 +1054,30 @@ fail:
 	return btd_error_not_supported(msg);
 }
 
-static bool chrc_pipe_read(struct io *io, void *user_data)
+static bool sock_read(struct io *io, void *user_data)
 {
 	struct characteristic *chrc = user_data;
 	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	struct msghdr msg;
 	uint8_t buf[512];
+	struct iovec iov;
 	int fd = io_get_fd(io);
 	ssize_t bytes_read;
 
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
+		error("recvmsg: %s", strerror(errno));
 		return false;
+	}
 
-	if (!gatt)
+	if (!gatt || bytes_read == 0)
 		return false;
 
 	bt_gatt_client_write_without_response(gatt, chrc->value_handle,
@@ -1076,7 +1087,7 @@ static bool chrc_pipe_read(struct io *io, void *user_data)
 	return true;
 }
 
-static void pipe_io_destroy(struct pipe_io *io)
+static void sock_io_destroy(struct sock_io *io)
 {
 	if (io->destroy)
 		io->destroy(io->data);
@@ -1088,20 +1099,19 @@ static void pipe_io_destroy(struct pipe_io *io)
 	free(io);
 }
 
-static void characteristic_destroy_pipe(struct characteristic *chrc,
-							struct io *io)
+static void destroy_sock(struct characteristic *chrc, struct io *io)
 {
 	queue_remove(chrc->service->client->ios, io);
 
 	if (chrc->write_io && io == chrc->write_io->io) {
-		pipe_io_destroy(chrc->write_io);
+		sock_io_destroy(chrc->write_io);
 		chrc->write_io = NULL;
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
 						chrc->path,
 						GATT_CHARACTERISTIC_IFACE,
 						"WriteAcquired");
 	} else if (chrc->notify_io) {
-		pipe_io_destroy(chrc->notify_io);
+		sock_io_destroy(chrc->notify_io);
 		chrc->notify_io = NULL;
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
 						chrc->path,
@@ -1110,22 +1120,21 @@ static void characteristic_destroy_pipe(struct characteristic *chrc,
 	}
 }
 
-static bool characteristic_pipe_hup(struct io *io, void *user_data)
+static bool sock_hup(struct io *io, void *user_data)
 {
 	struct characteristic *chrc = user_data;
 
 	DBG("%s: io %p", chrc->path, io);
 
-	characteristic_destroy_pipe(chrc, io);
+	destroy_sock(chrc, io);
 
 	return false;
 }
 
-static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
-						DBusMessage *msg)
+static DBusMessage *create_sock(struct characteristic *chrc, DBusMessage *msg)
 {
 	struct bt_gatt_client *gatt = chrc->service->client->gatt;
-	int pipefd[2];
+	int fds[2];
 	struct io *io;
 	bool dir;
 	uint16_t mtu;
@@ -1134,33 +1143,34 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
 	if (!gatt || !bt_gatt_client_is_ready(gatt))
 		return btd_error_failed(msg, "Not connected");
 
-	if (pipe2(pipefd, O_DIRECT | O_NONBLOCK | O_CLOEXEC) < 0)
+	if (socketpair(AF_LOCAL, SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC,
+								0, fds) < 0)
 		return btd_error_failed(msg, strerror(errno));
 
 	dir = dbus_message_has_member(msg, "AcquireWrite");
 
-	io = io_new(pipefd[!dir]);
+	io = io_new(fds[!dir]);
 	if (!io) {
-		close(pipefd[0]);
-		close(pipefd[1]);
+		close(fds[0]);
+		close(fds[1]);
 		return btd_error_failed(msg, strerror(EIO));
 	}
 
 	io_set_close_on_destroy(io, true);
 
-	if (!io_set_read_handler(io, chrc_pipe_read, chrc, NULL))
+	if (!io_set_read_handler(io, sock_read, chrc, NULL))
 		goto fail;
 
-	if (!io_set_disconnect_handler(io, characteristic_pipe_hup, chrc, NULL))
+	if (!io_set_disconnect_handler(io, sock_hup, chrc, NULL))
 		goto fail;
 
 	mtu = bt_gatt_client_get_mtu(gatt);
 
-	reply = g_dbus_create_reply(msg, DBUS_TYPE_UNIX_FD, &pipefd[dir],
+	reply = g_dbus_create_reply(msg, DBUS_TYPE_UNIX_FD, &fds[dir],
 					DBUS_TYPE_UINT16, &mtu,
 					DBUS_TYPE_INVALID);
 
-	close(pipefd[dir]);
+	close(fds[dir]);
 
 	if (dir) {
 		chrc->write_io->io = io;
@@ -1185,7 +1195,7 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
 
 fail:
 	io_destroy(io);
-	close(pipefd[dir]);
+	close(fds[dir]);
 	return btd_error_failed(msg, strerror(EIO));
 }
 
@@ -1197,7 +1207,7 @@ static void characteristic_ready(bool success, uint8_t ecode, void *user_data)
 	chrc->ready_id = 0;
 
 	if (chrc->write_io && chrc->write_io->msg) {
-		reply = characteristic_create_pipe(chrc, chrc->write_io->msg);
+		reply = create_sock(chrc, chrc->write_io->msg);
 
 		g_dbus_send_message(btd_get_dbus_connection(), reply);
 
@@ -1206,7 +1216,7 @@ static void characteristic_ready(bool success, uint8_t ecode, void *user_data)
 	}
 
 	if (chrc->notify_io && chrc->notify_io->msg) {
-		reply = characteristic_create_pipe(chrc, chrc->notify_io->msg);
+		reply = create_sock(chrc, chrc->notify_io->msg);
 
 		g_dbus_send_message(btd_get_dbus_connection(), reply);
 
@@ -1230,7 +1240,7 @@ static DBusMessage *characteristic_acquire_write(DBusConnection *conn,
 	if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
 		return btd_error_not_supported(msg);
 
-	chrc->write_io = new0(struct pipe_io, 1);
+	chrc->write_io = new0(struct sock_io, 1);
 
 	if (!bt_gatt_client_is_ready(gatt)) {
 		/* GATT not ready, wait until it becomes ready */
@@ -1242,7 +1252,7 @@ static DBusMessage *characteristic_acquire_write(DBusConnection *conn,
 		return NULL;
 	}
 
-	return characteristic_create_pipe(chrc, msg);
+	return create_sock(chrc, msg);
 }
 
 struct notify_client {
@@ -1414,21 +1424,26 @@ static void register_notify_cb(uint16_t att_ecode, void *user_data)
 static void notify_io_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
+	struct msghdr msg;
 	struct iovec iov;
 	struct notify_client *client = user_data;
 	struct characteristic *chrc = client->chrc;
 	int err;
 
-	/* Drop notification if the pipe is not ready */
-	if (!chrc->notify_io->io)
+	/* Drop notification if the sock is not ready */
+	if (!chrc->notify_io || !chrc->notify_io->io)
 		return;
 
 	iov.iov_base = (void *) value;
 	iov.iov_len = length;
 
-	err = io_send(chrc->notify_io->io, &iov, 1);
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	err = sendmsg(io_get_fd(chrc->notify_io->io), &msg, MSG_NOSIGNAL);
 	if (err < 0)
-		error("io_send: %s", strerror(-err));
+		error("sendmsg: %s", strerror(errno));
 }
 
 static void register_notify_io_cb(uint16_t att_ecode, void *user_data)
@@ -1499,7 +1514,7 @@ static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
 
 	queue_push_tail(chrc->notify_clients, client);
 
-	chrc->notify_io = new0(struct pipe_io, 1);
+	chrc->notify_io = new0(struct sock_io, 1);
 	chrc->notify_io->data = client;
 	chrc->notify_io->msg = dbus_message_ref(msg);
 	chrc->notify_io->destroy = notify_io_destroy;
@@ -1586,16 +1601,16 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
 	const char *sender = dbus_message_get_sender(msg);
 	struct notify_client *client;
 
+	if (chrc->notify_io) {
+		destroy_sock(chrc, chrc->notify_io->io);
+		return dbus_message_new_method_return(msg);
+	}
+
 	client = queue_remove_if(chrc->notify_clients, match_notify_sender,
 							(void *) sender);
 	if (!client)
 		return btd_error_failed(msg, "No notify session started");
 
-	if (chrc->notify_io) {
-		characteristic_destroy_pipe(chrc, chrc->notify_io->io);
-		return dbus_message_new_method_return(msg);
-	}
-
 	queue_remove(chrc->service->client->all_notify_clients, client);
 	bt_gatt_client_unregister_notify(gatt, client->notify_id);
 	update_notifying(chrc);
@@ -1664,12 +1679,12 @@ static void characteristic_free(void *data)
 
 	if (chrc->write_io) {
 		queue_remove(chrc->service->client->ios, chrc->write_io->io);
-		pipe_io_destroy(chrc->write_io);
+		sock_io_destroy(chrc->write_io);
 	}
 
 	if (chrc->notify_io) {
 		queue_remove(chrc->service->client->ios, chrc->notify_io->io);
-		pipe_io_destroy(chrc->notify_io);
+		sock_io_destroy(chrc->notify_io);
 	}
 
 	queue_destroy(chrc->notify_clients, remove_client);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index ec584fc3c..c31afa0e9 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2139,7 +2139,7 @@ static struct pending_op *send_write(struct btd_device *device,
 	return NULL;
 }
 
-static bool pipe_hup(struct io *io, void *user_data)
+static bool sock_hup(struct io *io, void *user_data)
 {
 	struct external_chrc *chrc = user_data;
 
@@ -2155,7 +2155,7 @@ static bool pipe_hup(struct io *io, void *user_data)
 	return false;
 }
 
-static bool pipe_io_read(struct io *io, void *user_data)
+static bool sock_io_read(struct io *io, void *user_data)
 {
 	struct external_chrc *chrc = user_data;
 	uint8_t buf[512];
@@ -2176,7 +2176,7 @@ static bool pipe_io_read(struct io *io, void *user_data)
 	return true;
 }
 
-static struct io *pipe_io_new(int fd, void *user_data)
+static struct io *sock_io_new(int fd, void *user_data)
 {
 	struct io *io;
 
@@ -2184,21 +2184,25 @@ static struct io *pipe_io_new(int fd, void *user_data)
 
 	io_set_close_on_destroy(io, true);
 
-	io_set_read_handler(io, pipe_io_read, user_data, NULL);
+	io_set_read_handler(io, sock_io_read, user_data, NULL);
 
-	io_set_disconnect_handler(io, pipe_hup, user_data, NULL);
+	io_set_disconnect_handler(io, sock_hup, user_data, NULL);
 
 	return io;
 }
 
-static int pipe_io_send(struct io *io, const void *data, size_t len)
+static int sock_io_send(struct io *io, const void *data, size_t len)
 {
+	struct msghdr msg;
 	struct iovec iov;
 
 	iov.iov_base = (void *) data;
 	iov.iov_len = len;
 
-	return io_send(io, &iov, 1);
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = &iov;
+
+	return sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
 }
 
 static void acquire_write_reply(DBusMessage *message, void *user_data)
@@ -2227,9 +2231,9 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 
 	DBG("AcquireWrite success: fd %d MTU %u\n", fd, mtu);
 
-	chrc->write_io = pipe_io_new(fd, chrc);
+	chrc->write_io = sock_io_new(fd, chrc);
 
-	if (pipe_io_send(chrc->write_io, op->data.iov_base,
+	if (sock_io_send(chrc->write_io, op->data.iov_base,
 				op->data.iov_len) < 0)
 		goto retry;
 
@@ -2308,7 +2312,7 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 
 	DBG("AcquireNotify success: fd %d MTU %u\n", fd, mtu);
 
-	chrc->notify_io = pipe_io_new(fd, chrc);
+	chrc->notify_io = sock_io_new(fd, chrc);
 
 	__sync_fetch_and_add(&chrc->ntfy_cnt, 1);
 
@@ -2685,7 +2689,7 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 		chrc->prep_authorized = false;
 
 	if (chrc->write_io) {
-		if (pipe_io_send(chrc->write_io, value, len) < 0) {
+		if (sock_io_send(chrc->write_io, value, len) < 0) {
 			error("Unable to write: %s", strerror(errno));
 			goto fail;
 		}
-- 
2.17.2

