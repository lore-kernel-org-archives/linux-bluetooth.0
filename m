Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74370C0502C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 23:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbiHZXUy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 19:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345509AbiHZXUs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 19:20:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D17BD8E04
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 142so2893126pfu.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=uKZN+WtU9c3IVIhReF07AEB77DEg2H9OvDD5FkV5cdU=;
        b=JKiF2BKdma8LDzpetxmzfhxm9vuch3kjq15vo4jSwK+rk+FfYUXi1ZBy/9FUzu4aka
         oGml0Fa1rgky6lODvc+Ee0gkbSLL7KRyPtaozmZPaeJELYdKOcWynKj8mWZqKi7j1a+y
         R/ohjnYLquWlutuwbQdjEZ3V4Q8I//fC+wAb2gSaXC7a0AMjdo+cjncDjqEHze6nEsAz
         OA5SF5/leOL7TWcv1RBU7wtU16voLAPK3OYxz6WCZXO1SgZhaFW+R74MaTHZ336XD+vE
         w1svRqs7Xi3d1hYhDjq9eTYBCuT9ER1xrtmKgXCJAiBU+cFE6Iz/MAj3WUb3oEiSL6g8
         9veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=uKZN+WtU9c3IVIhReF07AEB77DEg2H9OvDD5FkV5cdU=;
        b=ACj2ScCfL+wheQLUDlIP0UsNyavkt/YFJV1YOursf3zqt30rtkYzg2H7mrq211YknO
         5IpKUPl3ubdvMmhh+20jrGOCA0jLscIX4rV+BZavt98W5+9CeHqpn9AsPIS4urpIfXGO
         DfnmfJRqPjetP3FxjlL+J8azWJWCqGi0GypJ76pnajrkSt8Fi1ZicDC0cDVLTT9zuMsJ
         yJ5eQOvVlwEUayode2IXb8+QCnQzElWvPHwyQzbdbe1sZimAaMccj2QYz+QILvTvnifB
         sV+y6X9aUYGQ1y6Rc2xv9e9X+9jcvPphefoi2gimysgyvtL1fZWDcpaPIA4+O3KnCUzj
         b2Dg==
X-Gm-Message-State: ACgBeo1S6bPE37rNfg1DXB0oT3cCghBP5ZXEe1hEPv7wTLB377w+4/g3
        qWqSR++lq8NYsArrFwhITcnezq+Itkc=
X-Google-Smtp-Source: AA6agR6Jv/gvnoSNionIjk01Zw98N9tV2Z/eIKVwtQG3l8z5tQUtkjUZLUJ6VgU8n2WHLMJ1w7jmDA==
X-Received: by 2002:a63:931e:0:b0:42b:6394:f5b with SMTP id b30-20020a63931e000000b0042b63940f5bmr4954960pge.602.1661556046229;
        Fri, 26 Aug 2022 16:20:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b0053645475a6dsm2312338pfq.66.2022.08.26.16.20.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:20:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 9/9] client/player: Use QoS interval on transport.send
Date:   Fri, 26 Aug 2022 16:20:31 -0700
Message-Id: <20220826232031.20391-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826232031.20391-1-luiz.dentz@gmail.com>
References: <20220826232031.20391-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of QoS interval when sending a file.
---
 client/player.c          | 69 ++++++++++++++++++++++++++++++++++++++--
 tools/bluetooth-player.c |  1 -
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/client/player.c b/client/player.c
index 4ba1a72ecfd5..99b036b8c3ec 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2981,9 +2981,56 @@ static int open_file(const char *filename, int flags)
 	return fd;
 }
 
-static int transport_send(struct transport *transport, int fd)
+#define NSEC_USEC(_t) (_t / 1000L)
+#define SEC_USEC(_t)  (_t  * 1000000L)
+#define TS_USEC(_ts)  (SEC_USEC((_ts)->tv_sec) + NSEC_USEC((_ts)->tv_nsec))
+
+static void send_wait(struct timespec *t_start, uint32_t us)
 {
+	struct timespec t_now;
+	struct timespec t_diff;
+	int64_t delta_us;
+
+	/* Skip sleep at start */
+	if (!us)
+		return;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &t_now) < 0) {
+		bt_shell_printf("clock_gettime: %s (%d)", strerror(errno),
+								errno);
+		return;
+	}
+
+	t_diff.tv_sec = t_now.tv_sec - t_start->tv_sec;
+	t_diff.tv_nsec = t_now.tv_nsec - t_start->tv_nsec;
+
+	delta_us = us - TS_USEC(&t_diff);
+
+	if (delta_us < 0) {
+		bt_shell_printf("Send is behind: %zd us - skip sleep",
+							delta_us);
+		delta_us = 1000;
+	}
+
+	usleep(delta_us);
+
+	if (clock_gettime(CLOCK_MONOTONIC, t_start) < 0)
+		bt_shell_printf("clock_gettime: %s (%d)", strerror(errno),
+								errno);
+}
+
+static int transport_send(struct transport *transport, int fd,
+					struct bt_iso_qos *qos)
+{
+	struct timespec t_start;
 	uint8_t *buf;
+	uint32_t num = 0;
+
+	if (qos && clock_gettime(CLOCK_MONOTONIC, &t_start) < 0) {
+		bt_shell_printf("clock_gettime: %s (%d)", strerror(errno),
+								errno);
+		return -errno;
+	}
 
 	buf = malloc(transport->mtu[1]);
 	if (!buf) {
@@ -2991,6 +3038,10 @@ static int transport_send(struct transport *transport, int fd)
 		return -ENOMEM;
 	}
 
+	/* num of packets = latency (ms) / interval (us) */
+	if (qos)
+		num = (qos->out.latency * 1000 / qos->out.interval);
+
 	for (transport->seq = 0; ; transport->seq++) {
 		ssize_t ret;
 		int queued;
@@ -3016,6 +3067,11 @@ static int transport_send(struct transport *transport, int fd)
 		bt_shell_printf("[seq %d] send: %zd bytes "
 				"(TIOCOUTQ %d bytes)\n",
 				transport->seq, ret, queued);
+
+		if (qos) {
+			if (transport->seq && !((transport->seq + 1) % num))
+				send_wait(&t_start, num * qos->out.interval);
+		}
 	}
 
 	free(buf);
@@ -3026,6 +3082,8 @@ static void cmd_send_transport(int argc, char *argv[])
 	GDBusProxy *proxy;
 	struct transport *transport;
 	int fd, err;
+	struct bt_iso_qos qos;
+	socklen_t len;
 
 	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
@@ -3049,7 +3107,14 @@ static void cmd_send_transport(int argc, char *argv[])
 
 	bt_shell_printf("Sending ...\n");
 
-	err = transport_send(transport, fd);
+	/* Read QoS if available */
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos);
+	if (getsockopt(transport->sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
+							&len) < 0)
+		err = transport_send(transport, fd, NULL);
+	else
+		err = transport_send(transport, fd, &qos);
 
 	close(fd);
 
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index b6cdd161ee8c..eba104d09fdb 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -36,7 +36,6 @@
 #define PROMPT_ON	COLOR_BLUE "[bluetooth]" COLOR_OFF "# "
 #define PROMPT_OFF	"[bluetooth]# "
 
-
 static DBusConnection *dbus_conn;
 
 static void connect_handler(DBusConnection *connection, void *user_data)
-- 
2.37.2

