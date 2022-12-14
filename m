Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F27C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Dec 2022 00:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiLNAVh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbiLNAVe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Dec 2022 19:21:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FC26E
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 16:21:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so5311241pjo.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 16:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjLFNyLr9aJ18MvnVuzLEAw1HzFHK+KURxCgwlum7aQ=;
        b=IMmg7X2NPsh0yozXeESUiAQUeN8/uGdkMAykkidY+u8hzzrMwwGhcYpfxdGa+wyBDh
         sqqiEVjDZMHVJh7tKraPvaJfySm+knV5uVUdWR8+G4eJazCbHh7qdJ454ex1LuEHExUZ
         aVToTBE4apj1ombFAcaSj/KcGu1dY9rz58z9i4zSHMM2q1B2EaZGllTzj7udVQR4IqrA
         oTJybGaYzp4Ms+JuLKguHpa0TEnlyImcrTAm9XhKOCvN6PoJVy8eZ8aBV6d27q07I6MA
         /3hku95lCO6sPVmfLWW1ru9qRDgjOdCbVEcXvhQoEINEdiJucaSmoFO8qnTy0K8B1eMm
         nhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjLFNyLr9aJ18MvnVuzLEAw1HzFHK+KURxCgwlum7aQ=;
        b=IARt3haGYEevTbYLEpM1qmkBREvH1uPyXIgEtNon8JsyNj8+9GAP+RYjrX+5AweD+L
         a5+4MBHH6jMjiSgnBElhEziEl8osJpEAXybatClAbux3tlKmTKqltA/Qofw+i5Rw7HAt
         fli5EXx/LG23f72GhpuEKX93IegskFIqmahEJPQ8qRD/8sKo78b4uQ7PrNk/Zc0QUdjt
         JbPLf24ekhPM4Aw6OEwj1pOa2lujFCxlkNs9X3x48iPDPun3i7Iq47Gi0KVIgR2Ofli6
         vowRuJw+66QMqexSopsvK97T3GMHIMrvT8Sjy7msWkdiPFcm9Ms7y91CWP31HuFfiRa1
         1gXw==
X-Gm-Message-State: ANoB5pnA5MBcVUlIhNjkrALmYibC9Ib4dKmW530qBfoSjibOHbYjHdE+
        LY8zhGLxfqCq4yjVDGhexPOMFtJurSdLd7YV
X-Google-Smtp-Source: AA0mqf5CR1WjBs+iZvr7rVq+7sMByQQicgHjOT1MkVgXNxLJODlkz3u7NHMVuGSAqD3u0a3WuAiCMw==
X-Received: by 2002:a17:902:d4d2:b0:189:cdcc:5055 with SMTP id o18-20020a170902d4d200b00189cdcc5055mr32394126plg.0.1670977291521;
        Tue, 13 Dec 2022 16:21:31 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b001895d871c95sm482446plb.70.2022.12.13.16.21.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 16:21:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] client/player: Make transport.send non-blocking
Date:   Tue, 13 Dec 2022 16:21:27 -0800
Message-Id: <20221214002129.2105777-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes transport.send command non-blocking by using timerfd
callback to initiate the transfers.
---
 client/player.c | 206 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 139 insertions(+), 67 deletions(-)

diff --git a/client/player.c b/client/player.c
index 95309e101148..2c15fb0c2d01 100644
--- a/client/player.c
+++ b/client/player.c
@@ -24,6 +24,7 @@
 #include <sys/ioctl.h>
 #include <sys/uio.h>
 #include <wordexp.h>
+#include <sys/timerfd.h>
 
 #include <glib.h>
 
@@ -92,6 +93,7 @@ struct transport {
 	int fd;
 	struct io *io;
 	uint32_t seq;
+	struct io *timer_io;
 };
 
 static void endpoint_unregister(void *data)
@@ -3004,6 +3006,8 @@ static void transport_close(struct transport *transport)
 		return;
 
 	close(transport->fd);
+	transport->fd = -1;
+
 	free(transport->filename);
 }
 
