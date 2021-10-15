Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80254C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E55611C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhJOFLm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 01:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbhJOFLl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 01:11:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E25C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e65so5151544pgc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gO0Z/S805mULkQZTDEPEPY8IXHG2iR10DZEg/NfNjTg=;
        b=bvpUWcar9HmAhZiO/YITdiHZfbcnYmfrtCvb4JeIQGNf4BpHS/QlX7cGTK7vBQsRc3
         bKjRoGkgO/zAfc/0UrPV7Ph3Lwfr7Eftf6HmNvMgRcenUh2959Pg2s1poHcCm2OVp1bT
         4zlXc1nWQjiKGmHklBwxVfsUWssTYWNiM1kFpdPcJsfxf7NA7TynpxK7sPh3jKWUKImr
         m4/HoO1QNFF+XXLtslKv4BCD7dsMQpVvf4xaXJD0Vnu/NBZsC5lkKdSt2/NQsXVQ21ul
         aUR38OfCVRA0ieTbqfFKWlONeIlIsr7XU3hxcKXPIl0AQfbQo25As6sRXpM5nG5r7POc
         6P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gO0Z/S805mULkQZTDEPEPY8IXHG2iR10DZEg/NfNjTg=;
        b=HAsremLgceKnX9zJq6kDajvg9pJWuiv2yre60cBV3RBPd6t+HLgXD7uOASMHEZOI9z
         JIMn9Lmf4FWEkv18jnYlKBTqkus5fBJwVHMY+FVlxMHmfD5aAdUphfOeA2/dzGNGb1SC
         1Kmx8QgrIcov4adJjG5mIOgZ23Eg3Vs/wtVkC1+zzAFX55WSmwZsKmAg/7njbtzxnqYq
         biWMmUw+dg3CotjGYQJQJKmja2wiOoSkvj4GIlcr+9Ouo4Kybk2a3Lh+Nx/yTUBXjX3V
         vLf0IO6w/UTDYhUKD25wuuoUFgRG8F1nMHEqd01YO6i1Cnf5OZwABcWtwF/3JtG69P8/
         C3RQ==
X-Gm-Message-State: AOAM53229SWAjsJqML8SScDbxd3pL560nhJD739F3CwIiqkyj+qfao/s
        kg2tAYoiD2NMgUDsV1eRKyuvaihJYSs=
X-Google-Smtp-Source: ABdhPJz1dO8HeMlbxzthb9Qcap7QjUKx3p73PLABX+CA+ulKNqKqz/VW0yL7Xfn3/jGLV2U9QeVCTw==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr7553701pgh.8.1634274575269;
        Thu, 14 Oct 2021 22:09:35 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p17sm10347510pju.34.2021.10.14.22.09.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 22:09:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] vhci: Use io.h instead of mainloop.h
Date:   Thu, 14 Oct 2021 22:09:26 -0700
Message-Id: <20211015050929.3130100-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015050929.3130100-1-luiz.dentz@gmail.com>
References: <20211015050929.3130100-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The likes of mainloop_add_fd is not implemented in mainloop-glib.c while
io_set_read_handler so this makes it possible to use vhci instance with
both libshared-glib and libshared-mainloop.
---
 emulator/vhci.c | 67 +++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index 28cdef633..97fbcb8c4 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -24,14 +24,14 @@
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
 
-#include "src/shared/mainloop.h"
+#include "src/shared/io.h"
 #include "monitor/bt.h"
 #include "btdev.h"
 #include "vhci.h"
 
 struct vhci {
 	enum btdev_type type;
-	int fd;
+	struct io *io;
 	struct btdev *btdev;
 };
 
@@ -40,8 +40,7 @@ static void vhci_destroy(void *user_data)
 	struct vhci *vhci = user_data;
 
 	btdev_destroy(vhci->btdev);
-
-	close(vhci->fd);
+	io_destroy(vhci->io);
 
 	free(vhci);
 }
