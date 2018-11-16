Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA83AC43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A452086B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 20:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="rn5NfTq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A452086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbeKQHK6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:10:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44917 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeKQHK5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 02:10:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id j17-v6so26165984wrq.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 12:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xua6V6pxnybJG69L+MEeTX79K44jDwOWUMB1JY1LJtY=;
        b=rn5NfTq0nQh3AAL57Db4DEclxf0SKIgF7OZCbgm3J7eOKLXW3S8actvh0zJ7I/rCg2
         WG72vBnLFrCBmXIZZFChV9mkK8f65uVKV8YpIzxM5DIrZiR9Mfw4ZqrEnZr3eoxredpQ
         vvSrl8jdeS6NOlqxZyKyNgKHwh3jffysqwk/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xua6V6pxnybJG69L+MEeTX79K44jDwOWUMB1JY1LJtY=;
        b=rswgZZ5MdMHFIyukN8+XdowP4zkbBN0umw2PfaFCQjvsAypY3oM609kjdmtecNPgzv
         alv+YfuLOwm1CMsqZQPHKYoSHWMeESLF3Nky2sJ/7ICyow7TB/ogn0FKFbI0hQ2U5ePV
         +VvJiI0dsU6ZlAp92pf13tcn9aiUJ1zgp3pahEhbXnPXof51QG37VApglAZ9V0682bmB
         InESr+dyg3Cl9Zj/i37kxc9tOcTvmK4tJ4tSz8umMV3dDshODaiYj0EvAukP2bZlTmox
         +LKgGcpZcasBWOdQgRu7FwCYDhzDxd4Nna1JcyB4U8/bHH+XGDWsRmYjmGyA3rEJAG8i
         BSqQ==
X-Gm-Message-State: AGRZ1gL3qi7PEJYou72ZcPS2YLTgRWMU1l2fk2FTu5ane8/ZLG1E0q/V
        0Rx/dCphJbvDVvu+gw3+4xpUO0KldOKkaA+QmVgVsJ9n7M1RpyYjb0gc/Xz2+es5TnNpjqgAtuC
        t34aUBaR3cjxwkYqfQLwwjdPDwaOK2YX9jtW4myjVFSRCcfWSrxIXyf7vgPeWAKuBZYIpljE0Jx
        /YCBI=
X-Google-Smtp-Source: AJdET5fVdrVbgRTs6cLcId9QcGVPLaJbDWaZzUaW/iR4gObnXSCup/78aEA1DrOuLIj1znpzSZvcmw==
X-Received: by 2002:a5d:408c:: with SMTP id o12-v6mr10112985wrp.90.1542401817016;
        Fri, 16 Nov 2018 12:56:57 -0800 (PST)
Received: from localhost.localdomain (bzq-79-182-246-1.red.bezeqint.net. [79.182.246.1])
        by smtp.gmail.com with ESMTPSA id u8-v6sm21914009wrr.33.2018.11.16.12.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 12:56:56 -0800 (PST)
From:   Gal Ben-Haim <gbenhaim@augury.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gal Ben-Haim <gbenhaim@augury.com>
Subject: [PATCH BlueZ] io_send: Write to pipes with the MSG_NOSIGNAL flag
Date:   Fri, 16 Nov 2018 22:56:51 +0200
Message-Id: <20181116205651.8800-1-gbenhaim@augury.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
was acquired by AcquireNotify and there are no readers. it can be
reproduced by terminating the reader process without closing the reader
end of the pipe.

Requesting not to send SIGPIPE will cause the write operation to return an
error which will be logged as "io_send: Broken pipe".
---
 src/shared/io-ell.c      | 14 ++++++++++++--
 src/shared/io-glib.c     | 15 +++++++++++++--
 src/shared/io-mainloop.c | 14 ++++++++++++--
 src/shared/io.h          |  2 +-
 4 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
index 6748982c7..2bd166966 100644
--- a/src/shared/io-ell.c
+++ b/src/shared/io-ell.c
@@ -117,7 +117,7 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 							user_data, destroy);
 }
 
-ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
+ssize_t io_send(struct io *io, struct iovec *iov, int iovcnt)
 {
 	ssize_t ret;
 	int fd;
@@ -129,8 +129,18 @@ ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
 	if (fd < 0)
 		return -ENOTCONN;
 
+	const struct msghdr msg = {
+                .msg_name = NULL,
+                .msg_namelen = 0,
+                .msg_iov = iov,
+                .msg_iovlen = iovcnt,
+                .msg_control = NULL,
+                .msg_controllen = 0,
+                .msg_flags = 0
+        };
+
 	do {
-		ret = writev(fd, iov, iovcnt);
+		ret = sendmsg(fd, &msg, MSG_NOSIGNAL);
 	} while (ret < 0 && errno == EINTR);
 
 	if (ret < 0)
diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index d62de4e10..7e4c9961b 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <errno.h>
+#include <sys/socket.h>
 
 #include <glib.h>
 
@@ -263,7 +264,7 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 	return io_set_handler(io, G_IO_HUP, callback, user_data, destroy);
 }
 
-ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
+ssize_t io_send(struct io *io, struct iovec *iov, int iovcnt)
 {
 	int fd;
 	ssize_t ret;
@@ -273,8 +274,18 @@ ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
 
 	fd = io_get_fd(io);
 
+	const struct msghdr msg = {
+                .msg_name = NULL,
+                .msg_namelen = 0,
+                .msg_iov = iov,
+                .msg_iovlen = iovcnt,
+                .msg_control = NULL,
+                .msg_controllen = 0,
+                .msg_flags = 0
+        };
+
 	do {
-		ret = writev(fd, iov, iovcnt);
+		ret = sendmsg(fd, &msg, MSG_NOSIGNAL);
 	} while (ret < 0 && errno == EINTR);
 
 	if (ret < 0)
diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index 2306c3479..4b6cc14c7 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -298,15 +298,25 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 	return true;
 }
 
-ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
+ssize_t io_send(struct io *io, struct iovec *iov, int iovcnt)
 {
 	ssize_t ret;
 
 	if (!io || io->fd < 0)
 		return -ENOTCONN;
 
+	const struct msghdr msg = {
+		.msg_name = NULL,
+		.msg_namelen = 0,
+		.msg_iov = iov,
+		.msg_iovlen = iovcnt,
+		.msg_control = NULL,
+		.msg_controllen = 0,
+		.msg_flags = 0
+	};
+      		
 	do {
-		ret = writev(io->fd, iov, iovcnt);
+		ret = sendmsg(io->fd, &msg, MSG_NOSIGNAL);
 	} while (ret < 0 && errno == EINTR);
 
 	if (ret < 0)
diff --git a/src/shared/io.h b/src/shared/io.h
index 8bc1111d0..522ec26ff 100644
--- a/src/shared/io.h
+++ b/src/shared/io.h
@@ -34,7 +34,7 @@ void io_destroy(struct io *io);
 int io_get_fd(struct io *io);
 bool io_set_close_on_destroy(struct io *io, bool do_close);
 
-ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt);
+ssize_t io_send(struct io *io, struct iovec *iov, int iovcnt);
 bool io_shutdown(struct io *io);
 
 typedef bool (*io_callback_func_t)(struct io *io, void *user_data);
-- 
2.19.1

