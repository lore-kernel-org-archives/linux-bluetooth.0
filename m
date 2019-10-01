Return-Path: <SRS0=34D5=X2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4448AC352AA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1206620815
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 14:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="sJMb45G3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbfJAOKE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:10:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46932 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfJAOKE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Oct 2019 10:10:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so9951799lfc.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2019 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alzF4tpzHmP8qm7bH/g+AGGUXeageptKGk5OT5EgW10=;
        b=sJMb45G3sVpeHZLiz8soRIjNBJm6IbHBZHEZp4EaDZEyxj1PAUxi/54+EyPSX9KiLn
         GjR0c/kh5Yaegsn+ohmDQ3FCQs+uIp/GScLlaYsNXmJ73h48dDtPVG8cE9das89jV1iL
         7Ph3zxw8MHuUoPe62gZKVbYNhwb8IXdFiDV3oYCZdlCqcSWzmoy+H+wYkieQ30MbS5kM
         l7FFir3CNnE/7A5Lw3LdYNKZP0lpF+byRFQkOks/9WUbnwJbTLm5vpM04rC8sJJpqIeg
         /NN9kRfAf2eOIJFAqh5QKIEQCJVXs6XCdNHqj8i+8YrkMJHyn+bcdmhor/H4XOIeQxZJ
         XJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alzF4tpzHmP8qm7bH/g+AGGUXeageptKGk5OT5EgW10=;
        b=HSB2urZRFpUf0tY7KZVjo/SSf3nKJYASwKaXAEQYfyf2zoEMnJOc33bdYJLdLjLr8c
         b23kELT3DmcrrE9UK/0qQK0igguy6/5/a7DYzFCB5biUQ41XfB2bj56zpN61sg+0ku3D
         lMnpIXMPlOztzQ+D2DZTSziJmJZ6Uxv5ajun7GAXdr3QnsaJOFr6o62K3aT5i0yzSxin
         ji+4vleivKtO2uE46ULf1O7yfQQyRPV24pJvy/frTq76AObslg91ywOr3y5+MUifFU+S
         LpbmNXL0Hkr2HUENxcSn0LCjG3qVVDUt+tPYv7DQGTXXu/iNNyfYBhy2tBYbiiWhYYDL
         sYtg==
X-Gm-Message-State: APjAAAXDSFGNUXoyPK5K5tq4zNNcUH79J25zE9ebC6r0kd9MbTOjrXAG
        u3YEBOoImE/QZnZ+fcdLEBnZO1HiHis=
X-Google-Smtp-Source: APXvYqzTM67KoIFTAkdp17dnMUP8KE4whzfxaemRkslKua/C19rLaQhR2au80nP+C5Z+WBHtxfNH3A==
X-Received: by 2002:a19:5515:: with SMTP id n21mr15624628lfe.131.1569939001825;
        Tue, 01 Oct 2019 07:10:01 -0700 (PDT)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id k15sm4117794ljg.65.2019.10.01.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 07:10:01 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH V2 3/3] monitor: Add support for reading over J-Link RTT
Date:   Tue,  1 Oct 2019 16:09:41 +0200
Message-Id: <20191001140941.8005-3-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001140941.8005-1-szymon.janc@codecoup.pl>
References: <20191001140941.8005-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>

This patch adds support for reading data over J-Link RTT. It can be
used as replacement for TTY when reading from embedded devices since
it's much faster and does block a UART. Data format is the same as
for TTY. At the moment monitor over RTT is only supported by Apache
Mynewt project.

Reading data is done by polling RTT every 1 msec since there is no
blocking API to read something from RTT buffer.

To enable reading from RTT, J-Link configuration needs to be passed via
command line (all parameters except <device> can be skipped to use
default value):
  -J <device>,<interface=swd>,<speed=1000>,<serialno=0>
  -J nrf52,,683649029

In some cases J-Link cannot locate RTT buffer in RAM. In such case
RAM area and buffer name should be provided via command line:
  -R <address=0x0>,<area=0x1000>,<buffer=monitor>
  -R 0x20000000,0x10000
---
 Makefile.tools    |  3 ++-
 monitor/control.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 monitor/control.h |  1 +
 monitor/main.c    | 22 +++++++++++++++++++--
 4 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 81ed2e30d..7ce05b7ef 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -42,9 +42,10 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/analyze.h monitor/analyze.c \
 				monitor/intel.h monitor/intel.c \
 				monitor/broadcom.h monitor/broadcom.c \
+				monitor/jlink.h monitor/jlink.c \
 				monitor/tty.h
 monitor_btmon_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-mainloop.la $(UDEV_LIBS)
+				src/libshared-mainloop.la $(UDEV_LIBS) -ldl
 endif
 
 if LOGGER
diff --git a/monitor/control.c b/monitor/control.c
index 4022e7644..1e9054db3 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -57,6 +57,7 @@
 #include "ellisys.h"
 #include "tty.h"
 #include "control.h"
