Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3ECC169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 17:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E545B20B1F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 17:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monadnock.ca header.i=@monadnock.ca header.b="YrUPAvgH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vtNuOWsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfBFRiG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:38:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58329 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727082AbfBFRiG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 12:38:06 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 91F8421D72;
        Wed,  6 Feb 2019 12:38:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 06 Feb 2019 12:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monadnock.ca; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=AGOD4jyAII/t1myP61b7y++foN
        h649ZMRP3u9tToVNo=; b=YrUPAvgH6Vqv+JquhfFdJNHF6C8XJKWWK+cVlguCls
        mlbKBi9rcLHbUe3JPfXzeM19ZsqGbxM+QpCzbkyLUD12CBByPXzKsubH9EW55EIC
        wzKbayDO6NldFr4ojPvarvzr9JvBr5QS6yBGW9Xpx0l2BKVBIbqDyzuIFSSNI8EQ
        8xg+GVJIx0HUfOVj9jeUcylkpIpIMOG0P/qEC3lSBICY6lj1jm4QtkNboGYhKs4F
        VBpBngXNgA12/4ucq8N9+ZEbO3RM6/N+zom3L2ITO+bV+fTqglSZBtL1RZcCvz9J
        0X2EhMDWnJji0aAHmbPe9zXao+rKj8RXGJTybq5PzHxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=AGOD4jyAII/t1myP6
        1b7y++foNh649ZMRP3u9tToVNo=; b=vtNuOWsBe2HnDGoJ1FzENB/wZwlo+AH9A
        YlHoARd0hkuS74zb/lXO2+Zu6xiX7tXWrLO6HPpMPLhIrMo5tgvgsBZ/vCt6GRRF
        9GVaaGa/8E6qAEHbnpbGdM9CGqn/an2xZT6KR0pFfz5V63GxcFMaTcxCVAia3uYL
        sLhcKf2+G6LztBR2d8np1jzKS57SkoyVf6dKiWym3+vTYPYYFJBZiaNuEn5AmGlJ
        wC1/90gHra/hwJGS74oa5TO7vX9lmRO6wFVpmDNu51q1t68BW49IJ2KonSUqlzO6
        WCPWYQYEyMfRKWGZIgr3/LXSt54OeHeNVunpIYqcSoT4zdryzpiwQ==
X-ME-Sender: <xms:fBtbXHo23M5bxPdITFcGMmIxi1i1qEwi2DEXA2Tm5Y0c1Y9HBQv2uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeekgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuhh
    grfihnucfpohgtkhcuoehshhgrfihnsehmohhnrggunhhotghkrdgtrgeqnecukfhppedv
    gedrheegrdekiedrudehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhgrfihnsehmoh
    hnrggunhhotghkrdgtrgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:fBtbXOmLuYST_fyvLexfAB7QkFlh6qEA_t8gXeBTAPBITArWvSeiMg>
    <xmx:fBtbXP0FabSItytu1T8Wzp3zqb36Tq6UFZ0OKiUbMpYAHi0mdHwy9w>
    <xmx:fBtbXDRpkz8UwLkbGIEOM_HEOV-H7f4QU7LhXchv2xcXA-K8KDK6MQ>
    <xmx:fBtbXN7fxD3ycQEnhBMaWQ518JEtQfRcdwisgSMwGv7cdo3dyh1v9Q>
Received: from mobile.monadnock.ca (ip-24-54-86-15.user.start.ca [24.54.86.15])
        by mail.messagingengine.com (Postfix) with ESMTPA id C703C100BA;
        Wed,  6 Feb 2019 12:38:03 -0500 (EST)
From:   Shawn Nock <shawn@monadnock.ca>
To:     linux-bluetooth@vger.kernel.org
Cc:     Shawn Nock <shawn@monadnock.ca>
Subject: [PATCH BlueZ v2] shared/io-libevent2: Add support for libevent2 based IO handing
Date:   Wed,  6 Feb 2019 12:37:48 -0500
Message-Id: <20190206173748.16765-1-shawn@monadnock.ca>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---

Nothing like reading your own work on a mailing list to help find issues. This patch:

- Handles the case where required io_set_context() missing by refusing io_new
- Postpone setting an event to pending until a handler has been set

src/shared/io-libevent2.c | 246 ++++++++++++++++++++++++++++++++++++++
 src/shared/io.h           |   1 +
 2 files changed, 247 insertions(+)
 create mode 100644 src/shared/io-libevent2.c