@@ -52,23 +51,21 @@ static void vhci_write_callback(const struct iovec *iov, int iovlen,
 	struct vhci *vhci = user_data;
 	ssize_t written;
 
-	written = writev(vhci->fd, iov, iovlen);
+	written = io_send(vhci->io, iov, iovlen);
 	if (written < 0)
 		return;
 }
 
-static void vhci_read_callback(int fd, uint32_t events, void *user_data)
+static bool vhci_read_callback(struct io *io, void *user_data)
 {
 	struct vhci *vhci = user_data;
+	int fd = io_get_fd(vhci->io);
 	unsigned char buf[4096];
 	ssize_t len;
 
-	if (events & (EPOLLERR | EPOLLHUP))
-		return;
-
-	len = read(vhci->fd, buf, sizeof(buf));
+	len = read(fd, buf, sizeof(buf));
 	if (len < 1)
-		return;
+		return false;
 
 	switch (buf[0]) {
 	case BT_H4_CMD_PKT:
@@ -78,6 +75,8 @@ static void vhci_read_callback(int fd, uint32_t events, void *user_data)
 		btdev_receive_h4(vhci->btdev, buf, len);
 		break;
 	}
+
+	return true;
 }
 
 bool vhci_set_debug(struct vhci *vhci, vhci_debug_func_t callback,
@@ -105,19 +104,11 @@ struct vhci *vhci_open(uint8_t type)
 	struct vhci *vhci;
 	struct vhci_create_req req;
 	struct vhci_create_rsp rsp;
+	int fd;
 
-	vhci = malloc(sizeof(*vhci));
-	if (!vhci)
-		return NULL;
-
-	memset(vhci, 0, sizeof(*vhci));
-	vhci->type = type;
-
-	vhci->fd = open("/dev/vhci", O_RDWR | O_NONBLOCK);
-	if (vhci->fd < 0) {
-		free(vhci);
+	fd = open("/dev/vhci", O_RDWR | O_NONBLOCK);
+	if (fd < 0)
 		return NULL;
-	}
 
 	memset(&req, 0, sizeof(req));
 	req.pkt_type = HCI_VENDOR_PKT;
@@ -131,34 +122,38 @@ struct vhci *vhci_open(uint8_t type)
 		break;
 	}
 
-	if (write(vhci->fd, &req, sizeof(req)) < 0) {
-		close(vhci->fd);
-		free(vhci);
+	if (write(fd, &req, sizeof(req)) < 0) {
+		close(fd);
 		return NULL;
 	}
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (read(vhci->fd, &rsp, sizeof(rsp)) < 0) {
-		close(vhci->fd);
-		free(vhci);
+	if (read(fd, &rsp, sizeof(rsp)) < 0) {
+		close(fd);
 		return NULL;
 	}
 
+	vhci = malloc(sizeof(*vhci));
+	if (!vhci)
+		return NULL;
+
+	memset(vhci, 0, sizeof(*vhci));
+	vhci->type = type;
+	vhci->io = io_new(fd);
+
+	io_set_close_on_destroy(vhci->io, true);
+
 	vhci->btdev = btdev_create(type, rsp.index);
 	if (!vhci->btdev) {
-		close(vhci->fd);
-		free(vhci);
+		vhci_destroy(vhci);
 		return NULL;
 	}
 
 	btdev_set_send_handler(vhci->btdev, vhci_write_callback, vhci);
 
-	if (mainloop_add_fd(vhci->fd, EPOLLIN, vhci_read_callback,
-						vhci, vhci_destroy) < 0) {
-		btdev_destroy(vhci->btdev);
-		close(vhci->fd);
-		free(vhci);
+	if (!io_set_read_handler(vhci->io, vhci_read_callback, vhci, NULL)) {
+		vhci_destroy(vhci);
 		return NULL;
 	}
 
@@ -170,7 +165,7 @@ void vhci_close(struct vhci *vhci)
 	if (!vhci)
 		return;
 
-	mainloop_remove_fd(vhci->fd);
+	vhci_destroy(vhci);
 }
 
 struct btdev *vhci_get_btdev(struct vhci *vhci)
-- 
2.31.1

