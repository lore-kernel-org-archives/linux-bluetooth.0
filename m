Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684045;
	b=CsR70BO87nYwq0n3IFJyym5DUq6MHpUA7SvAV/aqzxiI+lMcWB5mHSVl3jBXCJbKlHsj
	 AC1VoPEjXk/hgxxz7ZX4Aj8lP8uMhNPgxQsDaR3AG0R482qaSe9I/mBV+PiISXBWTO1SR
	 jNaahGiQBZKEwNZ1h+7SlACykRXtHI4pk9cjQfwwWvuoGz+35bIDcNTt2KMl38tMnX+Ls
	 2wGXXlq850vuwltvfvH5BTPgu5wzi8O4fRhLNDmYTEbO/nvcF5C/yXUUn1RS4GT9Dpxm9
	 hLzDzKc2HTF1lva+WAMhoDxnbHAjzHb6Ic+gM0hmZgVg80Fc2ICCkklFkLqW+wDGPug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=thRvKYWN94dLvnjXMDHvBWLVJcnKyXjZ40Nuj3nJDFc=;
	b=kNHi5b3rXX6LUnGm85fshLCBUrReFfqFoD+5RwTWL9ZyKRAzAxuyZv8hJZdJQmjmmQdr
	 brvzrTxQ4lNejMO3csea9aJGpSWmIFhuWlRWqlaL7yWybbLutos/uEjmSL4Xv8ZL/JtuP
	 +DCVuasDMvEBB4yeKk6iwEsIUoNShp6zDncM4MF4T6u/CEZ9luyFxgcKlDL5SW1+80TQ/
	 F5RfK6zUMQKXn+I15OrDRYwuSl2SFPOLs13AMr3+ZWJU0aKtS1YK2IWt22/OcreqQtCvE
	 L4wSYzk+M3njwT+DOnUdpoawhenTRIOMnXnwr9B2GGhUBhRZ1WZ/ER06TVzX5nRE0zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HNqcjJtJ;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931E606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7931E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HNqcjJtJ
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so10985e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684043; x=1793288843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=thRvKYWN94dLvnjXMDHvBWLVJcnKyXjZ40Nuj3nJDFc=;
        b=HNqcjJtJjM/3kKeAm3m9PBZf0T5eopImEp9afX8OYDFtdkUhjRUCtv6Ndd1vd+sZx3
         TDzCWPMV8GyCtg2pJoFrmtFzb4bjethaUWCbEfwI8E/BgWo828LRZydNSjVIIVvjiWbJ
         htu7Q8udb9AHtrm5kh7CEoQh4tyCu8Phv+aTS/0Oe+52TEpqo96nizglxmTX7r3Fx6Jw
         rZCHKBf/xEvd9uwD9VPFWoUZ5S7wxi2QjoTrtyOyAReJ6YtNDo6cyzK+K5CJ+7xxQkM3
         T42HwLpeEna6YjORH6sln2+aTxgjz56bR8CdvLjVP+vxv6tw63mSoRpaRUNLwZ9BUEY7
         4nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684043; x=1793288843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=thRvKYWN94dLvnjXMDHvBWLVJcnKyXjZ40Nuj3nJDFc=;
        b=hVpLbgsMZ6AKZJ+d0xAiAk7oadEkYcSVeRcnDbSwhHhaeaAtD+ogavcAIRY1WuTT0p
         uPup2ZR3d11AW3CV3pASoX449F/vi0LYxF34Fpt/puZtr4x+SN+gXznhrr7EP69613pg
         OsE4JfjF+d7dJ7jm20iq4hrIHXRdbGGUrvFJikQYHNgeeNmd5f6VNnJDHtP4z/d8IcIG
         yWTpmbf7+Qf7pVmMI0zEYDsV4asNI66wJl6UlDxrBxz6Nm1m2nTip2Y1U9FS4tXauBSe
         EzNr7FwMuJhLcRR6y80wF6fFZrx3fe7N2hS4VBQAyWAGda8RuGhlEusetSrJehcogebO
         ngWQ==
X-Gm-Message-State: AFq9FYJlTEY7Hxei8nXkC6YV82BRRt5WY25yk9ftoEwhXEY7h6l+QlZf
	7yUwWLrg2wWEybRrBRp3ol0lnx6kyfWQqnAdrHvMfv+8Qiw7WFRi1NnOW8U/QR7o/9U=
X-Gm-Gg: AYBFou0ktQR+GndGGbz1t+DI/eXfhYouS9zS4LLUcaprr+LPvNREqbQrRev+PjylmhY
	9pe+z9HkY8ZwCGM32Qo+pUzmawIu7mMBw8hvSJ4I9EWbUkoRoVj/qeo0/tzWDFPgpFQcM8IGg8I
	b1zLMAHv42MDzmvmrjl8eRYEOi8NgCwBmVu6WToX7vyFAkcLFmKTJVCnxkcSF3Vufnt+oEkqp8S
	owO6psn9bSVmSmee10digwUDsaSeC9FfDayMT2k1OdS9HGqV5vAyFEL0JkFerRvu8EVw7iO1/oH
	TNt8tW93bMQLFVPAJuE0gKEAJKWmTscoCzTjVr9MH0RocKhBHk+i2YrVtghkdM/b7gCPmPJ1NiI
	xHx0oBXKdZE7et9cjgDBzQTBAdpUSOQQ3Cpgq8LaRxXD8mpxzaROP5kkMr871OEV2YgCyU9maEb
	R3eicRzkatO1RqpUJjsSfrwp9GAPLiKIqocVh/C2iHiT4H/qLmfo+7Qx/Wm9S81Td0EPXQ4h65X
	4IPcQOdScRaMl6HTSz5eBTgrpEbWQvUEDSX0x7K06rbHdw5d0UUw6fPk4rryzl9Zlf7ok0obPrO
	cXKLuMO7f29GgUC9wfHUq7OWMudsIoVmIi/T90PfAIkNa4yDXoLb0XzaPkwTCkKfrt8=
