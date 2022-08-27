Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88015ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbiH0AGB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345128AbiH0AF6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE754E42FA
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c16-20020a17090aa61000b001fb3286d9f7so8452467pjq.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=uKZN+WtU9c3IVIhReF07AEB77DEg2H9OvDD5FkV5cdU=;
        b=D65bEwoaCjVVkugPHJV49QE3p/11SvRRppn0inqH94FkMJLa0srtiKswBLXVY8aeo9
         Qa+vOEHue+EPnvEAllx2wfFh7O/EhVPgIWBL8ZZYcMLgV5RXNaJUHMB9+x8A6AiEE3Wv
         YmqwNGikv1JV6ZQ+wJfoQaQ+tXKDj6aqvWG3SpC/S6uK3EkPiHudXXLeeQXzcLfLoDYU
         gkJJZAuzAbiokmCzJSZhOyz5xej9zWKzc3Dptw3MyBWI6W7iid3XkImv4OeGS/s8v98g
         Ca5q/+q6oiSLqwkZ7X9zMWKHKsZCJYjepHr0rSDVcpP0fcRsoLNq8FAu2bwgNaMcG4AI
         VRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=uKZN+WtU9c3IVIhReF07AEB77DEg2H9OvDD5FkV5cdU=;
        b=hb30nkSUV1ZIApS+9A4T/VrfEbdXFphNYx2eGtKeMiZf5rKrn0i08thhNGxzGg7IdG
         0KFMCqXheJcqWuTd96IVvTMe47LzOq2pLJJ7lHQg+Bv2p2vXZoBeFX5q8pFjKeB8qEvq
         3bsqjYyHPtUl2Ocwt0aZ8yu1THMs473Ch52kXm4f5IDpHkvqdUizQox4UBKE7uXUIq/g
         Qu6+R7c7lZZiZVKoeqca1QzLQwPBG+sjASlZJ9KWwEUym2TsLxVdbYiRiTk0ZSp7Uuwx
         Me8G0NmnPPAEizEYgUzoQT0qJQvbh0rOjmnWuWM0aRuBuPINgBSnuBal3atpn5ph+3Zh
         79cw==
X-Gm-Message-State: ACgBeo04WuSixfntiNuWVALo1Nk/FRwc9xzuIin0lxZaBwCPwZRmVbHz
        /Z8cNyeMmiyu8nJSw2vt3OXg6hT+2iE=
X-Google-Smtp-Source: AA6agR5+9F7WPm1USe62ojFeSnfzFMZeUpMw7zj/pRwB6KMbF7WuLWXAg01L260/bMYZ3vQNNgDzig==
X-Received: by 2002:a17:903:32d2:b0:172:f62a:2f33 with SMTP id i18-20020a17090332d200b00172f62a2f33mr5916748plr.16.1661558754807;
        Fri, 26 Aug 2022 17:05:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 09/11] client/player: Use QoS interval on transport.send
Date:   Fri, 26 Aug 2022 17:05:38 -0700
Message-Id: <20220827000540.113414-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
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

