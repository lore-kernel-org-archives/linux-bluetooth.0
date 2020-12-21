Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8DBC433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 23:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2824F229CA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 23:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgLUXCZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 18:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLUXCZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 18:02:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA1C0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 15:01:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b5so292318pjl.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 15:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BfmpI0KTCdyAGKzQ+8ywEXg/zOYwXP89HRvv3RjC2NI=;
        b=fNe4fADUYN2jOmZwBEfAKQG9RspkLXAeLFEj67xZF4ASOJmEdE5BSuQ0lBAxheoHhk
         ohljTSXvEzblFs3tnrAP5a7bqaSb7CJuV1AVvtZp/wvp8ils1Ndo8GujymjM/+CMz9X7
         f76bATOTGGGucEBKZ9tjJlIEdWy4DxJG16Ij7kXQAgQa1xRAdIG4qvvADhno8OJNg04j
         vcQ3XYpJS8wKKCDsgnMDIZu+ga934/MbcboL7xCJRjFkCoqOxxNwL8c0cKaEBgJlohvi
         v+WXk5sMJ0bCQ2vjqfb4Mh+s/wXHXMDC/h/d2xIKtybu1evjETKau2i3PJAuFiFv6QjR
         9kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfmpI0KTCdyAGKzQ+8ywEXg/zOYwXP89HRvv3RjC2NI=;
        b=g8YWw24pImqvv7qGXpBIPPm5ieWbwLAn5YImuUgpp0X/5I26Wf2Vsv0VjfI+E600P1
         NWNowAEdkXYcToCc92KmhmOC3BSapxPWPPOF5IoHeX7c6GzCLVutWVe3YUfTvhIn5xUG
         J+0iP6NpZ58IEWR0ZNxSZrsWUwd5/0lIg74erc2hrQG0fsuejpYVhsZEEFOAbiZBgola
         FnmUscb6l/zeQqtbvoMYfCtaF/ZqvbRubAB/g1HzVZU3H38ZxhD5TPuB+HSP7yX689wJ
         /0pMFPRcg8K/+DLHL0Tiq3hdnqqx9JBmmEu++UwCcQYWjZDz+rIBQYWW0vRsAq59hBmO
         5KlQ==
X-Gm-Message-State: AOAM533NQJt1fV082sc7ozMgSfxpm7js6vHDn16w7gqJSR7hSdTpqqf8
        BV4mbjzw/ZOQa0fWDprCB61zFdgnq8A=
X-Google-Smtp-Source: ABdhPJwSWTOKXT8i5lezOcxc1RYv8BW/5BMc9G5KGUX0l/9mQ5UjclLNgK96LqAtYpsr78Z/4fKI5g==
X-Received: by 2002:a17:902:ff12:b029:db:d7b7:c99d with SMTP id f18-20020a170902ff12b02900dbd7b7c99dmr18290154plj.14.1608591703471;
        Mon, 21 Dec 2020 15:01:43 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a19sm17131855pfi.130.2020.12.21.15.01.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 15:01:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] tools: Add isotest tool
Date:   Mon, 21 Dec 2020 15:01:38 -0800
Message-Id: <20201221230140.2100824-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201221230140.2100824-1-luiz.dentz@gmail.com>
References: <20201221230140.2100824-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds isotest tool which can be used to test ISO sockets.
---
 Makefile.tools  |   5 +-
 tools/isotest.c | 845 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 849 insertions(+), 1 deletion(-)
 create mode 100644 tools/isotest.c

diff --git a/Makefile.tools b/Makefile.tools
index d5fdf2d89..c1eb2778a 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -191,7 +191,8 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/eddystone tools/ibeacon \
 			tools/btgatt-client tools/btgatt-server \
 			tools/test-runner tools/check-selftest \
-			tools/gatt-service profiles/iap/iapd
+			tools/gatt-service profiles/iap/iapd \
+			tools/isotest
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
 tools_bdaddr_LDADD = lib/libbluetooth-internal.la $(UDEV_LIBS)
@@ -291,6 +292,8 @@ tools_gatt_service_LDADD = $(GLIB_LIBS) $(DBUS_LIBS) gdbus/libgdbus-internal.la
 profiles_iap_iapd_SOURCES = profiles/iap/main.c
 profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
