Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE2EC32789
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 23:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbiHQXmH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 19:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbiHQXmG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 19:42:06 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2158A883D5
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:42:05 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d1so165463qvs.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=uKZN+WtU9c3IVIhReF07AEB77DEg2H9OvDD5FkV5cdU=;
        b=Q8Erl2eUY4fC5hv58lRJIPm5M5zpQO5t63O/9UbrQSYJtkW8zV7osq6MhQ62+8wsSA
         PY8ZlbkrPwIg2cfucm5UGAO5DRs3fWFeRxTL2PlXxG1qqUyCC9M0GdI1wGSWGGOK5cvS
         n1X2wYjQeoJ/7Q3qyW5e4hTa5KHardb7oBBSydAYdiAVCr5TMZbsFqEqcCxmRCVAvl8E
         2yn6VVG+z15swWpOPlE9eNaouSh70i4TP8yC/k8mcpih1TzO1tDjHhG3z7UNniba4Dtn
         aR4Hmd4xyA6R2rwbj9VmjSnQX2+0M4FTZKsrs47ziW+0FSAn85dq2mP2kAdMMM3FvFoI
         K51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=uKZN+WtU9c3IVIhReF07AEB77DEg2H9OvDD5FkV5cdU=;
        b=59BkIBZAHEobYCxXc8ku7rbU4fqz6LLv/cLXMhHiordBGs/GUBb8CgAuiXvD8rEsW2
         Y29oNOBQD6OoioQRNCLjTEK9LqxA7WVv0izOm2M4JJp0Z8FLQHdJyFHn1iLMlYaHTcij
         0f15lXf8CP373GBHRygBKNKPDOydjr85K/7CUKPZbdTikX/U4nFeZTCh2pA8XDlXSJEO
         WJJtkrVbHNbLKE/jrfof+F3+kzCBwJ+jEuw4uQN7BN0Sbvht2pgpS7917mq8G5r4RZpQ
         o2OgIyji35+OM77flTc81gDucpQCmmk2Htyh0Hz7rnwmUOPqoO7tEXUTIkKS5KchNaC/
         0t8g==
X-Gm-Message-State: ACgBeo3VG5WzmTjsF1PbJZ2r8qZFihs9CogVzs+6nWY/0ryYFpcJrz4Q
        9P0C4ws3O7v50ZCeiTtsz/wo54JYQbGd1fAr
X-Google-Smtp-Source: AA6agR58QC+9SmTtcY/8Ltxeu1O+kgVqmDNd5nYgkFtvi4Ed+lPUl3qqIDUwASBTpO6g0PmWLlsuaw==
X-Received: by 2002:a0c:8045:0:b0:476:dbbe:f169 with SMTP id 63-20020a0c8045000000b00476dbbef169mr349488qva.90.1660779723809;
        Wed, 17 Aug 2022 16:42:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r25-20020ae9d619000000b006bb2f555ba4sm189637qkk.41.2022.08.17.16.42.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:42:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 9/9] client/player: Use QoS interval on transport.send
Date:   Wed, 17 Aug 2022 16:41:46 -0700
Message-Id: <20220817234146.224081-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817234146.224081-1-luiz.dentz@gmail.com>
References: <20220817234146.224081-1-luiz.dentz@gmail.com>
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

