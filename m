Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0588CC0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F3D20827
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 16:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCiPa4DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F3D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeKHBpj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:45:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39388 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeKHBpj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 20:45:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so11878616lfh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 08:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=nw+AsApcp+6HX73IYeJDrtmZ/H2QlyUCV9ZlYmsRqFQ=;
        b=pCiPa4DGkIcI+Jic0Rd0eDbn6FU+7FUPFywQmoRLnfFFLbWzKlyxx3IcA7zS3vDHau
         RCeOdDDhH59Z5T975T9VTjF8vfHGdBS6MdLi57TKThquJD2EvVhL4PmbvaqWepYxTmlg
         zpCTqlXE8mQ8drcRFqOYVgGSt3uw4JAI3yTqLOZKt6iOYiHysioHqKdnstXZdPh1cpJQ
         IwwS7aqzyaLQJPZEye+9rVKo3g6+/cQXQLVkZFchjWn1+EKPPXyxv1PZ/TO2aaalNdTH
         YyxsTDKwy4jffOQpmegZUUeIct6JJrhb5i1Y40iYsbaj+8pKzKjAU0ItevuUX1h0/WSM
         k/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=nw+AsApcp+6HX73IYeJDrtmZ/H2QlyUCV9ZlYmsRqFQ=;
        b=RSFdJuZ7ymx8/tLMrdFyE7oZSCQ26yp1zfKzDEwNJoYL0zgFbxBAnpMEmTMc1jOaDe
         W45PHHm702g/ZT6+WUwGKItfmepckKBVt4fpuMzI+jwH8xDpd4qU+O0qAavvLliveVz4
         mdNLExR7RDUAhLRm7vfCwY1NrmM53hruJMebtEYuOj3zGTLjBClSSas761YahD7th5pv
         MdCVvN1nE70oBIhU1sSVaDk0yGO2X824RpqLYngj5NeN9OZJIUVKQAHRHtG060TAtHO4
         K6Spc4wm67nvwFAF5s1P6MsgX1WoNCOqiz/UCNoqi6zS6YpNkoAVSaT0uZS8Wruto8R6
         0m4Q==
X-Gm-Message-State: AGRZ1gJ5tvnGGNQ7YhHs+cbCzqZxDZbUK6vkof5rB12ujBJP+b0OTdD8
        F/I1neup0OkVfbFFBUytTk26UXkCRBo=
X-Google-Smtp-Source: AJdET5cIP+XeyDoOk+lhruLC+hch85j1pb92wG5KACpdUNkV48imuNNIfx8bJ3ExjMUnV3/Bnpx+EA==
X-Received: by 2002:a19:df41:: with SMTP id q1mr522079lfj.25.1541607275519;
        Wed, 07 Nov 2018 08:14:35 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id f95-v6sm199905lji.76.2018.11.07.08.14.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 08:14:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared/monitor: Add common code to interface with monitor
Date:   Wed,  7 Nov 2018 18:14:30 +0200
Message-Id: <20181107161432.13081-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables any code using shared to log into monitor.
---
 Makefile.am          |   1 +
 src/shared/monitor.c | 177 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/monitor.h |  30 ++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 src/shared/monitor.c
 create mode 100644 src/shared/monitor.h

diff --git a/Makefile.am b/Makefile.am
index 0ccf393c6..2243248aa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -119,6 +119,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/gatt-server.h src/shared/gatt-server.c \
 			src/shared/gatt-db.h src/shared/gatt-db.c \
 			src/shared/gap.h src/shared/gap.c \
+			src/shared/monitor.h src/shared/monitor.c \
 			src/shared/tty.h
 
 if READLINE
