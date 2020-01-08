Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC941C33C99
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7122F206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYq9gZuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgAHAdu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:50 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:52856 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHAdt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:49 -0500
Received: by mail-pj1-f54.google.com with SMTP id a6so296956pjh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xw7R8bhSk0Uesb5CHUf8tUJSR0vt75vvm3Njgga7itA=;
        b=KYq9gZuUzqBOpsoBngWB7f8Icuam6/RcKkn2eJUpMSD2OnDBYDP2niPxl6FKP00Qup
         nLIMK1XojuA88kyESWavdF1bzsDQ1c68wjtAIIshCVZiofL4oUklnQqEDH8ExZLMrN8A
         YASiT3yw//Fmz7vWpSeUw6B2J7N3a4s/D0nua3h+kBAPj3ha+TASECoIEKqWOW9l7Pvl
         gVjK+53kTiXDEw6hFqmFrgGIE/j2pGpQM46MhV4lpEUFFA9GdiM/CoCQCE43i2hV/qLj
         JdSmDKzpwhtsTHNcWZ+SaSzkNMtqUuOM9OLgvtfT7dJk7QsC4nyDzb33YF/5H+u8cUfi
         /iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xw7R8bhSk0Uesb5CHUf8tUJSR0vt75vvm3Njgga7itA=;
        b=pkJtSjQSar6C+TPAAKZrRxrZpU3+JBPnDFaj0dbp10GDQh5yHEHvkDX3mJT5H29hus
         H17WKiP0C80RJRF0xdLth8tX4urh4cJhLETLB9B7sdwe+kajkA/xMTcmHRm/2lLCCetz
         0zY5BMBqF3obzSi95lq5bTTptW6/rzLo8iyHj4j9o2DMzJ7hpBoQCXwa8Iq0uJgKORRX
         1tYm8jP8+zYHdMK9FGOqaelSfpz1hbDhIE+0n00Hw9u5Zpmr6K/NtB2S1oidhIHHX6za
         3pw+PD5pv+B8GZItZRXVIyV8S13Ev2tcA2XregQnC5EMs8lP8oupxWI0nAcbOLMHdT2/
         A1Ug==
X-Gm-Message-State: APjAAAXTRyCGlaVGEXaEEM6PMyS4/97gMjIKrwVbZOq2ikboUS2Bh+Mf
        YlQ+2lEaNos5VY5HUpZqAd+my45W0gQ=
X-Google-Smtp-Source: APXvYqyLFd4FZPBzbQIFOEyeXTLC8pgaNMhS9DuYXnskI5nlyFT7sW2+8aJxhwzJQJwWGo4SUbqG+A==
X-Received: by 2002:a17:90a:ac0f:: with SMTP id o15mr1337062pjq.133.1578443627735;
        Tue, 07 Jan 2020 16:33:47 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/22] tools: Add isotest tool
Date:   Tue,  7 Jan 2020 16:33:24 -0800
Message-Id: <20200108003342.15458-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds isotest tool which can be used to test ISO sockets.
---
 Makefile.tools  |    5 +-
 tools/isotest.c | 1019 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1023 insertions(+), 1 deletion(-)
 create mode 100644 tools/isotest.c

diff --git a/Makefile.tools b/Makefile.tools
index 006554cf7..9628b83e3 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -190,7 +190,8 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/eddystone tools/ibeacon \
 			tools/btgatt-client tools/btgatt-server \
 			tools/test-runner tools/check-selftest \
-			tools/gatt-service profiles/iap/iapd
+			tools/gatt-service profiles/iap/iapd \
+			tools/isotest
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
 tools_bdaddr_LDADD = lib/libbluetooth-internal.la $(UDEV_LIBS)
@@ -296,6 +297,8 @@ tools_gatt_service_LDADD = $(GLIB_LIBS) $(DBUS_LIBS) gdbus/libgdbus-internal.la
 profiles_iap_iapd_SOURCES = profiles/iap/main.c
 profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
+tools_isotest_LDADD = lib/libbluetooth-internal.la
+
 dist_man_MANS += tools/rctest.1 tools/l2ping.1 tools/bccmd.1 tools/btattach.1
 
 EXTRA_DIST += tools/bdaddr.1