@@ -3011,6 +3015,7 @@ static void transport_free(void *data)
 {
 	struct transport *transport = data;
 
+	io_destroy(transport->timer_io);
 	io_destroy(transport->io);
 	free(transport);
 }
@@ -3375,104 +3380,167 @@ static int open_file(const char *filename, int flags)
 	return fd;
 }
 
-#define NSEC_USEC(_t) (_t / 1000L)
-#define SEC_USEC(_t)  (_t  * 1000000L)
-#define TS_USEC(_ts)  (SEC_USEC((_ts)->tv_sec) + NSEC_USEC((_ts)->tv_nsec))
-
-static void send_wait(struct timespec *t_start, uint32_t us)
+static int elapsed_time(bool reset, int *secs, int *nsecs)
 {
-	struct timespec t_now;
-	struct timespec t_diff;
-	int64_t delta_us;
+	static struct timespec start;
+	struct timespec curr;
 
-	/* Skip sleep at start */
-	if (!us)
-		return;
-
-	if (clock_gettime(CLOCK_MONOTONIC, &t_now) < 0) {
-		bt_shell_printf("clock_gettime: %s (%d)", strerror(errno),
-								errno);
-		return;
+	if (reset) {
+		if (clock_gettime(CLOCK_MONOTONIC, &start) < 0) {
+			bt_shell_printf("clock_gettime: %s (%d)",
+						strerror(errno), errno);
+			return -errno;
+		}
 	}
 
-	t_diff.tv_sec = t_now.tv_sec - t_start->tv_sec;
-	if (t_start->tv_nsec > t_now.tv_nsec) {
-		t_diff.tv_sec--;
-		t_now.tv_nsec += 1000000000L;
-	}
-	t_diff.tv_nsec = t_now.tv_nsec - t_start->tv_nsec;
-
-	delta_us = us - TS_USEC(&t_diff);
-
-	if (delta_us < 0) {
-		bt_shell_printf("Send is behind: %" PRId64 " us - skip sleep",
-							delta_us);
-		delta_us = 1000;
-	}
-
-	usleep(delta_us);
-
-	if (clock_gettime(CLOCK_MONOTONIC, t_start) < 0)
+	if (clock_gettime(CLOCK_MONOTONIC, &curr) < 0) {
 		bt_shell_printf("clock_gettime: %s (%d)", strerror(errno),
-								errno);
-}
-
-static int transport_send(struct transport *transport, int fd,
-					struct bt_iso_qos *qos)
-{
-	struct timespec t_start;
-	uint8_t *buf;
-	uint32_t num = 0;
-
-	if (qos && clock_gettime(CLOCK_MONOTONIC, &t_start) < 0) {
-		bt_shell_printf("clock_gettime: %s (%d)", strerror(errno),
-								errno);
+						errno);
 		return -errno;
 	}
 
-	buf = malloc(transport->mtu[1]);
-	if (!buf) {
-		bt_shell_printf("malloc: %s (%d)", strerror(errno), errno);
-		return -ENOMEM;
+	*secs = curr.tv_sec - start.tv_sec;
+	*nsecs = curr.tv_nsec - start.tv_nsec;
+	if (*nsecs < 0) {
+		(*secs)--;
+		*nsecs += 1000000000;
 	}
 
-	/* num of packets = latency (ms) / interval (us) */
-	if (qos)
-		num = (qos->out.latency * 1000 / qos->out.interval);
+	return 0;
+}
 
-	for (transport->seq = 0; ; transport->seq++) {
+static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
+{
+	uint8_t *buf;
+	uint32_t i;
+
+	if (!num)
+		return 0;
+
+	buf = malloc(transport->mtu[1]);
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++, transport->seq++) {
 		ssize_t ret;
 		int queued;
+		int secs = 0, nsecs = 0;
 
 		ret = read(fd, buf, transport->mtu[1]);
 		if (ret <= 0) {
 			if (ret < 0)
 				bt_shell_printf("read failed: %s (%d)",
 						strerror(errno), errno);
-			close(fd);
+			free(buf);
 			return ret;
 		}
 
 		ret = send(transport->sk, buf, ret, 0);
 		if (ret <= 0) {
-			bt_shell_printf("Send failed: %s (%d)",
+			bt_shell_printf("send failed: %s (%d)",
 							strerror(errno), errno);
+			free(buf);
 			return -errno;
 		}
 
+		elapsed_time(!transport->seq, &secs, &nsecs);
+
 		ioctl(transport->sk, TIOCOUTQ, &queued);
 
-		bt_shell_printf("[seq %d] send: %zd bytes "
+		bt_shell_printf("[seq %d %d.%03ds] send: %zd bytes "
 				"(TIOCOUTQ %d bytes)\n",
-				transport->seq, ret, queued);
-
-		if (qos) {
-			if (transport->seq && !((transport->seq + 1) % num))
-				send_wait(&t_start, num * qos->out.interval);
-		}
+				transport->seq, secs,
+				(nsecs + 500000) / 1000000,
+				ret, queued);
 	}
 
 	free(buf);
+
+	return i;
+}
+
+static bool transport_timer_read(struct io *io, void *user_data)
+{
+	struct transport *transport = user_data;
+	struct bt_iso_qos qos;
+	socklen_t len;
+	int ret, fd;
+	uint32_t num;
+	uint64_t exp;
+
+	if (transport->fd < 0)
+		return false;
+
+	fd = io_get_fd(io);
+	ret = read(fd, &exp, sizeof(exp));
+	if (ret < 0) {
+		bt_shell_printf("Failed to read: %s (%d)\n", strerror(errno),
+								-errno);
+		return false;
+	}
+
+	/* Read QoS if available */
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos);
+	if (getsockopt(transport->sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
+							&len) < 0) {
+		bt_shell_printf("Failed to getsockopt(BT_ISO_QOS): %s (%d)\n",
+					strerror(errno), -errno);
+		return false;
+	}
+
+	/* num of packets = latency (ms) / interval (us) */
+	num = (qos.out.latency * 1000 / qos.out.interval);
+
+	ret = transport_send_seq(transport, transport->fd, num);
+	if (ret < 0) {
+		bt_shell_printf("Unable to send: %s (%d)\n",
+					strerror(-ret), ret);
+		return false;
+	}
+
+	if (!ret) {
+		bt_shell_printf("Transfer complete\n");
+		transport_close(transport);
+		return false;
+	}
+
+	return true;
+}
+
+static int transport_send(struct transport *transport, int fd,
+					struct bt_iso_qos *qos)
+{
+	struct itimerspec ts;
+	int timer_fd;
+
+	transport->seq = 0;
+
+	if (!qos)
+		return transport_send_seq(transport, fd, UINT32_MAX);
+
+	if (transport->fd >= 0)
+		return -EALREADY;
+
+	timer_fd = timerfd_create(CLOCK_MONOTONIC, 0);
+	if (timer_fd < 0)
+		return -errno;
+
+	memset(&ts, 0, sizeof(ts));
+	ts.it_value.tv_nsec = qos->out.latency * 1000000;
+	ts.it_interval.tv_nsec = qos->out.latency * 1000000;
+
+	if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
+		return -errno;
+
+	transport->fd = fd;
+
+	transport->timer_io = io_new(timer_fd);
+
+	io_set_read_handler(transport->timer_io, transport_timer_read,
+						transport, NULL);
+
+	return transport_send_seq(transport, fd, 1);
 }
 
 static void cmd_send_transport(int argc, char *argv[])
@@ -3502,6 +3570,8 @@ static void cmd_send_transport(int argc, char *argv[])
 	}
 
 	fd = open_file(argv[2], O_RDONLY);
+	if (fd < 0)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	bt_shell_printf("Sending ...\n");
 
@@ -3514,10 +3584,12 @@ static void cmd_send_transport(int argc, char *argv[])
 	else
 		err = transport_send(transport, fd, &qos);
 
-	close(fd);
-
-	if (err < 0)
+	if (err < 0) {
+		bt_shell_printf("Unable to send: %s (%d)", strerror(-err),
+								-err);
+		close(fd);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
-- 
2.37.3