+tools_isotest_LDADD = lib/libbluetooth-internal.la
+
 dist_man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1
 
 EXTRA_DIST += tools/bdaddr.1
diff --git a/tools/isotest.c b/tools/isotest.c
new file mode 100644
index 000000000..6abe2fd8a
--- /dev/null
+++ b/tools/isotest.c
@@ -0,0 +1,845 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <syslog.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/socket.h>
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+#include "lib/hci_lib.h"
+#include "lib/iso.h"
+
+#include "src/shared/util.h"
+
+/* Test modes */
+enum {
+	SEND,
+	RECV,
+	RECONNECT,
+	MULTY,
+	DUMP,
+	CONNECT
+};
+
+static unsigned char *buf;
+
+/* Default data size */
+static long data_size = 251;
+
+static bdaddr_t bdaddr;
+static int bdaddr_type = BDADDR_LE_PUBLIC;
+
+static int defer_setup = 0;
+
+struct bt_iso_qos *iso_qos = NULL;
+static bool inout;
+
+struct lookup_table {
+	const char *name;
+	int flag;
+};
+
+static struct lookup_table bdaddr_types[] = {
+	{ "le_public",	BDADDR_LE_PUBLIC	},
+	{ "le_random",	BDADDR_LE_RANDOM	},
+	{ NULL,		0			},
+};
+
+static int get_lookup_flag(struct lookup_table *table, char *name)
+{
+	int i;
+
+	for (i = 0; table[i].name; i++)
+		if (!strcasecmp(table[i].name, name))
+			return table[i].flag;
+
+	return -1;
+}
+
+static void print_lookup_values(struct lookup_table *table, char *header)
+{
+	int i;
+
+	printf("%s\n", header);
+
+	for (i = 0; table[i].name; i++)
+		printf("\t%s\n", table[i].name);
+}
+
+static float tv2fl(struct timeval tv)
+{
+	return (float)tv.tv_sec + (float)(tv.tv_usec/1000000.0);
+}
+
+static int do_connect(char *peer)
+{
+	struct sockaddr_iso addr;
+	struct bt_iso_qos qos;
+	socklen_t len;
+	int sk;
+
+	/* Create socket */
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
+	if (sk < 0) {
+		syslog(LOG_ERR, "Can't create socket: %s (%d)",
+							strerror(errno), errno);
+		return -1;
+	}
+
+	/* Bind to local address */
+	memset(&addr, 0, sizeof(addr));
+	addr.iso_family = AF_BLUETOOTH;
+	bacpy(&addr.iso_bdaddr, &bdaddr);
+	addr.iso_bdaddr_type = bdaddr_type;
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		syslog(LOG_ERR, "Can't bind socket: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
+	/* Set QoS if available */
+	if (iso_qos) {
+		if (!inout) {
+			iso_qos->in.phy = 0x00;
+			iso_qos->in.sdu = 0;
+		}
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, iso_qos,
+					sizeof(*iso_qos)) < 0) {
+			syslog(LOG_ERR, "Can't set QoS socket option: "
+					"%s (%d)", strerror(errno), errno);
+		}
+	}
+
+	/* Enable deferred setup */
+	if (defer_setup && setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
+				&defer_setup, sizeof(defer_setup)) < 0) {
+		syslog(LOG_ERR, "Can't enable deferred setup : %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
+	/* Connect to remote device */
+	memset(&addr, 0, sizeof(addr));
+	addr.iso_family = AF_BLUETOOTH;
+	str2ba(peer, &addr.iso_bdaddr);
+	addr.iso_bdaddr_type = bdaddr_type;
+
+	syslog(LOG_INFO, "Connecting %s ...", peer);
+
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		syslog(LOG_ERR, "Can't connect: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
+	/* Read Out QOS */
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos);
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
+		syslog(LOG_ERR, "Can't get QoS socket option: %s (%d)",
+				strerror(errno), errno);
+		goto error;
+	}
+
+	syslog(LOG_INFO, "Connected [%s]", peer);
+	syslog(LOG_INFO, "QoS [CIG 0x%02x CIS 0x%02x Packing 0x%02x "
+		"Framing 0x%02x]", qos.cig, qos.cis, qos.packing, qos.framing);
+	syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
+		"ms SDU %u PHY 0x%02x RTN %u]", qos.in.interval,
+		qos.in.latency, qos.in.sdu, qos.in.phy, qos.in.rtn);
+	syslog(LOG_INFO, "Output QoS [Interval %u us Latency %u "
+		"ms SDU %u PHY 0x%02x RTN %u]", qos.out.interval,
+		qos.out.latency, qos.out.sdu, qos.out.phy, qos.out.rtn);
+
+	return sk;
+
+error:
+	close(sk);
+	return -1;
+}
+
+static void do_listen(char *filename, void (*handler)(int fd, int sk))
+{
+	struct sockaddr_iso addr;
+	socklen_t optlen;
+	int sk, nsk, fd = -1;
+	char ba[18];
+
+	if (filename) {
+		fd = open(filename, O_WRONLY | O_CREAT | O_APPEND, 0644);
+		if (fd < 0) {
+			syslog(LOG_ERR, "Can't open file %s: %s\n",
+						filename, strerror(errno));
+			exit(1);
+		}
+	}
+
+	/* Create socket */
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
+	if (sk < 0) {
+		syslog(LOG_ERR, "Can't create socket: %s (%d)",
+							strerror(errno), errno);
+		if (fd >= 0)
+			close(fd);
+		exit(1);
+	}
+
+	/* Bind to local address */
+	memset(&addr, 0, sizeof(addr));
+	addr.iso_family = AF_BLUETOOTH;
+	bacpy(&addr.iso_bdaddr, &bdaddr);
+	addr.iso_bdaddr_type = bdaddr_type;
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		syslog(LOG_ERR, "Can't bind socket: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
+	/* Enable deferred setup */
+	if (defer_setup && setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
+				&defer_setup, sizeof(defer_setup)) < 0) {
+		syslog(LOG_ERR, "Can't enable deferred setup : %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
+	/* Listen for connections */
+	if (listen(sk, 10)) {
+		syslog(LOG_ERR,"Can not listen on the socket: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
+	syslog(LOG_INFO,"Waiting for connection ...");
+
+	while (1) {
+		memset(&addr, 0, sizeof(addr));
+		optlen = sizeof(addr);
+
+		nsk = accept(sk, (struct sockaddr *) &addr, &optlen);
+		if (nsk < 0) {
+			syslog(LOG_ERR,"Accept failed: %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+		if (fork()) {
+			/* Parent */
+			close(nsk);
+			continue;
+		}
+		/* Child */
+		close(sk);
+
+		ba2str(&addr.iso_bdaddr, ba);
+		syslog(LOG_INFO, "Connect from %s", ba);
+
+		/* Handle deferred setup */
+		if (defer_setup) {
+			syslog(LOG_INFO, "Waiting for %d seconds",
+							abs(defer_setup) - 1);
+			sleep(abs(defer_setup) - 1);
+
+			if (defer_setup < 0) {
+				close(nsk);
+				exit(1);
+			}
+		}
+
+		handler(fd, nsk);
+
+		syslog(LOG_INFO, "Disconnect");
+		exit(0);
+	}
+
+error:
+	if (fd >= 0)
+		close(fd);
+	close(sk);
+	exit(1);
+}
+
+static void dump_mode(int fd, int sk)
+{
+	int len;
+
+	if (defer_setup) {
+		len = read(sk, buf, data_size);
+		if (len < 0)
+			syslog(LOG_ERR, "Initial read error: %s (%d)",
+						strerror(errno), errno);
+		else
+			syslog(LOG_INFO, "Initial bytes %d", len);
+	}
+
+	syslog(LOG_INFO,"Receiving ...");
+	while ((len = read(sk, buf, data_size)) > 0) {
+		if (fd >= 0) {
+			len = write(fd, buf, len);
+			if (len < 0) {
+				syslog(LOG_ERR, "Write failed: %s (%d)",
+						strerror(errno), errno);
+				return;
+			}
+		} else
+			syslog(LOG_INFO, "Received %d bytes", len);
+	}
+}
+
+static void recv_mode(int fd, int sk)
+{
+	struct timeval tv_beg,tv_end,tv_diff;
+	long total;
+	int len;
+
+	if (defer_setup) {
+		len = read(sk, buf, data_size);
+		if (len < 0)
+			syslog(LOG_ERR, "Initial read error: %s (%d)",
+						strerror(errno), errno);
+		else
+			syslog(LOG_INFO, "Initial bytes %d", len);
+	}
+
+	syslog(LOG_INFO, "Receiving ...");
+
+	while (1) {
+		gettimeofday(&tv_beg, NULL);
+		total = 0;
+		while (total < data_size) {
+			int r;
+
+			r = recv(sk, buf, data_size, 0);
+			if (r <= 0) {
+				if (r < 0)
+					syslog(LOG_ERR, "Read failed: %s (%d)",
+							strerror(errno), errno);
+				if (errno != ENOTCONN)
+					return;
+				r = 0;
+			}
+
+			if (fd >= 0) {
+				r = write(fd, buf, r);
+				if (r < 0) {
+					syslog(LOG_ERR, "Write failed: %s (%d)",
+							strerror(errno), errno);
+					return;
+				}
+			}
+
+			total += r;
+		}
+		gettimeofday(&tv_end, NULL);
+
+		timersub(&tv_end, &tv_beg, &tv_diff);
+
+		syslog(LOG_INFO,"%ld bytes in %.2f sec speed %.2f kb/s", total,
+			tv2fl(tv_diff),
+			(float)(total * 8 / tv2fl(tv_diff)) / 1024.0);
+	}
+}
+
+static int open_file(const char *filename)
+{
+	int fd = -1;
+
+	syslog(LOG_INFO,"Opening %s ...", filename);
+
+	fd = open(filename, O_RDONLY);
+	if (fd <= 0) {
+		syslog(LOG_ERR, "Can't open file %s: %s\n",
+						filename, strerror(errno));
+	}
+
+	return fd;
+}
+
+static void send_mode(char *filename, char *peer, int i)
+{
+	struct bt_iso_qos qos;
+	socklen_t len;
+	uint32_t seq;
+	int sk, fd = -1;
+
+	if (filename) {
+		char altername[PATH_MAX];
+		struct stat st;
+		int err;
+
+		snprintf(altername, PATH_MAX, "%s.%u", filename, i);
+
+		err = stat(altername, &st);
+		if (!err)
+			fd = open_file(altername);
+
+		if (fd <= 0)
+			fd = open_file(filename);
+	}
+
+	sk = do_connect(peer);
+	if (sk < 0) {
+		syslog(LOG_ERR, "Can't connect to the server: %s (%d)",
+							strerror(errno), errno);
+		exit(1);
+	}
+
+	if (defer_setup) {
+		syslog(LOG_INFO, "Waiting for %d seconds",
+			abs(defer_setup) - 1);
+		sleep(abs(defer_setup) - 1);
+	}
+
+	syslog(LOG_INFO,"Sending ...");
+
+	/* Read QoS */
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos);
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
+		syslog(LOG_ERR, "Can't get Output QoS socket option: %s (%d)",
+				strerror(errno), errno);
+		qos.out.sdu = ISO_DEFAULT_MTU;
+	}
+
+	for (i = 6; i < qos.out.sdu; i++)
+		buf[i] = 0x7f;
+
+	seq = 0;
+	while (1) {
+		if (fd >= 0) {
+			ssize_t ret;
+
+			ret = read(fd, buf, qos.out.sdu);
+			if (ret <= 0) {
+				if (ret < 0)
+					syslog(LOG_ERR, "read failed: %s (%d)",
+							strerror(errno), errno);
+				close(fd);
+				break;
+			}
+		}
+
+		seq++;
+
+		if (send(sk, buf, qos.out.sdu, 0) <= 0) {
+			syslog(LOG_ERR, "Send failed: %s (%d)",
+							strerror(errno), errno);
+			exit(1);
+		}
+
+		usleep(qos.out.interval);
+	}
+}
+
+static void reconnect_mode(char *peer)
+{
+	while (1) {
+		int sk;
+
+		sk = do_connect(peer);
+		if (sk < 0) {
+			syslog(LOG_ERR, "Can't connect to the server: %s (%d)",
+							strerror(errno), errno);
+			exit(1);
+		}
+
+		close(sk);
+
+		sleep(5);
+	}
+}
+
+static void multy_connect_mode(char *peer)
+{
+	while (1) {
+		int i, sk;
+
+		for (i = 0; i < 10; i++){
+			if (fork())
+				continue;
+
+			/* Child */
+			sk = do_connect(peer);
+			if (sk < 0) {
+				syslog(LOG_ERR, "Can't connect to the server: "
+					"%s (%d)", strerror(errno), errno);
+			}
+			close(sk);
+			exit(0);
+		}
+
+		sleep(19);
+	}
+}
+
+#define QOS_IO(_interval, _latency, _sdu, _phy, _rtn) \
+{ \
+	.interval = _interval, \
+	.latency = _latency, \
+	.sdu = _sdu, \
+	.phy = _phy, \
+	.rtn = _rtn, \
+}
+
+#define QOS(_interval, _latency, _sdu, _phy, _rtn) \
+{ \
+	.cig = BT_ISO_QOS_CIG_UNSET, \
+	.cis = BT_ISO_QOS_CIS_UNSET, \
+	.sca = 0x07, \
+	.packing = 0x00, \
+	.framing = 0x00, \
+	.out = QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
+}
+
+#define QOS_PRESET(_name, _inout, _interval, _latency, _sdu, _phy, _rtn) \
+{ \
+	.name = _name, \
+	.inout = _inout, \
+	.qos = QOS(_interval, _latency, _sdu, _phy, _rtn), \
+}
+
+static struct qos_preset {
+	const char *name;
+	bool inout;
+	struct bt_iso_qos qos;
+} presets[] = {
+	/* QoS Configuration settings for low latency audio data */
+	QOS_PRESET("8_1_1", true, 7500, 8, 26, 0x02, 2),
+	QOS_PRESET("8_2_1", true, 10000, 10, 30, 0x02, 2),
+	QOS_PRESET("16_1_1", true, 7500, 8, 30, 0x02, 2),
+	QOS_PRESET("16_2_1", true, 10000, 10, 40, 0x02, 2),
+	QOS_PRESET("24_1_1", true, 7500, 8, 45, 0x02, 2),
+	QOS_PRESET("24_2_1", true, 10000, 10, 60, 0x02, 2),
+	QOS_PRESET("32_1_1", true, 7500, 8, 60, 0x02, 2),
+	QOS_PRESET("32_2_1", true, 10000, 10, 80, 0x02, 2),
+	QOS_PRESET("44_1_1", false, 8163, 24, 98, 0x02, 5),
+	QOS_PRESET("44_2_1", false, 10884, 31, 130, 0x02, 5),
+	QOS_PRESET("48_1_1", false, 7500, 15, 75, 0x02, 5),
+	QOS_PRESET("48_2_1", false, 10000, 20, 100, 0x02, 5),
+	QOS_PRESET("48_3_1", false, 7500, 15, 90, 0x02, 5),
+	QOS_PRESET("48_4_1", false, 10000, 20, 120, 0x02, 5),
+	QOS_PRESET("48_5_1", false, 7500, 15, 117, 0x02, 5),
+	QOS_PRESET("44_6_1", false, 10000, 20, 155, 0x02, 5),
+	/* QoS Configuration settings for high reliability audio data */
+	QOS_PRESET("8_1_2", true, 7500, 45, 26, 0x02, 41),
+	QOS_PRESET("8_2_2", true, 10000, 60, 30, 0x02, 53),
+	QOS_PRESET("16_1_2", true, 7500, 45, 30, 0x02, 41),
+	QOS_PRESET("16_2_2", true, 10000, 60, 40, 0x02, 47),
+	QOS_PRESET("24_1_2", true, 7500, 45, 45, 0x02, 35),
+	QOS_PRESET("24_2_2", true, 10000, 60, 60, 0x02, 41),
+	QOS_PRESET("32_1_2", true, 7500, 45, 60, 0x02, 29),
+	QOS_PRESET("32_2_1", true, 10000, 60, 80, 0x02, 35),
+	QOS_PRESET("44_1_2", false, 8163, 54, 98, 0x02, 23),
+	QOS_PRESET("44_2_2", false, 10884, 71, 130, 0x02, 23),
+	QOS_PRESET("48_1_2", false, 7500, 45, 75, 0x02, 23),
+	QOS_PRESET("48_2_2", false, 10000, 60, 100, 0x02, 23),
+	QOS_PRESET("48_3_2", false, 7500, 45, 90, 0x02, 23),
+	QOS_PRESET("48_4_2", false, 10000, 60, 120, 0x02, 23),
+	QOS_PRESET("48_5_2", false, 7500, 45, 117, 0x02, 23),
+	QOS_PRESET("44_6_2", false, 10000, 60, 155, 0x02, 23),
+};
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+static void usage(void)
+{
+	printf("isotest - ISO testing\n"
+		"Usage:\n");
+	printf("\tisotest <mode> [options] [bdaddr] [bdaddr1]...\n");
+	printf("Modes:\n"
+		"\t-d, --dump [filename]    dump (server)\n"
+		"\t-c, --reconnect          reconnect (client)\n"
+		"\t-m, --multiple           multiple connects (client)\n"
+		"\t-r, --receive [filename] receive (server)\n"
+		"\t-s, --send [filename,...] connect and send (client)\n"
+		"\t-n, --silent             connect and be silent (client)\n"
+		"Options:\n"
+		"\t[-b, --bytes <value>]\n"
+		"\t[-i, --device <num>]\n"
+		"\t[-h, --help]\n"
+		"\t[-W, --defer <seconds>]  enable deferred setup\n"
+		"\t[-M, --mtu <value>]\n"
+		"\t[-S, --sca <value>]\n"
+		"\t[-P, --packing <value>]\n"
+		"\t[-F, --framing <value>]\n"
+		"\t[-I, --interval <useconds>]\n"
+		"\t[-L, --latency <mseconds>]\n"
+		"\t[-Y, --phy <value>]\n"
+		"\t[-R, --rtn <value>]\n"
+		"\t[-B, --preset <value>]\n"
+		"\t[-G, --CIG <value>]\n"
+		"\t[-V, --type <value>] address type (help for list)\n");
+}
+
+static const struct option main_options[] = {
+	{ "dump",      optional_argument, NULL, 'd'},
+	{ "reconnect", no_argument,       NULL, 'c'},
+	{ "multiple",  no_argument,       NULL, 'm'},
+	{ "receive",   optional_argument, NULL, 'r'},
+	{ "send",      optional_argument, NULL, 's'},
+	{ "silent",    no_argument,       NULL, 'n'},
+	{ "bytes",     required_argument, NULL, 'b'},
+	{ "device",    required_argument, NULL, 'i'},
+	{ "help",      no_argument,       NULL, 'h'},
+	{ "defer",     required_argument, NULL, 'W'},
+	{ "mtu",       required_argument, NULL, 'M'},
+	{ "sca",       required_argument, NULL, 'S'},
+	{ "packing",   required_argument, NULL, 'P'},
+	{ "framing",   required_argument, NULL, 'F'},
+	{ "interval",  required_argument, NULL, 'I'},
+	{ "latency",   required_argument, NULL, 'L'},
+	{ "phy",       required_argument, NULL, 'Y'},
+	{ "rtn",       required_argument, NULL, 'R'},
+	{ "preset",    required_argument, NULL, 'B'},
+	{ "CIG",       required_argument, NULL, 'G'},
+	{ "type",      required_argument, NULL, 'V'},
+	{}
+};
+
+int main(int argc ,char *argv[])
+{
+	struct sigaction sa;
+	int sk, mode = RECV;
+	char *filename = NULL;
+	unsigned int i;
+
+	iso_qos = malloc(sizeof(*iso_qos));
+	/* Default to 16_2_1 */
+	*iso_qos = presets[3].qos;
+	inout = true;
+
+	while (1) {
+		int opt;
+
+		opt = getopt_long(argc, argv,
+				"d::cmr::s::nb:i:hV:W:M:S:P:F:I:L:Y:R:B:G:",
+				main_options, NULL);
+		if (opt < 0)
+			break;
+
+
+		switch(opt) {
+		case 'r':
+			mode = RECV;
+			if (optarg)
+				filename = strdup(optarg);
+			break;
+
+		case 's':
+			mode = SEND;
+			if (optarg)
+				filename = strdup(optarg);
+			break;
+
+		case 'd':
+			mode = DUMP;
+			if (optarg)
+				filename = strdup(optarg);
+			break;
+
+		case 'c':
+			mode = RECONNECT;
+			break;
+
+		case 'm':
+			mode = MULTY;
+			break;
+
+		case 'n':
+			mode = CONNECT;
+			break;
+
+		case 'b':
+			data_size = atoi(optarg);
+			break;
+
+		case 'i':
+			if (!strncasecmp(optarg, "hci", 3))
+				hci_devba(atoi(optarg + 3), &bdaddr);
+			else
+				str2ba(optarg, &bdaddr);
+			break;
+
+		case 'V':
+			bdaddr_type = get_lookup_flag(bdaddr_types, optarg);
+
+			if (bdaddr_type == -1) {
+				print_lookup_values(bdaddr_types,
+						"List Address types:");
+				exit(1);
+			}
+
+			break;
+
+		case 'W':
+			defer_setup = atoi(optarg);
+			break;
+
+		case 'M':
+			iso_qos->out.sdu = atoi(optarg);
+
+			break;
+
+		case 'S':
+			iso_qos->sca = atoi(optarg);
+
+			break;
+
+
+		case 'P':
+			iso_qos->packing = atoi(optarg);
+
+			break;
+
+		case 'F':
+			iso_qos->framing = atoi(optarg);
+
+			break;
+
+		case 'I':
+			iso_qos->out.interval = atoi(optarg);
+
+			break;
+
+		case 'L':
+			iso_qos->out.latency = atoi(optarg);
+
+			break;
+
+		case 'Y':
+			iso_qos->out.phy = atoi(optarg);
+
+			break;
+
+		case 'R':
+			iso_qos->out.rtn = atoi(optarg);
+
+			break;
+
+		case 'B':
+			for (i = 0; i < ARRAY_SIZE(presets); i++) {
+				if (!strcmp(presets[i].name, optarg)) {
+					*iso_qos = presets[i].qos;
+					inout = presets[i].inout;
+					break;
+				}
+			}
+
+			break;
+
+		case 'G':
+			iso_qos->cig = atoi(optarg);
+
+			break;
+
+		/* Fallthrough */
+		default:
+			usage();
+			exit(1);
+		}
+	}
+
+	if (inout)
+		iso_qos->in = iso_qos->out;
+
+	buf = malloc(data_size);
+	if (!buf) {
+		perror("Can't allocate data buffer");
+		exit(1);
+	}
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_IGN;
+	sa.sa_flags   = SA_NOCLDSTOP;
+	sigaction(SIGCHLD, &sa, NULL);
+
+	openlog("isotest", LOG_PERROR | LOG_PID, LOG_LOCAL0);
+
+	if (!(argc - optind)) {
+		switch (mode) {
+		case RECV:
+			do_listen(filename, recv_mode);
+			goto done;
+
+		case DUMP:
+			do_listen(filename, dump_mode);
+			goto done;
+		default:
+			usage();
+			exit(1);
+		}
+	}
+
+	argc -= optind;
+
+	for (i = 0; i < (unsigned int) argc; i++) {
+		pid_t pid;
+
+		pid = fork();
+		if (pid < 0) {
+			perror("Failed to fork new process");
+			return -1;
+		}
+
+		if (!pid)
+			continue;
+
+		switch (mode) {
+		case SEND:
+			send_mode(filename, argv[optind + i], i);
+			if (strchr(filename, ','))
+				filename = strchr(filename, ',') + 1;
+			break;
+
+		case RECONNECT:
+			reconnect_mode(argv[optind + i]);
+			break;
+
+		case MULTY:
+			multy_connect_mode(argv[optind + i]);
+			break;
+
+		case CONNECT:
+			sk = do_connect(argv[optind + i]);
+			if (sk < 0)
+				exit(1);
+			dump_mode(-1, sk);
+			break;
+		}
+
+		break;
+	}
+
+done:
+	syslog(LOG_INFO, "Exit");
+
+	closelog();
+
+	return 0;
+}
-- 
2.26.2