+#include "jlink.h"
 
 static struct btsnoop *btsnoop_file = NULL;
 static bool hcidump_fallback = false;
@@ -1416,6 +1417,55 @@ int control_tty(const char *path, unsigned int speed)
 	return 0;
 }
 
+static void rtt_callback(int id, void *user_data)
+{
+	struct control_data *data = user_data;
+	ssize_t len;
+
+	do {
+		len = jlink_rtt_read(data->buf + data->offset,
+					sizeof(data->buf) - data->offset);
+		data->offset += len;
+		process_data(data);
+	} while (len > 0);
+
+	if (mainloop_modify_timeout(id, 1) < 0)
+		mainloop_exit_failure();
+}
+
+int control_rtt(char *jlink, char *rtt)
+{
+	struct control_data *data;
+
+	if (jlink_init() < 0) {
+		fprintf(stderr, "Failed to initialize J-Link library\n");
+		return -EIO;
+	}
+
+	if (jlink_connect(jlink) < 0) {
+		fprintf(stderr, "Failed to connect to target device\n");
+		return -ENODEV;
+	}
+
+	if (jlink_start_rtt(rtt) < 0) {
+		fprintf(stderr, "Failed to initialize RTT\n");
+		return -ENODEV;
+	}
+
+	printf("--- RTT opened ---\n");
+
+	data = new0(struct control_data, 1);
+	data->channel = HCI_CHANNEL_MONITOR;
+	data->fd = -1;
+
+	if (mainloop_add_timeout(1, rtt_callback, data, free_data) < 0) {
+		free(data);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 bool control_writer(const char *path)
 {
 	btsnoop_file = btsnoop_create(path, 0, 0, BTSNOOP_FORMAT_MONITOR);
diff --git a/monitor/control.h b/monitor/control.h
index a9691e32f..ddf485f1f 100644
--- a/monitor/control.h
+++ b/monitor/control.h
@@ -28,6 +28,7 @@ bool control_writer(const char *path);
 void control_reader(const char *path, bool pager);
 void control_server(const char *path);
 int control_tty(const char *path, unsigned int speed);
+int control_rtt(char *jlink, char *rtt);
 int control_tracing(void);
 void control_disable_decoding(void);
 void control_filter_index(uint16_t index);
diff --git a/monitor/main.c b/monitor/main.c
index acd44a098..adb596635 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -75,6 +75,10 @@ static void usage(void)
 		"\t-A, --a2dp             Dump A2DP stream traffic\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
 		"\t-P, --no-pager         Disable pager usage\n"
+		"\t-J  --jlink <device>,[<interface>],[<speed>],[<serialno>]\n"
+		"\t                       Read data from RTT\n"
+		"\t-R  --rtt [<address>],[<area>],[<name>]\n"
+		"\t                       RTT control block parameters\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -94,6 +98,8 @@ static const struct option main_options[] = {
 	{ "a2dp",      no_argument,       NULL, 'A' },
 	{ "ellisys",   required_argument, NULL, 'E' },
 	{ "no-pager",  no_argument,       NULL, 'P' },
+	{ "jlink",     required_argument, NULL, 'J' },
+	{ "rtt",       required_argument, NULL, 'R' },
 	{ "todo",      no_argument,       NULL, '#' },
 	{ "version",   no_argument,       NULL, 'v' },
 	{ "help",      no_argument,       NULL, 'h' },
@@ -112,6 +118,8 @@ int main(int argc, char *argv[])
 	unsigned int tty_speed = B115200;
 	unsigned short ellisys_port = 0;
 	const char *str;
+	char *jlink = NULL;
+	char *rtt = NULL;
 	int exit_status;
 
 	mainloop_init();
@@ -122,7 +130,7 @@ int main(int argc, char *argv[])
 		int opt;
 		struct sockaddr_un addr;
 
-		opt = getopt_long(argc, argv, "r:w:a:s:p:i:d:B:V:tTSAEPvh",
+		opt = getopt_long(argc, argv, "r:w:a:s:p:i:d:B:V:tTSAE:PJ:R:vh",
 							main_options, NULL);
 		if (opt < 0)
 			break;
@@ -194,6 +202,12 @@ int main(int argc, char *argv[])
 		case 'P':
 			use_pager = false;
 			break;
+		case 'J':
+			jlink = optarg;
+			break;
+		case 'R':
+			rtt = optarg;
+			break;
 		case '#':
 			packet_todo();
 			lmp_todo();
@@ -246,11 +260,15 @@ int main(int argc, char *argv[])
 	if (ellisys_server)
 		ellisys_enable(ellisys_server, ellisys_port);
 
-	if (!tty && control_tracing() < 0)
+	if (tty && jlink)
 		return EXIT_FAILURE;
 
 	if (tty && control_tty(tty, tty_speed) < 0)
 		return EXIT_FAILURE;
+	else if (jlink && control_rtt(jlink, rtt) < 0)
+		return EXIT_FAILURE;
+	else if (control_tracing() < 0)
+		return EXIT_FAILURE;
 
 	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
-- 
2.21.0

