Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5442EC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100CA20851
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7mAoZ76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100CA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbeKTCHV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:07:21 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39373 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbeKTCHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 21:07:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so23243970edt.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 07:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bpW/DGNDU3dMOYzZ6TfMd7bIlN5mysm47qJUbkiB4BA=;
        b=X7mAoZ76RiWeXIEDuhmuoSwRP2Xj36CLcS0NkEIy4uNWrsjE3ezz6W3Nado22h1r/B
         W9DJ8qyHP4OzmAFaRMmL2L7VpbqWmYgQhhJ+qA2BxaLOn3lB8thSMkQTNOfjPZ/+L3M3
         y1gO+QJHElfJBwEkVp1yT5QSLb+rl1vnOYn6CGzu/aYxGiJAEeyO+wQ5JnL6V3Hf2dyO
         /8ZWVO9e0kTFBYv7X6cjX4DVfgSEPc+aUDH4dlVsY0PmttR2dMu6di3gO9yF7W5Xz9ys
         AyoAy9PIQT8+o6cgzCZp/vfoZCMJ9CLzANgi3EigJfomwr5BXeIRu0owJL/TrYHuU8GI
         tx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bpW/DGNDU3dMOYzZ6TfMd7bIlN5mysm47qJUbkiB4BA=;
        b=SIZxg6eTiI18ivWBSjXz9TOHW6iR8UwEJwkzbpoaRKOKWMz0WC7v3h52AqjGFGvovD
         DcoPLsrbFPciUrUZWNzhsNEpnL3NKe8T/qZSBPia1CPdr1geUk7pVHsFSQCqMX7gdzBS
         gRJ0tAhdSWMMB3m+O02hU1zvk7ns5ZR6JlxhoMHlbRBULc/LREaxHnfiRYQBIAGCRnzH
         VNwPCBkXrILfH867gf8sOxyIJUmHDifGkf377LRnzlPHC5no1U0qCGOMpdNmSKCZJLBT
         NgNhR1LdCoEXu1+asnmH3x0NraV6OegxdNDI4WnhKfjoWuJKZSCpXshjRqTZBPPB1eZs
         gUKQ==
X-Gm-Message-State: AA+aEWZrOugIW5dyd/Nid74U6/jgOILOypyGlWNFZAFLU5LjaHKRgk5a
        URubj33oZuaFVrCqF3d7hsdztC0Y
X-Google-Smtp-Source: AFSGD/UvHOiqgUufnME+s9f5SsytluCd0jbv3Gun0qBOfzXWBRhlMEmCXm//SblMMnr3cQSYxGir0Q==
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr4803007edd.188.1542642200476;
        Mon, 19 Nov 2018 07:43:20 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s3sm684448eda.69.2018.11.19.07.43.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 07:43:19 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] meshctl: Switch from write to sendmsg for Acquire*
Date:   Mon, 19 Nov 2018 17:43:11 +0200
Message-Id: <20181119154311.27826-5-luiz.dentz@gmail.com>
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
 tools/mesh/gatt.c | 64 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/tools/mesh/gatt.c b/tools/mesh/gatt.c
index 2c29c09b5..2269a20cf 100644
--- a/tools/mesh/gatt.c
+++ b/tools/mesh/gatt.c
@@ -166,7 +166,25 @@ uint16_t mesh_gatt_sar(uint8_t **pkt, uint16_t size)
 	}
 }
 
-static bool pipe_write(struct io *io, void *user_data)
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
+static bool sock_write(struct io *io, void *user_data)
 {
 	struct write_data *data = user_data;
 	struct iovec iov[2];
@@ -200,9 +218,8 @@ static bool pipe_write(struct io *io, void *user_data)
 
 		iov[1] = data->iov;
 
-		err = io_send(io, iov, 2);
+		err = sock_send(io, iov, 2);
 		if (err < 0) {
-			bt_shell_printf("Failed to write: %s\n", strerror(-err));
 			write_data_free(data);
 			return false;
 		}
@@ -247,7 +264,7 @@ static void notify_io_destroy(void)
 	notify_mtu = 0;
 }
 