diff --git a/src/shared/io-libevent2.c b/src/shared/io-libevent2.c
new file mode 100644
index 000000000..486839520
--- /dev/null
+++ b/src/shared/io-libevent2.c
@@ -0,0 +1,246 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019       Shawn Nock <shawn@monadnock.ca>
+ *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <unistd.h>
+#include <errno.h>
+#include <sys/socket.h>
+
+#include <event2/event.h>
+
+#include "src/shared/io.h"
+#include "src/shared/util.h"
+
+struct io {
+  struct event *event;
+  io_callback_func_t read_callback;
+  io_destroy_func_t read_destroy;
+  void *read_data;
+  io_callback_func_t write_callback;
+  io_destroy_func_t write_destroy;
+  void *write_data;
+  io_callback_func_t disconnect_callback;
+  io_destroy_func_t disconnect_destroy;
+  void *disconnect_data;
+};
+
+static struct event_base *g_event_base = NULL;
+
+void io_set_context(void *v) {
+	g_event_base = v;
+}
+
+void io_callback(int fd, short which, void* arg)
+{
+    struct io *io = arg;
+    if (which & EV_READ && io->read_callback) {
+        io->read_callback(io, io->read_data);
+    }
+
+    if (which & EV_WRITE && io->write_callback){
+        io->write_callback(io, io->write_data);
+    }
+
+    if (which & EV_CLOSED && io->disconnect_callback) {
+        io->disconnect_callback(io, io->disconnect_data);
+    }
+}
+
+struct io *io_new(int fd)
+{
+	if (fd < 0 || !g_event_base) {
+        return NULL;
+    }
+
+	struct io *io = new0(struct io, 1);
+
+	io->event = event_new(g_event_base, fd, EV_PERSIST, io_callback, io);
+	if (!io->event) {
+		free(io);
+		return NULL;
+	}
+	return io;
+}
+
+void io_destroy(struct io *io)
+{
+	if (!io)
+		return;
+
+	if (io->event)
+	    event_del(io->event);
+		event_free(io->event);
+
+	free(io);
+}
+
+int io_get_fd(struct io *io)
+{
+	if (!io || !io->event)
+		return -ENOTCONN;
+
+	return event_get_fd(io->event);
+}
+
+bool io_set_close_on_destroy(struct io *io, bool do_close)
+{
+    if (!io || !io->event)
+        return false;
+
+    return true;
+}
+
+static short io_get_events(struct io* io)
+{
+    short which;
+    event_get_assignment(io->event, NULL, NULL, &which, NULL, NULL);
+    return which;
+}
+
+static void io_set_events(struct io* io, short events)
+{
+    struct event_base *base;
+    int fd;
+    event_callback_fn cb;
+    void *arg;
+
+    event_get_assignment(io->event, &base, &fd, NULL, &cb, &arg);
+    int pending = event_pending(io->event, EV_READ | EV_WRITE | EV_CLOSED, NULL);
+
+    if (pending) {
+        event_del(io->event);
+    }
+    event_assign(io->event, base, fd, events, cb, arg);
+    event_add(io->event, NULL);
+}
+
+static void io_update_events(struct io* io, short events, bool enable)
+{
+    short new_ev;
+    short cur = io_get_events(io);
+    if (enable) {
+        new_ev = cur | events;
+    } else {
+        new_ev = cur & ~events;
+    }
+    if (events != new_ev) {
+        io_set_events(io, new_ev);
+    }
+}
+
+bool io_set_read_handler(struct io *io, io_callback_func_t callback,
+                         void *user_data, io_destroy_func_t destroy)
+{
+    if (!io || !io->event)
+        return false;
+
+    if (io->read_destroy) {
+        io->read_destroy(io->read_data);
+    }
+
+    io->read_callback = callback;
+    io->read_destroy = destroy;
+    io->read_data = user_data;
+
+    io_update_events(io, EV_READ, (bool)callback);
+
+	return true;
+}
+
+bool io_set_write_handler(struct io *io, io_callback_func_t callback,
+                          void *user_data, io_destroy_func_t destroy)
+{
+	if (!io || !io->event)
+		return false;
+
+	if (io->write_destroy) {
+	    io->write_destroy(io->write_data);
+	}
+
+    io->write_callback = callback;
+    io->write_destroy = destroy;
+    io->write_data = user_data;
+
+    io_update_events(io, EV_WRITE, (bool)callback);
+
+    return true;
+}
+
+bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
+                               void *user_data, io_destroy_func_t destroy)
+{
+	if (!io || !io->event)
+		return false;
+
+	if (io->disconnect_destroy) {
+	    io->disconnect_destroy(io->disconnect_data);
+	}
+
+    io->disconnect_callback = callback;
+    io->disconnect_destroy = destroy;
+    io->disconnect_data = user_data;
+
+    io_update_events(io, EV_CLOSED, (bool)callback);
+
+	return true;
+}
+
+ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
+{
+	ssize_t ret;
+	int fd;
+
+	if (!io || !io->event)
+		return -ENOTCONN;
+
+	fd = io_get_fd(io);
+	if (fd < 0)
+		return -ENOTCONN;
+
+	do {
+		ret = writev(fd, iov, iovcnt);
+	} while (ret < 0 && errno == EINTR);
+
+	if (ret < 0)
+		return -errno;
+
+	return ret;
+}
+
+bool io_shutdown(struct io *io)
+{
+	int fd;
+
+	if (!io || !io->event)
+		return false;
+
+	fd = io_get_fd(io);
+	if (fd < 0)
+		return false;
+
+	return shutdown(fd, SHUT_RDWR) == 0;
+}
diff --git a/src/shared/io.h b/src/shared/io.h
index 8bc1111d0..9a8d54062 100644
--- a/src/shared/io.h
+++ b/src/shared/io.h
@@ -45,3 +45,4 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy);
 bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy);
+void io_set_context(void *);
\ No newline at end of file
--
2.20.1