X-Received: by 2002:a05:6122:1c83:b0:5d1:dd67:3a02 with SMTP id 71dfb90a1353d-5eaebe06a7amr2221815e0c.10.1792684043046;
        Thu, 22 Oct 2026 08:47:23 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 14/27] emulator: Add virtio console and time travel client to btvirt
Date: Thu, 22 Oct 2026 11:46:47 -0400
Message-ID: <20261022154701.3959500-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add --console, a vhost-user virtio console with named ports, each
relayed to a Unix socket <path>-<name>, so a test driver outside the
guest, such as pytest-bluezenv, can reach User Mode Linux guests the way
it uses virtio-serial ports under QEMU. While the driver has no request
outstanding on a sync port, time is paced to real time so guests do not
run ahead of it.

Add --time-client, so the console relay takes part in an external time
travel calendar, e.g. one simulating the controllers: it keeps a request
one quantum (100 us) ahead and only injects input while the calendar
lets it run, as guests may run ahead of the calendar's current time with
FREE_UNTIL. Add --time-skew for btvirt's own calendar.

Assisted-by: Claude:claude-opus-5-5
---
 Makefile.tools      |   2 +
 emulator/main.c     |  69 ++++-
 emulator/ttclient.c | 313 ++++++++++++++++++++
 emulator/ttclient.h |  50 ++++
 emulator/vconsole.c | 701 ++++++++++++++++++++++++++++++++++++++++++++
 emulator/vconsole.h |  26 ++
 6 files changed, 1158 insertions(+), 3 deletions(-)
 create mode 100644 emulator/ttclient.c
 create mode 100644 emulator/ttclient.h
 create mode 100644 emulator/vconsole.c
 create mode 100644 emulator/vconsole.h

diff --git a/Makefile.tools b/Makefile.tools
index bc92bc02b83d..304dbf135e98 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -106,6 +106,8 @@ emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 				emulator/vhost.h emulator/vhost.c \
 				emulator/virtio.h emulator/virtio.c \
 				emulator/timetravel.h emulator/timetravel.c \
+				emulator/vconsole.h emulator/vconsole.c \
+				emulator/ttclient.h emulator/ttclient.c \
 				emulator/timeout.c
 emulator_btvirt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
 
diff --git a/emulator/main.c b/emulator/main.c
index a3b9456bb642..794d381764b5 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -29,6 +29,8 @@
 #include "vhci.h"
 #include "virtio.h"
 #include "timetravel.h"
+#include "vconsole.h"
+#include "ttclient.h"
 #include "le.h"
 
 static void signal_callback(int signum, void *user_data)
@@ -55,6 +57,14 @@ static void usage(void)
 		"\t                      server socket\n"
 		"\t--time[=path=/tmp]    Create time travel calendar socket\n"
 		"\t                      for User Mode Linux guests\n"
+		"\t--time-skew=<msec>    Let guests run up to msec apart\n"
+		"\t                      (default: 0, lock-step)\n"
+		"\t--time-client=<id>:<socket>\n"
+		"\t                      Inject console input as client of a\n"
+		"\t                      time travel calendar\n"
+		"\t--console=<path>:<name>[=sync]...\n"
+		"\t                      Create vhost-user virtio console with\n"
+		"\t                      named ports relayed to <path>-<name>\n"
 		"\t-l[num]               Number of local controllers\n"
 		"\t-L                    Create LE only controller\n"
 		"\t-U[num]               Number of test LE controllers\n"
@@ -74,6 +84,9 @@ static const struct option main_options[] = {
 	{ "tcp",     optional_argument, NULL, 't' },
 	{ "vhost",   optional_argument, NULL, 'V' },
 	{ "time",    optional_argument, NULL, 'I' },
+	{ "console", required_argument, NULL, 'O' },
+	{ "time-skew", required_argument, NULL, 'K' },
+	{ "time-client", required_argument, NULL, 'J' },
 	{ "local",   optional_argument, NULL, 'l' },
 	{ "le",      no_argument,       NULL, 'L' },
 	{ "bredr",   no_argument,       NULL, 'B' },
@@ -136,6 +149,10 @@ int main(int argc, char *argv[])
 	uint16_t tcp_port = 0;
 	const char *vhost_path = NULL;
 	const char *time_path = NULL;
+	const char *consoles[16];
+	int console_count = 0;
+	unsigned int time_skew = 0;
+	const char *time_client = NULL;
 	bool serial_enabled = false;
 	int letest_count = 0;
 	int vhci_count = 0;
@@ -150,8 +167,9 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "dSs::t::V::I::l::LBAC:U::vh",
-						main_options, NULL);
+		opt = getopt_long(argc, argv,
+					"dSs::t::V::I::O:K:J:l::LBAC:U::vh",
+					main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -173,6 +191,19 @@ int main(int argc, char *argv[])
 			else
 				tcp_port = 45550;
 			break;
+		case 'J':
+			time_client = optarg;
+			break;
+		case 'K':
+			time_skew = atoi(optarg);
+			break;
+		case 'O':
+			if (console_count == ARRAY_SIZE(consoles)) {
+				fprintf(stderr, "Too many consoles\n");
+				return EXIT_FAILURE;
+			}
+			consoles[console_count++] = optarg;
+			break;
 		case 'I':
 			time_path = optarg ? optarg : "/tmp";
 			break;
@@ -226,7 +257,7 @@ int main(int argc, char *argv[])
 
 	if (letest_count < 1 && vhci_count < 1 && !server_enabled &&
 				!tcp_port && !serial_enabled && !vhost_path &&
-				!time_path) {
+				!time_path && !console_count) {
 		fprintf(stderr, "No emulator specified\n");
 		return EXIT_FAILURE;
 	}
@@ -243,6 +274,8 @@ int main(int argc, char *argv[])
 			return EXIT_FAILURE;
 		}
 