-static bool pipe_hup(struct io *io, void *user_data)
+static bool sock_hup(struct io *io, void *user_data)
 {
 	bt_shell_printf("%s closed\n", io == notify_io ? "Notify" : "Write");
 
@@ -259,7 +276,7 @@ static bool pipe_hup(struct io *io, void *user_data)
 	return false;
 }
 
-static struct io *pipe_io_new(int fd)
+static struct io *sock_io_new(int fd)
 {
 	struct io *io;
 
@@ -267,7 +284,7 @@ static struct io *pipe_io_new(int fd)
 
 	io_set_close_on_destroy(io, true);
 
-	io_set_disconnect_handler(io, pipe_hup, NULL, NULL);
+	io_set_disconnect_handler(io, sock_hup, NULL, NULL);
 
 	return io;
 }
@@ -296,9 +313,9 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 
 	bt_shell_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_mtu);
 
-	write_io = pipe_io_new(fd);
+	write_io = sock_io_new(fd);
 
-	pipe_write(write_io, data);
+	sock_write(write_io, data);
 }
 
 static void acquire_setup(DBusMessageIter *iter, void *user_data)
@@ -342,7 +359,7 @@ bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
 	data->cb = cb;
 
 	if (write_io)
-		return pipe_write(write_io, data);
+		return sock_write(write_io, data);
 
 	if (g_dbus_proxy_method_call(proxy, "AcquireWrite",
 				acquire_setup, acquire_write_reply,
@@ -377,9 +394,11 @@ done:
 	g_free(data);
 }
 
-static bool pipe_read(struct io *io, bool prov, void *user_data)
+static bool sock_read(struct io *io, bool prov, void *user_data)
 {
 	struct mesh_node *node = user_data;
+	struct msghdr msg;
+	struct iovec iov;
 	uint8_t buf[512];
 	uint8_t *res;
 	int fd = io_get_fd(io);
@@ -388,9 +407,16 @@ static bool pipe_read(struct io *io, bool prov, void *user_data)
 	if (io != notify_io)
 		return true;
 
-	while ((len = read(fd, buf, sizeof(buf)))) {
+	iov.iov_base = buf;
+	iov.iov_len = sizeof(buf);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	while ((len = recvmsg(fd, &msg, MSG_DONTWAIT))) {
 		if (len <= 0)
-			break;
+			return false;
 
 		res = buf;
 		len_sar = mesh_gatt_sar(&res, len);
@@ -404,14 +430,14 @@ static bool pipe_read(struct io *io, bool prov, void *user_data)
 	return true;
 }
 
-static bool pipe_read_prov(struct io *io, void *user_data)
+static bool sock_read_prov(struct io *io, void *user_data)
 {
-	return pipe_read(io, true, user_data);
+	return sock_read(io, true, user_data);
 }
 
-static bool pipe_read_proxy(struct io *io, void *user_data)
+static bool sock_read_proxy(struct io *io, void *user_data)
 {
-	return pipe_read(io, false, user_data);
+	return sock_read(io, false, user_data);
 }
 
 static void acquire_notify_reply(DBusMessage *message, void *user_data)
@@ -457,15 +483,15 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 	if (g_dbus_proxy_get_property(data->proxy, "UUID", &iter) == FALSE)
 		goto done;
 
-	notify_io = pipe_io_new(fd);
+	notify_io = sock_io_new(fd);
 
 	dbus_message_iter_get_basic(&iter, &uuid);
 
 	if (!bt_uuid_strcmp(uuid, MESH_PROV_DATA_OUT_UUID_STR))
-		io_set_read_handler(notify_io, pipe_read_prov, data->user_data,
+		io_set_read_handler(notify_io, sock_read_prov, data->user_data,
 									NULL);
 	else if (!bt_uuid_strcmp(uuid, MESH_PROXY_DATA_OUT_UUID_STR))
-		io_set_read_handler(notify_io, pipe_read_proxy, data->user_data,
+		io_set_read_handler(notify_io, sock_read_proxy, data->user_data,
 									NULL);
 
 done:
-- 
2.17.2

