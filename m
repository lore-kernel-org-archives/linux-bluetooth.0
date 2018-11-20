Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE07C04EBC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9B0206BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzfNV9Hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9B0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeKTVIi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:08:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37924 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbeKTVIi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 16:08:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so1475589ede.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 02:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bpW/DGNDU3dMOYzZ6TfMd7bIlN5mysm47qJUbkiB4BA=;
        b=hzfNV9Hvc0Wl9DPuhPAfu7xAH2/v3b8Y171lOAgn29RlpnboUNTjrf7GbziJdqDBt6
         Cdj/1tgATAjThajdG4Bs1pRo1K7nR3s3ms7aTbBQfNj9ycDOYnbOJ+nfS5YocOyA+dmz
         M0EAgS4BKm3tUSzZCI4j38kjs31N/4LDHK0ukpH3O1v0LqYa5e/e6gEq01lvEIoATMDU
         vklxtrh6ZYqliJy0yNXg/1xDzYoK8Py4a/HH2TTRSCJosI/2i9n2o/OE2SBFs6MS0CIp
         PUlJv0FIdv9eGMkdN45tKf90vQZvgh5jXLVIA8hu0P5DHUh4QwRIIeL3L1JtAYsUBY3i
         xchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bpW/DGNDU3dMOYzZ6TfMd7bIlN5mysm47qJUbkiB4BA=;
        b=k2mEFYqFPwnllTOv7I9Y7SWmNhzprkNXZa+IGLlbpVqa1L1Fp1R2fq/lzxJq2YC/TO
         LfMQtayQgFS3NindWLcPt9sPoMr+4iV1MzTILyqnmwVROL3JNbSso3F28OgoAVZ/B554
         hCkSR0rlBstHs4Cb3r8SQpY3S951K3EHxZVFGqs5rLtjzcFn2hoFoiWFWVsqfBuIlzyj
         Pq9gd+2vY2uaBUyRzJC2OySonRIEXDmSiM2zczqymZeiwp+7rcBczaIc/PX0fobzwIFc
         bb1Aj94082zmAsG8JG3l9U7VP34uNYHWJP4MPo+TwHAm7B+X86ckMmWNxTZAqZoFsvUB
         FEuw==
X-Gm-Message-State: AA+aEWYcOnAmJyRK69Iz20lVl+Zj5aUvdSvvn6KLCy47HI0GRJg4xSli
        L+DMW6sLoQA35xJsf6/PLQ7BBBDj
X-Google-Smtp-Source: AFSGD/UnyTVGLWEExfjWdHqeSxeAdvFO3iRy1j1ox7Yi+kDeRx3Lro4G+XkYgNqVi19BWvaOIJr5ig==
X-Received: by 2002:a50:8799:: with SMTP id a25mr1844466eda.96.1542710407914;
        Tue, 20 Nov 2018 02:40:07 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id b42-v6sm14020900edd.81.2018.11.20.02.40.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 02:40:07 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] meshctl: Switch from write to sendmsg for Acquire*
Date:   Tue, 20 Nov 2018 12:39:59 +0200
Message-Id: <20181120103959.23502-5-luiz.dentz@gmail.com>
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