+		tt_set_skew(time_skew);
+
 		if (debug_enabled)
 			tt_set_debug(server_debug, "time");
 	}
@@ -337,6 +370,36 @@ int main(int argc, char *argv[])
 		fprintf(stderr, "Listening TCP on 127.0.0.1:%d\n", tcp_port);
 	}
 
+	for (i = 0; i < console_count; i++) {
+		struct vcon *vcon;
+
+		vcon = vcon_open(consoles[i]);
+		if (!vcon)
+			return EXIT_FAILURE;
+
+		if (debug_enabled)
+			vcon_set_debug(vcon, server_debug, "console");
+	}
+
+	if (time_client) {
+		char *end;
+		unsigned long id = strtoul(time_client, &end, 0);
+
+		if (*end != ':' || !end[1]) {
+			fprintf(stderr, "Invalid time client: %s\n",
+								time_client);
+			return EXIT_FAILURE;
+		}
+
+		if (debug_enabled)
+			ttc_set_debug(server_debug, "time-client");
+
+		if (!ttc_open(end + 1, id, 0)) {
+			fprintf(stderr, "Failed to connect to %s\n", end + 1);
+			return EXIT_FAILURE;
+		}
+	}
+
 	if (vhost_path) {
 		struct vtio *vtio;
 		char path[PATH_MAX];
diff --git a/emulator/ttclient.c b/emulator/ttclient.c
new file mode 100644
index 000000000000..c134b5be9af0
--- /dev/null
+++ b/emulator/ttclient.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "src/shared/mainloop.h"
+#include "src/shared/util.h"
+
+#include "ttclient.h"
+
+/* Protocol of include/uapi/linux/um_timetravel.h in Linux */
+#define TT_ACK		0
+#define TT_START	1
+#define TT_REQUEST	2
+#define TT_WAIT		3
+#define TT_RUN		6
+#define TT_FREE_UNTIL	7
+#define TT_BROADCAST	9
+
+struct tt_msg {
+	uint32_t op;
+	uint32_t seq;
+	uint64_t time;
+} __attribute__((packed));
+
+static struct {
+	int fd;
+	uint32_t seq;
+	uint64_t now;
+	uint64_t quantum;
+	bool running;
+	int pace_id;
+	ttc_run_func_t run;
+	void *run_data;
+	ttc_pace_func_t pace;
+	void *pace_data;
+	ttc_debug_func_t debug;
+	void *debug_data;
+} ttc = { .fd = -1 };
+
+static void ttc_debug(const char *format, ...)
+{
+	char str[128];
+	va_list ap;
+
+	if (!ttc.debug)
+		return;
+
+	va_start(ap, format);
+	vsnprintf(str, sizeof(str), format, ap);
+	va_end(ap);
+
+	ttc.debug(str, ttc.debug_data);
+}
+
+/* Read a message, closing any file descriptors it carries (shared memory
+ * offered with the START acknowledgment, which this client does not use).
+ */
+static bool read_msg(struct tt_msg *msg)
+{
+	char control[CMSG_SPACE(sizeof(int) * 2)];
+	struct iovec iov = { msg, sizeof(*msg) };
+	struct msghdr mh = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = control,
+		.msg_controllen = sizeof(control),
+	};
+	struct cmsghdr *cmsg;
+	ssize_t len;
+
+	do {
+		len = recvmsg(ttc.fd, &mh, MSG_CMSG_CLOEXEC);
+	} while (len < 0 && errno == EINTR);
+
+	for (cmsg = CMSG_FIRSTHDR(&mh); cmsg; cmsg = CMSG_NXTHDR(&mh, cmsg)) {
+		int fds[2];
+		unsigned int i, n;
+
+		if (cmsg->cmsg_level != SOL_SOCKET ||
+					cmsg->cmsg_type != SCM_RIGHTS)
+			continue;
+
+		n = MIN((cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int), 2U);
+		memcpy(fds, CMSG_DATA(cmsg), n * sizeof(int));
+		for (i = 0; i < n; i++)
+			close(fds[i]);
+	}
+
+	return len == sizeof(*msg);
+}
+
+static void send_msg(uint32_t op, uint32_t seq, uint64_t time)
+{
+	struct tt_msg msg = { .op = op, .seq = seq, .time = time };
+
+	if (write(ttc.fd, &msg, sizeof(msg)) < 0)
+		ttc_debug("write failed: %s", strerror(errno));
+}
+
+/* Messages the calendar may send at any time */
+static void handle_async(struct tt_msg *msg)
+{
+
+	switch (msg->op) {
+	case TT_FREE_UNTIL:
+	case TT_BROADCAST:
+		send_msg(TT_ACK, msg->seq, 0);
+		break;
+	case TT_RUN:
+		ttc.now = msg->time;
+		ttc.running = true;
+		send_msg(TT_ACK, msg->seq, 0);
+		break;
+	}
+}
+
+/* Send a request and wait for its acknowledgment */
+static bool request(uint32_t op, uint64_t time, uint64_t *ack_time)
+{
+	uint32_t seq = ++ttc.seq;
+	struct tt_msg msg;
+
+	send_msg(op, seq, time);
+
+	while (read_msg(&msg)) {
+		if (msg.op == TT_ACK && msg.seq == seq) {
+			if (ack_time)
+				*ack_time = msg.time;
+			return true;
+		}
+
+		handle_async(&msg);
+	}
+
+	ttc_debug("calendar connection lost");
+	return false;
+}
+
+static void run(void);
+
+void ttc_process(void)
+{
+	struct tt_msg msg;
+
+	if (ttc.fd < 0)
+		return;
+
+	/* Only messages the calendar may send while the client runs */
+	while (recv(ttc.fd, &msg, sizeof(msg), MSG_DONTWAIT | MSG_PEEK) ==
+							sizeof(msg)) {
+		if (msg.op != TT_FREE_UNTIL && msg.op != TT_BROADCAST)
+			break;
+
+		if (!read_msg(&msg))
+			break;
+
+		handle_async(&msg);
+	}
+}
+
+/* Ask to run again one quantum later and let the guests run until then */
+static void wait_next(void)
+{
+	if (!request(TT_REQUEST, ttc.now + ttc.quantum, NULL) ||
+				!request(TT_WAIT, (uint64_t) -1, NULL)) {
+		mainloop_remove_fd(ttc.fd);
+		return;
+	}
+
+	ttc.running = false;
+}
+
+static void pace_callback(int id, void *user_data)
+{
+	mainloop_remove_timeout(id);
+	ttc.pace_id = 0;
+	wait_next();
+}
+
+static void run(void)
+{
+	if (ttc.run)
+		ttc.run(ttc.run_data);
+
+	/* Without anything asked of the guests, hold time for one quantum
+	 * of real time, so it advances no faster than real time.
+	 */
+	if (ttc.pace && ttc.pace(ttc.pace_data)) {
+		ttc.pace_id = mainloop_add_timeout(
+				MAX(ttc.quantum / 1000000ULL, 1ULL),
+				pace_callback, NULL, NULL);
+		if (ttc.pace_id > 0)
+			return;
+	}
+
+	wait_next();
+}
+
+static void read_callback(int fd, uint32_t events, void *user_data)
+{
+	struct tt_msg msg;
+
+	if ((events & (EPOLLERR | EPOLLHUP)) || !read_msg(&msg)) {
+		ttc_debug("calendar disconnected");
+		mainloop_remove_fd(fd);
+		return;
+	}
+
+	handle_async(&msg);
+
+	if (msg.op == TT_RUN)
+		run();
+}
+
+static void ttc_destroy(void *user_data)
+{
+	if (ttc.pace_id > 0)
+		mainloop_remove_timeout(ttc.pace_id);
+
+	close(ttc.fd);
+	ttc.fd = -1;
+	ttc.running = false;
+}
+
+bool ttc_open(const char *path, unsigned int id, unsigned int quantum_us)
+{
+	struct sockaddr_un addr;
+	uint64_t ack;
+
+	if (ttc.fd >= 0 || strlen(path) >= sizeof(addr.sun_path))
+		return false;
+
+	ttc.fd = socket(PF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (ttc.fd < 0)
+		return false;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	memcpy(addr.sun_path, path, strlen(path));
+
+	if (connect(ttc.fd, (struct sockaddr *) &addr, sizeof(addr)) < 0)
+		goto fail;
+
+	ttc.quantum = (uint64_t) (quantum_us ? quantum_us : 100) * 1000ULL;
+
+	if (!request(TT_START, id, &ack))
+		goto fail;
+
+	ttc_debug("started, id %u", (unsigned int) (ack & 0xffff));
+
+	if (mainloop_add_fd(ttc.fd, EPOLLIN, read_callback, NULL,
+							ttc_destroy) < 0)
+		goto fail;
+
+	/* A client runs once started */
+	ttc.running = true;
+	run();
+
+	return true;
+
+fail:
+	close(ttc.fd);
+	ttc.fd = -1;
+	return false;
+}
+
+bool ttc_enabled(void)
+{
+	return ttc.fd >= 0;
+}
+
+bool ttc_running(void)
+{
+	return ttc.fd < 0 || ttc.running;
+}
+
+void ttc_set_run(ttc_run_func_t func, void *user_data)
+{
+	ttc.run = func;
+	ttc.run_data = user_data;
+}
+
+void ttc_set_pace(ttc_pace_func_t func, void *user_data)
+{
+	ttc.pace = func;
+	ttc.pace_data = user_data;
+}
+
+void ttc_set_debug(ttc_debug_func_t callback, void *user_data)
+{
+	ttc.debug = callback;
+	ttc.debug_data = user_data;
+}
diff --git a/emulator/ttclient.h b/emulator/ttclient.h
new file mode 100644
index 000000000000..237a42cc6db9
--- /dev/null
+++ b/emulator/ttclient.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+
+/* Time travel client: takes part in the scheduling of a calendar (the time
+ * controller of User Mode Linux guests started with time-travel=ext), so
+ * that input from outside the simulation is injected at simulated times
+ * no guest has run past.
+ *
+ * The client keeps a request one quantum ahead of its time, so the
+ * calendar never lets guests run (or run ahead with FREE_UNTIL) beyond
+ * it, and only runs when the calendar grants it. Requesting the current
+ * time instead is not safe: with FREE_UNTIL, guests may already be past
+ * the calendar's current time.
+ */
+
+/* Quantum in microseconds, default (0) 100 */
+bool ttc_open(const char *path, unsigned int id, unsigned int quantum_us);
+bool ttc_enabled(void);
+
+/* The calendar granted the client to run: injecting events is safe */
+bool ttc_running(void);
+
+/* Answer pending calendar messages, e.g. while waiting for a guest that
+ * itself waits for the calendar
+ */
+void ttc_process(void);
+
+/* Called each time the client runs */
+typedef void (*ttc_run_func_t)(void *user_data);
+void ttc_set_run(ttc_run_func_t func, void *user_data);
+
+/* While the pace function returns true, the client lets the guests' time
+ * advance no faster than real time, e.g. while a test driver outside the
+ * simulation has not asked anything of the guests.
+ */
+typedef bool (*ttc_pace_func_t)(void *user_data);
+void ttc_set_pace(ttc_pace_func_t func, void *user_data);
+
+typedef void (*ttc_debug_func_t)(const char *str, void *user_data);
+void ttc_set_debug(ttc_debug_func_t callback, void *user_data);
diff --git a/emulator/vconsole.c b/emulator/vconsole.c
new file mode 100644
index 000000000000..7d288458a759
--- /dev/null
+++ b/emulator/vconsole.c
@@ -0,0 +1,701 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "src/shared/mainloop.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+
+#include "vhost.h"
+#include "timetravel.h"
+#include "ttclient.h"
+#include "vconsole.h"
+
+/* Virtio console, see include/uapi/linux/virtio_console.h in Linux */
+#define VCON_F_MULTIPORT	1
+
+#define VCON_DEVICE_READY	0
+#define VCON_DEVICE_ADD		1
+#define VCON_PORT_READY		3
+#define VCON_PORT_OPEN		6
+#define VCON_PORT_NAME		7
+
+/* Queues: port 0 receive/transmit, control receive/transmit, then a
+ * receive/transmit pair for each further port.
+ */
+#define VCON_CTRL_RX		2
+#define VCON_CTRL_TX		3
+
+#define VCON_MAX_PORTS		3
+#define VCON_MAX_NAME		64
+/* The Linux driver posts receive buffers of a page */
+#define VCON_CHUNK		4096
+/* Data from the guest kept while no peer is connected */
+#define VCON_MAX_BACKLOG	(1024 * 1024)
+
+struct vcon_config {
+	uint16_t cols;
+	uint16_t rows;
+	uint32_t max_nr_ports;
+	uint32_t emerg_wr;
+} __attribute__((packed));
+
+struct vcon_ctrl {
+	uint32_t id;
+	uint16_t event;
+	uint16_t value;
+} __attribute__((packed));
+
+struct packet {
+	size_t len;
+	uint8_t data[];
+};
+
+struct port {
+	struct vcon *vcon;
+	unsigned int id;
+	char name[VCON_MAX_NAME];
+	bool sync;
+	int listen_fd;
+	int client_fd;
+	/* Data for the guest, waiting for receive buffers */
+	struct queue *to_guest;
+	/* Data from the guest, waiting for a peer */
+	struct queue *to_peer;
+	size_t to_peer_len;
+	/* The peer sent a request the guest has not answered yet */
+	bool outstanding;
+	/* The driver discards data of ports nobody opened in the guest */
+	bool guest_open;
+};
+
+struct vcon {
+	char path[108];
+	int fd;
+	struct vhost *vu;
+	struct vhost_ops ops;
+	struct vcon_config config;
+	struct port ports[VCON_MAX_PORTS];
+	unsigned int num_ports;
+	/* Control messages waiting for receive buffers */
+	struct queue *ctrl;
+	vcon_debug_func_t debug_callback;
+	void *debug_data;
+};
+
+static struct queue *vcons;
+
+static void vcon_debug(struct vcon *vcon, const char *format, ...)
+{
+	char str[160];
+	va_list ap;
+
+	if (!vcon->debug_callback)
+		return;
+
+	va_start(ap, format);
+	vsnprintf(str, sizeof(str), format, ap);
+	va_end(ap);
+
+	vcon->debug_callback(str, vcon->debug_data);
+}
+
+static unsigned int rx_queue(unsigned int port)
+{
+	return port ? 2 + 2 * port : 0;
+}
+
+static struct packet *packet_new(const void *data, size_t len)
+{
+	struct packet *pkt;
+
+	pkt = malloc(sizeof(*pkt) + len);
+	if (!pkt)
+		return NULL;
+
+	pkt->len = len;
+	memcpy(pkt->data, data, len);
+
+	return pkt;
+}
+
+/* Push pending packets to a receive queue while it has buffers */
+static void flush_queue(struct vcon *vcon, struct queue *pending,
+							unsigned int index)
+{
+	struct packet *pkt;
+
+	if (!vcon->vu || queue_isempty(pending))
+		return;
+
+	/* As time travel client, only inject while the calendar lets it run,
+	 * so no guest has run past that time.
+	 */
+	if (!ttc_running())
+		return;
+
+	while ((pkt = queue_peek_head(pending))) {
+		struct iovec iov = { pkt->data, pkt->len };
+
+		if (!vhost_push(vcon->vu, index, &iov, 1))
+			break;
+
+
+		queue_pop_head(pending);
+		free(pkt);
+	}
+}
+
+static void send_ctrl(struct vcon *vcon, unsigned int id, uint16_t event,
+					uint16_t value, const char *name)
+{
+	uint8_t buf[sizeof(struct vcon_ctrl) + VCON_MAX_NAME];
+	struct vcon_ctrl *ctrl = (void *) buf;
+	size_t len = sizeof(*ctrl);
+	struct packet *pkt;
+
+	ctrl->id = cpu_to_le32(id);
+	ctrl->event = cpu_to_le16(event);
+	ctrl->value = cpu_to_le16(value);
+
+	if (name) {
+		memcpy(buf + len, name, strlen(name));
+		len += strlen(name);
+	}
+
+	pkt = packet_new(buf, len);
+	if (!pkt)
+		return;
+
+	queue_push_tail(vcon->ctrl, pkt);
+	flush_queue(vcon, vcon->ctrl, VCON_CTRL_RX);
+}
+
+static void flush_port(struct port *port)
+{
+	if (port->guest_open)
+		flush_queue(port->vcon, port->to_guest, rx_queue(port->id));
+}
+
+static void handle_ctrl(struct vcon *vcon, const struct vcon_ctrl *ctrl)
+{
+	unsigned int id = le32_to_cpu(ctrl->id);
+	struct port *port;
+	unsigned int i;
+
+	switch (le16_to_cpu(ctrl->event)) {
+	case VCON_DEVICE_READY:
+		for (i = 0; i < vcon->num_ports; i++)
+			send_ctrl(vcon, i, VCON_DEVICE_ADD, 1, NULL);
+		break;
+	case VCON_PORT_READY:
+		if (id >= vcon->num_ports)
+			break;
+		send_ctrl(vcon, id, VCON_PORT_NAME, 1, vcon->ports[id].name);
+		/* Data from the guest is kept until a peer connects */
+		send_ctrl(vcon, id, VCON_PORT_OPEN, 1, NULL);
+		break;
+	case VCON_PORT_OPEN:
+		if (id >= vcon->num_ports)
+			break;
+		port = &vcon->ports[id];
+		port->guest_open = le16_to_cpu(ctrl->value);
+		vcon_debug(vcon, "%s: guest %s", port->name,
+				port->guest_open ? "opened" : "closed");
+		flush_port(port);
+		break;
+	}
+}
+
+static void write_peer(struct port *port, const uint8_t *data, size_t len)
+{
+	while (len) {
+		ssize_t n = write(port->client_fd, data, len);
+
+		if (n < 0)
+			return;
+
+		data += n;
+		len -= n;
+	}
+}
+
+static void from_guest(struct port *port, const uint8_t *data, size_t len)
+{
+	struct packet *pkt;
+
+	/* The guest answered */
+	port->outstanding = false;
+
+	if (port->client_fd >= 0) {
+		write_peer(port, data, len);
+		return;
+	}
+
+	/* Answers of a sync port belong to the peer that asked, other ports
+	 * keep the guest's output (e.g. logs) until a peer connects.
+	 */
+	if (port->sync || port->to_peer_len + len > VCON_MAX_BACKLOG)
+		return;
+
+	pkt = packet_new(data, len);
+	if (!pkt)
+		return;
+
+	queue_push_tail(port->to_peer, pkt);
+	port->to_peer_len += len;
+}
+
+static void queue_notify(struct vhost *vu, unsigned int index,
+							void *user_data)
+{
+	struct vcon *vcon = user_data;
+	static uint8_t buf[65536];
+	unsigned int i;
+	ssize_t len;
+
+	if (index == VCON_CTRL_TX) {
+		while ((len = vhost_pop(vu, index, buf, sizeof(buf)))) {
+			if (len >= (ssize_t) sizeof(struct vcon_ctrl))
+				handle_ctrl(vcon, (void *) buf);
+		}
+		goto done;
+	}
+
+	if (index == VCON_CTRL_RX) {
+		flush_queue(vcon, vcon->ctrl, VCON_CTRL_RX);
+		goto done;
+	}
+
+	for (i = 0; i < vcon->num_ports; i++) {
+		struct port *port = &vcon->ports[i];
+
+		if (index == rx_queue(i)) {
+			flush_port(port);
+			break;
+		}
+
+		if (index == rx_queue(i) + 1) {
+			while ((len = vhost_pop(vu, index, buf, sizeof(buf)))) {
+				if (len > 0)
+					from_guest(port, buf, len);
+			}
+			break;
+		}
+	}
+
+done:
+	tt_schedule();
+}
+
+static void run_vcon(void *data, void *user_data)
+{
+	struct vcon *vcon = data;
+	unsigned int i;
+
+	if (!vcon->vu)
+		return;
+
+	flush_queue(vcon, vcon->ctrl, VCON_CTRL_RX);
+
+	for (i = 0; i < vcon->num_ports; i++)
+		flush_port(&vcon->ports[i]);
+
+	vhost_flush_notify(vcon->vu);
+}
+
+/* The calendar lets the time travel client run: deliver what is pending */
+static void run(void *user_data)
+{
+	queue_foreach(vcons, run_vcon, NULL);
+}
+
+static bool can_notify(struct vhost *vu, void *user_data)
+{
+	return ttc_running();
+}
+
+static void vhost_wait(struct vhost *vu, void *user_data)
+{
+	tt_process();
+	ttc_process();
+}
+
+static void disconnect(struct vhost *vu, void *user_data)
+{
+	struct vcon *vcon = user_data;
+	unsigned int i;
+
+	vcon_debug(vcon, "guest disconnected");
+
+	vhost_free(vcon->vu);
+	vcon->vu = NULL;
+	queue_remove_all(vcon->ctrl, NULL, NULL, free);
+
+	for (i = 0; i < vcon->num_ports; i++)
+		vcon->ports[i].guest_open = false;
+
+	tt_schedule();
+}
+
+static void vu_debug(const char *str, void *user_data)
+{
+	struct vcon *vcon = user_data;
+
+	vcon_debug(vcon, "vhost-user: %s", str);
+}
+
+static void accept_guest(int fd, uint32_t events, void *user_data)
+{
+	struct vcon *vcon = user_data;
+	int nfd;
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_remove_fd(fd);
+		return;
+	}
+
+	nfd = accept(fd, NULL, NULL);
+	if (nfd < 0)
+		return;
+
+	if (vcon->vu) {
+		vcon_debug(vcon, "already serving a guest");
+		close(nfd);
+		return;
+	}
+
+	vcon->vu = vhost_new(nfd, &vcon->ops, vcon);
+	if (!vcon->vu) {
+		close(nfd);
+		return;
+	}
+
+	vhost_set_debug(vcon->vu, vu_debug, vcon);
+
+	vcon_debug(vcon, "guest connected");
+}
+
+static void peer_read(int fd, uint32_t events, void *user_data)
+{
+	struct port *port = user_data;
+	uint8_t buf[VCON_CHUNK];
+	struct packet *pkt;
+	ssize_t len;
+
+	len = read(fd, buf, sizeof(buf));
+	if (len <= 0) {
+		mainloop_remove_fd(fd);
+		return;
+	}
+
+	pkt = packet_new(buf, len);
+	if (!pkt)
+		return;
+
+	if (port->sync)
+		port->outstanding = true;
+
+	queue_push_tail(port->to_guest, pkt);
+	flush_port(port);
+
+	tt_schedule();
+}
+
+static void peer_destroy(void *user_data)
+{
+	struct port *port = user_data;
+
+	vcon_debug(port->vcon, "%s: peer disconnected", port->name);
+
+	close(port->client_fd);
+	port->client_fd = -1;
+	port->outstanding = false;
+
+	/* Requests of the peer that left are not delivered anymore */
+	queue_remove_all(port->to_guest, NULL, NULL, free);
+
+	tt_schedule();
+}
+
+static void accept_peer(int fd, uint32_t events, void *user_data)
+{
+	struct port *port = user_data;
+	struct packet *pkt;
+	int nfd;
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_remove_fd(fd);
+		return;
+	}
+
+	nfd = accept(fd, NULL, NULL);
+	if (nfd < 0)
+		return;
+
+	if (port->client_fd >= 0) {
+		close(nfd);
+		return;
+	}
+
+	port->client_fd = nfd;
+
+	if (mainloop_add_fd(nfd, EPOLLIN, peer_read, port, peer_destroy) < 0) {
+		close(nfd);
+		port->client_fd = -1;
+		return;
+	}
+
+	vcon_debug(port->vcon, "%s: peer connected", port->name);
+
+	while ((pkt = queue_pop_head(port->to_peer))) {
+		write_peer(port, pkt->data, pkt->len);
+		free(pkt);
+	}
+
+	port->to_peer_len = 0;
+}
+
+static int listen_unix(const char *path)
+{
+	struct sockaddr_un addr;
+	int fd;
+
+	if (strlen(path) >= sizeof(addr.sun_path))
+		return -1;
+
+	fd = socket(PF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		return -1;
+
+	unlink(path);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	memcpy(addr.sun_path, path, strlen(path));
+
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0 ||
+							listen(fd, 5) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+static void sync_state(void *data, void *user_data)
+{
+	struct vcon *vcon = data;
+	unsigned int *state = user_data;
+	unsigned int i;
+
+	for (i = 0; i < vcon->num_ports; i++) {
+		struct port *port = &vcon->ports[i];
+
+		if (!port->sync || port->client_fd < 0)
+			continue;
+
+		state[0]++;
+		if (port->outstanding)
+			state[1]++;
+	}
+}
+
+/* Hold time while a peer is connected to a sync port but has no request
+ * outstanding on any of them: it is between requests, so the guests must
+ * not run ahead of it, time then advances at most at real time.
+ */
+static bool hold(void *user_data)
+{
+	unsigned int state[2] = { 0, 0 };
+
+	queue_foreach(vcons, sync_state, state);
+
+	return state[0] && !state[1];
+}
+
+static void flush(void *user_data)
+{
+	struct vcon *vcon = user_data;
+
+	if (vcon->vu)
+		vhost_process(vcon->vu);
+}
+
+static bool parse_spec(struct vcon *vcon, const char *spec)
+{
+	char *str, *tok, *save = NULL;
+	bool ok = false;
+
+	str = strdup(spec);
+	if (!str)
+		return false;
+
+	tok = strtok_r(str, ":", &save);
+	if (!tok || strlen(tok) >= sizeof(vcon->path))
+		goto done;
+
+	memcpy(vcon->path, tok, strlen(tok) + 1);
+
+	while ((tok = strtok_r(NULL, ":", &save))) {
+		struct port *port;
+		char *opt;
+
+		if (vcon->num_ports == VCON_MAX_PORTS)
+			goto done;
+
+		port = &vcon->ports[vcon->num_ports];
+
+		opt = strchr(tok, '=');
+		if (opt) {
+			*opt++ = '\0';
+			if (strcmp(opt, "sync"))
+				goto done;
+			port->sync = true;
+		}
+
+		if (!*tok || strlen(tok) >= sizeof(port->name))
+			goto done;
+
+		memcpy(port->name, tok, strlen(tok) + 1);
+		port->id = vcon->num_ports++;
+	}
+
+	ok = vcon->num_ports > 0;
+
+done:
+	free(str);
+	return ok;
+}
+
+struct vcon *vcon_open(const char *spec)
+{
+	struct vcon *vcon;
+	unsigned int i;
+
+	vcon = new0(struct vcon, 1);
+	vcon->fd = -1;
+
+	for (i = 0; i < VCON_MAX_PORTS; i++) {
+		vcon->ports[i].listen_fd = -1;
+		vcon->ports[i].client_fd = -1;
+	}
+
+	if (!parse_spec(vcon, spec)) {
+		free(vcon);
+		return NULL;
+	}
+
+	vcon->ctrl = queue_new();
+	vcon->config.max_nr_ports = cpu_to_le32(vcon->num_ports);
+	vcon->ops.features = 1ULL << VCON_F_MULTIPORT;
+	vcon->ops.num_queues = 2 + 2 * vcon->num_ports;
+	vcon->ops.config = &vcon->config;
+	vcon->ops.config_len = sizeof(vcon->config);
+	vcon->ops.queue_notify = queue_notify;
+	vcon->ops.disconnect = disconnect;
+	vcon->ops.wait = vhost_wait;
+	vcon->ops.can_notify = can_notify;
+
+	vcon->fd = listen_unix(vcon->path);
+	if (vcon->fd < 0 || mainloop_add_fd(vcon->fd, EPOLLIN, accept_guest,
+							vcon, NULL) < 0)
+		goto fail;
+
+	for (i = 0; i < vcon->num_ports; i++) {
+		struct port *port = &vcon->ports[i];
+		char path[sizeof(vcon->path) + VCON_MAX_NAME + 1];
+
+		port->vcon = vcon;
+		port->to_guest = queue_new();
+		port->to_peer = queue_new();
+
+		snprintf(path, sizeof(path), "%s-%s", vcon->path, port->name);
+		port->listen_fd = listen_unix(path);
+		if (port->listen_fd < 0 || mainloop_add_fd(port->listen_fd,
+				EPOLLIN, accept_peer, port, NULL) < 0)
+			goto fail;
+	}
+
+	if (!vcons) {
+		vcons = queue_new();
+		tt_set_hold(hold, NULL);
+		ttc_set_pace(hold, NULL);
+		ttc_set_run(run, NULL);
+	}
+
+	queue_push_tail(vcons, vcon);
+	tt_add_flush(flush, vcon);
+
+	return vcon;
+
+fail:
+	fprintf(stderr, "Failed to open console %s\n", vcon->path);
+	vcon_close(vcon);
+	return NULL;
+}
+
+void vcon_close(struct vcon *vcon)
+{
+	unsigned int i;
+
+	if (!vcon)
+		return;
+
+	queue_remove(vcons, vcon);
+
+	for (i = 0; i < vcon->num_ports; i++) {
+		struct port *port = &vcon->ports[i];
+
+		if (port->client_fd >= 0)
+			mainloop_remove_fd(port->client_fd);
+		if (port->listen_fd >= 0) {
+			mainloop_remove_fd(port->listen_fd);
+			close(port->listen_fd);
+		}
+		queue_destroy(port->to_guest, free);
+		queue_destroy(port->to_peer, free);
+	}
+
+	vhost_free(vcon->vu);
+
+	if (vcon->fd >= 0) {
+		mainloop_remove_fd(vcon->fd);
+		close(vcon->fd);
+	}
+
+	tt_remove_flush(flush, vcon);
+	queue_destroy(vcon->ctrl, free);
+	free(vcon);
+}
+
+bool vcon_set_debug(struct vcon *vcon, vcon_debug_func_t callback,
+							void *user_data)
+{
+	if (!vcon)
+		return false;
+
+	vcon->debug_callback = callback;
+	vcon->debug_data = user_data;
+
+	return true;
+}
diff --git a/emulator/vconsole.h b/emulator/vconsole.h
new file mode 100644
index 000000000000..bfebe395005f
--- /dev/null
+++ b/emulator/vconsole.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#include <stdbool.h>
+
+struct vcon;
+
+/* Serve a virtio console with named ports on the vhost-user socket path.
+ * Each port is relayed to a Unix socket "<path>-<name>" for a peer outside
+ * the guest. spec is "<path>:<name>[=sync]:<name>[=sync]...", a sync port
+ * carries requests from the peer: time is held while the peer has none
+ * outstanding on any sync port.
+ */
+struct vcon *vcon_open(const char *spec);
+void vcon_close(struct vcon *vcon);
+
+typedef void (*vcon_debug_func_t)(const char *str, void *user_data);
+bool vcon_set_debug(struct vcon *vcon, vcon_debug_func_t callback,
+							void *user_data);
-- 
2.56.0