diff --git a/tools/isotest.c b/tools/isotest.c
new file mode 100644
index 000000000..f86ac243a
--- /dev/null
+++ b/tools/isotest.c
@@ -0,0 +1,1019 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
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
+struct bt_iso_qos *in_qos = NULL;
+struct bt_iso_qos *out_qos = NULL;
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
+	struct bt_iso_qos qos[2];
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
+	if (out_qos) {
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_OUT_QOS,
+					out_qos, sizeof(*out_qos)) < 0) {
+			syslog(LOG_ERR, "Can't set Output QoS socket option: "
+					"%s (%d)", strerror(errno), errno);
+		}
+	}
+
+	if (in_qos) {
+		if (!inout) {
+			in_qos->phy = 0x00;
+			in_qos->mtu = 0;
+		}
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_IN_QOS,
+					in_qos, sizeof(*in_qos)) < 0) {
+			syslog(LOG_ERR, "Can't set Input QoS socket option: "
+					"%s (%d)", strerror(errno), errno);
+		}
+	}
+
+	/* Connect to remote device */
+	memset(&addr, 0, sizeof(addr));
+	addr.iso_family = AF_BLUETOOTH;
+	str2ba(peer, &addr.iso_bdaddr);
+	addr.iso_bdaddr_type = bdaddr_type;
+
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		syslog(LOG_ERR, "Can't connect: %s (%d)",
+							strerror(errno), errno);
+		goto error;
+	}
+
+	/* Read Out QOS */
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos[0]);
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_IN_QOS, &qos[0], &len) < 0) {
+		syslog(LOG_ERR, "Can't get Input QoS socket option: %s (%d)",
+				strerror(errno), errno);
+		goto error;
+	}
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_OUT_QOS, &qos[1], &len) < 0) {
+		syslog(LOG_ERR, "Can't get Output QoS socket option: %s (%d)",
+				strerror(errno), errno);
+		goto error;
+	}
+
+	syslog(LOG_INFO, "Connected [%s]", peer);
+	syslog(LOG_INFO, "Input QoS [Interval %u us Framing 0x%02x Latency %u "
+		"ms MTU %u PHY 0x%02x RTN %u]", qos[0].interval, qos[0].framing,
+		qos[0].latency, qos[0].mtu, qos[0].phy, qos[0].rtn);
+	syslog(LOG_INFO, "Output QoS [Interval %u us Framing 0x%02x Latency %u "
+		"ms MTU %u PHY 0x%02x RTN %u]", qos[1].interval, qos[1].framing,
+		qos[1].latency, qos[1].mtu, qos[1].phy, qos[1].rtn);
+
+	return sk;
+
+error:
+	close(sk);
+	return -1;
+}
+
+static void do_listen(void (*handler)(int sk))
+{
+	struct sockaddr_iso addr;
+	socklen_t optlen;
+	int sk, nsk;
+	char ba[18];
+
+	/* Create socket */
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
+	if (sk < 0) {
+		syslog(LOG_ERR, "Can't create socket: %s (%d)",
+							strerror(errno), errno);
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
+		handler(nsk);
+
+		syslog(LOG_INFO, "Disconnect");
+		exit(0);
+	}
+
+error:
+	close(sk);
+	exit(1);
+}
+
+static void dump_mode(int sk)
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
+	while ((len = read(sk, buf, data_size)) > 0)
+		syslog(LOG_INFO, "Received %d bytes", len);
+}
+
+static void recv_mode(int sk)
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
+			total += r;
+		}
+		gettimeofday(&tv_end, NULL);
+
+		timersub(&tv_end, &tv_beg, &tv_diff);
+
+		syslog(LOG_INFO,"%ld bytes in %.2fm speed %.2f kb", total,
+			tv2fl(tv_diff) / 60.0,
+			(float)( total / tv2fl(tv_diff) ) / 1024.0 );
+	}
+}
+
+static void send_mode(char *peer)
+{
+	struct bt_iso_qos qos;
+	socklen_t len;
+	uint32_t seq;
+	int i, sk;
+
+	sk = do_connect(peer);
+	if (sk < 0) {
+		syslog(LOG_ERR, "Can't connect to the server: %s (%d)",
+							strerror(errno), errno);
+		exit(1);
+	}
+
+	syslog(LOG_INFO,"Sending ...");
+
+	/* Read Out QOS */
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos);
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_OUT_QOS, &qos, &len) < 0) {
+		syslog(LOG_ERR, "Can't get Output QoS socket option: %s (%d)",
+				strerror(errno), errno);
+		qos.mtu = ISO_DEFAULT_MTU;
+	}
+
+	for (i = 6; i < qos.mtu; i++)
+		buf[i] = 0x7f;
+
+	seq = 0;
+	while (1) {
+		put_le32(seq, buf);
+		put_le16(data_size, buf + 4);
+
+		seq++;
+
+		if (send(sk, buf, qos.mtu, 0) <= 0) {
+			syslog(LOG_ERR, "Send failed: %s (%d)",
+							strerror(errno), errno);
+			exit(1);
+		}
+
+		usleep(qos.interval);
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
+static void usage(void)
+{
+	printf("isotest - ISO testing\n"
+		"Usage:\n");
+	printf("\tisotest <mode> [options] [bdaddr]\n");
+	printf("Modes:\n"
+		"\t-d dump (server)\n"
+		"\t-c reconnect (client)\n"
+		"\t-m multiple connects (client)\n"
+		"\t-r receive (server)\n"
+		"\t-s connect and send (client)\n"
+		"\t-n connect and be silent (client)\n"
+		"Options:\n"
+		"\t[-b bytes]\n"
+		"\t[-i device]\n"
+		"\t[-W seconds] enable deferred setup\n"
+		"\t[-M mtu]\n"
+		"\t[-S sca]\n"
+		"\t[-P packing]\n"
+		"\t[-F framing]\n"
+		"\t[-I interval]\n"
+		"\t[-L latency]\n"
+		"\t[-Y phy]\n"
+		"\t[-R rtn]\n"
+		"\t[-B preset]\n");
+}
+
+static struct qos_preset {
+	const char *name;
+	bool inout;
+	struct bt_iso_qos qos;
+} presets[] = {
+	{
+		.name = "1.1",
+		.inout = true,
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 8,
+			.mtu = 30,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "1.2",
+		.inout = true,
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 10,
+			.mtu = 40,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "1.3",
+		.inout = true,
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 8,
+			.mtu = 45,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "1.4",
+		.inout = true,
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 10,
+			.mtu = 60,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "1.5",
+		.inout = true,
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 8,
+			.mtu = 60,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "1.6",
+		.inout = true,
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 10,
+			.mtu = 80,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "2.1",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 60,
+			.mtu = 45,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "2.2",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 80,
+			.mtu = 60,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "3.0",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 8,
+			.mtu = 75,
+			.phy = 0x02,
+			.rtn = 3,
+		}
+	},
+	{
+		.name = "3.1",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 10,
+			.mtu = 100,
+			.phy = 0x02,
+			.rtn = 3,
+		}
+	},
+	{
+		.name = "3.2",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 8,
+			.mtu = 90,
+			.phy = 0x02,
+			.rtn = 3,
+		}
+	},
+	{
+		.name = "3.3",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 10,
+			.mtu = 120,
+			.phy = 0x02,
+			.rtn = 3,
+		}
+	},
+	{
+		.name = "3.4",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 8,
+			.mtu = 117,
+			.phy = 0x02,
+			.rtn = 3,
+		}
+	},
+	{
+		.name = "3.5",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 10,
+			.mtu = 155,
+			.phy = 0x02,
+			.rtn = 3,
+		}
+	},
+	{
+		.name = "3.6",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10880,
+			.latency = 11,
+			.mtu = 120,
+			.phy = 0x02,
+			.rtn = 3,
+		}
+	},
+	{
+		.name = "4.0",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 60,
+			.mtu = 75,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "4.1",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 80,
+			.mtu = 100,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "4.2",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 60,
+			.mtu = 90,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "4.3",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 60,
+			.mtu = 180,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "4.4",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 80,
+			.mtu = 120,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "4.5",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 80,
+			.mtu = 240,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "4.6",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 60,
+			.mtu = 117,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "4.7",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 7500,
+			.latency = 60,
+			.mtu = 234,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "4.8",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 80,
+			.mtu = 155,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+	{
+		.name = "4.9",
+		.qos = {
+			.sca = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.interval = 10000,
+			.latency = 88,
+			.mtu = 120,
+			.phy = 0x02,
+			.rtn = 2,
+		}
+	},
+};
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+int main(int argc ,char *argv[])
+{
+	struct sigaction sa;
+	int opt, sk, mode = RECV;
+	unsigned int i;
+
+	while ((opt = getopt(argc, argv, "rdscmnb:i:V:W:M:S:P:F:I:L:Y:R:B:")) !=
+									EOF) {
+		switch(opt) {
+		case 'r':
+			mode = RECV;
+			break;
+
+		case 's':
+			mode = SEND;
+			break;
+
+		case 'd':
+			mode = DUMP;
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
+			if (!out_qos) {
+				out_qos = malloc(sizeof(*out_qos));
+				memset(out_qos, 0, sizeof(*out_qos));
+			}
+
+			out_qos->mtu = atoi(optarg);
+
+			break;
+
+		case 'S':
+			if (!out_qos) {
+				out_qos = malloc(sizeof(*out_qos));
+				memset(out_qos, 0, sizeof(*out_qos));
+			}
+
+			out_qos->sca = atoi(optarg);
+
+			break;
+
+
+		case 'P':
+			if (!out_qos) {
+				out_qos = malloc(sizeof(*out_qos));
+				memset(out_qos, 0, sizeof(*out_qos));
+			}
+
+			out_qos->packing = atoi(optarg);
+
+			break;
+
+		case 'F':
+			if (!out_qos) {
+				out_qos = malloc(sizeof(*out_qos));
+				memset(out_qos, 0, sizeof(*out_qos));
+			}
+
+			out_qos->framing = atoi(optarg);
+
+			break;
+
+		case 'I':
+			if (!out_qos) {
+				out_qos = malloc(sizeof(*out_qos));
+				memset(out_qos, 0, sizeof(*out_qos));
+			}
+
+			out_qos->interval = atoi(optarg);
+
+			break;
+
+		case 'L':
+			if (!out_qos) {
+				out_qos = malloc(sizeof(*out_qos));
+				memset(out_qos, 0, sizeof(*out_qos));
+			}
+
+			out_qos->latency = atoi(optarg);
+
+			break;
+
+		case 'Y':
+			if (!out_qos) {
+				out_qos = malloc(sizeof(*out_qos));
+				memset(out_qos, 0, sizeof(*out_qos));
+			}
+
+			out_qos->phy = atoi(optarg);
+
+			break;
+
+		case 'R':
+			if (!out_qos) {
+				out_qos = malloc(sizeof(*out_qos));
+				memset(out_qos, 0, sizeof(*out_qos));
+			}
+
+			out_qos->rtn = atoi(optarg);
+
+			break;
+
+		case 'B':
+			for (i = 0; i < ARRAY_SIZE(presets); i++) {
+				if (!strcmp(presets[i].name, optarg)) {
+					out_qos = &presets[i].qos;
+					inout = presets[i].inout;
+					break;
+				}
+			}
+
+			if (out_qos)
+				break;
+
+		/* Fallthrough */
+		default:
+			usage();
+			exit(1);
+		}
+	}
+
+	if (!(argc - optind) && (mode != RECV && mode != DUMP)) {
+		usage();
+		exit(1);
+	}
+
+	if (out_qos && !in_qos)
+		in_qos = out_qos;
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
+	switch( mode ){
+	case RECV:
+		do_listen(recv_mode);
+		break;
+
+	case DUMP:
+		do_listen(dump_mode);
+		break;
+
+	case SEND:
+		send_mode(argv[optind]);
+		break;
+
+	case RECONNECT:
+		reconnect_mode(argv[optind]);
+		break;
+
+	case MULTY:
+		multy_connect_mode(argv[optind]);
+		break;
+
+	case CONNECT:
+		sk = do_connect(argv[optind]);
+		if (sk < 0)
+			exit(1);
+		dump_mode(sk);
+		break;
+	}
+
+	syslog(LOG_INFO, "Exit");
+
+	closelog();
+
+	return 0;
+}
-- 
2.21.0

