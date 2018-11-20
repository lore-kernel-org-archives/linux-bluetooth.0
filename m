Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C731BC18DF5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAFA206BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slIXWFEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAFA206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeKUA1p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:27:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44863 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeKUA1p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 19:27:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so1969706edd.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 05:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=AxhPGKMLOfXQzGSiANP5TCUKP7aITrK2lrJvNAawjKs=;
        b=slIXWFEtcjTokqiPT+jWL2ygXn+00JS1qq6a72BJFm8eD9VrbuXJssuefthOak7DZG
         eKBNYzVTRdKcU+PbaOsRNlaw7zWXXNUMFIBarQj6R2FUwKwXUYzCJDFP29f0I/HMwJ7j
         gh0nhNQ2DOlJIdpcwGe06PtYh7zvfko8Tp9I84LvTC2aMcJ5ELYx5y0JdHvj/jJqWEPW
         S9HvJyziXQQM4IFETfboEjYuxpPKy3xAGkxEchFQtUC+1roiUb+KlLSTkib2ZlVBxx59
         4NDBTLeF+NwYA3946v+tbUtGkjGSkEsihU50MocpNBjFWY1Wh78Z5ny05LVGO08cP7j9
         S1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=AxhPGKMLOfXQzGSiANP5TCUKP7aITrK2lrJvNAawjKs=;
        b=QkVCbyIMHahIEqho3NPVfo3JMYYF34L2z4b9RIvRlL71w63FkEJw7hvCsZF4BVfArJ
         eDPdYrqGlFv0YvuyP4AvR5tid5ZBn+Ijh/HCHkntdIsakJNOdU56hbZmSy6vk4J3tWPa
         U9XT42mMRp3QQxBKT/MYa1ICRU+1HvKixhx52SBerLz6jdCHhQvh2zel/Xmp3Dl2wU7e
         9ixT/GnfLT24DLJU+DJzxDcaDjXnISfQiTkU9vWDy3Plm2WewPo/rMQ/j0N2iecLGSAY
         fLv38SGyUZOuRowEt4NRTmGoi+kKGEH61BChe1kjLcRAIyfBxWl/W5Y0jWLFHmPgC2+i
         K8vg==
X-Gm-Message-State: AGRZ1gJUmPgXh7ssaTkuzwq4FyqlYjxeZiarZ8hVtZp/nNrqBYj8qajd
        zO6be+f88xDtxBp9HwLnfpzqOqdx
X-Google-Smtp-Source: AJdET5dMdNpvCdM79FO6zEPGR4D2lJfstURrTjOy1Q/pTjBga8qOwybNm/jTBjESXxEzFLtIB7nX4Q==
X-Received: by 2002:a17:906:8488:: with SMTP id m8-v6mr2077625ejx.121.1542722305479;
        Tue, 20 Nov 2018 05:58:25 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id c29sm7200768eda.75.2018.11.20.05.58.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:58:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] shared/log: Add common code to interface with logging channel
Date:   Tue, 20 Nov 2018 15:58:18 +0200
Message-Id: <20181120135821.18082-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables any code using shared to log information using the logging
channel which can then be decoded by the likes of btmon.
---
 Makefile.am      |   1 +
 src/shared/log.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/log.h |  31 ++++++++
 3 files changed, 223 insertions(+)
 create mode 100644 src/shared/log.c
 create mode 100644 src/shared/log.h

diff --git a/Makefile.am b/Makefile.am
index 0ccf393c6..3f613a617 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -119,6 +119,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/gatt-server.h src/shared/gatt-server.c \
 			src/shared/gatt-db.h src/shared/gatt-db.c \
 			src/shared/gap.h src/shared/gap.c \
+			src/shared/log.h src/shared/log.c \
 			src/shared/tty.h
 
 if READLINE
diff --git a/src/shared/log.c b/src/shared/log.c
new file mode 100644
index 000000000..d42bae713
--- /dev/null
+++ b/src/shared/log.c
@@ -0,0 +1,191 @@
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
+#include "src/shared/log.h"
+
+struct log_hdr {
+	uint16_t opcode;
+	uint16_t index;
+	uint16_t len;
+	uint8_t  priority;
+	uint8_t  ident_len;
+} __attribute__((packed));
+
+struct log_l2cap_hdr {
+	uint16_t cid;
+	uint16_t psm;
+} __attribute__((packed));
+
+static int log_fd = -1;
+
+int bt_log_sendmsg(uint16_t index, const char *label, int level,
+					struct iovec *io, size_t io_len)
+{
+	struct log_hdr hdr;
+	struct msghdr msg;
+	struct iovec iov[5];
+	size_t i;
+	int err;
+
+	if (io_len > 3)
+		return -EMSGSIZE;
+
+	log_fd = bt_log_open();
+	if (log_fd < 0)
+		return log_fd;
+
+	hdr.opcode = cpu_to_le16(0x0000);
+	hdr.index = cpu_to_le16(index);
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
+	err = sendmsg(log_fd, &msg, 0);
+	if (err < 0) {
+		err = -errno;
+		close(log_fd);
+		log_fd = -1;
+	}
+
+	return err;
+}
+
+int bt_log_open(void)
+{
+	struct sockaddr_hci addr;
+	int fd;
+	static int err;
+
+	if (err < 0)
+		return err;
+
+	if (log_fd >= 0)
+		return log_fd;
+
+	fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (fd < 0) {
+		err = -errno;
+		return -errno;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.hci_family = AF_BLUETOOTH;
+	addr.hci_dev = HCI_DEV_NONE;
+	addr.hci_channel = HCI_CHANNEL_LOGGING;
+
+	err = bind(fd, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0) {
+		err = -errno;
+		close(fd);
+		return err;
+	}
+
+	log_fd = fd;
+
+	return fd;
+}
+
+int bt_log_vprintf(uint16_t index, const char *label, int level,
+					const char *format, va_list ap)
+{
+	struct iovec iov;
+	char *str;
+	int len;
+
+	len = vasprintf(&str, format, ap);
+	if (len < 0)
+		return errno;
+
+	len = strlen(str);
+
+	/* Replace new line since btmon already adds it */
+	if (len > 1 && str[len - 1] == '\n') {
+		str[len - 1] = '\0';
+		len--;
+	}
+
+	iov.iov_base = str;
+	iov.iov_len = len + 1;
+
+	len = bt_log_sendmsg(index, label, level, &iov, 1);
+
+	free(str);
+
+	return len;
+}
+
+int bt_log_printf(uint16_t index, const char *label, int level,
+						const char *format, ...)
+{
+	va_list ap;
+	int err;
+
+	va_start(ap, format);
+	err = bt_log_vprintf(index, label, level, format, ap);
+	va_end(ap);
+
+	return err;
+}
+
+void bt_log_close(void)
+{
+	if (log_fd < 0)
+		return;
+
+	close(log_fd);
+	log_fd = -1;
+}
diff --git a/src/shared/log.h b/src/shared/log.h
new file mode 100644
index 000000000..c72ab735b
--- /dev/null
+++ b/src/shared/log.h
@@ -0,0 +1,31 @@
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
+int bt_log_open(void);
+int bt_log_sendmsg(uint16_t index, const char *label, int level,
+					struct iovec *io, size_t io_len);
+int bt_log_vprintf(uint16_t index, const char *label, int level,
+					const char *format, va_list ap);
+int bt_log_printf(uint16_t index, const char *label, int level,
+					const char *format, ...);
+void bt_log_close(void);
-- 
2.17.2