diff --git a/src/shared/monitor.c b/src/shared/monitor.c
new file mode 100644
index 000000000..78766ed1a
--- /dev/null
+++ b/src/shared/monitor.c
@@ -0,0 +1,177 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/socket.h>
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+
+#include "src/shared/util.h"
+#include "src/shared/monitor.h"
+
+struct monitor_hdr {
+	uint16_t opcode;
+	uint16_t index;
+	uint16_t len;
+	uint8_t  priority;
+	uint8_t  ident_len;
+} __attribute__((packed));
+
+struct monitor_l2cap_hdr {
+	uint16_t cid;
+	uint16_t psm;
+} __attribute__((packed));
+
+static int monitor_fd = -1;
+
+int bt_monitor_sendmsg(const char *label, int level, struct iovec *io,
+							size_t io_len)
+{
+	struct monitor_hdr hdr;
+	struct msghdr msg;
+	struct iovec iov[5];
+	size_t i;
+	int err;
+
+	if (io_len > 3)
+		return -EMSGSIZE;
+
+	monitor_fd = bt_monitor_open();
+	if (monitor_fd < 0)
+		return monitor_fd;
+
+	hdr.opcode = cpu_to_le16(0x0000);
+	hdr.index = cpu_to_le16(0xffff);
+	hdr.ident_len = strlen(label) + 1;
+	hdr.len = cpu_to_le16(2 + hdr.ident_len);
+	hdr.priority = level;
+
+	iov[0].iov_base = &hdr;
+	iov[0].iov_len = sizeof(hdr);
+
+	iov[1].iov_base = (void *) label;
+	iov[1].iov_len = hdr.ident_len;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 2;
+
+	for (i = 0; i < io_len; i++) {
+		iov[i + 2] = io[i];
+		hdr.len += io[i].iov_len;
+		msg.msg_iovlen++;
+	}
+
+	err = sendmsg(monitor_fd, &msg, 0);
+	if (err < 0) {
+		err = -errno;
+		close(monitor_fd);
+		monitor_fd = -1;
+	}
+
+	return err;
+}
+
+int bt_monitor_open(void)
+{
+	struct sockaddr_hci addr;
+	int fd;
+	int err;
+
+	if (monitor_fd >= 0)
+		return monitor_fd;
+
+	fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (fd < 0)
+		return -errno;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.hci_family = AF_BLUETOOTH;
+	addr.hci_dev = HCI_DEV_NONE;
+	addr.hci_channel = HCI_CHANNEL_LOGGING;
+
+	err = bind(fd, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0 ){
+		err = -errno;
+		close(fd);
+		return err;
+	}
+
+	monitor_fd = fd;
+
+	return fd;
+}
+
+int bt_monitor_vprintf(const char *label, int level, const char *format,
+								va_list ap)
+{
+	struct iovec iov;
+	char *str;
+	int err;
+
+	err = vasprintf(&str, format, ap);
+	if (err < 0)
+		return errno;
+
+	iov.iov_base = str;
+	iov.iov_len = strlen(str) + 1;
+
+	err = bt_monitor_sendmsg(label, level, &iov, 1);
+
+	free(str);
+
+	return err;
+}
+
+int bt_monitor_printf(const char *label, int level, const char *format, ...)
+{
+	va_list ap;
+	int err;
+
+	va_start(ap, format);
+	err = bt_monitor_vprintf(label, level, format, ap);
+	va_end(ap);
+
+	return err;
+}
+
+void bt_monitor_close(void)
+{
+	if (monitor_fd < 0)
+		return;
+
+	close(monitor_fd);
+	monitor_fd = -1;
+}
diff --git a/src/shared/monitor.h b/src/shared/monitor.h
new file mode 100644
index 000000000..0aa538e36
--- /dev/null
+++ b/src/shared/monitor.h
@@ -0,0 +1,30 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
+int bt_monitor_open(void);
+int bt_monitor_sendmsg(const char *label, int level, struct iovec *io,
+							size_t io_len);
+int bt_monitor_vprintf(const char *label, int level, const char *format,
+								va_list ap);
+int bt_monitor_printf(const char *label, int level, const char *format, ...);
+void bt_monitor_close(void);
-- 
2.17.2

